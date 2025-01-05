Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492B2E77188
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 00:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUExQ-0004FQ-3U; Sat, 04 Jan 2025 19:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUExO-0004FC-GP
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 19:57:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUExM-0007uE-RP
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 19:57:30 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so142796475ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736038646; x=1736643446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zH2eBr7Nt0SM0CN7xoilpg8aER3fN7qRBvtohcX+Kds=;
 b=QHk3063PSrNEoM5oSSgJUQkKmqG030cOPyaXNYTdIAFV3yWAyHETCcc+wffSbr0Sry
 WZ+Idey+Roi2YFO5XSYnVdZrNLidyXi/fpJNJCxwbrGTi7Ow7sI2rE9xqO/vEucpRYL2
 aE9tFkZoINkRh/bHrQdJk+YKbUmiHVDjBi/i+w15B3IkqY8SwH657cC9hxvnp4+/NwBO
 mATP0lvicBaXkSwOth2WKHPzqtnYeRgMC8LwBO5OeEk3A22UlPEuhqYAMSX+ihMYXC/2
 weKgq7GNYctQ9ErnqTorBIpUtGg1K0TA15gZfB4yG1sT8xB9OSQdUCy43gYprpLHWPu1
 3kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736038646; x=1736643446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zH2eBr7Nt0SM0CN7xoilpg8aER3fN7qRBvtohcX+Kds=;
 b=YciCMjXeDfkBYYTYTfFPcqWdcOi1zLnl3KB7msOeJdpxNnPiFatQ8qe0UcJzsGJ5Cr
 VDQCIsZXXjSunxRdEBDcwjUU1zVg5Uuf6auLtZo+JGJulvlSy3k37ymEEkv9e2j2vtZC
 ndJagi4IY3A6lmrJlLX7LJ6n72F9GWizUxmvQ5R2O7XzFAHQXbAv5jlL3hzxAxqmUhaY
 E8ttZt7K4/8h6Gv7OMTEVGAmWFGOgClIakFq9m+AkBw+5xongsx1+j4X4+tBZXoNScb6
 N1apIM9r9NR63GczlxgBLn/awEmz++D291eeXTNV+RgJ+rk51N+Am1yi2+CAiaY/bkZ4
 jnDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoMmn9WVnbbGJ1vZ0+3gUepHfdM33iST2CkRfvRmDHUE71oSz+TQs/+2G38VsNapmRe1BGv7O5zqsO@nongnu.org
X-Gm-Message-State: AOJu0YzkDec2py6JbwvgIDvtVm3tPUeVeGexts0n/dDzKnSf1D9R0Q3Y
 JX03UIxNUIRnXw6TbicWbB6XAx70NQjEhK6Y4jf3kfhcXzRLLaT0c44aRLzv2/E=
X-Gm-Gg: ASbGncuWWXcEgCprLN5omHfciZ30mZ8brutQg+yLdU983ZdDL2P7Bt7momw6VwN7E5e
 uLqEg7VZeMh2JQiRNnBZgP3pB5yxs5XTE1GJKUgFT2/1oDUTqZLW2PU99R2VnYB4Yin1eoptk3q
 sKIGPxxChKej4/5ExCPAsufa+3ING/NyNRRKwAmBfZ1C2qHZOQZCcA0WMrh57h2W2ITFaRxqD7N
 eM+rnIfyX09+00uO7hik7p8CqSRgYnC2/3JlAOFR0uR+aozEpj9ar4PJkqsv7IGKRxGS0QUIEnk
 ESNLeST/9PSakd/AnyGfbxc+obAFOjM=
X-Google-Smtp-Source: AGHT+IG4lZAWtMOtDeXuUQspZH8GTWFQina0xVwT3OkuU1uBAWtpdoWstnEzWCoS+24FGjMi0h7GhA==
X-Received: by 2002:a17:902:ea03:b0:216:5e6e:68ae with SMTP id
 d9443c01a7336-219e6ebaf33mr777632655ad.31.1736038646403; 
 Sat, 04 Jan 2025 16:57:26 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d949asm268245795ad.141.2025.01.04.16.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 16:57:25 -0800 (PST)
Message-ID: <75d3b6cd-7899-4ea8-b762-784145111906@linaro.org>
Date: Sat, 4 Jan 2025 16:57:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] target: Only link capstone to targets requiring it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103231738.65413-1-philmd@linaro.org>
 <20250103231738.65413-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250103231738.65413-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/3/25 15:17, Philippe Mathieu-Daudé wrote:
> No need to link capstone to targets which don't use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/meson.build        | 1 -
>   target/arm/meson.build   | 1 +
>   target/i386/meson.build  | 1 +
>   target/ppc/meson.build   | 1 +
>   target/s390x/meson.build | 1 +
>   5 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/meson.build b/disas/meson.build
> index bbfa1197835..4e80adf36ae 100644
> --- a/disas/meson.build
> +++ b/disas/meson.build
> @@ -20,4 +20,3 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
>   ))
>   common_ss.add(files('disas-common.c'))
>   system_ss.add(files('disas-mon.c'))
> -specific_ss.add(capstone)

You need to think about which hosts require capstone as well,
which is most of them.  This will help almost never.


r~

