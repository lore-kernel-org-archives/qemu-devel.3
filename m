Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A11CEB2CA
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 12:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKF8c-0006sn-9D; Sat, 15 Nov 2025 07:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKF8U-0006ZD-2E
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:12:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKF8S-0008UU-54
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:12:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so7097915e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 04:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763208726; x=1763813526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z9xWuJYwhhzC7GPJBalpDP3OS9vmt3cjdzN2Fkh+bIQ=;
 b=pf5NIX/d9Ki9MIl1kvFBIuyu9XNjR/Q2H63dvFcZurE/8JVcFEuBLawWJAt/4tbzG+
 xf9Q+ugwPfYO37w/MPgQQkdDNo1BC6k2QCtcRUdhwulOkPnOJUIRswskqmEOD/h9z+bo
 JvN7PzSvpncOaJM+MCGhpfeQuoYzDq0nrpAxqSQpo2H9EkyFguXK1xOJ+AN/QYUo3K9a
 w+Ax/nXTmQk0T+RbU++5+lsy6t2I5WL4Xz52baGQ4Kx0yv4BS9FBIUcq62Cvzq2Y7suI
 5499R8hoeJNZi6xW5hmOkWDhzo2K4ko0pzttoDewu4upEhlBbbB8g9OYjnLwEYsutCZH
 0r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763208726; x=1763813526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z9xWuJYwhhzC7GPJBalpDP3OS9vmt3cjdzN2Fkh+bIQ=;
 b=AdKRxg8p2XpzvEkQhM0CA3S1cTAK8FSQ+Q52Vo46ttvA9xzpIYTIbuzwTKBcchmsDR
 6NyrEHs/bcvR7PX5OmE8AdDN49r5u3yjx0rZOkcBb+yt69A+WCNvDP5rfSbvEKMZ3Ysn
 2OCxHMGoCZdni+8fCTIsCLazTQle8AUsZ9HbF1dvmOuJ6DLU+F+3vrhq+m4Ht2fRRs9i
 tVTkCKdB25m/FbOE2omOLQPCI7hCpvi2Ngt6+GH9QWHFeJ+4SeP86QFPDJL/lzVMcRrt
 bDsegHwRFA66TU0WkCqdgVPikVEKxcL+nTc52TuCKj9qRxnkJyUIuFElbfj7uiq6vC9Q
 un2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3sEf0fRsMbEWE4RWxjrB+1YVEy5nnuRLSBOl7ydpLL8EK/AavamgnNsfbzIRxC7rm3M5Wc68ODqjO@nongnu.org
X-Gm-Message-State: AOJu0YyMcfNyoqHTnkW/FoWQ0vpPyGdYmel76qK7aLblkQk7GdBUUWPr
 eTRuY4BNJc3KY+DYSoHUuqq9Cj/m6GR4ANMICtGT+h6dc8qvC14a1929xImKXmmQ8ZFslwVNHte
 IuG1r9wU=
X-Gm-Gg: ASbGncsaMHxDxbLo3+4y0J3OswtkL8jfWVzPudHQDxsfdcaZba2585xREHsZv26JMGR
 /R6by4nPCZiiatzQv2ZXjVnugXatP0ZKBGo/el4uvoTThyRsL9+n74cj8fRThQlYXSOzs7bD5B7
 dUhIC0x4w5aDeZTzfFOMiaoCyuar21vPY7giJB3t7Eni95rUEFz3fb9YZojgVHvk2iHMyOM+Vxh
 jFex/KlReNGRz4cnD0kVVKdJSbLcY/ZYH1LKbHvRnmZxIOvi3hkOvnCqGlQTcLjIDbFXdMlJqi6
 rahLZH5FDakbxtLVvxZ1MfL0h54SYesBb6iPDBcO+6GyCbMHO6SWUBeT6n4MHi2qymNo7Kc/6Rd
 MeQflGlCNKSqmgUrLjN2lWmR0Kk5e5yuBtOMw/ETVk9NlLaT2mu+R64+5ZVnuty/ZTtvYH7w4o3
 Zg3GmGOJT0XxI7zDpALvRFF7hZuvqtIxzSoX3RrIslddonD/f9BXIzd4xzZ3VMPnbTgjL/HYu7H
 aeSZW3qzw==
X-Google-Smtp-Source: AGHT+IF62fBPPojl/OxOgSLTuSKZFdXWUE/xI9pAf3MECeB3I+6lDBSWWAvLl3+ZtSraKTACt2nbVA==
X-Received: by 2002:a05:600c:3556:b0:477:bcb:24cd with SMTP id
 5b1f17b1804b1-4778fea30aemr56473585e9.22.1763208726174; 
 Sat, 15 Nov 2025 04:12:06 -0800 (PST)
Received: from [192.168.8.105] (115.red-2-141-104.dynamicip.rima-tde.net.
 [2.141.104.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e95327sm191731045e9.12.2025.11.15.04.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 04:12:05 -0800 (PST)
Message-ID: <00cc483f-a28d-4d44-b0d9-5635eb5646ab@linaro.org>
Date: Sat, 15 Nov 2025 13:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Enable ID_AA64MMFR4_EL1 register
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
 <20251112092048.450090-2-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251112092048.450090-2-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/12/25 10:17, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-sysregs.h.inc | 1 +
>   target/arm/helper.c          | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c62..2ba49d8478 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>   DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>   DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>   DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
>   DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>   DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>   DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b..c20334fa65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
>                 .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
> -            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
> +            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
> -              .resetvalue = 0 },
> +              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
>               { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
>                 .access = PL1_R, .type = ARM_CP_CONST,


