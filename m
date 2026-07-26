Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500BEC531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnzLs-0000Tr-BZ; Sun, 26 Jul 2026 09:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wnzLp-0000TE-TN
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wnzLn-0007VC-4f
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785074225;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTDKPT3VQAV53tCUW7gPrXEyb5gqnxN4RZCXgIUNRUk=;
 b=glVHfroew7CVYHq+rpwu7y5CS+y2HwuQIziRZ5TGC30Lnyesdd2nDLZRLBV3O6i4TZ2Lg0
 0eGXHZk9IAotBTyKVhWMYZbfOCDikLl1bnIQvS3ROCKi+Uos9UhjK8ja+Kl5wDZL7oP0zm
 2XD0tGCwqGnhY4L5Tr0lVRzkj7EG7iA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-h9V45xOHPymoQGsSsLuOTg-1; Sun, 26 Jul 2026 09:57:03 -0400
X-MC-Unique: h9V45xOHPymoQGsSsLuOTg-1
X-Mimecast-MFC-AGG-ID: h9V45xOHPymoQGsSsLuOTg_1785074223
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493a7fa8481so18011525e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 06:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785074222; x=1785679022;
 h=content-transfer-encoding:content-type:in-reply-to:references
 :reply-to:cc:to:from:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LTDKPT3VQAV53tCUW7gPrXEyb5gqnxN4RZCXgIUNRUk=;
 b=Bncx7bXSb1vWQrBnhV5YX3+1HgGealh5dXYHBmDukiAX4D/fDSpNxOBi1RHs0GSdaP
 AV3zr/wJg+Qq3Lis8OeQVwn/5PW3YRJQ5kx4Fz1/2HWoeEt2edX+Zb/IbWjqBr/dU5Q0
 ARBlFKIWnbEJxy8oowSsZjq0friqwuVsC0y6LtU8m0nzpTqfZ0kfMAys2+vAXlKGxpO8
 tQYqk/sm3a5ejtOGD9/yb5JCcgHSI4OzFhO30tsZzL+kasisUI6xtGooWEHkKvF1G/Kk
 laYd87OkvVjz0N1xvPeSoD+vCF2sNkD4t2MhPOL6b4icNUTM5vT+wBNJeMwgBzSOddzU
 Hu3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGWBxgoK4v5yX5RyPwbnW5mW7lp5xMy1iXkUNTdC5u8ePmNZkn4B57BKwtvk2NtHZKvMU7tR0s+FcU@nongnu.org
X-Gm-Message-State: AOJu0YwOlBu9LLpjahQ9V5Dhnkb1aWjcObRe+Z03hgg2NoXdyvLCsjez
 DTUcilK1Vgf6ikj/V3Y5/19bMBIK0f5pcqBplfgG5KJVTi4rtMR66q6ftSq+P/kAUtNd1e9JOzN
 zh2o5beFyz2P6iX/DuXrlXpTUVyoPd8Q+PHq9K/AZa+U/Ah/9fnW+b+o2
X-Gm-Gg: AR+sD10Msi/EMJofqL9e93RM9PLG2Fzzq0E78rfcsoN502ZMiFm0okpureMmUXgXfkL
 xqdAo6lZj/wAkcAqEJR6p6YEPOeVnSRaJJp8tu8AsXsgzIXLTk5G3EnM1eip6Ri9HmjyxGetLoa
 Xk5Oh87rfKjcXuZSkWeinCFV3xbNH3L1yuLYA6/ATqQZJz0y9A7je7ksNyfhkd3dayRgf9rz4cX
 y7EH9oHuJifuR1dvqwrs6ZjhVTd8omfjrySZp7v/JoKh5p1ZDaKCwoTHl3yR99bSI1seygaEO2z
 VgfAud+qA/+nOf+RL9ZEukuMMiplCFVoBV/Pan9hTiq+iT4IpTX7Kax/i0Jfb/w8X4URCjy9mcG
 o0Xw4iirU9hYA4V0FR1VVtatWnEtzftilkUc=
