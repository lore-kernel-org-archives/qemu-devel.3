Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B3C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXc5G-0005Pe-18; Wed, 07 Feb 2024 02:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXc5E-0005PF-0J; Wed, 07 Feb 2024 02:11:00 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rXc5B-0002Ne-L6; Wed, 07 Feb 2024 02:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707289858; x=1738825858;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=YF+uGhauGJSK+RpFv2lVg21sycBgzmH3KP4TRG7yn3s=;
 b=nbhcnisjYKCA6Ed7Qv49aYoN7Er8UW6uwolHzodEgOoiX2XNBwBO5Gop
 NFz6wVj3Xyn95WdTg0KjXojqN8QtL+7yXNSAj2smg5wm1IO3oCwE7IGpM
 QjNvaPbdg/5kQiL3a1a3CQ3Dr82r0TkeWxBmrgI6BiXhod1sWh1Uw8umd
 5ymJZM+ZtyZJk9gDP/gAaUukU4+Q2T6TIQu09zb8rRhf/eDr3ZLVgYqjj
 YFEiT6V6gj053JwRRgziMkAuO+U++uEOFPk25pwumY+/FTTFlFxPOzhO0
 RcUPLZhfVzGgfMy6/2NG8P7ZbRLDWJTxLFwndyKuwnJiiBF+sU4h0FUTL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1081592"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1081592"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 23:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5876791"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 23:10:48 -0800
Message-ID: <b942480c-a25c-4d5e-ab25-49ebe925ebb4@intel.com>
Date: Wed, 7 Feb 2024 15:10:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] i386/sev: Switch to use
 confidential_guest_kvm_init()
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20240206082852.3333299-1-xiaoyao.li@intel.com>
 <20240206082852.3333299-3-xiaoyao.li@intel.com> <ZcI_NdzheUcHncd_@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZcI_NdzheUcHncd_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/6/2024 10:16 PM, Daniel P. Berrangé wrote:
> On Tue, Feb 06, 2024 at 03:28:50AM -0500, Xiaoyao Li wrote:
>> Use confidential_guest_kvm_init() instead of calling SEV specific
>> sev_kvm_init(). As a bouns, it fits to future TDX when TDX implements
>> its own confidential_guest_support and .kvm_init().
>>
>> Move the "TypeInfo sev_guest_info" definition and related functions to
>> the end of the file, to avoid declaring the sev_kvm_init() ahead.
>>
>> Clean up the sve-stub.c since it's not needed anymore.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/kvm.c       |   2 +-
>>   target/i386/kvm/meson.build |   2 -
>>   target/i386/kvm/sev-stub.c  |   5 --
>>   target/i386/sev.c           | 120 +++++++++++++++++++-----------------
>>   target/i386/sev.h           |   2 -
>>   5 files changed, 63 insertions(+), 68 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 76a66246eb72..bb63bba61fa1 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2534,7 +2534,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>        * mechanisms are supported in future (e.g. TDX), they'll need
>>        * their own initialization either here or elsewhere.
>>        */
>> -    ret = sev_kvm_init(ms->cgs, &local_err);
>> +    ret = confidential_guest_kvm_init(ms->cgs, &local_err);
> 
> If you agree with my comment in patch 1 about the API expecting non-NULL,
> then this would need to be conditionalized (same for the 2 following
> patches too)

sure. Will change.

