Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF52C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 04:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2MnB-00015F-D7; Wed, 09 Apr 2025 00:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u2Mn8-00014I-0y
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:11:58 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u2Mn5-00050y-BV
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 00:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744171916; x=1775707916;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HJPmOzcpDOBiyEVULpgtysKmlX77a1A4bKhdWOnZPxs=;
 b=GAFAQylPOnIaGYgZvPE47WTiLiWM+EaJHzIef8w7cJ1R+GM/vnCoquYN
 /uhHMMrxJu4KCoqCdQ4lueeL95M4LzojWanv/6C7qMNK6hidSIqpk8Fcr
 mSOphI9HF3iejfgSSxSJNUJ+z/bs44gcob+ulm7wTdrzu6r3ko+t2mGQx
 cDZ0EVFuD3rkkHzSNzeV1CWdWt0vOGtXZ5/8rOf9LkaeTp3toKrjkP1Xi
 LV8MMYWgr7F/jg59EDT9ZcRGEF3AUSotP/gEAkoWxSPCMkPISUqiy5K9F
 UMo5UEAisdFBl7zEmSK2C8P54HESlmNNRxQiGzukk70WtONcod39a2Uej g==;
X-CSE-ConnectionGUID: nwDEhf5ZS46b5gj0UeGWHQ==
X-CSE-MsgGUID: eS46cvqFTyqLLg0l9WeijQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45344672"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="45344672"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 21:11:52 -0700
X-CSE-ConnectionGUID: 8hfkWdB3R1+oPyHz+SscgQ==
X-CSE-MsgGUID: XFRJU8dnSQqBd90MlFUJhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; d="scan'208";a="128461221"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 21:11:49 -0700
Message-ID: <f311a233-0238-4bcd-8481-0829d6bc1eda@intel.com>
Date: Wed, 9 Apr 2025 12:11:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/55] i386/tdvf: Introduce function to parse TDVF
 metadata
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-18-xiaoyao.li@intel.com>
 <Z-0o0sYJcnqI23aX@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0o0sYJcnqI23aX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/2/2025 8:08 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:27AM -0400, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> TDX VM needs to boot with its specialized firmware, Trusted Domain
>> Virtual Firmware (TDVF). QEMU needs to parse TDVF and map it in TD
>> guest memory prior to running the TDX VM.
>>
>> A TDVF Metadata in TDVF image describes the structure of firmware.
>> QEMU refers to it to setup memory for TDVF. Introduce function
>> tdvf_parse_metadata() to parse the metadata from TDVF image and store
>> the info of each TDVF section.
>>
>> TDX metadata is located by a TDX metadata offset block, which is a
>> GUID-ed structure. The data portion of the GUID structure contains
>> only an 4-byte field that is the offset of TDX metadata to the end
>> of firmware file.
>>
>> Select X86_FW_OVMF when TDX is enable to leverage existing functions
>> to parse and search OVMF's GUID-ed structures.
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> Changes in v8:
>>   - Drop the failure handling of memcpy() since it cannot fail;
>>
>> Changes in v7:
>>   - Update license info to only use SPDX tag;
>>   - use g_autofree to avoid manually free;
>>
>> Changes in v6:
>>   - Drop the the data endianness change for metadata->Length;
>>
>> Changes in v1:
>>   - rename tdvf_parse_section_entry() to
>>     tdvf_parse_and_check_section_entry()
>>
>> Changes in RFC v4:
>>   - rename TDX_METADATA_GUID to TDX_METADATA_OFFSET_GUID
>> ---
>>   hw/i386/Kconfig        |   1 +
>>   hw/i386/meson.build    |   1 +
>>   hw/i386/tdvf.c         | 183 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/i386/tdvf.h |  38 +++++++++
>>   4 files changed, 223 insertions(+)
>>   create mode 100644 hw/i386/tdvf.c
>>   create mode 100644 include/hw/i386/tdvf.h
>>
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index cce9521ba934..eb65bda6e071 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -12,6 +12,7 @@ config SGX
>>   
>>   config TDX
>>       bool
>> +    select X86_FW_OVMF
>>       depends on KVM
>>   
>>   config PC
>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
>> index 10bdfde27c69..3bc1da2b6eb4 100644
>> --- a/hw/i386/meson.build
>> +++ b/hw/i386/meson.build
>> @@ -32,6 +32,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
>>     'port92.c'))
>>   i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
>>                                           if_false: files('pc_sysfw_ovmf-stubs.c'))
>> +i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c'))
>>   
>>   subdir('kvm')
>>   subdir('xen')
>> diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
>> new file mode 100644
>> index 000000000000..328d1b7ffdf8
>> --- /dev/null
>> +++ b/hw/i386/tdvf.c
>> @@ -0,0 +1,183 @@
>> +/*
>> + * Copyright (c) 2025 Intel Corporation
>> + * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
>> + *                        <isaku.yamahata at intel.com>
>> + *         Xiaoyao Li <xiaoyao.li@intel.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +
>> +#include "hw/i386/pc.h"
>> +#include "hw/i386/tdvf.h"
>> +#include "system/kvm.h"
>> +
>> +#define TDX_METADATA_OFFSET_GUID    "e47a6535-984a-4798-865e-4685a7bf8ec2"
>> +#define TDX_METADATA_VERSION        1
>> +#define TDVF_SIGNATURE              0x46564454 /* TDVF as little endian */
>> +
>> +typedef struct {
>> +    uint32_t DataOffset;
>> +    uint32_t RawDataSize;
>> +    uint64_t MemoryAddress;
>> +    uint64_t MemoryDataSize;
>> +    uint32_t Type;
>> +    uint32_t Attributes;
>> +} TdvfSectionEntry;
>> +
>> +typedef struct {
>> +    uint32_t Signature;
>> +    uint32_t Length;
>> +    uint32_t Version;
>> +    uint32_t NumberOfSectionEntries;
>> +    TdvfSectionEntry SectionEntries[];
>> +} TdvfMetadata;
> 
> struct field names starting with an initial capital is
> not the usual QEMU code style. Can this be all initial
> lowercase, with capital just for word separation.

I think Isaku used such names because they are defined in TDVF Design 
Guide spec[1].

QEMU's internal data structure for metadata are below, which follows 
QEMU coding style.

	typedef struct TdxFirmwareEntry {
	    uint32_t data_offset;
	    uint32_t data_len;
	    uint64_t address;
	    uint64_t size;
	    uint32_t type;
	    uint32_t attributes;
	} TdxFirmwareEntry;

	typedef struct TdxFirmware {
	    uint32_t nr_entries;
	    TdxFirmwareEntry *entries;
	} TdxFirmware;

So if no strong preference, I would keep it as-is that the raw struct 
read from TDVF keeps the name convention of TDVF Design Guide spec and 
internal data struct uses QEMU's convention.

[1] https://cdrdv2.intel.com/v1/dl/getContent/733585

> 
>> +
>> +struct tdx_metadata_offset {
>> +    uint32_t offset;
>> +};
>> +
> 
> With regards,
> Daniel


