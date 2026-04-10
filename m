Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3585F44842
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBARS-0001yB-0b; Fri, 10 Apr 2026 07:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBARR-0001xx-5H
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:54:29 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBARO-00084D-LL
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:54:28 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65075c2ba66so2443691d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775822065; cv=none;
 d=google.com; s=arc-20240605;
 b=MLyv6R1UKch7NNBhqOZpO0t9KoH9j6v55VJDoviv/8cV6OT8m7nLJCrit4939iL/ca
 R7WKxUveH9EMsoQGAXiI3A1HiAl/8+yGBacYqnJpDpWziAA41BTeyCjfbj+JSKcQVo32
 z8wZy9AAaO73vcpWVnGacEIH+xZ3vdFYVeW6ltL1DpidbHid+QyRFMfGg4lfNmA2ckk2
 WQEITpSU2XQn5wDMxJX6bsYLGYZNi3pxUrCTU3ne9E2/g/NRB3LVunAX0loF/4QjYb6l
 kmqATvfWRI5zsLBopNesmWj/UlkJbaP2XAftxzwZI7vAdyyg8iAd9lu+C9Uf5RB2h0Vs
 UDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OD9VUg4Hb1JkRYfbq1+/0d2jPLvQeVrxHCuNxTkexC8=;
 fh=WfmaBjntOjA/GsHgB1al5+YdfF5IDgzNkZfxJgEBWss=;
 b=joWtvR6OeD0w1qkXtfQk7aIBL2KLYV+nUlPiOz6ezVlTwpMGgYcHT2DnfgiQw+wVfM
 aSMcPdj2oRAvRB+LDk9tEyWAoVLk/AzDh4EqiOIIhaeW5/WtqoMZ74q3h/84fzsOAEbY
 w6sHX59PKi6mpF4DYpwqRx4jsDLs4/vhizYB5ApbgLeqTZ6n41WDAM8IOf8v8RlRHmUD
 0ZiuBLnh+X9vMrGaiFVBZCDmByW85fM7X4mran8JD9yItWz60y/WyGfaiSwo1Pz5kNzW
 4QSo8KnxTnJ6wdVl2azYRt5bc7ISTvxfYqFjKiecw94BdoQHXhSOVxN25rcSpoIOnzJ5
 yeUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775822065; x=1776426865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OD9VUg4Hb1JkRYfbq1+/0d2jPLvQeVrxHCuNxTkexC8=;
 b=S2JYqmlIFVxLvBFU88eX96Hb3yJ9vHQPBc1yiVpY+w5skN9jK5lHmMLRH9lnkjcYhv
 mTd3R84GCiqfZkueIvg+XT9acYYs8WpBI+wl9124znjmSmv8vcT7Vl9DUwecqlhcmfZ3
 FkxF2YIgiMZzoUWvFmCYGofah81bdaJPXqcACgkkikeevNzPbcFUh0STht9e0kWYFkZk
 MZ+pjOq/Csz8qbev4VWaA5W4QKNcav0hpQVbGp5zffgnugPopSLZGhBJAEpDbQbQiNyG
 9AzTgWucGu/Vnvxx0b+Jp1Js8kwFTuluGiecPEaUU7Vjc/G8G7Dd9uXhbbWvaKVdMZI9
 3vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822065; x=1776426865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OD9VUg4Hb1JkRYfbq1+/0d2jPLvQeVrxHCuNxTkexC8=;
 b=TQtpCW+HU/vSbYFggu3hczokvvdD4RzmYmf9UINO2K8Iq3WaoR+wXOYPi+jQQXVuDq
 qXoloOp+6RNPMfJ/jYa5MDXCSQ/wCNAkmCwVBQNqWxQOTv+XZWhi+0I4qVlMve7PJF5W
 ykin0dEKuE+iAHncejuZUeNx/9dUpVZKW6ABsIQRPTDT51y4gpcJ8soJCyGPSdKiMBAd
 KvfIkM9xW2ctirLi/zy8kKCsSqtdQjXHeyxPfZSGyrmSAUSGpd/7zRh2GvbjiemnWn3A
 ljyosLyIGaXfmtTplOL5yKRb4Y+/nSkpgmXmb12eAZcq5+OvUuzUV9B/Tj9ljHiboiNi
 +xcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPXGckjC3r754ZQKDkLWpx7OmPEgFY0Svq5so9j4ew9DTzilZWplcbdOHKYIvSsaK/41r7dEO4EB2E@nongnu.org
X-Gm-Message-State: AOJu0Yzt9YwC7MkONmThmtNQm0o6cmQYJWSxwbUJMfnpzehPd8beR90Q
 zq6HPGwTJFJTrqTsO30oHlHqm0ZvkTn4XFoYcKoxqsYa6EUbGtoEeEUwAWGK/zP20cF3MFQvbbI
 bpdd7KM/UgLNE674gEHhqXdndNZGACKrIlXQ8EnpIgg==
