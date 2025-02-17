Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F7C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0y6-00007v-Ml; Mon, 17 Feb 2025 08:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0xv-0008UW-3p
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0xq-0006RL-NH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so2348755e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739798109; x=1740402909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7XQNmQBSODM2Vsq4Jd0tYm7oiq1+uBYoBAth3SpthhY=;
 b=CD+vxHMzOnT4Zywkut5+Z6eQJbPrTYjlko/ijR+xQ/R6Pllx86jKZklZtEjUOdZ4r8
 zQqsr4SqJnLmY3g35/jcSCn5tYRZiMPrkHWxwPU8LeV6V3WwVMQa7VibXeoeRbcPEBhN
 JI6wMO4QCiBzRkZs0jhCfdwC+xnQuCxm6mE7TRMz0P3zYc0bT3N+buSBRvpXe8bH3TB8
 D9HfooPVBpWkiAEvKaD6pXhEPiV3qrg1TxgFxT8KKQe9X9q6Z3WBGvIib5eGn6AlJC4v
 D/+bOG81ZrW0DjiIUe8wlekgx5Hd3EHROkYPNCYOml6c0k4/6vt+zmX80SogXygayfcu
 OBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798109; x=1740402909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7XQNmQBSODM2Vsq4Jd0tYm7oiq1+uBYoBAth3SpthhY=;
 b=AzV3dWYpiWBZOUlJvHWTaGZw6fWKbQjFCH//x3kBPlkVXuMhcZfh5pN5HNpeOKz4QB
 h7GL3AP8ZNIB9kO16p58VG00ox6I39AMnezrInVPa+bvGB54S+rD8R9EE5dGU6gV0/lU
 7CSa23O1F+bWgbzBRWN9PqmvDMPv8LJ/Bm7v9cyLfVYuLxk68hLfx8eVT7vW7a59OQrc
 7YocZY4UKv2Hj1Y7ZBDyIeFrkV+fWUmXOnGrxviNjozE/Qdr0Rhoz63+OY0mnbeuok4p
 otVxvhymslL/TBWUcfH/4XbhaN9FAk4Wjie6/w8pf6uJ85ahYvj6kA0KC2GFsKJItGix
 cjCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Kz4uI8QBtNgcdRl5x2MPSjaZxMxm5fb0tSb6HtIUeJ0VEC1IzTIFNfYaSKUlzcmyG/KP+6C02rwt@nongnu.org
X-Gm-Message-State: AOJu0YxVHXmZZDXXPAId1ThZLeR25SeYgYPKEEGkBr4PEVLf2P4asW5L
 0SmBcIpqnK5d5LwFkTmOsQKQGf9K970YdSBCkWCMDJ1cKP5PQxV6EdQuwBvL9+s=
X-Gm-Gg: ASbGncukR6P9InHjnHtg5DGqfhiqAOQxe0eetNbWUXOBUO9ADiiRPHrGr40ZbjTYXPc
 iCgJiZWYbFjYZYyYwV5iLPFm1hLIT71BJRqEnZAw2n0Oi9q1rf2JU/ZlQpE2evgudvMb9m8oeOR
 v9Fm/YTNoj0LrOv5C7TQC13QE218rNrvkO2JCgH1kW2yO2EMGbAqLfqKQ/gbZbaYs2gw94VxRZF
 rtRPFmwRSBfOjUiu0o7V6CId3Y/Ck/cEVOOvyefZRuaOSlXRgYCblx32KOmuEHl7Dp/Pohd86YT
 Ba42FAXTiLWZKnSDDYKjbT1CB8Bx5w7pQVQ=
X-Google-Smtp-Source: AGHT+IEK5jMLvEKEXSbPFm1pHOBAYaxRXloUb6eNfVqXsBFc6TfpYzYVwBJ2+Bf9UVpbT45Cr4rBDA==
X-Received: by 2002:a5d:4651:0:b0:38d:a8f7:cb73 with SMTP id
 ffacd0b85a97d-38f33f43850mr8370484f8f.40.1739798109003; 
 Mon, 17 Feb 2025 05:15:09 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm4087785e9.10.2025.02.17.05.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:15:08 -0800 (PST)
Message-ID: <2678f9ec-42de-4da9-8708-0b2fa166dbcf@linaro.org>
Date: Mon, 17 Feb 2025 14:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] fpu: Always decide snan_bit_is_one() at runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-9-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> Currently we have a compile-time shortcut where we return a hardcode
> value from snan_bit_is_one() on everything except MIPS, because we
> know that's the only target that needs to change
> status->no_signaling_nans at runtime.
> 
> Remove the ifdef, so we always look at the status flag.  This means
> we must update the two targets (HPPA and SH4) that were previously
> hardcoded to return true so that they set the status flag correctly.
> 
> This has no behavioural change, but will be necessary if we want to
> build softfloat once for all targets.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c       | 1 +
>   target/sh4/cpu.c               | 1 +
>   fpu/softfloat-specialize.c.inc | 7 -------
>   3 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


