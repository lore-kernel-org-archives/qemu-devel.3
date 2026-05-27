Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95DDCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGDh-00057n-62; Wed, 27 May 2026 11:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGDZ-000570-NQ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGDX-0006ZI-O5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779895846;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnJCSe+uWFP66T9XonIRkjHBsSIKz38FDbggZYeLMyU=;
 b=WQD/j0ABCmLHKLKFS3rnQPSrJWVQIk/X+EiV2UO70IkLu5o1VSItY8Qy8CXZxLHvbjCf4M
 uKXud0q47d/4XGmuzqzcjlSXR1uWUVwTTLL37L1JCLoN2nL5K3Sb3/J2oE4vzeNgyBw53F
 yXBO58Z4wmNPPOYfFJgp0b52ebt4RdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-YSP88w22OFOTNkS2TWi8-g-1; Wed, 27 May 2026 11:30:40 -0400
X-MC-Unique: YSP88w22OFOTNkS2TWi8-g-1
X-Mimecast-MFC-AGG-ID: YSP88w22OFOTNkS2TWi8-g_1779895840
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48feb0298d7so97481225e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895839; x=1780500639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnJCSe+uWFP66T9XonIRkjHBsSIKz38FDbggZYeLMyU=;
 b=KMWP/oNl0KpKBiGGEXdz0Ph6K7ggRxqKrMlkrzojjhcupv3+h1Jv30V/lvuG/eJwkp
 Z1JXt1DOVn0fXr08lyrjozmpqWTNn+VPa++ow7yolzQda5Xh1vAyGpu3ch4jtKfpruIL
 ZbaX3lnRTeneiaB5+TX6Eo4Z6MZOJjZtMeAN4pRJ9fYzDJNgfHNE0ptJfcgM1BckfnkT
 dSHxcOYeNNJ4N8uvKuLKbB7dBeO9xa9oN02+oCi1kiXaf1AnY80LOT39DW/DvP0RTqiY
 buZFrvnolnNgWMJZ0jXIr9L8foM0hToProhpsnP4uYWFJ46mHBTz4t1+9UoFL3e69YnD
 CeYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cMg1nZnYpyR0HNOikNSUwkw5oVkBZXsfiCcqq2fxpOU3oUA/6iCVdqRSzgQpV+k+bwjWaFjtQH6On@nongnu.org
X-Gm-Message-State: AOJu0YxCEg5Brh17fwI3SMOzlYdjeqdD/6JsgUOQjl9FOcWlr5JTt65g
 QAaUBdB4J9RFuwbrEif68UDfgoZqjCz9NUTiZrpjgrzMAnP5YgogG5Adv1afJbsr3gxuJGe13bN
 21yRdld25YZ1CZHmF8fY4NlNo9eYGjLdfjSV0FeWM+3i5hL5oCwbe8Bs6
X-Gm-Gg: Acq92OF6150JS2Nx56TmrO7v5FrJz9Q3WTOXIzIyhVRp28CsEL0sO7aBG1aiDkBsIo0
 qAN+fqZhxSboOCaVKYkb/Duq8nKH3eQcy5AX2Zu9vl4DGmZs8mfLTqOUPjIOm5K9Hx25NyxkqmM
 F3CgQ1MPajokXi2fpqeA2PP/ILZESPCdVCwkvrHYbzc3tTQoWK0ZpZKqbD7ljAIDtP7VFfOTTlJ
 UE+AEfPCI08Zg7n7/k5WSRc5MWBjnVTxgjer7dwLR3JmF6Fozueg7OFs6J67wYamPinFyxWVbWh
 pyacizkyD9mEz5hWiHb+wrbY/QzrLC5VMecCpxcMyVfNqMN6V/K9GSuzcNNJJYC1ACiVby5GJtb
 4NTAkvs1UVNoaiNfE0jaIk7ET6EpTiqOUJcYBXWkPrv+PlamnCTljuBnsylHueYWG1afS7hh91Q
 JhvD6w
X-Received: by 2002:a05:600c:a402:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-490426d1a91mr278965415e9.19.1779895839428; 
 Wed, 27 May 2026 08:30:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-490426d1a91mr278964615e9.19.1779895838739; 
 Wed, 27 May 2026 08:30:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm462805075e9.9.2026.05.27.08.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:30:38 -0700 (PDT)
Message-ID: <de7ddfac-3a93-43f2-abcb-e38bb20debf5@redhat.com>
Date: Wed, 27 May 2026 17:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/18] arm/kvm: Initialize all writable ID registers
 from host
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-12-eric.auger@redhat.com>
 <7CF06975-A0CB-43CD-9B3D-FF74DBF55AB9@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7CF06975-A0CB-43CD-9B3D-FF74DBF55AB9@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/27/26 5:02 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> We want to allow overwriting writable fields of some ID registers.
