Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E00C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tretF-0003lW-IQ; Mon, 10 Mar 2025 11:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tresj-0003Kj-Ji
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:17:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trese-00009y-NK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:17:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224171d6826so64777635ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619842; x=1742224642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tiVi00OGQcmjgLi8Wi/pag2bLZpzjwGsu8wLYOHBwMY=;
 b=UOLo0/hK/xQF5bL1fqZlZVnBu31hiTAepTkQxUXC2z+bpINLdxnMzZhQtS4uTQcPLP
 Zf5uwpnyqDG62W06bdtZRwp/o2G2DvI+Y+QSWM2qZv8IFQMu+eRpjXnatYsIDpieTt8f
 yU22qGHU+e4K0bWcEvIt0M68kNzai8dw7lpe1jLy7zEDKu6fF1ousXzycjWHkjb1aUG6
 XZnN0qvKL1KiNpJHwbCzESOhTB2RFB/GqCOD56TEpBlkxxPVLtU9DRDAlONHd+QTK99z
 F+Vru6ahRpYpBtxDsxceol7gNYVBOr85H/9CzmyNXsqqQZowpaxK/Si3Vi29T8ZCRibW
 MR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619842; x=1742224642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tiVi00OGQcmjgLi8Wi/pag2bLZpzjwGsu8wLYOHBwMY=;
 b=hTSV0YeyrQl9Sukq/nWfvgXUL2e6+1O3/XudCZBgerX1BplnqvwVhDRe9m2X6gntvu
 r3mB4M3wHUnwSF/OEdcTUbrYnQk4d3WCvGnGdyTaOpOvLb+ZioRulgxEvw0hU3nT6S/Y
 147kwUyLfJsszpCNLncarwDFonKbKMfz8rXP36+kdUgX+K4bl8MvWsicfrcdXzaOLfyU
 b6B5fYCrK+VfM6YIdrEkrH5vKZDg3eUME9fNl0naG1ZOLbvv/z8pK6XomSTrxjDI9rnm
 x9sHQHdgFC6rtxHTiz2EF30dmcAm0yicecwXzXMwUEtOYY/XJEtRt2VMElrqGcjMNQkT
 mCpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkr8n1Yj2tUZbhpOKDlldz1lp8qBb9Amj5TP1zbriJC+ICLA89eKPlC3m0MSxh0Lwpo0V+8dr1xPIf@nongnu.org
X-Gm-Message-State: AOJu0YyOU1IKZy1nbxZDEYBYsOorE7XvrXcpmsovtyKusywoekVNh3Yd
 qsUSWydgErV9r22H6uoGURlEotDCrCiwtWEN8WnrN3RxBG+lq+NTDd1ZvYEYUHs=
X-Gm-Gg: ASbGncspm/uBF0jSI+Kzgsrl3KckkLN34M5MN3SWpDic1GyrjBGHjHB/qgUyubE8mGs
 FK57CnCWsT1LnXM7+Bv3HGnddAfPuhaiz1ERn7j6VyMVL9/dsJWIUOW7g/vEnzLu+vBLEZG76YE
 ovR90Ksfd0F/dS2S24rJ9vgFwdC4FbyiINSNctA/jYEEVOsvkfzIEVr0tyHnpNdj01ceTsXtJsN
 /DwGz3f4/CYnAv2NKTZ+MyesZ8YC8Lq+Yb5fkak5Uu1pbiQdkZnNgqcUPSlcT+5XLX1kxtbjZ5Q
 A+AXtg0hhWIiGub32E5ymiIzXsVovn8evzQ6a46RUl03hFoa2uVhawKedpPaoc0F8ZYDj7Uls2v
 4o451ZsO0
X-Google-Smtp-Source: AGHT+IE6rigLHAGIqcMyISYq6mIzZnSgUa9rgkwmanJoTBZxGtuUUibh7w+FFQc4JYW9+RQ2qUTBcA==
X-Received: by 2002:a17:902:eccc:b0:223:f639:69df with SMTP id
 d9443c01a7336-22428ab89b6mr255290235ad.41.1741619841802; 
 Mon, 10 Mar 2025 08:17:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7fc55sm79464035ad.138.2025.03.10.08.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:17:21 -0700 (PDT)
Message-ID: <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
Date: Mon, 10 Mar 2025 08:17:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/25 21:58, Pierrick Bouvier wrote:
> They are now accessible through exec/memory.h instead, and we make sure
> all variants are available for common or target dependent code.
...
> diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
> index 92ad74e9560..74519a88de0 100644
> --- a/include/exec/memory_ldst.h.inc
> +++ b/include/exec/memory_ldst.h.inc
> @@ -19,7 +19,8 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#ifdef TARGET_ENDIANNESS
> +uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>   uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
>       hwaddr addr, MemTxAttrs attrs, MemTxResult *result);

You shouldn't be exposing

   address_space_lduw

to common code, only

   address_space_lduw_be
   address_space_lduw_le

etc.  I'm not sure what you're trying to do here.


r~

