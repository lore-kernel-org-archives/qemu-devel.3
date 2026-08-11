Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB1C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtha4-0005uu-7e; Tue, 11 Aug 2026 04:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wthZi-0005eY-Q0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wthZg-0005BZ-8z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786435862;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCqV+LwYeH1TzbOC6x2tcguj3jnVdShCKf3wQhrW4jI=;
 b=WLXiBiyopXLcDBpMxvSkZBYtyX4Ipyp9qZe1CNWz4KfwjfctbK+70PWph20TDgp2oqOQwl
 dYKcfR5tamqNtjEKipwk+2z2iqPcvlRX0P3k+xBcXJF+HmctHp/MVe24RstPJW8Hm5Qda1
 A2ScpMf3H+7b4pwkDLt/OxbTRlPl/tQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-QY-h7BZ-MqqXehfd69opeQ-1; Tue, 11 Aug 2026 04:11:01 -0400
X-MC-Unique: QY-h7BZ-MqqXehfd69opeQ-1
X-Mimecast-MFC-AGG-ID: QY-h7BZ-MqqXehfd69opeQ_1786435860
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so23755145e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786435860; x=1787040660;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCqV+LwYeH1TzbOC6x2tcguj3jnVdShCKf3wQhrW4jI=;
 b=DyRkG5jwXTYj6ahvziCs9GPrkZTmrVkAJn72HIZ7VHuMk3maKXCLpvDKFTbBSlqVjF
 GSU1f2l3RIJykzCTcguLYXyjiTe8v8NN6obMIgvE8OXtXhUM4LKdHCaq+ZSKbobYjffz
 k2FAtzpcsXXPSA9ToBTJisD7/LGvQDY80Ii7nkLr0eR3CnUa/NHZntccFmOCCgz77i6T
 rGFbsa2WsFqq2K1i0XEFCBKfqw5I9ZMdGiN8bf4fvjwVntJl2jmrk3eL5bwAZpJEzvw0
 q7HAAqN6Sa+Mez0QwDYAibGILRM7edOtWXhtsvTPSAmXLvLumojpzKFkOWXFRAKfnFO2
 tz3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4xoPtJW2ZiCCW9+KsqOuJhSByApcJXvaP2QiyQHP3pMBsUB6/qBtiM0DVqdvqsczHklQxU0g3HfJx@nongnu.org
X-Gm-Message-State: AOJu0YwioFv2dxOU6CrZQ7IL4cHLg1IdfnHYsg4ohpDZcdAPfvrn1xJX
 +1uQgobyiqMNQ5RSSpQ5yzqx6QhqeKzDRliTFoAdeic6YNPByWmx7MXVvSDnTqEHNQfp52Z3Jnb
 JlsFhVZft2GY8jWR0xpj9/ELrdj2qa1k8HNoxf11aKubPs0T2Pyzhih/w
X-Gm-Gg: AR+sD10oB68Xp+ZPUO7YSFZyvpQuXoVqCbH7Y5orV5F83xgLutfi12o6ZaMl+wPXE7P
 jnJKgkmZIDGeQDcJMtckwN47LIWr/W4C11lcJ474dml1LNuH9+JZKCTxnqbwm/7IMBW7JD8fkvm
 VDE/rNMcKSixlObwRSVifdRiNZvwyR9RBv+rF8oHeMkOMTEwxZuRGUyxKjOB52Ib70bXRSeNVe5
 SHG6Oy6Wem+8jcXG/Db+VYmbs2XExzTVKovAfDu9bnR6rIvljm3tRR0pccdE59I4RDEskm+s4pk
 YxAB2BTI6RziRML06ZMJgJ+J+IlL8RNQVDlFhw1Lwk3nOQySsehUmg205JPTa+fEdePcrgQncwv
 5JEn+6aqUwU1/WNvrGTfHNoMuCiTNiSb+RqkH+tII5lWrO5Bs
X-Received: by 2002:a05:600c:4585:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-499784612aemr23515625e9.10.1786435860001; 
 Tue, 11 Aug 2026 01:11:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4585:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-499784612aemr23513965e9.10.1786435859092; 
 Tue, 11 Aug 2026 01:10:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e86b55sm41224385e9.4.2026.08.11.01.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:10:58 -0700 (PDT)