>     if (ms->cgs) {
>        ret = confidential_guest_kvm_init(....)
>        if (ret < 0) {
>           ....
>        }
>     }
> 
>>       if (ret < 0) {
>>           error_report_err(local_err);
>>           return ret;
>> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
>> index 84d9143e6029..e7850981e62d 100644
>> --- a/target/i386/kvm/meson.build
>> +++ b/target/i386/kvm/meson.build
>> @@ -7,8 +7,6 @@ i386_kvm_ss.add(files(
>>   
>>   i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>>   
>> -i386_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
>> -
>>   i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
>>   
>>   i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
>> diff --git a/target/i386/kvm/sev-stub.c b/target/i386/kvm/sev-stub.c
>> index 1be5341e8a6a..4a1560cf8ad7 100644
>> --- a/target/i386/kvm/sev-stub.c
>> +++ b/target/i386/kvm/sev-stub.c
>> @@ -14,8 +14,3 @@
>>   #include "qemu/osdep.h"
>>   #include "sev.h"
>>   
>> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>> -{
>> -    /* If we get here, cgs must be some non-SEV thing */
>> -    return 0;
>> -}
> 
> You can actually delete this entire file, since you removed the
> only method in it, and stopped building it in the meson.build
> patch above.

I intented to do it. Apprarently I missed it somehow and didn't catch it 
before sending out.

will fix in next version.

>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 173de91afe7d..19e79d3631d0 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -353,63 +353,6 @@ static void sev_guest_set_kernel_hashes(Object *obj, bool value, Error **errp)
>>       sev->kernel_hashes = value;
>>   }
>>   
>> -static void
>> -sev_guest_class_init(ObjectClass *oc, void *data)
>> -{
>> -    object_class_property_add_str(oc, "sev-device",
>> -                                  sev_guest_get_sev_device,
>> -                                  sev_guest_set_sev_device);
>> -    object_class_property_set_description(oc, "sev-device",
>> -            "SEV device to use");
>> -    object_class_property_add_str(oc, "dh-cert-file",
>> -                                  sev_guest_get_dh_cert_file,
>> -                                  sev_guest_set_dh_cert_file);
>> -    object_class_property_set_description(oc, "dh-cert-file",
>> -            "guest owners DH certificate (encoded with base64)");
>> -    object_class_property_add_str(oc, "session-file",
>> -                                  sev_guest_get_session_file,
>> -                                  sev_guest_set_session_file);
>> -    object_class_property_set_description(oc, "session-file",
>> -            "guest owners session parameters (encoded with base64)");
>> -    object_class_property_add_bool(oc, "kernel-hashes",
>> -                                   sev_guest_get_kernel_hashes,
>> -                                   sev_guest_set_kernel_hashes);
>> -    object_class_property_set_description(oc, "kernel-hashes",
>> -            "add kernel hashes to guest firmware for measured Linux boot");
>> -}
>> -
>> -static void
>> -sev_guest_instance_init(Object *obj)
>> -{
>> -    SevGuestState *sev = SEV_GUEST(obj);
>> -
>> -    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
>> -    sev->policy = DEFAULT_GUEST_POLICY;
>> -    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
>> -                                   OBJ_PROP_FLAG_READWRITE);
>> -    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
>> -                                   OBJ_PROP_FLAG_READWRITE);
>> -    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
>> -                                   OBJ_PROP_FLAG_READWRITE);
>> -    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>> -                                   &sev->reduced_phys_bits,
>> -                                   OBJ_PROP_FLAG_READWRITE);
>> -}
>> -
>> -/* sev guest info */
>> -static const TypeInfo sev_guest_info = {
>> -    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
>> -    .name = TYPE_SEV_GUEST,
>> -    .instance_size = sizeof(SevGuestState),
>> -    .instance_finalize = sev_guest_finalize,
>> -    .class_init = sev_guest_class_init,
>> -    .instance_init = sev_guest_instance_init,
>> -    .interfaces = (InterfaceInfo[]) {
>> -        { TYPE_USER_CREATABLE },
>> -        { }
>> -    }
>> -};
>> -
>>   bool
>>   sev_enabled(void)
>>   {
>> @@ -906,7 +849,7 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
>>       }
>>   }
>>   
>> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>> +static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>   {
>>       SevGuestState *sev
>>           = (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
>> @@ -1383,6 +1326,67 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
>>       return ret;
>>   }
>>   
>> +static void
>> +sev_guest_class_init(ObjectClass *oc, void *data)
>> +{
>> +    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>> +
>> +    klass->kvm_init = sev_kvm_init;
>> +
>> +    object_class_property_add_str(oc, "sev-device",
>> +                                  sev_guest_get_sev_device,
>> +                                  sev_guest_set_sev_device);
>> +    object_class_property_set_description(oc, "sev-device",
>> +            "SEV device to use");
>> +    object_class_property_add_str(oc, "dh-cert-file",
>> +                                  sev_guest_get_dh_cert_file,
>> +                                  sev_guest_set_dh_cert_file);
>> +    object_class_property_set_description(oc, "dh-cert-file",
>> +            "guest owners DH certificate (encoded with base64)");
>> +    object_class_property_add_str(oc, "session-file",
>> +                                  sev_guest_get_session_file,
>> +                                  sev_guest_set_session_file);
>> +    object_class_property_set_description(oc, "session-file",
>> +            "guest owners session parameters (encoded with base64)");
>> +    object_class_property_add_bool(oc, "kernel-hashes",
>> +                                   sev_guest_get_kernel_hashes,
>> +                                   sev_guest_set_kernel_hashes);
>> +    object_class_property_set_description(oc, "kernel-hashes",
>> +            "add kernel hashes to guest firmware for measured Linux boot");
>> +}
>> +
>> +static void
>> +sev_guest_instance_init(Object *obj)
>> +{
>> +    SevGuestState *sev = SEV_GUEST(obj);
>> +
>> +    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
>> +    sev->policy = DEFAULT_GUEST_POLICY;
>> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
>> +                                   OBJ_PROP_FLAG_READWRITE);
>> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
>> +                                   OBJ_PROP_FLAG_READWRITE);
>> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
>> +                                   OBJ_PROP_FLAG_READWRITE);
>> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>> +                                   &sev->reduced_phys_bits,
>> +                                   OBJ_PROP_FLAG_READWRITE);
>> +}
>> +
>> +/* sev guest info */
>> +static const TypeInfo sev_guest_info = {
>> +    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
>> +    .name = TYPE_SEV_GUEST,
>> +    .instance_size = sizeof(SevGuestState),
>> +    .instance_finalize = sev_guest_finalize,
>> +    .class_init = sev_guest_class_init,
>> +    .instance_init = sev_guest_instance_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_USER_CREATABLE },
>> +        { }
>> +    }
>> +};
>> +
>>   static void
>>   sev_register_types(void)
>>   {
>> diff --git a/target/i386/sev.h b/target/i386/sev.h
>> index e7499c95b1e8..9e10d09539a7 100644
>> --- a/target/i386/sev.h
>> +++ b/target/i386/sev.h
>> @@ -57,6 +57,4 @@ int sev_inject_launch_secret(const char *hdr, const char *secret,
>>   int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size);
>>   void sev_es_set_reset_vector(CPUState *cpu);
>>   
>> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
>> -
>>   #endif
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


