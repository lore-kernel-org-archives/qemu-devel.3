Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E47C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 01:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjUTF-0005aN-Cz; Sun, 10 Mar 2024 21:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjUTD-0005Zw-Nh
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 21:28:51 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjUTC-0006xd-0M
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 21:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710120530; x=1741656530;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BZyyCiYR0UjspFIqdj1irv2all9tyd7KB68o6I992zY=;
 b=k2AwW/k2SuK41Zam5iEQxXulbl9BKRsewI198y3BsQJzwVMquhv9CjSr
 VGuVr9OlWaOW4YDYmaJR5maOLQE+NC4ZCbaiHV1+bb4tlanNcoenjpe9F
 cCVUxrXtIJGf1OlOBvNmfW672/5iq9ob9dBErcE+rx23USI2DHSekX9Y6
 p8zC8Ugsu9PQicZAIhjNEEf1oP/wRe+tYNd6YEJNazPtL9kj5Pf9nq6UG
 f4ycxDna9R1E1GOCoShB8hKcQku6T67YwmC6TF3yQqiCjjpDxSEzeLX66
 gHgjlPqiffTr0gmALdjVvXKr+rAPoOuHsj4ZDLjGOAM3/n1FnEK+KDZj3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15409285"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15409285"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 18:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15502450"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 18:28:40 -0700
Message-ID: <95e623e1-ccf3-4d8f-9751-7767db100e2b@intel.com>
Date: Mon, 11 Mar 2024 09:28:37 +0800
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
 <d5cb6e5e-0bc1-40bd-8fc1-50a03f42e9cf@intel.com>
 <87y1au881k.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87y1au881k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 3/7/2024 9:51 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 2/29/2024 4:51 PM, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>>>
>>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>> Changes in v5:
>>>> - mention additional error information in gpa when it presents;
>>>> - refine the documentation; (Markus)
>>>>
>>>> Changes in v4:
>>>> - refine the documentation; (Markus)
>>>>
>>>> Changes in v3:
>>>> - Add docmentation of new type and struct; (Daniel)
>>>> - refine the error message handling; (Daniel)
>>>> ---
>>>>    qapi/run-state.json   | 31 +++++++++++++++++++++--
>>>>    system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>>>>    target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>>>>    3 files changed, 110 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>> index dd0770b379e5..b71dd1884eb6 100644
>>>> --- a/qapi/run-state.json
>>>> +++ b/qapi/run-state.json
>>>> @@ -483,10 +483,12 @@
>>>>   #
>>>>   # @s390: s390 guest panic information type (Since: 2.12)
>>>>   #
>>>> +# @tdx: tdx guest panic information type (Since: 9.0)
>>>> +#
>>>>   # Since: 2.9
>>>>   ##
>>>>   { 'enum': 'GuestPanicInformationType',
>>>> -  'data': [ 'hyper-v', 's390' ] }
>>>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>>>      ##
>>>> # @GuestPanicInformation:
>>>> @@ -501,7 +503,8 @@
>>>>     'base': {'type': 'GuestPanicInformationType'},
>>>>     'discriminator': 'type',
>>>>     'data': {'hyper-v': 'GuestPanicInformationHyperV',
>>>> -          's390': 'GuestPanicInformationS390'}}
>>>> +          's390': 'GuestPanicInformationS390',
>>>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>>>   ##
>>>>   # @GuestPanicInformationHyperV:
>>>> @@ -564,6 +567,30 @@
>>>>              'psw-addr': 'uint64',
>>>>              'reason': 'S390CrashReason'}}
>>>> +##
>>>> +# @GuestPanicInformationTdx:
>>>> +#
>>>> +# TDX Guest panic information specific to TDX, as specified in the
>>>> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
>>>> +# section TDG.VP.VMCALL<ReportFatalError>.
>>>> +#
>>>> +# @error-code: TD-specific error code
>>>> +#
>>>> +# @message: Human-readable error message provided by the guest. Not
>>>> +#     to be trusted.
>>>> +#
>>>> +# @gpa: guest-physical address of a page that contains more verbose
>>>> +#     error information, as zero-terminated string.  Present when the
>>>> +#     "GPA valid" bit (bit 63) is set in @error-code.
>>>
>>> Uh, peeking at GHCI Spec section 3.4 TDG.VP.VMCALL<ReportFatalError>, I
>>> see operand R12 consists of
>>>
>>>       bits    name                        description
>>>       31:0    TD-specific error code      TD-specific error code
>>>                                           Panic – 0x0.
>>>                                           Values – 0x1 to 0xFFFFFFFF
>>>                                           reserved.
>>>       62:32   TD-specific extended        TD-specific extended error code.
>>>               error code                  TD software defined.
>>>       63      GPA Valid                   Set if the TD specified additional
>>>                                           information in the GPA parameter
>>>                                           (R13).
>>> Is @error-code all of R12, or just bits 31:0?
>>> If it's all of R12, description of @error-code as "TD-specific error
>>> code" is misleading.
>>
>> We pass all of R12 to @error_code.
>>
>> Here it wants to use "error_code" as generic as the whole R12. Do you have any better description of it ?
> 
> Sadly, the spec is of no help: it doesn't name the entire thing, only
> the three sub-fields TD-specific error code, TD-specific extended error
> code, GPA valid.
> 
> We could take the hint, and provide the sub-fields instead:
> 
> * @error-code contains the TD-specific error code (bits 31:0)
> 
> * @extended-error-code contains the TD-specific extended error code
>    (bits 62:32)
> 
> * we don't need @gpa-valid, because it's the same as "@gpa is present"
> 
> If we decide to keep the single member, we do need another name for it.
> @error-codes (plural) doesn't exactly feel wonderful, but it gives at
> least a subtle hint that it's not just *the* error code.

The reason we only defined one single member, is that the 
extended-error-code is not used now, and I believe it won't be used in 
the near future.

If no objection from others, I will use @error-codes (plural) in the 
next version.

>>> If it's just bits 31:0, then 'Present when the "GPA valid" bit (bit 63)
>>> is set in @error-code' is wrong.  Could go with 'Only present when the
>>> guest provides this information'.
>>>
>>>> +#
>>>> +#
>>>
>>> Drop one of these two lines, please.
>>>
>>>> +# Since: 9.0
>>>> +##
>>>> +{'struct': 'GuestPanicInformationTdx',
>>>> + 'data': {'error-code': 'uint64',
>>>> +          'message': 'str',
>>>> +          '*gpa': 'uint64'}}
>>>> +
>>>>    ##
>>>>    # @MEMORY_FAILURE:
>>>>    #
>>>
> 


