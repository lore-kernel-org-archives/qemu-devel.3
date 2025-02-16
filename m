Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9E2C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 19:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjjwd-0008S0-NK; Sun, 16 Feb 2025 14:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjwb-0008RZ-TC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 14:04:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjwZ-0003BV-Ro
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 14:04:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso1248945e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739732681; x=1740337481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJPFV1jhZAYXywQhgbQi4s8w/5CfRhWcLWHhO2EvHrI=;
 b=RPsgU7KLg99ofYiT7N/7Q3yHvyaLi7B6NGbKk7cuCx1mnDlzcbscpnrIszQDCIpu6k
 SND2CrTiCpaD7poBRFN64hrPbxWfDL9I+QyWh4r2aKQhctSz65mLa8wSG3epe1R8nfxK
 mHuriKfk7g91tjpkKG0Zou90yVj2L6T8NKtMLs0Nxr8CNaBDIG6ZsWLQK4gtHnMYDGrX
 LlNi03IzSfMiXfMSFiWN6EE12GodvsLSHHZevCLZvHDmBOoMNbUzwIP4tdkQm9sx4IlG
 zqXNuP8s8e3MhvraZzzUWnTk8e9NkKMO7NxXA6V+9LsJiC9vtytA4NBVUU+9ua5R2SNo
 aGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739732681; x=1740337481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJPFV1jhZAYXywQhgbQi4s8w/5CfRhWcLWHhO2EvHrI=;
 b=BeGWqBNQiyVsb7xBOYB7n0I9DhjgPNQhXzB9t36190OtPBAS5O97L8aejWI2iy64JT
 wY8EB7NqgAbhlAs2WTpTBIHa6eKop6ts776tqAdgv0JdDn77phKdE2ktDGK/EBvRgyq4
 ilnPzVFnflOPMUqo8+zIr2+kwx6FS1vqSIhGGKd9wV+zDxheajLuNG84wtEMxmgfPiNv
 /aLHFlvfbPlyjAYt2KLQATZ3+KcXuPGpAYhklxo/WFgFIa3rVq0ngkEIFWesNLz7X3mB
 BxBSclm3U5GJPw1urGJuz4Bzyz6RPmuX5eMIq37yvtpUVOajzI6EaRHop5fUnjK78Q9N
 fS8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUET00EU2xKu5tcQCpq971sPgGjdQOsuJcAxvsxtNzkNBG4gay0S42oDTrFaV5on3mydj0QNJ0I/eM@nongnu.org
X-Gm-Message-State: AOJu0Yx3qLWpMFQbhZXFuHRD8shZ5Rw1a7GO1rX5z5HVd493otlkSPEc
 vTJD+uBrmbr39bi++qG/S/ADjes7YM9FANB5YiraEPYpeD0b8bE3FSeTHezShfmqZrskg96UdQ6
 WZP8=
X-Gm-Gg: ASbGnctOiCgrDErzX6jBjkI58QUqQBLJOkpLpbX6AP18vDVOk00ggAy9Ww8ouzsBgLd
 OToSS3ndbEUDMTzK+5/UEQxqEWLypDOFc/28CxXgcX6b53xuH5I4LHsJw5NDgn8fJSazf7b1aqy
 gy4bJiQFxukg0eajIBL0KVzIr3NV/HMIbovtuyjdkg20Y1vjtaeXlaHrq2oUzDncxelmuuqg/5G
 hOjeD5SykI+FwlDpUa7fvXMQaefXD4BVwpw5CFHtidAY6UAQy1gD8Cj2v7ID1wZ7isDuEIuP7eG
 /RO7Vh89y6txY476aCe+KMJV3zg7fDAuk1i/Dsw+HUfYkeGtCwnY9qUvmPw=
X-Google-Smtp-Source: AGHT+IFedRLb2PCp1eqJ6hZjSb1ImsKyiy1Ba94Xy0G+bwP0xIUh9jfgry/DPl0zRUzYnYtNdHBHAQ==
X-Received: by 2002:a05:600c:1c97:b0:439:403a:6b77 with SMTP id
 5b1f17b1804b1-4396e6c944dmr70896755e9.10.1739732681662; 
 Sun, 16 Feb 2025 11:04:41 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7bcsm131581945e9.28.2025.02.16.11.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 11:04:40 -0800 (PST)
Message-ID: <59a4c4f6-341b-45b5-82af-472e2930889a@linaro.org>
Date: Sun, 16 Feb 2025 20:04:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: Remove TCG_TARGET_HAS_{br, set}cond2 from riscv
 and loongarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216024709.2624325-1-richard.henderson@linaro.org>
 <20250216024709.2624325-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216024709.2624325-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/2/25 03:47, Richard Henderson wrote:
> These defines never should have been added as they were
> never used.  Only 32-bit hosts may have these opcodes and
> they have them unconditionally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target-has.h | 2 --
>   tcg/riscv/tcg-target-has.h       | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
> index ac88522eef..188b00799f 100644
> --- a/tcg/loongarch64/tcg-target-has.h
> +++ b/tcg/loongarch64/tcg-target-has.h
> @@ -37,8 +37,6 @@
>   #define TCG_TARGET_HAS_clz_i32          1
>   #define TCG_TARGET_HAS_ctz_i32          1
>   #define TCG_TARGET_HAS_ctpop_i32        0
> -#define TCG_TARGET_HAS_brcond2          0
> -#define TCG_TARGET_HAS_setcond2         0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0

Fixes: 6cb14e4de29 ("tcg/loongarch64: Add the tcg-target.h file")

Missed in 0a16d036154 ("tcg/loongarch64: Extract TCG_TARGET_HAS_foo defs 
to 'tcg-target-has.h'")

> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index f35f9b31f5..98081084f2 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -37,8 +37,6 @@
>   #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
> -#define TCG_TARGET_HAS_brcond2          1
> -#define TCG_TARGET_HAS_setcond2         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0

Fixes: fb1f70f3685 ("tcg/riscv: Add the tcg-target.h file")

Missed in 0242532b45d ("tcg/riscv: Extract TCG_TARGET_HAS_foo defs to 
'tcg-target-has.h'")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


