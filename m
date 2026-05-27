Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F9BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGFr-0005pr-7C; Wed, 27 May 2026 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGFg-0005lC-LX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGFd-0007vz-2b
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779895975;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ic8Wg9aAPk+Mhhq/27qjdOX4g2Kr5WbssMEq9vuslTE=;
 b=gBU8yi2+F9FiqMjezUdVWBjbpKf8F/Av712T0QDIlfVJT54FPWxsYLpEgZ5kNVJqpzXNyF
 QLD9m/XbLjaJYTAsYtOSILpyuilVmqYXoJ0YWUV3PxVDPgNb3Dxh/oOVdHlqoLNi1u6VKA
 3Lu2CcJS74+9w21rtbIp4s2nfR77lTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-S9Ve-YIdPMq86or9o3zcDg-1; Wed, 27 May 2026 11:32:53 -0400
X-MC-Unique: S9Ve-YIdPMq86or9o3zcDg-1
X-Mimecast-MFC-AGG-ID: S9Ve-YIdPMq86or9o3zcDg_1779895973
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd233d1e2so27709565e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895973; x=1780500773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic8Wg9aAPk+Mhhq/27qjdOX4g2Kr5WbssMEq9vuslTE=;
 b=i6OoDC4HU9MROUfXshWhASFpuE6Qc1486ohF3O1xE1g87AfLJv534HSFTLBnDX1Wm+
 lvBEBlYwQDGLau6NN5uwMn96Dxr03gOH3AI5QolGeFsF+tvzTTa4Sqop/RWOf9KNxMPT
 FnhnquMAtzN2VyiHpleK6rn3XpN8wlDd/15ug4n3gYK88F8FhhzTdcOft1lsmuXYfTeA
 ENgp0AK+mueSU9zpJFeLaZar6o2LFlPz/hdvX+HtcVZUR+U7KOh3bBdvJjM8NoMtnZa+
 yGREhFEUv/HIngRAGU4MbCS1v+Hgu81VwJ8RmIXABjISL2QupQXL+YNV3zmczxXLYC1m
 /O/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7rtKTiX/vGRuA2Tl3aSScU4ExP3iqpcc3nKESNn5/kMmOWvtkeBncaLDdNBtUwEgEcWKO08asgkv+@nongnu.org
X-Gm-Message-State: AOJu0Yxd+dhCfaNytCeKl90bSi7SOuL72fOmyo1smzxZtb849fjqoWsy
 JTQ0c84AnGTwEES4LAZl7D+hzLOl7ikZu0tbNF3RXfnc/1PUE+CfqqDha7Qt/P7cANHmxUvm0n0
 UMwnIWnkXodxWSNm4dwOYZqISWzCI+ua97381Iz53+Apeu8y6t4yDrmDW
X-Gm-Gg: Acq92OHGAozHSfm8fgLdUX5We4btjtzV8QPqSpQdqMLyph6rgWNYTwDYQK0UULbu5Ya
 7X84OJzyfEqQhXX0dLt1ZQZREQwSdM6eD1TbhTM9s7EiJOvPYP1XHI4pPOiAQE9EOdQy+6kw4dS
 +8DhCG3foBpHMMtK+5kt0wjb2fUdjCBQBuVL0XSfUaivlNGbf95XILnssME8MVYeaxojDDESO2H
 n/gQleZxRbp84JWhRDGuOxRCE/lzDmZ+aYehL8UTyA0tqR0xNhAQHiujzxjG0UGZzqe/udDYIyf
 PSpTneY0FFHyTRVNU1YoSfSj9qT52+oMPDwwYGZtqn+PrJIZEZJtTK1fQEginVpQxSHw8YXgcLE
 e9SAievrkHMZGO5tQPSKb5N5ic7pjQVWO/VhHznqOfeEHeWV9W8OoYAMjAm7X92jpMdTU7Q==
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-490426bc737mr438889675e9.19.1779895972597; 
 Wed, 27 May 2026 08:32:52 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-490426bc737mr438888955e9.19.1779895972126; 
 Wed, 27 May 2026 08:32:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm393564415e9.11.2026.05.27.08.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:32:51 -0700 (PDT)
Message-ID: <c4a38526-a803-4e69-b6ca-f6bf0583198a@redhat.com>
Date: Wed, 27 May 2026 17:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/18] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
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
 <20260519132905.145643-14-eric.auger@redhat.com>
 <3344B74E-39B1-421D-8417-373A688DB372@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3344B74E-39B1-421D-8417-373A688DB372@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 5/27/26 5:08 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> This helper decode the ID reg writable mask, matches it against
