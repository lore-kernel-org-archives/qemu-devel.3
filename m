Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD00C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjnS-0004Nt-Vx; Wed, 21 May 2025 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjnA-0004M1-R0
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:47:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjn7-0005sz-LR
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:47:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so4389601f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747835244; x=1748440044; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nBXVOpbGyWXSIdO33E3lpC30HHFtVvz+d53JDHnGpA0=;
 b=drWhkUEcYqLewf7aOkohcu4HeS9fy9HKcKMZG528gEuAM44sM+0Nk+U4Re8HZZr9Js
 i97dSJWYMARPZX4FRxxuelfQ8OHRb7JEFPbPm/lxvQL66DsFSqJWya3bwZyb/qqB91yw
 rUQCwKR3Dyqp+Ole0AF4NXKYNbVf4pvEXHk4vMXe/DF+NHlTG1pmNGehG8QB9Riis26Y
 zDfpLgDyAq6WQ/PlhqnhoFvp2OX6uYNWDOUW1orto7EIhkhw9k3LygIPSFmhgRdJ+eAz
 ollgRtUBiRc38OVGBlG+8a01aaHESirstTMoQPefsOEpywXhlL4GL8JEQI/Bw8TH4PNm
 RFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747835244; x=1748440044;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nBXVOpbGyWXSIdO33E3lpC30HHFtVvz+d53JDHnGpA0=;
 b=sDBgSfeuaQHNXEMTEHU35QKztmY8Ka0GuWNf2VkIwuIcYaBqhM1Fv1RBG6Fvircw3o
 WHmmO3IS5TUgoob9HZowxfqojATAoFLKml7PweuCrM+wqtPphyt9sL2ath5CH0oeYbuG
 1NvlecxT6AbsY2zEc8KhX6YtAiv8IgyI7BxBbBmdfIOGN044hEhNHzi37CTGJQ0KTx+B
 erfCqzkXb4KlzIV+dC68dWUc+s3NP7HTjp1F/d1/bTNXGpZBLbktXSJtMH1plQWjUSXn
 YUBo0kb0pRpDy3QNz3pZnyNWE+lx7GyxEl588v7Lk/UGGKU2P/oJIgJ+hwip2ZAtVFPc
 FF3g==
X-Gm-Message-State: AOJu0Ywtl2BfZzsapNcNvARhHud2E9Nnvs+ho9JJw5z1CDUObhEpIvWE
 /ATTOOBb7UyORILSKoNc8esmTlt8JIiTyZABJSVkv2ghEqLKdYHFjBvpMneISEvMGOU=
X-Gm-Gg: ASbGncuswdk0vCrz+/pX7t+pcEXExytcidnQ9O5hYV2Lc+OO3/Z16P84FY8IPofEdCa
 aVH8MpKKuusEV74yi/UDBlJEpdW5t8Se7dbmczXnMBXQ6dBLKAowf7HKXKuvXY4Yd4wipSTUSI6
 TG1PNkN3Lypb9CIa1djlJ1gSmbSgQKGOw8id6klnGbCD95Q7GG21SnVZ47f2ByfVmuZBLUa7YEr
 sDxyRarY0QvLadYs5zwZos2LflUCP5ieimcwESkAw4DIgVeC2VzK0tZn5hSMKcrWwgqumg28x77
 BuOU83E03ugs0mCpCqgNJt6fBFKam5W9rtZaclk=
X-Google-Smtp-Source: AGHT+IFBc18lR0pLVn1+4oUn/5so8tIwFLcRkv+unywCd+zNbKohbVJcqmBhqJomx/MKFlLOAOyhwg==
X-Received: by 2002:a05:6000:178f:b0:3a3:7435:9a30 with SMTP id
 ffacd0b85a97d-3a374359b6fmr8481297f8f.47.1747835243807; 
 Wed, 21 May 2025 06:47:23 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef0ac6sm71707875e9.15.2025.05.21.06.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 06:47:23 -0700 (PDT)
