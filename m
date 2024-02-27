Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE54C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reu7V-0007hX-Lq; Tue, 27 Feb 2024 04:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1reu7P-0007eH-Bg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:51:23 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1reu7M-0003wr-3u
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 04:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709027480; x=1740563480;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zqNzZxK5kJTKvJ+QklHiadEBpHT0kyIhtbdJ39re5U4=;
 b=iK3gVLlFQBmq2al91UJHWsTBNK1+i0v7YAzkdbQI3rxZl5BJ008bx4Wb
 i9JTbOo+OLq5a1x6x2Sihwyb91+whX2q29ABeep1ONaq5r6EzBDpcWGU+
 yY+6Kd1Fo2aEGyxmIDdaQS0SoLEAneQyV1UZ04lgIC51lsRng9n/djVdb
 pxo37gL06oBiU8pz5gnFeJI3xiyNp4l9sqOgNWWlbuOU30XqMuF4IeVKA
 eHxVPcVtHXW3jv8bcMlZpVx/4GlDH4gzlOYeYdbIkxzWyN98WojteCrqx
 TkthJ97DDeAPSDncQtgAcLxPTtY1nrqILBT87+JD76fIBktemWx+4UQdn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3218521"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3218521"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 01:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7192358"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 01:51:07 -0800
Message-ID: <1d7f7c1b-cfaa-4de6-80a0-8d1104440f54@intel.com>
Date: Tue, 27 Feb 2024 17:51:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 53/66] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-54-xiaoyao.li@intel.com>
 <87v86kehts.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87v86kehts.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.674, HK_RANDOM_FROM=1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/19/2024 8:53 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>
>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v4:
>> - refine the documentation; (Markus)
>>
>> Changes in v3:
>> - Add docmentation of new type and struct; (Daniel)
>> - refine the error message handling; (Daniel)
>> ---
>>   qapi/run-state.json   | 28 ++++++++++++++++++++--
>>   system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.c | 24 ++++++++++++++++++-
>>   3 files changed, 103 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index 08bc99cb8561..5429116679e3 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -485,10 +485,12 @@
>>   #
>>   # @s390: s390 guest panic information type (Since: 2.12)
>>   #
>> +# @tdx: tdx guest panic information type (Since: 8.2)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v', 's390' ] }
>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>   
>>   ##
>>   # @GuestPanicInformation:
>> @@ -503,7 +505,8 @@
>>    'base': {'type': 'GuestPanicInformationType'},
>>    'discriminator': 'type',
>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>> -          's390': 'GuestPanicInformationS390'}}
>> +          's390': 'GuestPanicInformationS390',
>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>   
>>   ##
>>   # @GuestPanicInformationHyperV:
>> @@ -566,6 +569,27 @@
>>             'psw-addr': 'uint64',
>>             'reason': 'S390CrashReason'}}
>>   
>> +##
>> +# @GuestPanicInformationTdx:
>> +#
>> +# TDX Guest panic information specific to TDX GCHI
>> +# TDG.VP.VMCALL<ReportFatalError>.
>> +#
>> +# @error-code: TD-specific error code
> 
> Where could a user find information on these error codes?

TDX GHCI (Guset-host-communication-Interface)spec. It defines all the 
TDVMCALL leaves.

0: panic;
0x1 - 0xffffffff: reserved.

>> +#
>> +# @gpa: guest-physical address of a page that contains additional
>> +#     error data, in forms of zero-terminated string.
> 
> "in the form of a zero-terminated string"

fixed.

>> +#
>> +# @message: Human-readable error message provided by the guest. Not
>> +#     to be trusted.
> 
> How is this message related to the one pointed to by @gpa?

In general, @message contains a brief message of the error. While @gpa 
(when valid) contains a verbose message.

The reason why we need both is because sometime when TD guest hits a 
fatal error, its memory may get corrupted so we cannot pass information 
via @gpa. Information in @message is passed through GPRs.

>> +#
>> +# Since: 9.0
>> +##
>> +{'struct': 'GuestPanicInformationTdx',
>> + 'data': {'error-code': 'uint64',
>> +          'gpa': 'uint64',
>> +          'message': 'str'}}
>> +
>>   ##
>>   # @MEMORY_FAILURE:
>>   #
> 
> [...]
> 