X-Gm-Gg: AeBDieuyVLl55+C/1+H7B32+Dp39YTkjNdj7d2T63Er55g8DKYx2Q6UliAGvDgLi/UD
 YXdhL6/AfSxxJxJdAVzxiqkVG70rPOHsLfXTs1b6ghYQCCu3gjCeQDaoWUBdbqVBYXcafJagX9t
 +B+UpOk/QgUjsFPLMyEXNJZ39V79TEJMWHIOVcb4wn9M0+HO2TvJtuYMfisITIfHQGrx2C1fW0k
 ZYM8ouU3Q1KaUxCDHSsxP/ujZ3LHOeNp6ENZ6mdRFyN/m6QWPej7UPe7sim7Z/4atSvPt4G2oMx
 lIHbSHWkNHYrlG6NnAP+vQUSEbBv13xTLfPvND8QnCFt2P4wu348GKQZQyyNI14kA1Q=
X-Received: by 2002:a53:ac0b:0:b0:64d:6cf8:f8c with SMTP id
 956f58d0204a3-65198b47273mr2034317d50.40.1775822065194; Fri, 10 Apr 2026
 04:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-2-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 12:54:12 +0100
X-Gm-Features: AQROBzDmQ53nCtw7ExhcN94LRT-6Ybbn6HxROsFcKjhECUYcK5VJMerx1ILTW9s
Message-ID: <CAFEAcA8_m567opty6USJz4zXyLKW28ufQ+JZPQBp-X7HjZRYpg@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] target/arm/cpu: Introduce the infrastructure for
 cpreg migration tolerances
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> We introduce a datatype for a tolerance with respect to a given
> cpreg migration issue. The tolerance applies to a given cpreg kvm index,
> and can be of different types:
> - ToleranceNotOnBothEnds (cpreg index is allowed to be only present
>   on one end)
> - ToleranceDiffInMask (value differences are allowed only within a mask)
> - ToleranceFieldLT (incoming field value must be less than a given value)
> - ToleranceFieldGT (incoming field value must be greater than a given value)
>
> A QLIST of such tolerances can be populated using a new helper:
> arm_register_cpreg_mig_tolerance() and arm_cpu_match_cpreg_mig_tolerance()
> allows to check whether a tolerance exists for a given kvm index and its
> criterion is matched.
>
> callers for those helpers will be introduced in subsequent patches.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>

Thanks for reworking the approach to this. I like this overall,
so my review comments are all minor stuff.

>
> ---
> v8 -> v9
> - fix the tolerance type checking
> - rename arm_cpu_cpreg_has_mig_tolerance into arm_cpu_match_cpreg_mig_tolerance
> ---
>  target/arm/cpu.h | 33 +++++++++++++++++++++

Could we put the new types, function prototypes, etc into internals.h
or cpregs.h ? Generally we try to keep things needed only in other
target/arm code in some other header than cpu.h, because cpu.h is pulled
in by a lot of other files outside target/arm.

>  target/arm/cpu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 657ff4ab20b..2b1d3af34f0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -843,6 +843,21 @@ struct ARMELChangeHook {
>      QLIST_ENTRY(ARMELChangeHook) node;
>  };
>
> +typedef enum {
> +    ToleranceNotOnBothEnds,
> +    ToleranceDiffInMask,
> +    ToleranceFieldLT,
> +    ToleranceFieldGT,
> +} ARMCPUCPREGMigToleranceType;
> +
> +typedef struct ARMCPUCPREGMigTolerance {
> +    uint64_t kvmidx;
> +    uint64_t mask;
> +    uint64_t value;
> +    ARMCPUCPREGMigToleranceType type;
> +    QLIST_ENTRY(ARMCPUCPREGMigTolerance) node;
> +} ARMCPUCPREGMigTolerance;

I don't think we need the "CPU" part of these type names. How about

ARMCPRegMigToleranceType
ARMCPRegMigTolerance

? That would match the prefix of the existing ARMCPRegInfo,
ARMCPRegUserSpaceInfo types.

> +
>  /* These values map onto the return values for
>   * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
>  typedef enum ARMPSCIState {
> @@ -1139,6 +1154,7 @@ struct ArchCPU {
>
>      QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
>      QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
> +    QLIST_HEAD(, ARMCPUCPREGMigTolerance) cpreg_mig_tolerances;
>
>      int32_t node_id; /* NUMA node this CPU belongs to */
>
> @@ -2632,6 +2648,23 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>  void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
>          *opaque);
>
> +/**
> + * arm_register_cpreg_mig_tolerance:
> + * Register a migration tolerance wrt one given cpreg identified by its
> + * @kvmidx. Only one tolerance can be registered by kvm reg idx.

We should say "Calling this function twice for the same @kvmidx
is a programming error and will cause an assertion failure."

> + */

Could we expand this doc comment to describe what the different kinds of
tolerance we can register are? We mention them briefly in the commit
message but I think that ought to be described here, including what the
"mask" and "value" arguments to this function are for.

