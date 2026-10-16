Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19AECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiOq-0003gE-5I; Fri, 16 Oct 2026 09:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHiOk-0003fQ-U2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHiOi-0003MR-AS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792158898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3owZnDxfPPBPVhBKp7S/V/dJ4O1D5PPO4EeDa7UuIg=;
 b=iGA34F8N4hSIQ2GZCSndpRLc48WchGwg68K8lsVNFYRhynsQxkO2UqAVqNwxvmrhvv946U
 1NGRYA6b56u32ArMhMa5/VSvRC+DnvRi+VdAslEbcT1BwtjE8HgSWFZRuizg13gx/ut4xZ
 ebZoflH1cC3/eWJzU6/cw3AUWbxfAYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-ulXauBkgM3-NYmHxE1dZDg-1; Fri, 16 Oct 2026 13:54:57 +0000
X-MC-Unique: ulXauBkgM3-NYmHxE1dZDg-1
X-Mimecast-MFC-AGG-ID: ulXauBkgM3-NYmHxE1dZDg_1792158896
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1d15e7bfaso4517265e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158896; x=1792763696;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3owZnDxfPPBPVhBKp7S/V/dJ4O1D5PPO4EeDa7UuIg=;
 b=wfWjgnL98rAf0rBqxM75YP/l/E9VD6W0tZhUf3sTOwpl7DIXP9MhhMwnntQmMbKo+6
 LiQrxV0J8CjbEybBXxyvMXQeeloQY5w74EyGjLE8chbelGDc1ae1GhWqBq17V9Yu6ePz
 JCDyh6w6XTa/z7KKItWYjJ699ESgKgoZqUfMHN4Q8RfsXUI5xD602dTTHVNa+wFe3r2w
 OJbHDB8rstAqXgLvnd1I6XcmFQN+Tn5SuymnH4gI9TLu9biY0YzJFATH6NvyoPDu4j3A
 F0oNAjLrD4EGKpttFJU5KmiY+aMTgYRbCKK+E8kmEN7UFNvJ8faj78zjgaSGbtOcXjAE
 9v/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwJLGCEXeNicsj3S3+VGVUCFWQP+LCqyIwv4UN0E+ErS1sLdcYOdXr34M1mvryVri+eJOPBsRfCugu@nongnu.org
X-Gm-Message-State: AFq9FYJyF38OIm7eZTEY9XR8KV/oSnGlbvy0BZOWebJxzMzLaGhk1/po
 QQZgMTXbduYtTlwKY2lXXyx/ewYxlYuI+a1t7PYqO7AYoslgQTQS4acZB5eKEQLiSnZZH+2mljF
 f4V2bTXXXcLD8c7II4WvTKsQLJyUjo6nPB2lqAofuFcrTaltNVfw0pzqx
X-Gm-Gg: AYBFou2WXoJXqDRVqZdTHCgITD0cUFS8LgDkrTsdK+dklF7KlCcm4K27tYQeVXqQXTX
 rD6V432L7K7bQKYVwldpCPSONIR3arDQ+w3KKbkdbDund9dfyTd02R+f0aBxZfmN+STpyQso4VT
 nUktozrKzszXkfqaaCVSzY0dy/843CBn6pTMRpJQyoSreK/ENUyQ5xT7Gifwv7JXpxn/3AmKIfG
 rS83Vm/MDIyqxBHGRkuA5lL5lPa7bkSv1sBfrGkIVETSEm2xIT6ZD0Pp/2NSHwvp31O75LO1+Yv
 qzefPK3HqfA/XTyxNPt9fQ6cakbHLyAKYQ9GW3n6BDN+MJTeBMvM4XAIBjQzPsWRtLinFvam/DS
 +6hl2BGsTIzHhOzVl3tcIv98j+EnSPpMSxu4JVhyAY5N5QObC
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4a190780997mr316217775e9.31.1792158896251; 
 Fri, 16 Oct 2026 06:54:56 -0700 (PDT)
X-Received: by 2002:a05:600d:8488:10b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4a190780997mr316217355e9.31.1792158895821; 
 Fri, 16 Oct 2026 06:54:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm154675415e9.3.2026.10.16.06.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:54:55 -0700 (PDT)
