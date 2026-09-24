Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C407C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9dLe-0000Uf-2q; Thu, 24 Sep 2026 02:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9dLY-0000UE-H0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9dLW-00036M-1V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 02:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDLbeH2FlzuhXW9rwMbnBfXwetXfylZcqNOyrQMFHF4=;
 b=KN3cnvx2DVtXSPmS9Or8LYAAXH4Xezd4gjWH6ob72tMtIMkYPVRa64+ADaEy606mtpDqfr
 hoEe7ABhbey+mm3MRIa7dNONkGmM/KBYnsU76LdNYNk9JFtA7CN9Q9TL/j7mfKPE/Gn1QO
 a03rHnYx+SMDvNop0d61i/EE/v12KSU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-XzREprhdPtiqImKPjusuxw-1; Thu, 24 Sep 2026 02:54:14 -0400
X-MC-Unique: XzREprhdPtiqImKPjusuxw-1
X-Mimecast-MFC-AGG-ID: XzREprhdPtiqImKPjusuxw_1790232853
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6ba4abdfso20508385e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 23:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232853; x=1790837653;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDLbeH2FlzuhXW9rwMbnBfXwetXfylZcqNOyrQMFHF4=;
 b=M08TOMQs7VuvZgKCa84Pfrot/56Ie0qW5iV2bHYW/Mb/GFxDNQ9MHA9oRC3O8V4zoH
 kryD1Z9AtYTW7GQbae6rUEtGbU+FiQy48zW9AdlW1RhzmsFuxNDXxgrwuMSnpb6/18ps
 ZmYmD6xRvXMVy4hmotApXz8DMl56FHu04a2eEeM7hLGlKN/53PjUnte1Q/ayzf3VlEud
 3BYk8ycRP3yHQwbZ87KFHQCy/DlqMxA0aOj5GkFHfjEE/QclQhEhaK0BTj4dOm7PS+2k
 Wua9aLMR4G5E5gQvOcBVplFm1cvbOMwcgqyWobNX/dgaVmZULucaD8IVPcE8KZmKkKpI
 7R/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuo8QW0tTCRbFzCtb6OqDzETtXxBwHMxe6zBW6NRpka1VvNzOlv2OUTkUeRVgoYoGzsVDIqK7tGWw4@nongnu.org
X-Gm-Message-State: AFuF++nS7phnVIRTmZOwZIB6MqCJSC9aSiEMhJgSUA1lTqcYJMMkD/h0
 YeM7srOyiqI3s99hKKbYgHd5GMaH4OjrbpzkoczJksKBgD9ezrFNfboKiZN+nw27qzYRR2y/RHG
 FGjpFuIOJQQV9JFF5NToypioxIPjEGzlRzUuBu2tOv8Bk/4R3Kx/nkLfA
X-Gm-Gg: AYBFou0cGdfxNQLGhcjwWNWJJfmjpT535SisJnKUHh/yhganHhVia3oow1z3DeimInF
 vjqFzU/BS8W78P7nGQFCZZq5g7ae9Y5x72QcAHvUuIbtoV9+ozgmPoOna6fzZ9YeW3UPLqTxHiE
 FbbLd8cJtyFT6ymd2hROPVcHXfla/6i7tmMvJ0D9jq6P5GD7HSV56PAZJday51KiTJR10aV3cPf
 j/MgsxFcQ5yy6//JHBBBC2kVCgugox48Rc2yi3GsQqWyoO3itzgAzm7GRjUQgzBQla90K5kDxTl
 4vxEuci3J/CFGRdX6qpTGLeNxsC/W8bcoZsw+gfrGvHB+HKZ3MGdcR6HzQty0zSPOgtabUaU8Co
 NND+R9JDHolxmJHcWL3EmLvSz0MskXPv8Mf/iaOvJxoSIYsGD
X-Received: by 2002:a05:6000:71a:b0:487:c3e:8df8 with SMTP id
 ffacd0b85a97d-488716b6caemr2225443f8f.5.1790232853176; 
 Wed, 23 Sep 2026 23:54:13 -0700 (PDT)
X-Received: by 2002:a05:6000:71a:b0:487:c3e:8df8 with SMTP id
 ffacd0b85a97d-488716b6caemr2225395f8f.5.1790232852820; 
 Wed, 23 Sep 2026 23:54:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877970fsm12638914f8f.24.2026.09.23.23.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 23:54:12 -0700 (PDT)
