Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60715CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZ3S-0004Uq-9v; Fri, 22 May 2026 19:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQZ3Q-0004Nr-M1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:13:20 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQZ3N-00066u-HK
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:13:19 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-57516e08474so6048080e0c.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779491596; x=1780096396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GEFD1n5j9GGzU4s63QqricYbFjRfTK2BLi6JRIRb1RU=;
 b=in7aAZzktxuJEW9g2s+N6JWC+VPOlO86NV0JG4hAr4iKPYQaroT/DznED0tDccmcCj
 vzyFXGuZVvInUpQXPDI5a1oZi873OmEnIvXSqGiz3mu9NboQPLkFG5sxb60pg5RdUP4u
 kxgcgRzxaDa3ZPMVQjhhO1S+CN34PXh5N53eTksf7ygn5SE3QWLekx4Eq2DeX67lr+4r
 kQxeWWMXXGt9HcN8LfsVNgiwkaSTP3XUNgPfDXkujuukRRMkw497GsYLXAr6Y+Kh4zvJ
 Vw8Wa34BeFezYRRYDrB5mmhNT0M4UDb1gsGxSTlZABMrZPNL4m83P4WScrZ2sxVo8jm0
 r1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779491596; x=1780096396;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEFD1n5j9GGzU4s63QqricYbFjRfTK2BLi6JRIRb1RU=;
 b=Nk9yaNnIiciTc7FQUb6Rs5cTf+XIqVkfiYjp29W86jroM0tHOAxAHBX4UrLslvDbjF
 szeSDKgXAOlezs8G6mFOOs+RopKhEkz9VAjA74A4j75hLjzHFEs3roDrHB6/rIySTVt/
 dqcXOn1dbU+YkE6Zms9s5XopHmFr9mnaSQcdvNg37j7ruNFIEyICltgUFzXBQJtW5JmD
 67R41kHQydvKbB6mwG2HVSjrnB4G/bdtdmaMjHgYpZoZOT3UXNURHNqjAFsao+JzYZT+
 pZsdQ5J6Q0ag9W4tFwXpZqQIb/1RRfV2cqIaFxK7UcENJD0TDHZC1Zerb0gm3kkD/wm8
 Jj0g==
X-Gm-Message-State: AOJu0YyCYTZaAVgOQ9zvXrjR6OVjY6wqlZigswDCISf717EQEHhd66mM
 /JuFg8Vrotj+GakMA4cdSEbmOIniCHbNV3A9bM24zW4wkYP62S8PBoaCCYUCJyl2OkduOJix/8q
 hx8tS
X-Gm-Gg: Acq92OGn8z7ml4zoxb3HUFCtEfbeSDchX9YGZUNF3ZWg7jh+UqXK2mDeGoWdmPuYv+Z
 HRYQhsC97jhl6zF7R+PHzigSS1G4RJg49R41QDQgFxXsSsFdlqYHqJoWc725zGXDA42W4dWm6pv
 gqpLq6WZ7xs0OHmypDXKAktUQmn+ZcoBVgXg6ySGqMown5tDJATc6+ltYZyMX0lJhNN0gjjiWdN
 c6suV5c300rOmbn1UTsVxzYw4dgZor3xOleIHLAjiYqNvvfeb38E4u8jr9Que9mJtElLgunVnH0
 +xBFQygV5QiweGCOvbYvG4bx7/VyRF/8VB6p+17W/La1Uq+gKO121AEWF/1pasVmPJLIPldLRt2
 QY0Kly9vFG8+ztQZ3UCM/KscCnyCGOxP8FjEmU/rd941b6MyKpcLP57rtfctq0OKczey9744Ogr
 e+7qmnIhFnGvfpvEO9Whl/rqBDdz6ltqXhFsNiLJOa
X-Received: by 2002:a17:903:3c2d:b0:2b2:42b1:adac with SMTP id
 d9443c01a7336-2beb031af0bmr55417255ad.3.1779490807477; 
 Fri, 22 May 2026 16:00:07 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm25164035ad.76.2026.05.22.16.00.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:00:07 -0700 (PDT)
Message-ID: <47c1bfab-8d88-4e61-b374-8c6b101daaaf@linaro.org>
Date: Fri, 22 May 2026 16:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
To: qemu-devel@nongnu.org
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260519153249.31100-2-wrigjl@proton.me>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519153249.31100-2-wrigjl@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I did this myself 9 months ago, but never posted it for some reason.

https://gitlab.com/rth7680/qemu/-/commit/2598d4896e19376fbae3926728ac737e7bbea190

The only difference I have is

> +static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                  bool isread)
> +{
> +    if (env->cp15.scr_el3 & SCR_TRNDR) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +    return CP_ACCESS_OK;
> +}

static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
{
     if (env->cp15.scr_el3 & SCR_TRNDR) {
         return CP_ACCESS_TRAP_EL3;
     }
     /*
      * Note that FEAT_RNDR_TRAP may be implemented without FEAT_RNDR.
      * In that case, if the trap is not enabled, the read undefs.
      */
     if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
         return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
}

...

     if (cpu_isar_feature(aa64_rndr, cpu) ||
         cpu_isar_feature(aa64_rndr_trap, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }


r~

