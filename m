Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E5CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIA68-0007JW-Q5; Wed, 29 Apr 2026 14:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIA62-0007Hq-Rd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:57:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIA60-0006EM-MK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:57:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so1369075e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777489035; x=1778093835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WyukkISRT3EqtuMfJc7VrSUgJJ1UgN4hLSWqM/j8BFw=;
 b=xrCdSYv21ZsiyGy7NOxOwwO/BE31nn+MbFlz3EZ6CNuSOX+vWv1RhoGhAMKO4RVavd
 IhtCLHTLKJdCtBoUCiKeIeldmsb4Dx16mXOrVaK1UMN3UWEymsJJNaW1A3HMKBsmHMEO
 jz1nrWtwBGhgIEywhUTtPT8LW81XNDlMMrgeyP7rKCTMWjNgDciNzTJI8bP9SkP/xPDT
 /nQHj57+yR07XFySyTWDtB2b+2Lm7eWRFSkJm38abEQlAVg4ZZc//dYi0RtP0W+URd+T
 vsCtYeVLrJJJAqbTqR7hW54VjjcMLIhpzwEEjBtS68bjDSJT9y1indFWIpdsn5UCXBEK
 j6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777489035; x=1778093835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WyukkISRT3EqtuMfJc7VrSUgJJ1UgN4hLSWqM/j8BFw=;
 b=beSeYI6XKTtUkSRkGgvDJGaMatLiFewOE9XAdo8BdtqJ9JsEvXGqTx24Sj0GNcs7fF
 4cYEhw7KJcctHOx5EVeNdHmBvYrRcqeNy9HBzGC4PMAAmNlCAtAFJDecZ0pkIyjTMUe2
 AYDCOFz7kw9Dg3a0en71240zmWusIdt2hYuhMf4dh0VO3BnJwMJaGCX7032lvALSIxz7
 YBoRwAU3W98myzebchhamJTeUKdbXw0+PYlfLdcA1OrsTiR0sXC7TrCQZLHXUC47LzyA
 0ZaamIj3UOoyK2h/nJHWZrVk1GqEqnS4D6VVSVXOXerCLE0WCFqQsAvllQX8T46muNq8
 YVBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ84uESle/0LK2RTft6BCQNmJMtxbnjjEISxalozPJkxIWwJEjPEhOEi6f5OW/uYOQi6JKWWvYD0p6xI@nongnu.org
X-Gm-Message-State: AOJu0Yzi0Iy0OAbDhBKMBX+qxhJ7xPzi/MnHQkT77H+vIpnG8yhP0fHx
 4k5hNKew7OMwxTKHj/elLMcoOjnXY/soIg18gWWd+RzU49EnIWZqKEWn7BW4REDv9bs=
X-Gm-Gg: AeBDievb97RJwurcXrhIH8efjddhB0I4ehbZu+VeAp/lM2RXOv2LfTgYKvcQanADeuk
 ZhNe7qjtLryQ1jxBcqP1KjraaGhO7QjqH28MDo9QEfZCwme9AZNsTpJu2bSq/xMRVGGBg2WmRx+
 GKmadShxqb3CAzOLcvq2p7fcPbbC9dLDw8fH2+zO3MC/+jxQwKSSe2jM7SHi4MpQtEaRXFMyXCE
 4fPPmCTEkdlVmkOV/bM/PURy6D7ylHkCcitF1p3LX1owQFmOj4GthUSyGQeopKuYswOLl2/pPzu
 p7ai/P/cghTInkuDO+lKMpXbIap18rFE1NNEhPRzPY5FnwDJhfZ/P/IEkDKpQoMbaO2OCnmCPXt
 17msT2+fMOdu7cFPmfRlR3XJ6sQ9Zc0DmsBEdzwqryT/OYvOC8yRbhWKwSnCyoUw5+2AiMP29x6
 61erm2dJCDT4KzvUYwwxoC8FRMd9i8DJx634fSDNuLuSz/9GTvEaq4iabzk2A0NmEtsieMQyEOa
 STu
X-Received: by 2002:a05:600c:3516:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48a7b542187mr88263515e9.21.1777489034878; 
 Wed, 29 Apr 2026 11:57:14 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f28sm14478045e9.13.2026.04.29.11.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:57:13 -0700 (PDT)
Message-ID: <3454f178-c529-4da2-b290-3567dbb43f57@linaro.org>
Date: Wed, 29 Apr 2026 20:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/84] fpu: Change parts_float_to_float_narrow to
 parts128_to_parts64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-48-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Rename and return FloatParts64 structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

