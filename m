Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191FE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxIP-0005v4-AV; Wed, 18 Dec 2024 11:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tNxI5-0005sN-I8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:52:54 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tNxI4-0007Zv-0S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:52:53 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166022c5caso55446215ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734540768; x=1735145568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQ9UV4baBMSwcaeS+fgZ1pAcBLcTcp3faVoEM9XD5QM=;
 b=gebgH602Gx4pBqwzfgcLWdqXiKCSFcenVZPIjIXY7FWkskFZ+I3ZKAFiiZfmM3idl1
 JZzlDGPnSeUja2TnPjiO9HaNd97loYLNu9MMqztLif+XOsm8HzBJYtt5jHQKF6smGYpw
 KDDSYt1EHPKgdzq6Htom5/oSA9l0OGfgIj5Bp3mhusRCwR+rTOqSjkDIcLh+Vl8xVPgl
 mfJIQiV1Kq3/31qQF6S1WAo65Uptx4NYaq8NxzdYsMVMCpWBR6yCRW+4vKwWAnCinyiS
 Yt7sS3oijTZBX7XS5iySywBTD4cXxQtRrbQLBFF6Wh1egL+o120sSwrv1cRI7gJAqqSG
 ETxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734540768; x=1735145568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQ9UV4baBMSwcaeS+fgZ1pAcBLcTcp3faVoEM9XD5QM=;
 b=oyVoYn3ErSQUe6Kd22hqgasX6MnICn2oDdbiqFXQp/tqNDzfafXEavGrvnzchnUyU1
 4BdYrRMnCAzKwRjDVe2LsNiVxlux7JAtzIA670nMzMesfXYS+/XypNUNzI0SePdYXtYg
 q5XguUv6ZFgpfQ3r++Mjv/O2SgomRMSM7zcTQ3RK3YqGIaHmNgT5BUU5i3WoBdpVvh5d
 l1ctmNRV0FTGPhYd1dyuQNO0//mGkduRQheYPtnDdE0xP1/MhEJeEu5vFrGObMk63nZa
 P2U3yTzFlFxkC8mg3GmX8yx+2ffS1aOSr2TGnx7hXwy+noCou8RcTwGCOlXXwgg59ogZ
 UL/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAGqm3y8l9nXCtge+OX1UF3Hg7t9l897JcN7kVHaUWgDnlag2tsl3btMioa7a6SnWxlx/FWfpL7SQM@nongnu.org
X-Gm-Message-State: AOJu0YzkpDfF0+L6+dJWR2fvNUWu5FmTGSNtQ6BvYHW+EkHWkZoYhxwa
 0NruVy60MppbjXglDePv/4gTRvnx9HEmtb6h9+wz0wsh7ULJP/wGBAyluuPj0qY=
X-Gm-Gg: ASbGncv/OlBPLWSwRolDAR7cSE2OT2B/o1IItRBBWYmGq+ER4fRnH5LGpPhjvC/otnb
 4SfNpg9dAZWtoZ1dcmFSSEw4ROtTEWKm+MgPD+x7Ndrd749q0QQyTZcCsjA2zs3AB+BerVOQEoL
 huclQU2GjUlSkVr97HW1gwmZDJtPi6y0hgaf4wYwGOg/hbsd1O9nHH1l3XVmhlzveVLwtj42F4G
 Syl8sS7CP3VVSLzFDmyoIsPsqBoHujwd17H6tAlAWJBt75kipl7APHnpjk7Vmn0QqlpoovzEso4
 JPG8uqwZVVU55yWcjzfmypp6/MjTIkAWRA==
X-Google-Smtp-Source: AGHT+IHuhhvvS6i8Gj4G9se35NRo8REjHPqtQG5QbeLgkSVrH6DhPQUtzbUgLITYoKV+/zAjOX1uKA==
X-Received: by 2002:a17:902:ce05:b0:215:b45a:6a63 with SMTP id
 d9443c01a7336-218d723362bmr61524445ad.32.1734540768310; 
 Wed, 18 Dec 2024 08:52:48 -0800 (PST)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5d1bcsm76150165ad.205.2024.12.18.08.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:52:47 -0800 (PST)
Message-ID: <7c04ac72-7db5-406e-81a7-478bace0c5fd@sifive.com>
Date: Thu, 19 Dec 2024 00:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] target/riscv: rvv: fix typo in vext continuous
 ldst function names
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Paolo Savini <paolo.savini@embecosm.com>
References: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
 <20241218142353.1027938-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20241218142353.1027938-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
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

Reviewed-by: Max Chou <max.chou@sifive.com>

max


On 2024/12/18 10:23 PM, Craig Blackmore wrote:
> Replace `continus` with `continuous`.
>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a85dd1d200..0f57e48cc5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -195,7 +195,7 @@ GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
>   GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
>   
>   static inline QEMU_ALWAYS_INLINE void
> -vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
> +vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>                          void *vd, uint32_t evl, target_ulong addr,
>                          uint32_t reg_start, uintptr_t ra, uint32_t esz,
>                          bool is_load)
> @@ -207,7 +207,7 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>   }
>   
>   static inline QEMU_ALWAYS_INLINE void
> -vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
> +vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
>                           void *vd, uint32_t evl, uint32_t reg_start, void *host,
>                           uint32_t esz, bool is_load)
>   {
> @@ -342,8 +342,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>   
>       if (flags == 0) {
>           if (nf == 1) {
> -            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
> -                                    esz, is_load);
> +            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
> +                                      host, esz, is_load);
>           } else {
>               for (i = env->vstart; i < evl; ++i) {
>                   k = 0;
> @@ -357,7 +357,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>           env->vstart += elems;
>       } else {
>           if (nf == 1) {
> -            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
> +            vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
>                                      ra, esz, is_load);
>           } else {
>               /* load bytes from guest memory */


