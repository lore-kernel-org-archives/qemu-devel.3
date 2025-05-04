Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC3C3ABB8
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmP-0004fc-WF; Sun, 04 May 2025 12:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbm2-0004Ph-HD
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:01:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBblx-00045R-VQ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:01:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c91576aso32156795ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746374455; x=1746979255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzVQpNPT+TL8s16+jQLivHLgw76ZAyXebgPC9LfcVXs=;
 b=PKUP6Fk8riyNRZqkYrbCtqtU8jkRM9Go73tNk1E1fxycUhUhSiPO0NE84dVVFXKGXR
 nJzEs2pAt7ru7O0UlKTqdV18C0swEugqPUjl2SN3t6opwIlmZT3yt676nfs1EM9MDOvd
 JAcd9OA1DpxWTkEqXmRtDKnQkTHxrv/ZZGgb/iK4More4d5w9psexGBbdbTEoU0IpmhU
 9S4JHX8q21CdZJSQ45CKzoF1RBjtjEbhR6hIY2db3S3j0nxpOCI4DFIvaFGHpVDNS06K
 fj4e47MLbi1/7zx5iulJHI1FeZtFbHLZpD6cYROZTrdt0Pa4Ae4azvO99k/oYI1hFoyD
 JyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746374455; x=1746979255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzVQpNPT+TL8s16+jQLivHLgw76ZAyXebgPC9LfcVXs=;
 b=LW3cWPwW7UCqv4xE/kSZlCjJ5UbJwY5u2kQL4WuFWm9spXXNrHIkvt9Rnb7wDG6K5u
 N7lvn8X83tkh/wZUlm4zTS/X4gnzd2HBfvKtRUFrFXAcmbttMtXzrUE+4iP/BsJpjv7q
 GG2S+MumCjUVfHjGCC5okovp2K5PLOAqmXWKkTEerTDIOP5vBoIqW4p0kBeVSiXGvf3/
 ffmss+oFK53P4b9o2IJP1rdStLmcHrEnRMwrw0uqTJGQ5Xh+QVvRrz26M5Q41xdHnCHB
 przjFY5mojyj39tXyFTKki+X/hPik3RGlrAEb7nOEkPQicnyI7s6PL0B63p/9DFNqQZp
 1rxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1L83k6FPjeAM03mQ71VCaNVza6KbMsIzDMulvROqlz0U3YW3uNhonSIiAnmpG2NQXBHw97zve1v3R@nongnu.org
X-Gm-Message-State: AOJu0YzntuxZe+IPCeBcnEm9Fj+SBFVR/xsT0PAM/mOu1x7lsRm0PIm7
 sh2qbIxp49EM1vOkNuW0QtZgiUM/o6KwrS/WLm5lswnCx9jMsAb/qARHXuUXNqU=
X-Gm-Gg: ASbGncuCAZicSzDkAXa0MRPp6ukkbq3oHK/7nsg6/KE5cQvuU0hpLQUAi8CQAiJS90x
 3x6wHQRoRWIWRa89RCraKgCrQvfsL3ooV5Km/1uE45KhjFtYRgtUUtyjVakl6SPshsdnvY2ojyV
 cihFyN1A5pMqs6TMto7BrX/7dz+Nhcj9f74TEDCU6bsEKC1idDphspO6qkq30jemQ4PqO4qA9D4
 8cQ3mMYio0tp9bxuVOmrqzpegp7o4BqXVbWDO6+iwo1lg7+YmJco32huOZTPW9qF7r+VgaRNnDE
 GFMGlK1SlIZrUEin8pHYZ4p2qcqF2oWTzWZVzMJKezVGOcFj38iBwvdrEsBNiwgdVWR3nI0uT0M
 dXCwxq64=
X-Google-Smtp-Source: AGHT+IE66o3FzhnOoYhmgbYjj7kCGXhJa8dnqD/72XM0gm+75hkSaixle1rVIRPVkTst3i+gp8NmmQ==
X-Received: by 2002:a17:902:d4cd:b0:22d:e458:96a5 with SMTP id
 d9443c01a7336-22e1eae8762mr70246125ad.38.1746374455257; 
 Sun, 04 May 2025 09:00:55 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a332sm5199607b3a.16.2025.05.04.09.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:00:54 -0700 (PDT)
Message-ID: <6ca071ae-4608-4777-a2b1-719d869e1330@linaro.org>
Date: Sun, 4 May 2025 09:00:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/40] target/arm/cpu: compile file twice (user,
 system) only
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/3/25 22:28, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index c39ddc4427b..89e305eb56a 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -1,6 +1,6 @@
>   arm_ss = ss.source_set()
> +arm_common_ss = ss.source_set()
>   arm_ss.add(files(
> -  'cpu.c',
>     'debug_helper.c',
>     'gdbstub.c',
>     'helper.c',
> @@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
>   )
>   
>   arm_system_ss = ss.source_set()
> +arm_common_system_ss = ss.source_set()
>   arm_system_ss.add(files(
>     'arch_dump.c',
>     'arm-powerctl.c',
> @@ -30,6 +31,9 @@ arm_system_ss.add(files(
>   ))
>   
>   arm_user_ss = ss.source_set()
> +arm_user_ss.add(files('cpu.c'))
> +
> +arm_common_system_ss.add(files('cpu.c'), capstone)
>   
>   subdir('hvf')
>   
> @@ -42,3 +46,5 @@ endif
>   target_arch += {'arm': arm_ss}
>   target_system_arch += {'arm': arm_system_ss}
>   target_user_arch += {'arm': arm_user_ss}
> +target_common_arch += {'arm': arm_common_ss}
> +target_common_system_arch += {'arm': arm_common_system_ss}


