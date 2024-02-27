Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6704C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexDV-0000Xx-Mo; Tue, 27 Feb 2024 08:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rexDT-0000WK-Ra
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rexDS-0006GO-25
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709039388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y9rPD00F7OIDy6VyYPXw2CahA2P7o8tC42UrT8Kk1Ds=;
 b=FznDZiGto6JPIYbVmzLzANfTZaS5iwAb0rMT6RToxU3O2OdkUV1rxyDMC5yIiSZrH9xJTn
 /j57bK4dCgq4GqujLbuHddIi3ZXlIO5NG7Rhqhdp5t0YeLLhC9eKzvp0bYWvGopW8hDoOO
 xnaDurcydj+KRgTYZkXFQ/roTs8XtFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-rWDsa9VKPLqNx6Z2cH-3Xw-1; Tue,
 27 Feb 2024 08:09:44 -0500
X-MC-Unique: rWDsa9VKPLqNx6Z2cH-3Xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 281A73C0F185;
 Tue, 27 Feb 2024 13:09:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C3F40166A5;
 Tue, 27 Feb 2024 13:09:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D82D21E6740; Tue, 27 Feb 2024 14:09:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 53/66] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
In-Reply-To: <09c5fd9b-be96-45b6-b48e-772d5b5aad16@intel.com> (Xiaoyao Li's
 message of "Tue, 27 Feb 2024 20:09:41 +0800")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-54-xiaoyao.li@intel.com>
 <87v86kehts.fsf@pond.sub.org>
 <1d7f7c1b-cfaa-4de6-80a0-8d1104440f54@intel.com>
 <87le76dt1g.fsf@pond.sub.org>
 <09c5fd9b-be96-45b6-b48e-772d5b5aad16@intel.com>
Date: Tue, 27 Feb 2024 14:09:41 +0100
Message-ID: <87wmqqawa2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/27/2024 7:51 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> On 2/19/2024 8:53 PM, Markus Armbruster wrote:
>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>
>>>>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>>>>
>>>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>> ---
>>>>> Changes in v4:
>>>>> - refine the documentation; (Markus)
>>>>>
>>>>> Changes in v3:
>>>>> - Add docmentation of new type and struct; (Daniel)
>>>>> - refine the error message handling; (Daniel)
>>>>> ---
>>>>>    qapi/run-state.json   | 28 ++++++++++++++++++++--
>>>>>    system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
>>>>>    target/i386/kvm/tdx.c | 24 ++++++++++++++++++-
>>>>>    3 files changed, 103 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>>>> index 08bc99cb8561..5429116679e3 100644
>>>>> --- a/qapi/run-state.json
>>>>> +++ b/qapi/run-state.json

[...]

>>>>> @@ -566,6 +569,27 @@
>>>>>              'psw-addr': 'uint64',
>>>>>              'reason': 'S390CrashReason'}}
>>>>>    
>>>>> +##
>>>>> +# @GuestPanicInformationTdx:
>>>>> +#
>>>>> +# TDX Guest panic information specific to TDX GCHI
>>>>> +# TDG.VP.VMCALL<ReportFatalError>.
>>>>> +#
>>>>> +# @error-code: TD-specific error code
>>>>
>>>> Where could a user find information on these error codes?
>>>
>>> TDX GHCI (Guset-host-communication-Interface)spec. It defines all the
>>> TDVMCALL leaves.
>>>
>>> 0: panic;
>>> 0x1 - 0xffffffff: reserved.
>> 
>> Would it make sense to add a reference?
>
> https://cdrdv2.intel.com/v1/dl/getContent/726792

URLs have this annoying tendency to rot.

What about

# @error-code: Error code as defined in "Guest-Hypervisor Communication
#     Interface (GHCI) Specification for Intel TDX 1.5"

>>>>> +#
>>>>> +# @gpa: guest-physical address of a page that contains additional
>>>>> +#     error data, in forms of zero-terminated string.
>>>>
>>>> "in the form of a zero-terminated string"
>>>
>>> fixed.
>>>
>>>>> +#
>>>>> +# @message: Human-readable error message provided by the guest. Not
>>>>> +#     to be trusted.
>>>>
>>>> How is this message related to the one pointed to by @gpa?
>>>
>>> In general, @message contains a brief message of the error. While @gpa
>>> (when valid) contains a verbose message.
>>>
>>> The reason why we need both is because sometime when TD guest hits a
>>> fatal error, its memory may get corrupted so we cannot pass information
>>> via @gpa. Information in @message is passed through GPRs.
>> 
>> Well, we do pass information via @gpa, always.  I guess it page's
>> contents can be corrupted.
>
> No. It's not always. the bit 63 of the error code is "GPA valid" bit. 
> @gpa is valid only when bit 63 of error code is 1.
>
> And current Linux TD guest implementation doesn't use @gpa at all.
> https://github.com/torvalds/linux/blob/45ec2f5f6ed3ec3a79ba1329ad585497cdcbe663/arch/x86/coco/tdx/tdx.c#L131 

Aha!

Why would we want to include @gpa when the "GPA valid" bit is off?

If we do want it, then

# @gpa: guest-physical address of a page that contains more verbose
#     error information, as zero-terminated string.  Valid when the
#     "GPA valid" bit is set in @error-code.

If we don't, then make @gpa optional, present when valid, and document
it like this:

# @gpa: guest-physical address of a page that contains more verbose
#     error information, as zero-terminated string.  Present when the
#     "GPA valid" bit is set in @error-code.

>> Perhaps something like
>> 
>>      # @message: Human-readable error message provided by the guest.  Not
>>      #     to be trusted.
>>      #
>>      # @gpa: guest-physical address of a page that contains more verbose
>>      #     error information, as zero-terminated string.  Note that guest
>>      #     memory corruption can corrupt the page's contents.
>> 
>>>>> +#
>>>>> +# Since: 9.0
>>>>> +##
>>>>> +{'struct': 'GuestPanicInformationTdx',
>>>>> + 'data': {'error-code': 'uint64',
>>>>> +          'gpa': 'uint64',
>>>>> +          'message': 'str'}}
>> 
>> Note that my proposed doc string has the members in a different order.
>> Recommend to use the same order here.
>> 
>>>>> +
>>>>>    ##
>>>>>    # @MEMORY_FAILURE:
>>>>>    #
>>>>
>>>> [...]
>>>>
>> 