>> However currently some of them are never touched, neither read nor
>> w. Examples are CLIDR_EL1, CTR_EL0, REVIDR_EL1, MIDR_EL1.
>>
>> We want to initialize them from the host value, allow overwrite
>> and write back for kvm afterwards. This patch implements the
>> initialization.
>>
>> Introduce a new get_host_cpu_idregs() helper that gets the host
>> values for all writable ID regs and store them in isar.idregs[].
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>> ---
>> target/arm/kvm.c        | 72 +++++++++++++++++++++++++++++++++++++++--
>> target/arm/trace-events |  1 +
>> 2 files changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 4adfd20050..92219ee62e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -42,6 +42,7 @@
>> #include "hw/acpi/ghes.h"
>> #include "target/arm/gtimer.h"
>> #include "migration/blocker.h"
>> +#include "cpu-idregs.h"
>>
>> const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>     KVM_CAP_INFO(DEVICE_CTRL),
>> @@ -273,7 +274,62 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
>>     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
>> }
>>
>> -static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>> +static int idregs_idx_to_kvm_feature_idx(ARMIDRegisterIdx idx)
>> +{
>> +    ARMSysRegs sysreg = id_register_sysreg[idx];
>> +
>> +    return KVM_ARM_FEATURE_ID_RANGE_IDX((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK)
>> +                                            >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
>> +                                        (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK)
>> +                                            >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
>> +                                        (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK)
>> +                                            >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
>> +                                        (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK)
>> +                                            >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
>> +                                        (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK)
>> +                                            >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
>> +}
>> +
>> +/*
>> + * get_host_cpu_idregs: Read all the writable ID reg host values
>> + *
>> + * Need to be called once the writable mask has been populated
>> + * Note we may want to read all the known id regs but some of them are not
>> + * writable and return an error, hence the choice of reading only those which
>> + * are writable. Those are also readable!
>> + */
>> +static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
>> +{
>> +    int err = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < NUM_ID_IDX; i++) {
>> +        ARM64SysReg *sysregdesc = &arm64_id_regs[i];
>> +        ARMSysRegs sysreg = id_register_sysreg[i];
>> +        uint64_t writable_mask =
>> +             cpu->writable_map[idregs_idx_to_kvm_feature_idx(i)];
>> +        uint64_t *reg;
>> +        int ret;
>> +
>> +        if (!writable_mask) {
>> +            continue;
>> +        }
>> +
>> +        reg = &ahcf->isar.idregs[i];
>> +        ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
>> +        trace_get_host_cpu_idregs(sysregdesc->name, *reg);
>> +        if (ret) {
>> +            error_report("%s error reading value of host %s register (%m)",
>> +                         __func__, sysregdesc->name);
>> +
>> +            err = ret;
>> +        }
>> +    }
>> +    return err;
>> +}
>> +
>> +static void
>> +kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf)
>> {
>>     /* Identify the feature bits corresponding to the host CPU, and
>>      * fill out the ARMHostCPUClass fields accordingly. To do this
>> @@ -359,6 +415,18 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>         SET_IDREG(&ahcf->isar, ID_AA64PFR0, 0x00000011); /* EL1&0, AArch64 only */
>>         err = 0;
>>     } else {
>> +        /* Make sure all writable ID reg values are initialized */
>> +        if (cpu->writable_map) {
>> +            err |= get_host_cpu_idregs(cpu, fd, ahcf);
>> +        }
> Again, I do not like writable_map being in ARMCPU.
>
> Why should kvm_arm_get_host_cpu_features care if writable
> map is populated or not?
>
>> +        /*
>> +         * temporarily override the CLIDR_EL1 value since some host values
>> +         * trigger "Unified type is not implemented at level n" error in
>> +         * fdt_add_cpu_nodes()
>> +         */
>> +        SET_IDREG(&ahcf->isar, CLIDR, 0x0);
>> +
> This is because by default KVM exposes a 1 level unified, 1 way 1 set simple
> cache, to efficiently handle set/way based cache operations.

I sent a separate question to the contributor in
https://lore.kernel.org/all/0fc08e52-d62c-4c40-9221-9f4e659c2aa5@redhat.com/.
You can also reply in the separate thread

This looks we need a separate fix for that, no?

Thanks

Eric
>
> TBH this is slightly ugly. Should make the virt machine code to not expose
> cache fdt nodes if using KVM.
>
> For our v2 (WIP), we have handled this by a new property ‘expose-cache’ for
> named cpu models which is used to set CLIDR and CCSIDR banks based
> on values provided by the model and only creating fdt nodes if those
> values are provided.
>
>>         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
>>         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR2_EL1_IDX);
>>         err |= get_host_cpu_reg(fd, ahcf, ID_AA64SMFR0_EL1_IDX);
>> @@ -485,7 +553,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>>     CPUARMState *env = &cpu->env;
>>
>>     if (!arm_host_cpu_features.dtb_compatible) {
>> -        kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
>> +        kvm_arm_get_host_cpu_features(cpu, &arm_host_cpu_features);
>>     }
>>
>>     cpu->kvm_target = arm_host_cpu_features.target;
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index 8502fb3265..8c7faf57c7 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -13,6 +13,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>>
>> # kvm.c
>> kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>> +get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>>
>> # cpu.c
>> arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
>> -- 
>> 2.53.0
>>
>
> Warm Regards,
> Khushit
>


