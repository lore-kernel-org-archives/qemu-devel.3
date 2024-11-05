Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D4D12693
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I9E-0005k2-J6; Tue, 05 Nov 2024 06:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I9C-0005fQ-GI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:58 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8I99-000226-W0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730807696; x=1762343696;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p9rsca4qedfgBzXyq8Qwc5Nr7Elmpj9SiXaFRufhkv8=;
 b=dzZ8KYIOpmHt8C/KO/xCVeT4twBPE9pOOevFFPuDyHLnpQj+0hOG9dpd
 DjSwY3le2G9fEQLfDVYA0iu/gLdqEiUZ4MryKuXqkRmRpCQFoD0kDYoTa
 XLReiFoS6sKQ5ZJfU5bkkzFvrNKOBWjvuchuihGCEmvlfLYY1Ow/LXDUa
 CefW0YkTcZc2nBGvTIRQMbBfZhF0Cg5RYUq7wA4uJLdxwhR7KVjqfitdf
 0N7JQvjDpG372Sfp32U2wXEt9QzgXLSslkc1R6o761DrYZY1KTEVeSvGS
 ANwfUUOokZeeJPQCJbv1ZpRYSUIVWQkbK8A/c8mvfv9vk4AxJJf5hdxF2 A==;
X-CSE-ConnectionGUID: 1TOKAxfuT5y73ma1i9MK5w==
X-CSE-MsgGUID: p0QAhGBVSqaUJW/QymA3XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41180201"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="41180201"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:54:54 -0800
X-CSE-ConnectionGUID: C+RWG7b1SpC/hJE7wUEjCQ==
X-CSE-MsgGUID: Fpkk3Jl1SCqn1YbtkrmyBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="84382439"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:54:45 -0800
Message-ID: <1722bb61-32e5-4da0-8390-14f8ca8ab328@intel.com>
Date: Tue, 5 Nov 2024 19:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/60] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-15-xiaoyao.li@intel.com>
 <Zyn1qW36aJeIGqbC@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zyn1qW36aJeIGqbC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/5/2024 6:38 PM, Daniel P. Berrangé wrote:
> On Tue, Nov 05, 2024 at 01:23:22AM -0500, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>> can be provided for TDX attestation. Detailed meaning of them can be
>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
>>
>> Allow user to specify those values via property mrconfigid, mrowner and
>> mrownerconfig. They are all in base64 format.
>>
>> example
>> -object tdx-guest, \
>>    mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v6:
>>   - refine the doc comment of QAPI properties;
>>
>> Changes in v5:
>>   - refine the description of QAPI properties and add description of
>>     default value when not specified;
>>
>> Changes in v4:
>>   - describe more of there fields in qom.json
>>   - free the old value before set new value to avoid memory leak in
>>     _setter(); (Daniel)
>>
>> Changes in v3:
>>   - use base64 encoding instread of hex-string;
>> ---
>>   qapi/qom.json         | 16 +++++++-
>>   target/i386/kvm/tdx.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |  3 ++
>>   3 files changed, 104 insertions(+), 1 deletion(-)
> 
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 5a9ce2ada89d..887a5324b439 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -13,6 +13,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/base64.h"
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>>   
>> @@ -222,6 +223,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       X86CPU *x86cpu = X86_CPU(cpu);
>>       CPUX86State *env = &x86cpu->env;
>>       g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>> +    size_t data_len;
>>       int r = 0;
>>   
>>       QEMU_LOCK_GUARD(&tdx_guest->lock);
>> @@ -232,6 +234,37 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>   
>> +#define SHA384_DIGEST_SIZE  48
> 
> Don't define this - as of fairly recently, we now have
> QCRYPTO_HASH_DIGEST_LEN_SHA384 in QEMU's "crypto/hash.h"
> header.

Thanks for the information!

Will update to use it.

>> +    if (tdx_guest->mrconfigid) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
>> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
>> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
>> +            error_setg(errp, "TDX: failed to decode mrconfigid");
>> +            return -1;
>> +        }
>> +        memcpy(init_vm->mrconfigid, data, data_len);
>> +    }
>> +
>> +    if (tdx_guest->mrowner) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
>> +                              strlen(tdx_guest->mrowner), &data_len, errp);
>> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
>> +            error_setg(errp, "TDX: failed to decode mrowner");
>> +            return -1;
>> +        }
>> +        memcpy(init_vm->mrowner, data, data_len);
>> +    }
>> +
>> +    if (tdx_guest->mrownerconfig) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
>> +                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
>> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
>> +            error_setg(errp, "TDX: failed to decode mrownerconfig");
>> +            return -1;
>> +        }
>> +        memcpy(init_vm->mrownerconfig, data, data_len);
>> +    }
>> +
>>       r = setup_td_guest_attributes(x86cpu, errp);
>>       if (r) {
>>           return r;
> 
> With regards,
> Daniel