Message-ID: <41f47202-cf63-4586-a6b8-9dd9001a1f6b@redhat.com>
Date: Thu, 24 Sep 2026 08:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 03/25] target/arm: move SYSREG_ prop infra to
 cpu64.c
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-4-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-4-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/21/26 2:32 PM, Khushit Shah wrote:
> kvm_arm_expose_idreg_properties() no longer depends on KVM-specific
> logic. Move it to cpu64.c as aarch64_add_idregs_properties() along with
> all SYSREG_ property infra, making it accelerator-agnostic.
Even before, the code had no real kvm adherence, I mean even if we keep
reg->writable_mask checks. This latter could be populated with another
accelerator. So I think I can move in this direction in the parent series.

Eric
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu64.c      | 101 +++++++++++++++++++++++++++++++++++++++-
>  target/arm/internals.h  |   1 +
>  target/arm/kvm.c        | 100 ---------------------------------------
>  target/arm/kvm_arm.h    |  10 ----
>  target/arm/trace-events |   4 +-
>  5 files changed, 104 insertions(+), 112 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 3d522bf20d..7487b48cc9 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -38,6 +38,7 @@
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpu-idregs.h"
> +#include "trace.h"
>  
>  /* convert between <register>_IDX and SYS_<register> */
>  #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
> @@ -644,6 +645,104 @@ static const Property arm_cpu_pauth_qarma3_property =
>  static Property arm_cpu_pauth_qarma5_property =
>      DEFINE_PROP_BOOL("pauth-qarma5", ARMCPU, prop_pauth_qarma5, false);
>  
> +#ifndef CONFIG_USER_ONLY
> +static void set_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t old, value, mask;
> +    int lower = field->shift;
> +    int length = field->length;
> +    int index = field->index;
> +
> +    if (!visit_type_uint64(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (length < 64 && value > ((1 << length) - 1)) {
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> +                   name, value, length);
> +        return;
> +    }
> +
> +    if (field->arch_vals) {
> +        /* this field has some enum values */
> +        for (int i = 0; i < field->arch_vals_count; i++) {
> +            if (value == field->arch_vals[i]) {
> +                goto valid;
> +            }
> +        }
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) does not match any "
> +                   "arch valid enum value", name, value);
> +        return;
> +    }
> +
> +valid:
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = value << lower;
> +    old = idregs[index];
> +    idregs[index] = old & ~mask;
> +    idregs[index] |= value;
> +    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
> +}
> +
> +static void get_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t value, mask;
> +    int lower = field->shift;
> +    int length = field->length;
> +    int index = field->index;
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = (idregs[index] & mask) >> lower;
> +    visit_type_uint64(v, name, &value, errp);
> +    trace_get_sysreg_prop(name, value);
> +}
> +
> +static void add_idregs_properties(Object *obj, ARM64SysReg *reg)
> +{
> +    int nb_sysreg_props = 0;
> +
> +    for (int i = 0; i < reg->fields_count; i++) {
> +        ARM64SysRegField *field = &reg->fields[i];
> +
> +        /* skip reserved fields */
> +        if (g_str_equal(field->name, "RES0") ||
> +            g_str_equal(field->name, "RES1") ||
> +            g_str_equal(field->name, "RAZ")) {
> +            continue;
> +        }
> +
> +        char *prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name,
> +                                          field->name);
> +        object_property_add(obj, prop_name, "uint64",
> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> +        g_free(prop_name);
> +        nb_sysreg_props++;
> +    }
> +
> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> +}
> +
> +void aarch64_add_idregs_properties(Object *obj)
> +{
> +    for (int i = 0; i < NUM_ID_IDX; i++) {
> +        add_idregs_properties(obj, &arm64_id_regs[i]);
> +    }
> +}
> +#endif
> +
>  void aarch64_add_pauth_properties(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -810,7 +909,7 @@ void aarch64_host_initfn(Object *obj)
>      aarch64_add_sve_properties(obj);
>  
>      /* generate SYSREG properties */
> -    kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
> +    aarch64_add_idregs_properties(obj);
>  
>  #elif defined(CONFIG_HVF)
>      hvf_arm_set_cpu_features_from_host(cpu);
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f6b4e173a5..7c76ffea7d 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1813,6 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
>  void aarch64_add_pauth_properties(Object *obj);
>  void aarch64_add_sve_properties(Object *obj);
>  void aarch64_add_sme_properties(Object *obj);
> +void aarch64_add_idregs_properties(Object *obj);
>  void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa64_enabled);
>  void aarch64_host_initfn(Object *obj);
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 2f6c090e43..d5155a3706 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -416,106 +416,6 @@ bool kvm_idreg_write_scratch_vcpu(int cpufd, Visitor *v, const char *name,
>      return true;
>  }
>  
> -static void set_sysreg_prop(Object *obj, Visitor *v,
> -                            const char *name, void *opaque,
> -                            Error **errp)
> -{
> -    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    uint64_t *idregs = cpu->isar.idregs;
> -    uint64_t old, value, mask;
> -    int lower = field->shift;
> -    int length = field->length;
> -    int index = field->index;
> -
> -    if (!visit_type_uint64(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    if (length < 64 && value > ((1 << length) - 1)) {
> -        error_setg(errp,
> -                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> -                   name, value, length);
> -        return;
> -    }
> -
> -    if (field->arch_vals) {
> -        /* this field has some enum values */
> -        for (int i = 0; i < field->arch_vals_count; i++) {
> -            if (value == field->arch_vals[i]) {
> -                goto valid;
> -            }
> -        }
> -        error_setg(errp,
> -                   "idreg %s set value (0x%lx) does not match any "
> -                   "arch valid enum value", name, value);
> -        return;
> -    }
> -
> -valid:
> -
> -    mask = MAKE_64BIT_MASK(lower, length);
> -    value = value << lower;
> -    old = idregs[index];
> -    idregs[index] = old & ~mask;
> -    idregs[index] |= value;
> -    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
> -}
> -
> -static void get_sysreg_prop(Object *obj, Visitor *v,
> -                            const char *name, void *opaque,
> -                            Error **errp)
> -{
> -    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    uint64_t *idregs = cpu->isar.idregs;
> -    uint64_t value, mask;
> -    int lower = field->shift;
> -    int length = field->length;
> -    int index = field->index;
> -
> -    mask = MAKE_64BIT_MASK(lower, length);
> -    value = (idregs[index] & mask) >> lower;
> -    visit_type_uint64(v, name, &value, errp);
> -    trace_get_sysreg_prop(name, value);
> -}
> -
> -static void
> -add_idreg_field_properties(Object *obj, ARM64SysReg *reg)
> -{
> -    int nb_sysreg_props = 0;
> -
> -    for (int i = 0; i < reg->fields_count; i++) {
> -        ARM64SysRegField *field = &reg->fields[i];
> -
> -        /* skip reserved fields */
> -        if (g_str_equal(field->name, "RES0") ||
> -            g_str_equal(field->name, "RES1") ||
> -            g_str_equal(field->name, "RAZ")) {
> -            continue;
> -        }
> -
> -        char *prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name,
> -                                          field->name);
> -        object_property_add(obj, prop_name, "uint64",
> -                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> -        g_free(prop_name);
> -        nb_sysreg_props++;
> -    }
> -
> -    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> -}
> -
> -void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
> -{
> -    Object *obj = OBJECT(cpu);
> -
> -    for (int i = 0; i < NUM_ID_IDX; i++) {
> -        ARM64SysReg *sysregdesc = &regs[i];
> -        add_idreg_field_properties(obj, sysregdesc);
> -    }
> -}
> -
>  static void
>  kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  {
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index aafb3cd232..997120966f 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -163,16 +163,6 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>   */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>  
> -typedef struct ARM64SysReg ARM64SysReg;
> -/**
> - * kvm_arm_expose_idreg_properties:
> - * @cpu: The CPU object to generate the properties for
> - * @reg: registers from the host
> - *
> - * analyze the writable mask and generate properties for writable fields
> - */
> -void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
> -
>  /**
>   * kvm_arm_steal_time_finalize:
>   * @cpu: ARMCPU for which to finalize kvm-steal-time
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 7696a8ed40..bbf2e5dfa2 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -15,10 +15,12 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>  get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>  kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
> +kvm_idreg_write_scratch_vcpu(const char *name, uint64_t oldfv, uint64_t newfv, uint64_t actualfv) "successful dry-run for %s old=0x%"PRIx64" new=0x%"PRIx64" actual=0x%"PRIx64
> +
> +# cpu64.c
>  get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
>  set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
>  nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
> -kvm_idreg_write_scratch_vcpu(const char *name, uint64_t oldfv, uint64_t newfv, uint64_t actualfv) "successful dry-run for %s old=0x%"PRIx64" new=0x%"PRIx64" actual=0x%"PRIx64
>  
>  # cpu.c
>  arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64