>> ID reg fields defined in target/arm/cpu-idregs.h.inc and
>> for each writable named field, generates a uint64 property.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v4 -> v5:
>> - free prop_name
>> - check cpu->writable_map as a preamble in kvm_arm_expose_idreg_properties
>> ---
>> target/arm/kvm.c        | 135 ++++++++++++++++++++++++++++++++++++++++
>> target/arm/kvm_arm.h    |  10 +++
>> target/arm/trace-events |   4 ++
>> 3 files changed, 149 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 30c5175c68..960052e67e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -343,6 +343,141 @@ static int get_host_cpu_idregs(ARMCPU *cpu, int fd, ARMHostCPUFeatures *ahcf)
>>     return err;
>> }
>>
>> +static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
>> +{
>> +    for (int f = 0; f < reg->fields_count; f++) {
>> +        struct ARM64SysRegField *field = &reg->fields[f];
>> +        int upper = field->shift + field->length - 1;
>> +
>> +        if (i >= field->shift && i <= upper) {
>> +            return field;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static void set_sysreg_prop(Object *obj, Visitor *v,
>> +                            const char *name, void *opaque,
>> +                            Error **errp)
>> +{
>> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    uint64_t *idregs = cpu->isar.idregs;
>> +    uint64_t old, value, mask;
>> +    int lower = field->shift;
>> +    int length = field->length;
>> +    int index = field->index;
>> +
>> +    if (!visit_type_uint64(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +
>> +    if (length < 64 && value > ((1 << length) - 1)) {
>> +        error_setg(errp,
>> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
>> +                   name, value, length);
>> +        return;
>> +    }
>> +
>> +    mask = MAKE_64BIT_MASK(lower, length);
>> +    value = value << lower;
>> +    old = idregs[index];
>> +    idregs[index] = old & ~mask;
>> +    idregs[index] |= value;
>> +    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
>> +}
>> +
>> +static void get_sysreg_prop(Object *obj, Visitor *v,
>> +                            const char *name, void *opaque,
>> +                            Error **errp)
>> +{
>> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    uint64_t *idregs = cpu->isar.idregs;
>> +    uint64_t value, mask;
>> +    int lower = field->shift;
>> +    int length = field->length;
>> +    int index = field->index;
>> +
>> +    mask = MAKE_64BIT_MASK(lower, length);
>> +    value = (idregs[index] & mask) >> lower;
>> +    visit_type_uint64(v, name, &value, errp);
>> +    trace_get_sysreg_prop(name, value);
>> +}
>> +
>> +/*
>> + * decode_idreg_writemap: Generate props for writable fields
>> + *
>> + * @obj: CPU object
>> + * @index: index of the sysreg
>> + * @map: writable map for the sysreg
>> + * @reg: description of the sysreg
>> + */
>> +static int
>> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
>> +{
>> +    int i = ctz64(map);
>> +    int nb_sysreg_props = 0;
>> +
>> +    while (map) {
>> +        ARM64SysRegField *field = get_field(i, reg);
>> +        int lower, upper;
>> +        char *prop_name;
>> +        uint64_t mask;
>> +
>> +        if (!field) {
>> +            warn_report("%s bit %d of %s is writable but no named field "
>> +                        "in target/arm/cpu-idregs.h.inc",
>> +                        __func__, i, reg->name);
>> +            warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
>> +            map =  map & ~BIT_ULL(i);
>> +            i = ctz64(map);
>> +            continue;
>> +        }
>> +        lower = field->shift;
>> +        upper = field->shift + field->length - 1;
>> +        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
>> +        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
>> +        object_property_add(obj, prop_name, "uint64",
>> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
>> +        g_free(prop_name);
>> +        nb_sysreg_props++;
>> +
>> +        mask = MAKE_64BIT_MASK(lower, field->length);
>> +        map = map & ~mask;
>> +        i = ctz64(map);
>> +    }
>> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
>> +    return 0;
>> +}
>> +
>> +/* analyze the writable mask and generate properties for writable fields */
>> +void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
>> +{
>> +    int i, idx;
>> +    Object *obj = OBJECT(cpu);
>> +
>> +    if (!cpu->writable_map) {
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < KVM_ARM_FEATURE_ID_RANGE_SIZE; i++) {
>> +        uint64_t mask = cpu->writable_map[i];
>> +
>> +        if (mask) {
>> +            /* reg @i has some writable fields, decode them */
>> +            idx = kvm_feature_idx_to_idregs_idx(i);
>> +            if (idx < 0) {
>> +                /* no matching reg? */
>> +                warn_report("%s: reg %d writable, but not in list of idregs?",
>> +                            __func__, i);
>> +            } else {
>> +                decode_idreg_writemap(obj, i, mask, &regs[idx]);
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> static void
>> kvm_arm_get_host_cpu_features(ARMCPU *cpu, ARMHostCPUFeatures *ahcf)
>> {
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index c1c2e7ec37..8446a9cbf0 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -142,6 +142,16 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>>  */
>> void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>>
>> +typedef struct ARM64SysReg ARM64SysReg;
>> +/**
>> + * kvm_arm_expose_idreg_properties:
>> + * @cpu: The CPU object to generate the properties for
>> + * @reg: registers from the host
>> + *
>> + * analyze the writable mask and generate properties for writable fields
>> + */
>> +void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs);
>> +
>> /**
>>  * kvm_arm_steal_time_finalize:
>>  * @cpu: ARMCPU for which to finalize kvm-steal-time
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index c25d2a1191..d72ad6b671 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -15,6 +15,10 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>> kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>> get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>> kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
>> +decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
>> +get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
>> +set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
>> +nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
>>
>> # cpu.c
>> arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
>> -- 
>> 2.53.0
>>
> Why only expose the writable fields? I assume any management layer would also
> atleast like to know the values of non-writable fields. If they just know about 
> writable fields. How will they know if a migration is safe between two nodes?
>
> I understand we cannot write to non-writable fields but that does not mean we
> cannot expose the host values for those fields.
I replied separately to this on your series thread. I am inclined to do
so but this raises another problematic for the layered products to know
which mismatch can be fixed

Thanks

Eric
>
> Warm Regards,
> Khushit


