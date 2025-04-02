Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464D4C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvAj-0002nC-Ix; Wed, 02 Apr 2025 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvAb-0002mS-T3
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:18:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvAZ-0002Cm-Kq
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:18:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso524356f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743589081; x=1744193881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JHCsjTY/AOw/Ta/MGcKgn7s7T+w8Vc9Ct3I2i7SylEw=;
 b=aIufsUe8kdTI2E1VSh5azKqzIRPnI3QrROjhZjfZsevU0cU6/ZKhKQFA4rZL5Dt9II
 yBXNu0N+v4IT72+WLg+FLj3oT5FzzS4l4+lgJ02roVKZEh9XiVOAvs1qFrscxO0mc+FN
 pGUlPrXGenx9ZmrKl3ssBNWwPxV4yKIScNZphY70LyyptEw4dYV7seOKLJ0X4POkRv8O
 oVdqCEtFQgSqv+9a/vW/AaiovOPI8mIkMjbFzn0NqCFdjMK2phNGVdmfGqaFlsZcQjr3
 N0D5l/HVeY4p/wlybfx2ZB4g7o5mWv8oCr9lZl6oTfkl1AdBlg9A4AalQHVmaa1WZ74q
 a8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743589081; x=1744193881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JHCsjTY/AOw/Ta/MGcKgn7s7T+w8Vc9Ct3I2i7SylEw=;
 b=CYzx6O4OERLNjNQ7YJ3Y4EpQ4DniSMhuZLwffwxfowIDRjR01ib+xt5l50qvZYHz9Y
 91ct6ddoIg1XiZbY1AlQax60afD6ZJ86TaG79D4y0Tp0RyeoGCpId9FO7L3amZKlLevP
 rF3Gc8Uy92kPUBbsiLbKjapGz3c2mh7eeR1ZgYihPXJ8IB92AYAeCmsFdZTCv4f8Qq5M
 etj8iQxMp+nE4TGvG8voxBhFFPMA78VRTm77+Rx4ysJgJRVQ/Mlm8XYXoic3lcsfde9c
 D9ABiQEqehzEqE5fZVWqZE5I3F6SEeZ3Qb8BxW2uzPbTo3nWmrxk++rdqr1Eut29KJcE
 fPtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jY1ip5yvaPox5IB7QPocBE/L24NNehAIxEnrtEdKTEpKM2KniYjjgFuPzy3pYUMXV1rfL4f5p4/r@nongnu.org
X-Gm-Message-State: AOJu0YzzPyXwhjecMEOEn70ydskjdqEg6VR+PHXUVarRXXIQ1vxdLQ2A
 zk4RgUW/kkAnFRlzczVx2cTbFVfESoYN5WXoqDKJfrTszpyxMp20y5nG4l9B0Sk=
X-Gm-Gg: ASbGncv/4uq+dQKzxYW/lm+BbK2xgk2V9w5J1V0ohrdeZwGmAf+Y2MrW1PYQISHPYws
 blk/bzmbtCv7o2trcL35fiPYCQR7RC6c/vA6GTeipByJlNpIJJ9ZKM19okSDtY775FDddSAMEcb
 jvPYohiJjbja7nVYDZmHt7TronCCg5z7U0P/SU9r1G5Tl3oUat1fgf5JnPVUMGpEHgPSXXRRAsf
 lugp8t/8cV1kKoEQy/WqoSmmf9pK31WwxgU5YdLEE6/VXKoF5GVAiVjAVcDEWEEwcyulq+0Vku8
 vJTBxh+WoXmqJe2q1uFptBEJrxKrSaeDEBuTuhJkLo8wtE2/L54X9lJOwSs1QgtABTl9WIFW7eF
 7e5Hlk1sPSXFR
X-Google-Smtp-Source: AGHT+IEvgoq+eo+oQ/QObwhIa0Ue/FsZFs1gUcsAFx2y69UT/cMxkGNvsJjjQiYldQQDTmjaxyihjA==
X-Received: by 2002:a05:6000:2211:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c2a33f13dmr1359467f8f.2.1743589081107; 
 Wed, 02 Apr 2025 03:18:01 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663573sm16989747f8f.33.2025.04.02.03.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 03:18:00 -0700 (PDT)
Message-ID: <b240dea4-082c-4bdd-8dfb-45d444ae12ef@linaro.org>
Date: Wed, 2 Apr 2025 12:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/23] include/exec: Split out exec/cpu-interrupt.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250308225902.1208237-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Richard,

On 8/3/25 23:58, Richard Henderson wrote:
> Some of these bits are actually common to all cpus; while the
> reset have common reservations for target-specific usage.
> While generic code cannot know what the target-specific usage is,
> common code can know what to do with the bits, e.g. single-step.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h       | 53 +--------------------------
>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>   include/exec/poison.h        | 13 -------
>   3 files changed, 71 insertions(+), 65 deletions(-)
>   create mode 100644 include/exec/cpu-interrupt.h


> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 35721366d7..8ed04b3108 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -46,19 +46,6 @@
>   
>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>   
> -#pragma GCC poison CPU_INTERRUPT_HARD
> -#pragma GCC poison CPU_INTERRUPT_EXITTB
> -#pragma GCC poison CPU_INTERRUPT_HALT
> -#pragma GCC poison CPU_INTERRUPT_DEBUG
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_2

If I understood correctly yesterday's discussion, these
definitions are internal to target/ and shouldn't be used
by hw/ at all. If this is right, then we need to keep them
poisoned for hw/ code.