X-Received: by 2002:a05:600c:4704:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-496b5c92ebfmr63134635e9.19.1785074222588; 
 Sun, 26 Jul 2026 06:57:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4704:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-496b5c92ebfmr63134215e9.19.1785074222111; 
 Sun, 26 Jul 2026 06:57:02 -0700 (PDT)
Received: from [192.168.3.191] (228.246.150.77.rev.sfr.net. [77.150.246.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm153279405e9.2.2026.07.26.06.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 06:57:01 -0700 (PDT)
Message-ID: <a842eeb4-801c-4d42-825e-b5ecf581da31@redhat.com>
Date: Sun, 26 Jul 2026 15:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/19] target/arm/kvm: Handle writeback for special
 ID register fields
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 prerna.saxena@nutanix.com
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-9-khushit.shah@nutanix.com>
 <9fe4814a-5479-4180-9a61-7d2d5d2fbb92@redhat.com>
In-Reply-To: <9fe4814a-5479-4180-9a61-7d2d5d2fbb92@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-to:  eric.auger@redhat.com
X-ACL-Warn: ,  Eric Auger <eric.auger@redhat.com>
From:  Eric Auger via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/26 2:05 PM, Eric Auger wrote:
> Hi Khushit,
> On 7/16/26 11:38 PM, Khushit Shah wrote:
>> Some fields should not be written back to KVM for various reasons:
>>  - ID_AA64PFR0_EL1.GIC / ID_PFR1_EL1.GIC are fabricated by KVM based on
>>    the gic-version property.
> so this is part of the overall handling of legacy composite options
> versus sysreg settings. To be the fact they both are consistent should
> be enforced upfront.
>>  - KVM does not allow writing 0 to ID_DFR0_EL1.CopDbg, which breaks
>>    booting an AArch64-only guest on a host that also supports AArch32.
>>  - ID_DFR0_EL1.PerfMon is populated by KVM even for AArch64-only guests
>>    but is not writable there.
>>  - MPIDR_EL1 is managed by KVM based on vCPU index.
>>  - Hold off writing back CLIDR_EL1 until we properly support exposing
>>    cache topology to a KVM guest.
> Sounds this deserves a prerequisite fix. I also have this hack in my
> series but this should be dealt with separately I think.
>>
>> Some registers such as DCZID_EL0 are not exposed through the KVM cpreg
>> list at all, but guest still sees the host value, we verify that vCPU's
>> ID regs values match the host value.
> why isn't it cpreg then? Shouldn't we add it instead?
>>
>> To do this, refactor kvm_arm_writable_idregs_to_cpreg_list to
>> kvm_arm_write_idregs_to_cpregs_list, which operates per field and now
>> returns an error if a non-writable field mismatches with the host value.
>>
>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>> ---
>>  target/arm/cpu-idregs.c |  19 +++++++
>>  target/arm/cpu-idregs.h |   4 ++
>>  target/arm/kvm.c        | 116 ++++++++++++++++++++++++++++++++++------
>>  target/arm/trace-events |   2 +-
>>  4 files changed, 125 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/arm/cpu-idregs.c b/target/arm/cpu-idregs.c
>> index c41d0ab0c4..6fa02af0f3 100644
>> --- a/target/arm/cpu-idregs.c
>> +++ b/target/arm/cpu-idregs.c
>> @@ -7,6 +7,7 @@
>>   *  SPDX-License-Identifier: GPL-2.0-or-later
>>   */
>>  #include "qemu/osdep.h"
>> +#include "qemu/bitops.h"
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>> @@ -94,3 +95,21 @@ ARM64SysReg arm64_id_regs[NUM_ID_IDX] = {
>>  #include "cpu-idregs.h.inc"
>>  };
>>  
>> +uint64_t arm_get_field_mask(const ARM64SysRegField *field)
>> +{
>> +    return MAKE_64BIT_MASK(field->shift, field->length);
>> +}
>> +
>> +bool arm_field_is_writable(const ARM64SysRegField *field)
>> +{
>> +    uint64_t field_mask = arm_get_field_mask(field);
>> +
>> +    return (arm64_id_regs[field->index].writable_mask & field_mask)
>> +           == field_mask;
>> +}
>> +
>> +bool field_matches(const ARM64SysRegField *field, ARMIDRegisterIdx index,
>> +                   const char *name)
>> +{
>> +    return field->index == index && !strcmp(field->name, name);
> why do you need to check both index and name. Only checking index should
> be sufficient.
forget this, index refers to the reg while name corresponds to the field
name. Thought name was the prop name ...

Eric


>> +}
>> diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
>> index 245f1c8103..d866bd9e0a 100644
>> --- a/target/arm/cpu-idregs.h
>> +++ b/target/arm/cpu-idregs.h
>> @@ -38,4 +38,8 @@ typedef struct ARM64SysReg {
>>   */
>>  extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>>  
>> +uint64_t arm_get_field_mask(const ARM64SysRegField *field);
>> +bool arm_field_is_writable(const ARM64SysRegField *field);
>> +bool field_matches(const ARM64SysRegField *field, ARMIDRegisterIdx index,
>> +                   const char *name);
>>  #endif
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 6974e5c551..c38b99cfce 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -951,6 +951,16 @@ static uint64_t *kvm_arm_get_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
>>      return &cpu->cpreg_values[res - cpu->cpreg_indexes];
>>  }
>>  
>> +/* Like kvm_arm_get_cpreg_ptr, but returns NULL if the register is not found. */
>> +static uint64_t *kvm_arm_find_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
>> +{
>> +    uint64_t *res;
>> +    res = bsearch(&regidx, cpu->cpreg_indexes, cpu->cpreg_array_len,
>> +                  sizeof(uint64_t), compare_u64);
>> +
>> +    return res ? &cpu->cpreg_values[res - cpu->cpreg_indexes] : NULL;
>> +}
>> +
>>  /**
>>   * kvm_arm_reg_syncs_via_cpreg_list:
>>   * @regidx: KVM register index
>> @@ -1252,32 +1262,105 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>>      return true;
>>  }
>>  
>> +static bool arm_field_skip_writeback_always(const ARM64SysRegField *field)
>> +{
>> +    /*
>> +     * GIC is controlled by the gic-version property and fabricated by KVM
>> +     * when the vGIC device is created, so a named CPU model must not touch
>> +     * it. KVM also rejects writing 0 to ID_DFR0_EL1.CopDbg, which breaks
>> +     * booting a model that lacks AArch32 support on a host that supports
>> +     * it. MPIDR_EL1 is managed by KVM based on number of vCPUs, skip
>> +     * writing it back. Similarly, skip writing back CLIDR_EL1 till we
>> +     * properly support exposing cache for KVM guest.
>> +     */
>> +    return field_matches(field, ID_AA64PFR0_EL1_IDX, "GIC")
>> +        || field_matches(field, ID_PFR1_EL1_IDX, "GIC")
>> +        || field_matches(field, ID_DFR0_EL1_IDX, "CopDbg")
>> +        || field->index == MPIDR_EL1_IDX
>> +        || field->index == CLIDR_EL1_IDX;
>> +}
>> +
>> +static bool arm_field_skip_writeback_if_not_writable(const ARM64SysRegField *field)
>> +{
>> +    /*
>> +     * KVM populates ID_DFR0_EL1.PerfMon even for AArch64-only guests but
>> +     * does not expose it as writable there, so skip it when it is not
>> +     * writable.
>> +     */
>> +    return field_matches(field, ID_DFR0_EL1_IDX, "PerfMon");
>> +}
>> +
>>  /*
>> - * Copy writable ID regs from isar.idregs[] to cpreg_list
>> - * in case their value differs from the original init cpreg value
>> + * Copy writable ID reg fields from isar.idregs[] into the KVM cpreg list,
>> + * so the subsequent write_list_to_kvmstate() pushes them to KVM.
>> + * Only writable fields are copied; fields that must not be written back
>> + * (see arm_field_skip_writeback_*) are skipped.
>> + * Returns -1 if any vCPU's ID reg value differs from the host value and the
>> + * field is not writable.
>>   */
>> -static void kvm_arm_writable_idregs_to_cpreg_list(ARMCPU *cpu)
>> +static int kvm_arm_write_idregs_to_cpreg_list(ARMCPU *cpu)
>>  {
>>      for (int i = 0; i < NUM_ID_IDX; i++) {
>>          ARM64SysReg *sysregdesc = &arm64_id_regs[i];
>>          ARMSysRegs sysreg = id_register_sysreg[i];
>> -        uint64_t previous, new;
>> +        uint64_t writable_mask = sysregdesc->writable_mask;
>> +        uint64_t desired = cpu->isar.idregs[i];
>> +        uint64_t previous, updated;
>>          uint64_t *cpreg;
>>  
>> -        if (!sysregdesc->writable_mask) {
>> +        cpreg = kvm_arm_find_cpreg_ptr(cpu, idregs_sysreg_to_kvm_reg(sysreg));
>> +        /*
>> +         * Registers such as DCZID_EL0 are not exposed through the cpreg
>> +         * list and are therefore not writable. Use the host value
>> +         * snapshotted at probe time as the reference to check the vCPU ID
>> +         * regs have the same value.
>> +         */
>> +        previous = cpreg ? *cpreg : arm_host_cpu_features.isar.idregs[i];
>> +
>> +        if (previous == desired) {
>>              continue;
>>          }
> while at it you could also test all reserved fields here, RAZ, RES0/1
> and make sure host value complies with the description.
>>  
>> -        cpreg = kvm_arm_get_cpreg_ptr(cpu, idregs_sysreg_to_kvm_reg(sysreg));
>> -        previous = *cpreg;
>> -        new = cpu->isar.idregs[i];
>> +        for (int j = 0; j < sysregdesc->fields_count; j++) {
>> +            const ARM64SysRegField *field = &sysregdesc->fields[j];
>> +            uint64_t field_mask = arm_get_field_mask(field);
>> +            uint64_t prev_val = previous & field_mask;
>> +            uint64_t new_val = desired & field_mask;
>> +
>> +            if (prev_val == new_val) {
>> +                continue;
>> +            }
>> +
>> +            if (arm_field_skip_writeback_always(field) ||
>> +                (!arm_field_is_writable(field) &&
>> +                 arm_field_skip_writeback_if_not_writable(field))) {
>> +                /* Never write this field back; keep KVM's value. */
>> +                writable_mask &= ~field_mask;
>> +                continue;
>> +            }
>> +
>> +            if (!arm_field_is_writable(field)) {
>> +                error_report("%s.%s is not writable: host=0x%" PRIx64
>> +                             ", requested=0x%" PRIx64,
>> +                             sysregdesc->name, field->name,
>> +                             prev_val >> field->shift, new_val >> field->shift);
>> +                return -1;
>> +            }
>> +        }
>> +
>> +        if (!cpreg || !writable_mask) {
>> +            continue;
>> +        }
>>  
>> -        if (previous != new) {
>> -            *cpreg = new;
>> -            trace_kvm_arm_writable_idregs_to_cpreg_list(sysregdesc->name,
>> -                                                        previous, new);
>> -         }
>> +        updated = (previous & ~writable_mask) | (desired & writable_mask);
>> +        if (updated != previous) {
>> +            *cpreg = updated;
>> +            trace_kvm_arm_write_idregs_to_cpreg_list(sysregdesc->name,
>> +                                                        previous, updated);
>> +        }
>>      }
>> +
>> +    return 0;
>>  }
>>  
>>  void kvm_arm_reset_vcpu(ARMCPU *cpu)
>> @@ -2235,8 +2318,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      if (ret) {
>>          return ret;
>>      }
>> -    /* overwrite writable ID regs with their updated property values */
>> -    kvm_arm_writable_idregs_to_cpreg_list(cpu);
>> +    /* overwrite ID reg fields with their updated property values */
>> +    ret = kvm_arm_write_idregs_to_cpreg_list(cpu);
>> +    if (ret) {
>> +        return ret;
>> +    }
>>      ret = write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE);
>>      if (!ret) {
>>          return -1;
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index f33b0d821d..f042ab59b8 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -14,7 +14,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>>  # kvm.c
>>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>>  get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>> -kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
>> +kvm_arm_write_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
>>  
>>  # cpu64.c
>>  get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
> Thanks
> 
> Eric


