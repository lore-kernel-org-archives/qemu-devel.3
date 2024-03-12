Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F047C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwY3-0002sx-Ki; Tue, 12 Mar 2024 03:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjwXi-0002s2-66
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:27:22 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjwXc-0007bz-Fr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710228437; x=1741764437;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wq55gM97pyRdirQ5fxyXXyXEC+jco3c3Ytc8YdM0KwA=;
 b=bJzQ56foBcFL5YW5ggpj7xN/1+Tlg+xtdIRemY0zuqe33640CShGTyqq
 mS1gcYQoBFwl3Cfj0pU5B7qL3+TS6EPvVUYlU5m0Suv5suHPxqTAT0ono
 FrYk/PkBE7pqWPFdcSTzdfOqHqBBDt3FSH1FsGOtJRBkgrO5FYLc8zMAf
 y+z9EtyS9kOPl0d2Mx5dsTvtyzYnnWhwaoe1870dPVw1jEdNcaQ25ApPB
 PwKqJV/cThzf3L6CweFMELYZK1/UqEpm4cEbY2MKx6kkDvFXON8voLO8g
 iNrTO6VA9/RYvXuCfmjTooukvckIH75RSOEVy1vHWgwNwe9qZ0voZGqrP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16362954"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16362954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 00:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="34622364"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 00:27:04 -0700
Message-ID: <73f7b57c-32b7-4ea5-bcb2-b6eecf52e08b@intel.com>
Date: Tue, 12 Mar 2024 15:27:01 +0800
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
 <95e623e1-ccf3-4d8f-9751-7767db100e2b@intel.com>
 <87plw1uszk.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87plw1uszk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 3/11/2024 3:29 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 3/7/2024 9:51 PM, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> On 2/29/2024 4:51 PM, Markus Armbruster wrote:
>>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>>
>>>>>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>>>>>
>>>>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>> ---
>>>>>> Changes in v5:
>>>>>> - mention additional error information in gpa when it presents;
>>>>>> - refine the documentation; (Markus)
>>>>>>
>>>>>> Changes in v4:
>>>>>> - refine the documentation; (Markus)
>>>>>>
>>>>>> Changes in v3:
>>>>>> - Add docmentation of new type and struct; (Daniel)
>>>>>> - refine the error message handling; (Daniel)
>>>>>> ---
>>>>>>     qapi/run-state.json   | 31 +++++++++++++++++++++--
>>>>>>     system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>     target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>>>>>>     3 files changed, 110 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>>>> index dd0770b379e5..b71dd1884eb6 100644
>>>>>> --- a/qapi/run-state.json
>>>>>> +++ b/qapi/run-state.json
> 
> [...]
> 
>>>>>> @@ -564,6 +567,30 @@
>>>>>>               'psw-addr': 'uint64',
>>>>>>               'reason': 'S390CrashReason'}}
>>>>>> +##
>>>>>> +# @GuestPanicInformationTdx:
>>>>>> +#
>>>>>> +# TDX Guest panic information specific to TDX, as specified in the
>>>>>> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
>>>>>> +# section TDG.VP.VMCALL<ReportFatalError>.
>>>>>> +#
>>>>>> +# @error-code: TD-specific error code
>>>>>> +#
>>>>>> +# @message: Human-readable error message provided by the guest. Not
>>>>>> +#     to be trusted.
>>>>>> +#
>>>>>> +# @gpa: guest-physical address of a page that contains more verbose
>>>>>> +#     error information, as zero-terminated string.  Present when the
>>>>>> +#     "GPA valid" bit (bit 63) is set in @error-code.
>>>>>
>>>>> Uh, peeking at GHCI Spec section 3.4 TDG.VP.VMCALL<ReportFatalError>, I
>>>>> see operand R12 consists of
>>>>>
>>>>>        bits    name                        description
>>>>>        31:0    TD-specific error code      TD-specific error code
>>>>>                                            Panic – 0x0.
>>>>>                                            Values – 0x1 to 0xFFFFFFFF
>>>>>                                            reserved.
>>>>>        62:32   TD-specific extended        TD-specific extended error code.
>>>>>                error code                  TD software defined.
>>>>>        63      GPA Valid                   Set if the TD specified additional
>>>>>                                            information in the GPA parameter
>>>>>                                            (R13).
>>>>> Is @error-code all of R12, or just bits 31:0?
>>>>> If it's all of R12, description of @error-code as "TD-specific error
>>>>> code" is misleading.
>>>>
>>>> We pass all of R12 to @error_code.
>>>>
>>>> Here it wants to use "error_code" as generic as the whole R12. Do you have any better description of it ?
>>>
>>> Sadly, the spec is of no help: it doesn't name the entire thing, only
>>> the three sub-fields TD-specific error code, TD-specific extended error
>>> code, GPA valid.
>>>
>>> We could take the hint, and provide the sub-fields instead:
>>>
>>> * @error-code contains the TD-specific error code (bits 31:0)
>>>
>>> * @extended-error-code contains the TD-specific extended error code
>>>     (bits 62:32)
>>>
>>> * we don't need @gpa-valid, because it's the same as "@gpa is present"
>>>
>>> If we decide to keep the single member, we do need another name for it.
>>> @error-codes (plural) doesn't exactly feel wonderful, but it gives at
>>> least a subtle hint that it's not just *the* error code.
>>
>> The reason we only defined one single member, is that the
>> extended-error-code is not used now, and I believe it won't be used in
>> the near future.
> 
> Aha!  Then I recommend
> 
> * @error-code contains the TD-specific error code (bits 31:0)
> 
> * Omit bits 62:32 from the reply; if we later find an actual use for
>    them, we can add a suitable member
> 
> * Omit bit 63, because it's the same as "@gpa is present"
> 
>> If no objection from others, I will use @error-codes (plural) in the
>> next version.
> 
> I recommend to keep the @error-code name, but narrow its value to the
> actual error code, i.e. bits 31:0.

It works for me. I will got this direction in the next version.

>>>>> If it's just bits 31:0, then 'Present when the "GPA valid" bit (bit 63)
>>>>> is set in @error-code' is wrong.  Could go with 'Only present when the
>>>>> guest provides this information'.
> 
> [...]
> 


