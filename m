Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57277D3B7E3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 07:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFTVX-0007ZH-J9; Mon, 25 Nov 2024 02:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tFTVO-0007Vc-8R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:27:35 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tFTVJ-0001LN-NU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732519650; x=1764055650;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/nnjJpaGCwuNhpECEATFrIwD915CoDEyDwVOTo9KLYU=;
 b=Jh53u4PBOBSbfM6FrB11a2/AEQ19v3nXXlqd4DTFxYd/anZTRs1M7mwI
 04TW+HikiV4MgudGfzvlwZQT2LuBQmg1t8oWU0hrGSrJ5AkoG8lDizjRc
 Zvdp7nzLD6DA3UrmAx/PaoM/Gmmd1ceLtCvFAQIuUg1DGyKseoLFj+//w
 +pZFKyqIte9/OAZvAK1zMa0/2iGxP1GD5UkH8DmoOC84WAKkCI3jgHBUx
 qF8qg1eB8GV/6ZZmZGbNx7hNv124gnfugJ7cDHep+PJrqfe0WxONvc0WV
 Kf9SIwbja4lh5LQ+1MPL3FZmB1dMpd1GmmjkZXf4LwtCXNT2Fc0TMQiA7 A==;
X-CSE-ConnectionGUID: h70Q/ZLsTkiWrF5YKTN3Rw==
X-CSE-MsgGUID: fLIxt7iHSiqFcm52SIP9Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="50020892"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; d="scan'208";a="50020892"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2024 23:27:26 -0800
X-CSE-ConnectionGUID: n0FEg9PXQI+AiOQUFtUCvw==
X-CSE-MsgGUID: +BHEjdYPSgmLsIrForslWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; d="scan'208";a="91137263"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2024 23:27:21 -0800
Message-ID: <68c65132-0f2e-44eb-b084-bf70edd51417@intel.com>
Date: Mon, 25 Nov 2024 15:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/60] kvm: Introduce kvm_arch_pre_create_vcpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-8-xiaoyao.li@intel.com>
 <fbe5da1d-9a0e-4aa4-91f9-dfb729f39dc9@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <fbe5da1d-9a0e-4aa4-91f9-dfb729f39dc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.78, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/13/2024 2:28 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 5/11/24 06:23, Xiaoyao Li wrote:
>> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
>> work prior to create any vcpu. This is for i386 TDX because it needs
>> call TDX_INIT_VM before creating any vcpu.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> Changes in v3:
>> - pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
>> ---
>>   accel/kvm/kvm-all.c  | 10 ++++++++++
>>   include/sysemu/kvm.h |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 930a5bfed58f..1732fa1adecd 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -523,6 +523,11 @@ void kvm_destroy_vcpu(CPUState *cpu)
>>       }
>>   }
>> +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu, 
>> Error **errp)
> 
> We don't use the weak attribute. Maybe declare stubs for each arch?

Or define TARGET_KVM_HAVE_PRE_CREATE_VCPU to avoid touching other ARCHes?

8<------------------------------------------------------------------
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -536,10 +531,12 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)

      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));

+#ifdef TARGET_KVM_HAVE_PRE_CREATE_VCPU
      ret = kvm_arch_pre_create_vcpu(cpu, errp);
      if (ret < 0) {
          goto err;
      }
+#endif

      ret = kvm_create_vcpu(cpu);
      if (ret < 0) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 643ca4950543..bb76bf090fec 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -374,7 +374,9 @@ int kvm_arch_get_default_type(MachineState *ms);

  int kvm_arch_init(MachineState *ms, KVMState *s);

+#ifdef TARGET_KVM_HAVE_PRE_CREATE_VCPU
  int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
+#enfid
  int kvm_arch_init_vcpu(CPUState *cpu);
  int kvm_arch_destroy_vcpu(CPUState *cpu);



I'm OK with either. Please let me what is your preference!

>> +{
>> +    return 0;
>> +}
>> +
>>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       KVMState *s = kvm_state;
>> @@ -531,6 +536,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>> +    ret = kvm_arch_pre_create_vcpu(cpu, errp);
>> +    if (ret < 0) {
>> +        goto err;
>> +    }
>> +
>>       ret = kvm_create_vcpu(cpu);
>>       if (ret < 0) {
>>           error_setg_errno(errp, -ret,
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index c3a60b28909a..643ca4950543 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -374,6 +374,7 @@ int kvm_arch_get_default_type(MachineState *ms);
>>   int kvm_arch_init(MachineState *ms, KVMState *s);
>> +int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>>   int kvm_arch_init_vcpu(CPUState *cpu);
>>   int kvm_arch_destroy_vcpu(CPUState *cpu);
> 