Message-ID: <89403aff-9082-40fb-bd62-a13638bde9f7@redhat.com>
Date: Fri, 16 Oct 2026 15:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 25/25] target/arm/qmp: hook blockers in
 query-cpu-definitions
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
 <20260921123249.1708067-26-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-26-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Hi,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Report blockers for named CPU models in query-cpu-definitions.
>
> Efficiently do this by validating the realized ID register values
> against the host values. sveNNNN properties need special handling
> because they are not stored in ID registers.
>
> This way, we need not instantiate each model to check if it can be
> realized on the host, and we also get granular information about the ID
> register fields blocking realization.
>
> Introduce arm_cpu_class_check_missing_features() and
> kvm_arm_idregs_get_blockers() to achieve this.

I would recommend to show an excerpt of the output
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/arm-qmp-cmds.c    | 12 +++++++++
>  target/arm/cpu-models-stub.c |  5 ++++
>  target/arm/cpu-models.c      | 35 +++++++++++++++++++++++++
>  target/arm/cpu-models.h      |  2 ++
>  target/arm/kvm.c             | 50 ++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h         | 13 ++++++++++
>  6 files changed, 117 insertions(+)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index ba488d5c01..d837ec6653 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -379,6 +379,18 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
>      info->name = cpu_model_from_type(typename);
>      info->q_typename = g_strdup(typename);
>  
> +    /* calculate blockers */
> +    if (kvm_enabled()
> +            && !g_str_equal(info->name, "host")
> +            && !g_str_equal(info->name, "max")
> +            && arm_find_model(info->name) != NULL) {
> +        arm_cpu_class_check_missing_features(ARM_CPU_CLASS(oc),
> +                                    &info->unavailable_features);
> +        if (info->unavailable_features) {
> +            info->has_unavailable_features = true;
> +        }
> +    }
> +
>      QAPI_LIST_PREPEND(*cpu_list, info);
>  }
>  
> diff --git a/target/arm/cpu-models-stub.c b/target/arm/cpu-models-stub.c
> index 48f712d648..2d1be49e0a 100644
> --- a/target/arm/cpu-models-stub.c
> +++ b/target/arm/cpu-models-stub.c
> @@ -11,3 +11,8 @@ const ArmNamedCpuModel *arm_find_model(const char *name)
>  {
>      return NULL;
>  }
> +
> +void arm_cpu_class_check_missing_features(ARMCPUClass *acc, strList **blockers)
> +{
> +    return;
> +}
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> index 855eb5ee6b..9591b6dbfc 100644
> --- a/target/arm/cpu-models.c
> +++ b/target/arm/cpu-models.c
> @@ -477,6 +477,41 @@ static void arm_named_cpu_initfn(Object *obj)
>      arm_named_cpu_zero_unknown_feature_ids(cpu, &error_abort);
>  }
>  
> +void arm_cpu_class_check_missing_features(ARMCPUClass *acc, strList **blockers)
> +{
> +    Error *err = NULL;
> +    Object *obj = object_new_with_class(OBJECT_CLASS(acc));
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (!kvm_enabled() || !arm_find_model(acc->info->name)) {
> +        goto out;
> +    }
> +
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        aarch64_cpu_sve_finalize(cpu, &err);
> +        if (err) {
> +            error_free(err);
> +            err = NULL;
> +            uint32_t host_vq_map = cpu->sve_vq.supported;
> +            uint32_t model_vq_map = cpu->sve_vq.map;
> +
> +            if ((model_vq_map & host_vq_map) != model_vq_map) {
> +                for (int vq = 1; vq <= ARM_MAX_VQ; vq++) {
> +                    uint32_t vq_bit = (1 << (vq - 1));
> +                    if ((model_vq_map & vq_bit) && !(host_vq_map & vq_bit)) {
> +                        QAPI_LIST_PREPEND(*blockers,
> +                            g_strdup_printf("sve%d", vq * 128));
> +                    }
> +                }
> +            }
> +        }
> +    }
> +
> +    kvm_arm_idregs_get_blockers(cpu, kvm_arm_get_host_isar(), blockers);
> +out:
> +    object_unref(obj);
> +}
> +
>  void arm_register_named_cpu_models(void)
>  {
>      static ARMCPUInfo *arm_named_cpu_infos;
> diff --git a/target/arm/cpu-models.h b/target/arm/cpu-models.h
> index 144778744e..41bb15d928 100644
> --- a/target/arm/cpu-models.h
> +++ b/target/arm/cpu-models.h
> @@ -4,6 +4,7 @@
>  
>  #include "qapi/error.h"
>  #include "qom/object.h"
> +#include "cpu.h"
>  
>  typedef enum ArmModelPropType {
>      ARM_MODEL_PROP_BOOL,
> @@ -32,5 +33,6 @@ void arm_apply_model_props(Object *obj, const ArmModelPropValue *props,
>                             Error **errp);
>  void arm_realize_model_chain(Object *obj, const ArmNamedCpuModel *model,
>                               Error **errp);
> +void arm_cpu_class_check_missing_features(ARMCPUClass *acc, strList **blockers);
>  
>  #endif /* ARM_CPU_MODELS_H */
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index bb74f8c274..ca3da80262 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1485,6 +1485,56 @@ arm_field_skip_writeback_if_not_writable(const ARM64SysRegField *field)
>      return field_matches(field, ID_DFR0_EL1_IDX, "PerfMon");
>  }
>  
> +void kvm_arm_idregs_get_blockers(ARMCPU *cpu,
> +                                 const ARMISARegisters *host_isar,
> +                                 strList **blockers)
> +{
> +    for (int i = 0; i < NUM_ID_IDX; i++) {
> +        ARM64SysReg *reg = &arm64_id_regs[i];
> +
> +        if (!reg->name) {
> +            continue;
> +        }
> +
> +        for (uint32_t j = 0; j < reg->fields_count; j++) {
> +            const ARM64SysRegField *field = &reg->fields[j];
> +            ArmFieldValueSet *vs = NULL;
> +            bool supported = false;
> +            uint64_t model_val;
> +
> +            /* Not a blocker if the field is never written back to KVM. */
> +            if (arm_field_skip_writeback_always(field) ||
> +                (!arm_field_is_writable(field) &&
> +                 arm_field_skip_writeback_if_not_writable(field))) {
> +                continue;
> +            }
> +
> +            model_val = extract64(cpu->isar.idregs[field->index],
> +                                  field->shift, field->length);
nit I see you use that several times, you could introduce a helper
> +
> +            /*
> +             * If the field is written back, make sure a "supported" value
> +             * is requested.
> +             */
> +            kvm_arm_field_get_supported_values(field, host_isar, &vs);
> +            for (size_t k = 0; k < vs->n_ranges; k++) {
> +                if (model_val >= vs->ranges[k].min &&
> +                    model_val <= vs->ranges[k].max) {
> +                    supported = true;
> +                    break;
> +                }
> +            }
> +            g_free(vs->ranges);
> +            g_free(vs);
> +
> +            if (!supported) {
> +                QAPI_LIST_PREPEND(*blockers,
> +                    g_strdup_printf("SYSREG_%s_%s", reg->name, field->name));
> +            }
> +        }
> +    }
> +}
> +
>  /*
>   * Copy writable ID reg fields from isar.idregs[] into the KVM cpreg list,
>   * so the subsequent write_list_to_kvmstate() pushes them to KVM.
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index ab01ce8665..59832d8063 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -205,6 +205,19 @@ void kvm_arm_field_get_supported_values(const ARM64SysRegField *field,
>                                          const ARMISARegisters *host_isar,
>                                          ArmFieldValueSet **value_set);
>  
> +/**
> + * kvm_arm_idregs_get_blockers:
> + * @cpu: ARMCPU
> + * @host_isar: The host ISAR registers
> + * @blockers: The list of blockers
> + *
> + * Get the list of "blockers" in @cpu's idregs state for the given
> + * @host_isar.
> + */
> +void kvm_arm_idregs_get_blockers(ARMCPU *cpu,
> +                                 const ARMISARegisters *host_isar,
> +                                 strList **blockers);
> +
>  /**
>   * kvm_arm_steal_time_finalize:
>   * @cpu: ARMCPU for which to finalize kvm-steal-time
Thanks

Eric


