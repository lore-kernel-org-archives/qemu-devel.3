Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE048C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDH73-0007t1-Ta; Fri, 09 May 2025 02:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uDH6z-0007sR-G6
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:21:35 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uDH6x-0005Ak-EU
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746771691; x=1778307691;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jRUZzy/hdvsaJ7n/Y9b2uRRC/3g/EzCJMvS+AN5xPOc=;
 b=K+sJ/9SxuciJp/4QhGgbM24mR6xBVaEvRRBwhXs6vIsx2qGjz545nYHN
 r3uUPBwTmeOCwhF/IZtmserL0v+GRYQGrJoVmDMvv5U7+d/enEKaYZCox
 FnMme1MwImO0ZOg4j7qAZqvGuoStSDy9DJBXW8uinIyDaA/V/aH+yFagB
 +X0d+/BxGNRbMObk4dlvbUdWQSS5vZtyyde3y7gfnVVerL+UojVhblcHu
 wuAPgsD7krqLUvKYmyylrHIqPURtCqEQQ2ttDwa5HD9hQYJo0oCKbFf2v
 8AWygYMJMSKyOtCxwyKUQHu77j/47sQbQEOuNX05Tq2RujWIfbIRn4DtJ A==;
X-CSE-ConnectionGUID: sWbLp3L3Q9+Tlw7QQc8cRw==
X-CSE-MsgGUID: S/yOvYn6Q/eeSY3Vj/8Z6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59989669"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="59989669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:21:28 -0700
X-CSE-ConnectionGUID: Ofn2lzZERguaK2Pli/8GGg==
X-CSE-MsgGUID: leDuIIUmThi90JuIFA4hVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141296842"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:21:24 -0700
Message-ID: <13e47cae-8519-4e08-9530-87a48201ed2e@intel.com>
Date: Fri, 9 May 2025 14:21:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
 <20250508150002.689633-14-xiaoyao.li@intel.com> <aBzT3TrdldaN-uqx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aBzT3TrdldaN-uqx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/8/2025 11:55 PM, Daniel P. Berrangé wrote:
> On Thu, May 08, 2025 at 10:59:19AM -0400, Xiaoyao Li wrote:
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
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>> Changes in v9:
>>   - return -1 directly when qbase64_decode() return NULL; (Daniel)
>>
>> Changes in v8:
>>   - it gets squashed into previous patch in v7. So split it out in v8;
>>
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
>>   target/i386/kvm/tdx.c | 95 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |  3 ++
>>   3 files changed, 113 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index f229bb07aaec..a8379bac1719 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1060,11 +1060,25 @@
>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>   #     be set, otherwise they refuse to boot.
>>   #
>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
>> +#     Defaults to all zeros.
>> +#
>> +# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
>> +#     Defaults to all zeros.
>> +#
>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>> +#     e.g., specific to the workload rather than the run-time or OS
>> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.
>> +#
>>   # Since: 10.1
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>>     'data': { '*attributes': 'uint64',
>> -            '*sept-ve-disable': 'bool' } }
>> +            '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
>>   
>>   ##
>>   # @ThreadContextProperties:
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 3de3b5fa6a49..39fd964c6b27 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -11,8 +11,10 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/base64.h"
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>> +#include "crypto/hash.h"
>>   
>>   #include "hw/i386/x86.h"
>>   #include "kvm_i386.h"
>> @@ -240,6 +242,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       CPUX86State *env = &x86cpu->env;
>>       g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>       Error *local_err = NULL;
>> +    size_t data_len;
>>       int retry = 10000;
>>       int r = 0;
>>   
>> @@ -251,6 +254,45 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>   
>> +    if (tdx_guest->mrconfigid) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
>> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
>> +        if (!data) {
>> +            return -1;
>> +        }
>> +        if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
>> +            error_setg(errp, "TDX: failed to decode mrconfigid");
> 
> As a general guideline I'd always suggest including both the received
> and expected values, when reporting an length check failure. Also
> the error message is misleading - we successfully decoded the data,
> the decoded data was simply the wrong length.
> 
> eg
> 
>              error_setg(errp, "TDX mrconfigid sha386 digest was %d bytes, expected %d bytes")

s/sha386/sha384

> 	               data_len, QCRYPTO_HASH_DIGEST_LEN_SHA384);

good advice!

(If it needs another version, I will fix it. If this version is going to 
be picked by Paolo, I will leave it to Paolo to fix.)

> 
> With regards,
> Daniel