Date: Wed, 21 May 2025 15:47:22 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 bjorn@kernel.org
Subject: Re: [PATCH 3/3] target/riscv: add profile->present flag
Message-ID: <20250521-dd501866c360e3d0853d2491@orel>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520172336.759708-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Tue, May 20, 2025 at 02:23:36PM -0300, Daniel Henrique Barboza wrote:
> Björn reported in [1] a case where a rv64 CPU is going through the
> profile code path to enable satp mode. In this case,the amount of
> extensions on top of the rv64 CPU made it compliant with the RVA22S64
> profile during the validation of CPU 0. When the subsequent CPUs were
> initialized the static profile object has the 'enable' flag set,
> enabling the profile code path for those CPUs.
> 
> This happens because we are initializing and realizing each CPU before
> going to the next, i.e. init and realize CPU0, then init and realize
> CPU1 and so on. If we change any persistent state during the validation
> of CPU N it will interfere with the init/realization of CPU N+1.
> 
> We're using the 'enabled' profile flag to do two distinct things: inform
> cpu_init() that we want profile extensions to be enabled, and telling
> QMP that a profile is currently enabled in the CPU. We want to be
> flexible enough to recognize profile support for all CPUs that has the
> extension prerequisites, but we do not want to force the profile code
> path if a profile wasn't set too.
> 
> Add a new 'present' flag for profiles that will coexist with the 'enabled'
> flag. Enabling a profile means "we want to switch on all its mandatory
> extensions". A profile is 'present' if we asserted during validation
> that the CPU has the needed prerequisites.
> 
> This means that the case reported by Björn now results in
> RVA22S64.enabled=false and RVA22S64.present=true. QMP will recognize it
> as a RVA22 compliant CPU and we won't force the CPU into the profile
> path.
> 
> [1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.belong.to.us/
> 
> Reported-by: Björn Töpel <bjorn@kernel.org>
> Fixes: 2af005d610 ("target/riscv/tcg: validate profiles during finalize")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Your s-o-b somehow got included twice.

> ---
>  target/riscv/cpu.h            | 15 +++++++++++++++
>  target/riscv/riscv-qmp-cmds.c |  2 +-
>  target/riscv/tcg/tcg-cpu.c    | 11 +++--------
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b56d3afa69..82ca41d55b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -82,7 +82,22 @@ typedef struct riscv_cpu_profile {
>      struct riscv_cpu_profile *s_parent;
>      const char *name;
>      uint32_t misa_ext;
> +    /*
> +     * The profile is enabled/disabled via command line or
> +     * via cpu_init(). Enabling a profile will add all its
> +     * mandatory extensions in the CPU during init().
> +     */
>      bool enabled;
> +    /*
> +     * The profile is present in the CPU, i.e. the current set of
> +     * CPU extensions complies with it. A profile can be enabled
> +     * and not present (e.g. the user disabled a mandatory extension)
> +     * and the other way around (e.g. all mandatory extensions are
> +     * present in a non-profile CPU).
> +     *
> +     * QMP uses this flag.
> +     */
> +    bool present;
>      bool user_set;
>      int priv_spec;
>      int satp_mode;
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index d0a324364d..ad8efd180d 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -121,7 +121,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
>  
>      for (int i = 0; riscv_profiles[i] != NULL; i++) {
>          profile = riscv_profiles[i];
> -        value = QOBJECT(qbool_from_bool(profile->enabled));
> +        value = QOBJECT(qbool_from_bool(profile->present));
>  
>          qdict_put_obj(qdict_out, profile->name, value);
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index af202c92a3..396fac0938 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -840,16 +840,11 @@ static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
>                                             RISCVCPUProfile *profile,
>                                             RISCVCPUProfile *parent)
>  {
> -    const char *parent_name;
> -    bool parent_enabled;
> -
> -    if (!profile->enabled || !parent) {
> +    if (!profile->present || !parent) {
>          return;
>      }
>  
> -    parent_name = parent->name;
> -    parent_enabled = object_property_get_bool(OBJECT(cpu), parent_name, NULL);
> -    profile->enabled = parent_enabled;
> +    profile->present = parent->present;
>  }
>  
>  static void riscv_cpu_validate_profile(RISCVCPU *cpu,
> @@ -910,7 +905,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>          }
>      }
>  
> -    profile->enabled = profile_impl;
> +    profile->present = profile_impl;
>  
>      riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
>      riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
> -- 
> 2.49.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

