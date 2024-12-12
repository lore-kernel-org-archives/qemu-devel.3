Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D44E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 00:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWfL-0004ep-Al; Wed, 11 Dec 2024 19:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWez-0004IC-7S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:29 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWex-00036D-NX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:28 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f304ac59b9so32083eaf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961746; x=1734566546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asKUsggT+0F56nh+WUR2TT5crj5xSwZ64CEeuaa2E1U=;
 b=mHx3rwF5BcF9MTg+bKOTycXe62OMnqb162mPkmglBXM8ImNkcK217w0fJXxjcfi29N
 s1/t9bFlP7fVTSVdd0IdCwfaQxuGJig6EyUQ3Zp7PmyXFbX206JaL8p5ljGVSQtMTY7i
 8eBZSuJu4q/VXTtBck8dttBcZaine8dhJSexiYMHB/sFZy4TV/ewXIT8LWKzxGUXBAKu
 0SrSPYlW9zYpPWEBoEgxtucYf1LjS3eU3Lt5x3c2Qup5XQAmErlPK1z5CsO6O2I1fPMu
 PGjnb1TdnTtKEp9VO/MaLwKFRp9VWmGyKW3yf00WuZmeFpisL6Y40ESpbjClZQd2k3pY
 NKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961746; x=1734566546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asKUsggT+0F56nh+WUR2TT5crj5xSwZ64CEeuaa2E1U=;
 b=f+blogSjtVckgw9jjmSt/XFDdNMBVPghCmihvB5yPZL5JaSiKQAtT7M24Qrmj9mwpx
 HyJrdMGb3pF4ciKv1b+FYf9iwfZehDniJu0nRZ6fG38ya2VO/SQw1yM1R5tcFhN6fDTR
 6TCxPWTC3ilSz2rQsOZS7mqsLvmXnUEjPO0D6GtCNCQj3f/XO7XP5H5rTMmFeqfFoAGG
 ARcrOe9xyoKJGtv5uGkAmlVHQHdeOGXkdQCUEOvmbliE6ot/EY15bXZWusDIt5UdzD0v
 2oT3iQAf1m6EE4ANYqP6R39xlXb/qSWCAmUe6z3oAlQ54CyIa0XQi6+4bZfPxf1dduar
 asbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIsVO+JKtg842IK3581OZhi8qEzbDNsgvt5FvwJDU+Pr3Rd+aQ5SgegpI6H21S7myOdhEt+iuD+k84@nongnu.org
X-Gm-Message-State: AOJu0YwfLC0tHUaaJnEeCsnleepI6v3M4j+vTgSKRXKcOWV3/W+vzHAI
 yT2/wqpIY9+R3uuEtzz1Zndl37u/N4uHilTgQhabke4RZisY5M4ATdp3GAtNZf+t4jxsXk8b8hZ
 M6D3kuHFV
X-Gm-Gg: ASbGncultH2T/tLfLE1+YgntTqqWFjcx3JoDPyq8YMnnf2m1c1utztgp57kaydJQHxH
 bL8Hcl40Oc+iN95bSjPORZWlEpKufNoP+FmZ6mL4OtkxP8n1UKTMQNhni1lmt6kpVjoDtUnKnKh
 llcLz/nAlXhnmHVCYE8K/JfnCdv953sVH/ZondtBU101ki4DJLMNP/D9bFK7gB4SGOy482cQaQO
 VC3uDSKkjqUDsnHhaAbBPB90xz+H3gkC4D5sC/TpK37ELskyYSfOen0IDcsMeEeLMIcFvvX/KRJ
 ydosOnxIZRDyNi/XVq5mS4M3BcVl656S
X-Google-Smtp-Source: AGHT+IGuVh319sFL1n25ZwkJ7JW5huDPSlth0XHhjmGKU3VKRDN0AdC36v5bDVUKc9g7CmmgRoAPLw==
X-Received: by 2002:a4a:ec41:0:b0:5f2:c5e0:453a with SMTP id
 006d021491bc7-5f2efc5dee7mr939781eaf.8.1733961746532; 
 Wed, 11 Dec 2024 16:02:26 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2a9d525f2sm2179300eaf.4.2024.12.11.16.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 16:02:26 -0800 (PST)
Message-ID: <75d1d73a-3e9a-41bc-832c-c88e8b0d1c44@linaro.org>
Date: Wed, 11 Dec 2024 18:02:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/xtensa: Include missing 'exec/tswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> Some files indirectly get "exec/tswap.h" declarations via
> "exec/cpu-all.h". Include it directly to be able to remove
> the former from the latter, otherwise we get:
> 
>    hw/xtensa/bootparam.h:40:16: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       40 |         .tag = tswap16(tag),
>          |                ^
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/xtensa/bootparam.h | 1 +
>   hw/xtensa/xtfpga.c    | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