Message-ID: <de4f28a8-5f6a-4675-8daa-327ee7d938d7@redhat.com>
Date: Tue, 11 Aug 2026 10:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 10/18] target/arm/kvm: Retrieve writable ID reg map
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
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-11-eric.auger@redhat.com>
 <650A3325-5A8A-477A-9E60-D1D02363FA19@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <650A3325-5A8A-477A-9E60-D1D02363FA19@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

Hi Khushit,
On 8/6/26 6:52 AM, Khushit Shah wrote:
>
>> On 26 Jul 2026, at 8:59 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Add an helper to retrieve the writable id reg bitmask.
>>
>> then retrieve the writable_map array and dispatch it in the writable_map
>> fields of arm64_id_regs[] elements.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> v5 -> v6
>> - use arm64_id_regs[].writable_map
>> - squashed 2 commits (helper + user)
>> - removed stub
>> ---
>> target/arm/kvm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 61 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index d40a6a9859..d270f9870e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -28,6 +28,7 @@
>> #include "kvm_arm.h"
>> #include "cpu.h"
>> #include "cpu-sysregs.h"
>> +#include "cpu-idregs.h"
>> #include "trace.h"
>> #include "internals.h"
>> #include "hw/pci/pci.h"
>> @@ -51,6 +52,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>> static bool cap_has_mp_state;
>> static bool cap_has_inject_serror_esr;
>> static bool cap_has_inject_ext_dabt;
>> +static bool writable_map_dispatched;
>>
>> /**
>>  * ARMHostCPUFeatures: information about the host CPU (identified
>> @@ -273,6 +275,21 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
>>     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
>> }
>>
>> +static int kvm_feature_idx_to_idregs_idx(int kidx)
>> +{
>> +    int op1, crm, op2;
>> +    ARMSysRegs sysreg;
>> +
>> +    op1 = kidx / 64;
>> +    if (op1 == 2) {
>> +        op1 = 3;
>> +    }
>> +    crm = (kidx % 64) / 8;
>> +    op2 = kidx % 8;
>> +    sysreg = ENCODE_ID_REG(3, op1, 0, crm, op2);
>> +    return get_sysreg_idx(sysreg);
>> +}
>> +
>> static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>> {
>>     /* Identify the feature bits corresponding to the host CPU, and
>> @@ -480,9 +497,53 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>     ahcf->features = features;
>> }
>>
>> +static int kvm_arm_get_writable_id_regs(uint64_t *idregmap)
>> +{
> This should probably be gated with kvm_enabled()?
>
> qtest-aarch64/device-introspect-test fails on my aarch64 devvm, which does not
> have KVM.
Thanks for the report.

I will fix that in next respin

Eric
>
>> +    int cap_writable_id_regs;
>> +    struct reg_mask_range range = {
>> +        .range = KVM_ARM_FEATURE_ID_RANGE,
>> +        .reserved = {0},
>> +        .addr = (uint64_t)idregmap,
>> +    };
>> +
>> +    cap_writable_id_regs =
>> +        kvm_check_extension(kvm_state, KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES);
>> +
>> +    if (!cap_writable_id_regs ||
>> +        !(cap_writable_id_regs & (1 << KVM_ARM_FEATURE_ID_RANGE))) {
>> +        return -ENOSYS;
>> +    }
>> +
>> +    if (kvm_vm_ioctl(kvm_state, KVM_ARM_GET_REG_WRITABLE_MASKS, &range)) {
>> +        return -errno;
>> +    }
>> +    return 0;
>> +}
>> +
>> void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>> {
>>     CPUARMState *env = &cpu->env;
>> +    uint64_t *writable_map;
>> +
>> +    writable_map = g_new(uint64_t, KVM_ARM_FEATURE_ID_RANGE_SIZE);
>> +
>> +    if (!writable_map_dispatched &&
>> +        !kvm_arm_get_writable_id_regs(writable_map)) {
>> +        for (int i = 0; i < KVM_ARM_FEATURE_ID_RANGE_SIZE; i++) {
>> +            uint64_t mask = writable_map[i];
>> +
>> +            if (mask) {
>> +                int idx = kvm_feature_idx_to_idregs_idx(i);
>> +
>> +                if (idx < 0 || idx > ARRAY_SIZE(arm64_id_regs)) {
>> +                    continue;
>> +                }
>> +                arm64_id_regs[idx].writable_mask = mask;
>> +            }
>> +        }
>> +        writable_map_dispatched = true;
>> +    }
>> +    g_free(writable_map);
>>
>>     if (!arm_host_cpu_features.dtb_compatible) {
>>         kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
>> -- 
>> 2.53.0
>>


