Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F9EC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpMu-0005ms-Fw; Wed, 24 Jan 2024 21:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpMr-0005mT-7o
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:21:25 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpMo-0007PM-RZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706149282; x=1737685282;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Utqxtc/5ZatFVSiS307J7Nk+cesD9KgTkO5S7kPv/SQ=;
 b=FY4pUh2guBYJ5dN3OrkvwhebA7xfyinw4vL0iJ6nBtCq2q3eIMs4U/vP
 uA/KqLIOU71WbmUhSoPACr0xJupsZHMRKBgT/NJ4E3vjeAXSMubu0Wfyv
 hpdrj7mNSkWT2Ngu7yAz4cv7zMidQJia7W/8Nbwv8uG/Z4ueiwqJ9JXO9
 Zyg2JOOrH7OvDKdBvC24/RpGWylmHzUl9ngS/jzm9Nn+6qj6GyL3OJRl+
 s9znO5n2uWtS9lm2PI4RdATlwTmLvrp2SDDvP0S3sE/XVmCeKoieFMPDv
 8cAjE2P2TIS6l4jddSeMQvF65GeTkIrjPcBW9sOFt2A8O5YX5CLvMHjwU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399192253"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="399192253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="28606224"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:21:18 -0800
Message-ID: <4527135e-2471-4594-9325-b5e63e3f0144@intel.com>
Date: Thu, 25 Jan 2024 10:21:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/pc: Drop pc_machine_kvm_type()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231007065819.27498-1-xiaoyao.li@intel.com>
 <20231018092715-mutt-send-email-mst@kernel.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231018092715-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10/18/2023 9:27 PM, Michael S. Tsirkin wrote:
> On Sat, Oct 07, 2023 at 02:58:19AM -0400, Xiaoyao Li wrote:
>> pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
>> add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
>> specific initialization by utilizing kvm_type method.
>>
>> commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
>> moves the Xen specific initialization to pc_basic_device_init().
>>
>> There is no need to keep the PC specific kvm_type() implementation
>> anymore. So we'll fallback to kvm_arch_get_default_type(), which
>> simply returns 0.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Acked-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Seems ok
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> kvm thing so please merge through that tree.

Ping.

> 
>> ---
>>   hw/i386/pc.c         | 5 -----
>>   include/hw/i386/pc.h | 3 ---
>>   2 files changed, 8 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index aad7e8ccd1d7..41783b137b9a 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1730,11 +1730,6 @@ static void pc_machine_initfn(Object *obj)
>>       cxl_machine_init(obj, &pcms->cxl_devices_state);
>>   }
>>   
>> -int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
>> -{
>> -    return 0;
>> -}
>> -
>>   static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
>>   {
>>       CPUState *cs;
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index bec38cb92cf7..ad7149cb10b5 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -305,15 +305,12 @@ extern const size_t pc_compat_1_5_len;
>>   extern GlobalProperty pc_compat_1_4[];
>>   extern const size_t pc_compat_1_4_len;
>>   
>> -int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
>> -
>>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>>       { \
>>           MachineClass *mc = MACHINE_CLASS(oc); \
>>           optsfn(mc); \
>>           mc->init = initfn; \
>> -        mc->kvm_type = pc_machine_kvm_type; \
>>       } \
>>       static const TypeInfo pc_machine_type_##suffix = { \
>>           .name       = namestr TYPE_MACHINE_SUFFIX, \
>>
>> base-commit: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
>> -- 
>> 2.34.1
> 


