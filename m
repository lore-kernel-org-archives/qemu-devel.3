Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D713C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBxj-0005pj-Vt; Thu, 07 Mar 2024 06:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBxc-0005pL-DM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:30:54 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBxa-0002R8-CQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709811050; x=1741347050;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=A10UBKhRS/a5V9sC5bEpT6S/qORoPkNjQunvfSxHJ6I=;
 b=Q4/p/2fnEtratJx0JjD0tBIzGaLMzSvLLfOYI8pm6gC9xVggH20o3FCI
 MjWrH+vsyq4I9tdmKrI81tvWU/oasZx2eZgXnaxQmtwfM+6RJg7ZwzUCS
 M+P4ekjV6fY18e/eQoyGB8zEJP770N99SsbNRI9QvsmvqwNMEJOu5B9Ic
 5NJy/Ek6In9+LmFlyVGAJHKnpcWub4JMLQ4cwbyWarR9+ApyLo+G41/qw
 kBLY7Qu3b6fTjUDEgsyxaDV+xA/QEjyHWIVWxqUsPS7lh3TAfA57XgwNG
 fuqmVoqPlo9e0OuH+KjpGDquUVatgPY09TZcUc2k9CI6uS6hiMxE9cxxr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="29916226"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="29916226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="33237722"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:30:41 -0800
Message-ID: <d5cb6e5e-0bc1-40bd-8fc1-50a03f42e9cf@intel.com>
Date: Thu, 7 Mar 2024 19:30:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 52/65] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-53-xiaoyao.li@intel.com> <874jdr1wmt.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <874jdr1wmt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.276, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 2/29/2024 4:51 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
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
>>   qapi/run-state.json   | 31 +++++++++++++++++++++--
>>   system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>>   3 files changed, 110 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index dd0770b379e5..b71dd1884eb6 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -483,10 +483,12 @@
>>   #
>>   # @s390: s390 guest panic information type (Since: 2.12)
>>   #
>> +# @tdx: tdx guest panic information type (Since: 9.0)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v', 's390' ] }
>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>   
>>   ##
>>   # @GuestPanicInformation:
>> @@ -501,7 +503,8 @@
>>    'base': {'type': 'GuestPanicInformationType'},
>>    'discriminator': 'type',
>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>> -          's390': 'GuestPanicInformationS390'}}
>> +          's390': 'GuestPanicInformationS390',
>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>   
>>   ##
>>   # @GuestPanicInformationHyperV:
>> @@ -564,6 +567,30 @@
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
> 
> Uh, peeking at GHCI Spec section 3.4 TDG.VP.VMCALL<ReportFatalError>, I
> see operand R12 consists of
> 
>      bits    name                        description
>      31:0    TD-specific error code      TD-specific error code
>                                          Panic – 0x0.
>                                          Values – 0x1 to 0xFFFFFFFF
>                                          reserved.
>      62:32   TD-specific extended        TD-specific extended error code.
>              error code                  TD software defined.
>      63      GPA Valid                   Set if the TD specified additional
>                                          information in the GPA parameter
>                                          (R13).
> 
> Is @error-code all of R12, or just bits 31:0?
> 
> If it's all of R12, description of @error-code as "TD-specific error
> code" is misleading.

We pass all of R12 to @error_code.

Here it wants to use "error_code" as generic as the whole R12. Do you 
have any better description of it ?

> If it's just bits 31:0, then 'Present when the "GPA valid" bit (bit 63)
> is set in @error-code' is wrong.  Could go with 'Only present when the
> guest provides this information'.
> 
>> +#
>> +#
> 
> Drop one of these two lines, please.
> 
>> +# Since: 9.0
>> +##
>> +{'struct': 'GuestPanicInformationTdx',
>> + 'data': {'error-code': 'uint64',
>> +          'message': 'str',
>> +          '*gpa': 'uint64'}}
>> +
>>   ##
>>   # @MEMORY_FAILURE:
>>   #
> 


