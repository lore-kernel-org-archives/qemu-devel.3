Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FA4CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9vn-00024V-J8; Wed, 29 Apr 2026 14:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9vk-00023w-4Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:46:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9vi-0002gz-Dw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:46:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso750105e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488397; x=1778093197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqHTyY/eV9Yj5rxUMndxPsZOPP1mlFXeaa4s1Vhq0OE=;
 b=K4D7lz0xLclab1RorC6E3c75l6/YPumutPZKYhk4WadQQRl4Tlbysdg932Nlh+sUU3
 YNVpARs0uvIL0nzBTUSiN1vx4fucmRHjeB0qon2Vb3QjbZo9TmUPNprTrekZerj+VTjR
 S5K4NFJOYt0TNaIuNgWCd/fEjKWLsMuyYvSDHKYJ6+ikjdgwUnYpxEHwLxqQm03qs9OF
 HVbMT2S+hr7FwFw2E8PBdX3+yCv7qMZUabYzXYuAeNI6micSgjDlKXXvFSGFFsJI+Sb7
 58Ksa/5WiR5juAG6NLE9p2sXphK27pNvdf+wsAzIAB5khjNOdqqD38ATOZeIP56MejMG
 TNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488397; x=1778093197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqHTyY/eV9Yj5rxUMndxPsZOPP1mlFXeaa4s1Vhq0OE=;
 b=GpoAXveHth4fmnRLjTyfPFkGCGtJ88rQdL1zo/prFy3JJWRy2HF0ltIavMIE6/U6zj
 mkmDZ74v5OnmHE3WZNdQyGYpe+pSvWvb5w6GcfFHIXWcH0ZRZ0ydd8T9awjaF1+BNQSe
 e0H/c9RBNb3NUf5ceW3ne1j7YSqzRMVIo7IsUykgvbpF0Dmpe6L8rA8scK90+MCKo3FT
 40mGcGPUvaWaEjEBopJgGDscqvY6vA74ZQSOBBXFx02QbUKIf0qWBNqdguFyRe64sFiw
 /x3d89SNc60SRQDM3/jKarav1useqFn31H/aRwsPA0+KtUUoESaeI5+nBA5qmnuxLem7
 hhVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80HIZ1KqX1IdDy/VGMWiM/q3CdXMWLzA+RIg3+7jWzDYWqBV24qb90sqpEF7+zTje83DI2KrDX0aGL@nongnu.org
X-Gm-Message-State: AOJu0YwArcmBaLvZJU1gc7TFyEHPusd2TX3N0UtLPfLUmLXBo1KAa8bM
 AyG38t33Pxi75CptEUiTLj8Wnd8e07bugM4XpWmhZzS4nTZdKwg/BiFwXul+qQqC+t4ecq2G5GA
 XM2F0SwY=
X-Gm-Gg: AeBDievMu4kilMy3voQC/FxilEOfK6SOqgK5kNP+tVZn0jUl2FfHFTtpaiknfT8O7VR
 7sB1tstErGeHRnVGhQ1rbwlmvsYztMBvmTwUsdU758KIPsSXNO+kHiCiDZ4iCcGH6M2oXf3oeij
 WA/ZP2mHnifmcGJzAfJQmOXdqjlrlrgPTiylSprqiiJF+q7UdaN2zj4RMzJKXrEaq5LEFv3OLp7
 TsXsRyFnrmbIp8R29q7zzgQN4+rH5UGe7z5NML9HpEsyKIeNamHj309rCe2bbi3TlTPFXvuxGKl
 XhLmgzA5BvBGLZ1jmHBLfKCVd9J/ZsJ75+qVLuaUhBD+5TKlM1pwcBCfOvwxaqr6sEUtJ89l6oI
 mOfbWRGDhIEnOna2f6aQ7YYpKc1B4Gvrg8o0TQMcfBfx3Z7i3ODZTfxYQ+BzxsW0ApPTbhXzOI6
 Af8QuxmvqhxD1AbHMGaXX0zSqRckxzQoH+B3JVSs9zQQCsrj8v8ofUljl9IAjaC5IMbNpjhQhY7
 swI
X-Received: by 2002:a05:600c:1f13:b0:48a:7772:c26b with SMTP id
 5b1f17b1804b1-48a7b546cf4mr85058565e9.26.1777488396699; 
 Wed, 29 Apr 2026 11:46:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b3csm8940585e9.13.2026.04.29.11.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:46:36 -0700 (PDT)
Message-ID: <4d641c86-96e4-402b-9247-b96fcaf852ab@linaro.org>
Date: Wed, 29 Apr 2026 20:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/84] fpu: Return struct from float128_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-47-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-47-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 105 +++++++++++++++++-------------------------------
>   1 file changed, 37 insertions(+), 68 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