> +void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
> +                                      uint64_t mask, uint64_t value,
> +                                      ARMCPUCPREGMigToleranceType type);
> +
> +/**
> + * arm_cpu_match_cpreg_mig_tolerance:
> + * Check whether a tolerance of type @type exists for a given @kvmidx
> + * and the tolerance criterion is satified

"satisfied"

> + */
> +bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
> +                                       uint64_t vmstate_value, uint64_t local_value,
> +                                       ARMCPUCPREGMigToleranceType type);
>  /**
>   * arm_rebuild_hflags:
>   * Rebuild the cached TBFLAGS for arbitrary changed processor state.
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7e3e84b4bbb..79e328c2888 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -181,6 +181,75 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>      QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
>  }
>
> +void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
> +                                      uint64_t mask, uint64_t value,
> +                                      ARMCPUCPREGMigToleranceType type)
> +{
> +    ARMCPUCPREGMigTolerance *t, *entry;
> +
> +    /* make sure the kvmidx has not tolerance already registered */
> +    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
> +        if (t->kvmidx == kvmidx) {
> +            g_assert_not_reached();
> +        }

    assert(kvmidx != t->kvm_idx);

is simpler (but see below).

> +    }
> +    entry = g_new0(ARMCPUCPREGMigTolerance, 1);
> +
> +    entry->kvmidx = kvmidx;
> +    entry->mask = mask;
> +    entry->value = value;
> +    entry->type = type;
> +
> +    QLIST_INSERT_HEAD(&cpu->cpreg_mig_tolerances, entry, node);
> +}
> +
> +bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
> +                                       uint64_t vmstate_value, uint64_t local_value,
> +                                       ARMCPUCPREGMigToleranceType type)
> +{
> +    ARMCPUCPREGMigTolerance *t;
> +    uint64_t diff, diff_outside_mask, field;
> +    bool found = false;
> +
> +    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
> +        if (t->kvmidx == kvmidx && t->type == type)  {
> +            found = true;
> +            break;
> +        }
> +    }
> +    if (!found) {
> +        return false;
> +    }

How about we have a function

static ARMCPUCPRegMigTolerance *find_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx)
{
    ARMCPUCPREGMigTolerance *t;
    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
        if (t->kvmidx == kvmidx)  {
            return t;
        }
    }
    return NULL;
}

Then in arm_register_cpreg_mig_tolerance() we can write
   assert(!find_mig_tolerance(cpu, kvmidx);

and in arm_cpu_match_cpreg_mig_tolerance() we can write
   ARMCPUCPREGMigTolerance *t = find_mig_tolerance(cpu, kvmidx);

   if (!t || t->type != type) {
       return false;
   }



> +
> +    /* we found one tolerance woth @type associated to the @kvmidx */

"with" (but you might consider that with the naming of the function
above, that makes this comment redundant)

> +
> +    if (type == ToleranceNotOnBothEnds) {
> +        return true;
> +    }
> +
> +    /* Need to check the mask */
> +    diff = vmstate_value ^ local_value;
> +    diff_outside_mask = diff & ~t->mask;
> +
> +    if (diff_outside_mask) {
> +        /* there are differences outside of the mask */
> +        return false;
> +    }
> +    if (type == ToleranceDiffInMask) {
> +        /* differences only in the field, tolerance matched */
> +        return true;
> +    }
> +    /* need to compare field value against authorized ones */
> +    field = vmstate_value & t->mask;
> +    if (type == ToleranceFieldLT && (field < t->value)) {
> +        return true;
> +    }
> +    if (type == ToleranceFieldGT && (field > t->value)) {
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
>  {
>      /* Reset a single ARMCPRegInfo register */
> @@ -1106,6 +1175,7 @@ static void arm_cpu_initfn(Object *obj)
>
>      QLIST_INIT(&cpu->pre_el_change_hooks);
>      QLIST_INIT(&cpu->el_change_hooks);
> +    QLIST_INIT(&cpu->cpreg_mig_tolerances);
>
>  #ifdef CONFIG_USER_ONLY
>  # ifdef TARGET_AARCH64
> @@ -1550,6 +1620,7 @@ static void arm_cpu_finalizefn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>      ARMELChangeHook *hook, *next;
> +    ARMCPUCPREGMigTolerance *t, *n;
>
>      g_hash_table_destroy(cpu->cp_regs);
>
> @@ -1561,6 +1632,10 @@ static void arm_cpu_finalizefn(Object *obj)
>          QLIST_REMOVE(hook, node);
>          g_free(hook);
>      }
> +    QLIST_FOREACH_SAFE(t, &cpu->cpreg_mig_tolerances, node, n) {
> +        QLIST_REMOVE(t, node);
> +        g_free(t);
> +    }
>  #ifndef CONFIG_USER_ONLY
>      if (cpu->pmu_timer) {
>          timer_free(cpu->pmu_timer);
> --
> 2.53.0

thanks
-- PMM

