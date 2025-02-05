Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FF5C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcer-0001Os-Ks; Wed, 05 Feb 2025 05:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfceo-0001OC-MH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:29:22 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcem-0002tm-Mx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738751360; x=1770287360;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=334KkDC7EyuQcwN7ovyQW7RvcYBsNBgMLnTEYSz5aYc=;
 b=TuyUGvqwY6nXvZxxU9ocaIoBIXmqnQU/TLGZ8dBKKZd4ieSb4YAPbNVK
 A1yIxTkWPbsP10HRi0vPnafQCiqsfS9wBUUf6b08tdWnftqObztR2OQfN
 wS3A2BPFuwMRehko2Jf5ztgfDNgvDGHUmrbvlsZdAN7/g3+JyihV4ARoM
 p6GT+n/N2n1ZEHG/7x09Xh+CnkQn+SXbeJaaLSOBc6zvr/9e8lAKmi3Rs
 uToBhHzcTl+orXPu9HeZqCt1TJW9BaPTiiCMxmRUfX+TD2Oto98LwnWhQ
 FivDDzk54Mba21uUUdXE8r8C/EUw4JRUddTA/lK+VEalXvtUXCJov77P6 A==;
X-CSE-ConnectionGUID: ZosbysBdRbqY9xWff4O68A==
X-CSE-MsgGUID: MmZlxl0WSXOgTRrvpWoFPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49561778"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49561778"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:29:18 -0800
X-CSE-ConnectionGUID: o2XfOx7NSpW4ShZBReTJZw==
X-CSE-MsgGUID: JhG4VD9PTDa2CLDctdCpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="110758692"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:29:14 -0800
Message-ID: <931df5b6-beeb-49dc-9f3f-c8a06522d632@intel.com>
Date: Wed, 5 Feb 2025 18:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/52] i386/tdx: Validate TD attributes
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-13-xiaoyao.li@intel.com>
 <878qqk4v6i.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <878qqk4v6i.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2/5/2025 5:06 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Validate TD attributes with tdx_caps that only supported bits arer
>> allowed by KVM.
>>
>> Besides, sanity check the attribute bits that have not been supported by
>> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
>> TD support lands in QEMU.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> Changes in v7:
>> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>>    user's request. (Rick)
>>
>> Changes in v3:
>> - using error_setg() for error report; (Daniel)
>> ---
>>   qapi/qom.json         |  16 +++++-
>>   target/i386/kvm/tdx.c | 118 +++++++++++++++++++++++++++++++++++++++++-
>>   target/i386/kvm/tdx.h |   3 ++
>>   3 files changed, 134 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 8740626c4ee6..a53000ca6fb4 100644
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
> 
> All three members are IDs, but only the first one has "id" in its name.
> Odd.  Any particular reason for that?
> 
>> +#
>>   # Since: 10.0
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>>     'data': { '*attributes': 'uint64',
>> -            '*sept-ve-disable': 'bool' } }
>> +            '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
> 
> The member names are abbreviations all run together, wheras QAPI/QMP
> favors words-separated-with-dashes.  If you invented them, please change
> them to QAPI/QMP style.  If they are established TDX terminology, keep
> them as they are, but please show us your evidence.

The names are defined in TDX spec. Table 3.13 "TD_PARAMS definition" in 
TDX Module ABI spec[1]. And they are used for attestation, please refer 
to section 12 "Measurement and Attestation" in TDX Module Base spec[2].

[1] https://cdrdv2.intel.com/v1/dl/getContent/733579
[2] https://cdrdv2.intel.com/v1/dl/getContent/733575


>>   
>>   ##
>>   # @ThreadContextProperties:
> 
> [...]
> 


