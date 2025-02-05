Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F30C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfcW2-0007RE-Db; Wed, 05 Feb 2025 05:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcVm-0007IO-Iq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:20:08 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tfcVk-0001fb-6U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 05:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738750800; x=1770286800;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZlyeICVSSjRaYfD4jzB36Voj3oGOORphki8ao45B0yc=;
 b=eVVWWKkS1nvupPSX6/dLOJGhaJSUe64S0ydBShcBP3Woigdnd4qf9sP9
 XprUt0jbg1RgdE5vO3hAtovH+V7RvyflxXLKFXvtq8Xl4ISPV/fNPx+s8
 D33vHSWzm6NOPHvAOz+s/IJUsHSh0ytHoZAl2IDrxAYulPxNqeuw+0+dr
 0srL6+EB45uLdZkG9NVbx/2+KWABdbMDyWyCv/tacjXIXQV4ZnTq4hHx5
 JK3Wx/jJ4POjsejL+P6YupeVt67Hl6e5lAhzjAagzcvLrlQorv5ocjC4c
 PvzNSywJYlc7ouehim0EHC/LMjWiWrxoRUKXYvcYSw9F/9Exv4RdT8n31 g==;
X-CSE-ConnectionGUID: JWxFYXDLSnWzINMNZw3iMQ==
X-CSE-MsgGUID: C1h62mAfTSSt80Ic9TNYzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49560833"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49560833"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:19:55 -0800
X-CSE-ConnectionGUID: Lx/U0d8RQlGR6sBiX7GFjw==
X-CSE-MsgGUID: 6i2q+Y/ETBO3ololtO6Gvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="115856871"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:19:51 -0800
Message-ID: <1852eef7-57e3-472a-80a7-203ec043950c@intel.com>
Date: Wed, 5 Feb 2025 18:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/52] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
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
 <20250124132048.3229049-29-xiaoyao.li@intel.com>
 <874j184ukg.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <874j184ukg.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/5/2025 5:19 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v6:
>> - change error_code of GuestPanicInformationTdx from uint64_t to
>>    uint32_t, to only contains the bit 31:0 returned in r12.
>>
>> Changes in v5:
>> - mention additional error information in gpa when it presents;
>> - refine the documentation; (Markus)
>>
>> Changes in v4:
>> - refine the documentation; (Markus)
>>
>> Changes in v3:
>> - Add docmentation of new type and struct; (Daniel)
>> - refine the error message handling; (Daniel)
>> ---
>>   qapi/run-state.json   | 31 ++++++++++++++++++--
>>   system/runstate.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.c | 24 +++++++++++++++-
>>   3 files changed, 119 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index ce95cfa46b73..e63611780a2c 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -501,10 +501,12 @@
>>   #
>>   # @s390: s390 guest panic information type (Since: 2.12)
>>   #
>> +# @tdx: tdx guest panic information type (Since: 9.0)
> 
> Since: 10.0
> 
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v', 's390' ] }
>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>   
>>   ##
>>   # @GuestPanicInformation:
>> @@ -519,7 +521,8 @@
>>    'base': {'type': 'GuestPanicInformationType'},
>>    'discriminator': 'type',
>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>> -          's390': 'GuestPanicInformationS390'}}
>> +          's390': 'GuestPanicInformationS390',
>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>   
>>   ##
>>   # @GuestPanicInformationHyperV:
>> @@ -598,6 +601,30 @@
>>             'psw-addr': 'uint64',
>>             'reason': 'S390CrashReason'}}
>>   
>> +##
>> +# @GuestPanicInformationTdx:
>> +#
>> +# TDX Guest panic information specific to TDX, as specified in the
>> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
>> +# section TDG.VP.VMCALL<ReportFatalError>.
>> +#
>> +# @error-code: TD-specific error code
>> +#
>> +# @message: Human-readable error message provided by the guest. Not
>> +#     to be trusted.
>> +#
>> +# @gpa: guest-physical address of a page that contains more verbose
>> +#     error information, as zero-terminated string.  Present when the
>> +#     "GPA valid" bit (bit 63) is set in @error-code.
>> +#
>> +#
>> +# Since: 10.0
>> +##
>> +{'struct': 'GuestPanicInformationTdx',
>> + 'data': {'error-code': 'uint32',
>> +          'message': 'str',
>> +          '*gpa': 'uint64'}}
>> +
>>   ##
>>   # @MEMORY_FAILURE:
>>   #
> 
> With the since information corrected
> Acked-by: Markus Armbruster <armbru@redhat.com>

will update the since information.

Thanks!

> [...]
> 


