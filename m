Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2F7C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDP2-000195-0k; Wed, 26 Feb 2025 04:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnDOq-00014X-Ru
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:08:19 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnDOo-00013u-Vf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740560895; x=1772096895;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GWWzRHBQNiFlJY0nRVjsPP62ueyICDRFNE/0/AqsqDM=;
 b=g0LJg0hPIPXTQ4MEzK0pC5dzpYpYATD6K7V73NlwkulFMpLKZGE2k9Cu
 NLeFFlvbWj5QWGPKnPhxZ2hNbCmNA88Km5TmxRjty5e0cV1UBq8DgmPbp
 baKs+KDJerEZsn/JSIe3hf3n76j6/I7pxTD/Zvt2BoSADc6iupNDUh1t4
 tFLS2VzDTaak8V/1dD9melotP+vcpJHozKkTT6RqVgaoAuUsKWblF6AZM
 oUvB7iE4nb1oTQAXrdCHyp06ZBQt8zY0qloUL8/GRc8Xavh/RiriLlEj1
 zQkMXn+016f8lNEAGf30PlNydCigv4nyYz/zoKGyzXJhzoNxXiSNOkRSW Q==;
X-CSE-ConnectionGUID: FbiNcKJTR5GbXEb6fD7Tsw==
X-CSE-MsgGUID: R59G1O/VQA20Irz2oo8NTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66768446"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="66768446"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:08:13 -0800
X-CSE-ConnectionGUID: lsIln+ngSEaSEg/4dP7mKg==
X-CSE-MsgGUID: C9wFepWBThaaQSCKNqD1xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147557543"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:08:09 -0800
Message-ID: <4bbc83f9-f000-4f4b-834a-3804007745e4@intel.com>
Date: Wed, 26 Feb 2025 17:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/52] i386/tdx: Track mem_ptr for each firmware entry
 of TDVF
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-20-xiaoyao.li@intel.com>
 <4ec0652b387427cfadaef796ae9162921115bf43.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <4ec0652b387427cfadaef796ae9162921115bf43.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/20/2025 2:40 AM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 73f90b0a2217..8564b3ae905d 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -12,10 +12,14 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/base64.h"
>> +#include "qemu/mmap-alloc.h"
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>>   #include "crypto/hash.h"
>> +#include "system/system.h"
>>   
>> +#include "hw/i386/x86.h"
>> +#include "hw/i386/tdvf.h"
>>   #include "hw/i386/x86.h"
> 
> Duplicated include
> 

Thanks for catching it!

