Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F57C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revzi-0003F3-BX; Tue, 27 Feb 2024 06:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revzg-0003Eg-Mp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revzf-0007oZ-4A
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709034689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uk9fiadTynJu7VqDaSTH+1mkCCzDcstFTbqQ/wNRaiI=;
 b=JNfQFTgbu1w+HjRXmPqI6Mw9G0VK3V+NaWZ2np3XZh1mvUjCU/mTACC0rnSIY3wY1AkS4G
 q/N36mBOI02mUoIZ5ayNszUCIW4BoycssPoM9Zyjy5fWWSQI9i5GSEu7r0hVFSCw36ak8U
 PwgP/Ud5R5Yv+ZFHIPdg4k1uDjRTrbc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-jfHY44QbNXiUfmDsqOXBVQ-1; Tue,
 27 Feb 2024 06:51:25 -0500
X-MC-Unique: jfHY44QbNXiUfmDsqOXBVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ABFA1C04B5F;
 Tue, 27 Feb 2024 11:51:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB3AB492BD7;
 Tue, 27 Feb 2024 11:51:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B702C21E66D0; Tue, 27 Feb 2024 12:51:23 +0100 (CET)
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
In-Reply-To: <1d7f7c1b-cfaa-4de6-80a0-8d1104440f54@intel.com> (Xiaoyao Li's
 message of "Tue, 27 Feb 2024 17:51:05 +0800")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-54-xiaoyao.li@intel.com>
 <87v86kehts.fsf@pond.sub.org>
 <1d7f7c1b-cfaa-4de6-80a0-8d1104440f54@intel.com>
Date: Tue, 27 Feb 2024 12:51:23 +0100
Message-ID: <87le76dt1g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

> On 2/19/2024 8:53 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>>
>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>> Changes in v4:
>>> - refine the documentation; (Markus)
>>>
>>> Changes in v3:
>>> - Add docmentation of new type and struct; (Daniel)
>>> - refine the error message handling; (Daniel)
>>> ---
>>>   qapi/run-state.json   | 28 ++++++++++++++++++++--
>>>   system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.c | 24 ++++++++++++++++++-
>>>   3 files changed, 103 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>> index 08bc99cb8561..5429116679e3 100644
>>> --- a/qapi/run-state.json
>>> +++ b/qapi/run-state.json
>>> @@ -485,10 +485,12 @@
>>>  #
>>>  # @s390: s390 guest panic information type (Since: 2.12)
>>>  #
>>> +# @tdx: tdx guest panic information type (Since: 8.2)
>>> +#
>>>  # Since: 2.9
>>>  ##
>>>  { 'enum': 'GuestPanicInformationType',
>>> -  'data': [ 'hyper-v', 's390' ] }
>>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>>   
>>>  ##
>>>  # @GuestPanicInformation:
>>> @@ -503,7 +505,8 @@
>>>    'base': {'type': 'GuestPanicInformationType'},
>>>    'discriminator': 'type',
>>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>>> -          's390': 'GuestPanicInformationS390'}}
>>> +          's390': 'GuestPanicInformationS390',
>>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>>   
>>>  ##
>>>  # @GuestPanicInformationHyperV:
>>> @@ -566,6 +569,27 @@
>>>             'psw-addr': 'uint64',
>>>             'reason': 'S390CrashReason'}}
>>>   
>>> +##
>>> +# @GuestPanicInformationTdx:
>>> +#
>>> +# TDX Guest panic information specific to TDX GCHI
>>> +# TDG.VP.VMCALL<ReportFatalError>.
>>> +#
>>> +# @error-code: TD-specific error code
>> 
>> Where could a user find information on these error codes?
>
> TDX GHCI (Guset-host-communication-Interface)spec. It defines all the 
> TDVMCALL leaves.
>
> 0: panic;
> 0x1 - 0xffffffff: reserved.

Would it make sense to add a reference?

>>> +#
>>> +# @gpa: guest-physical address of a page that contains additional
>>> +#     error data, in forms of zero-terminated string.
>> 
>> "in the form of a zero-terminated string"
>
> fixed.
>
>>> +#
>>> +# @message: Human-readable error message provided by the guest. Not
>>> +#     to be trusted.
>> 
>> How is this message related to the one pointed to by @gpa?
>
> In general, @message contains a brief message of the error. While @gpa 
> (when valid) contains a verbose message.
>
> The reason why we need both is because sometime when TD guest hits a 
> fatal error, its memory may get corrupted so we cannot pass information 
> via @gpa. Information in @message is passed through GPRs.

Well, we do pass information via @gpa, always.  I guess it page's
contents can be corrupted.

Perhaps something like

    # @message: Human-readable error message provided by the guest.  Not
    #     to be trusted.
    #
    # @gpa: guest-physical address of a page that contains more verbose 
    #     error information, as zero-terminated string.  Note that guest
    #     memory corruption can corrupt the page's contents.

>>> +#
>>> +# Since: 9.0
>>> +##
>>> +{'struct': 'GuestPanicInformationTdx',
>>> + 'data': {'error-code': 'uint64',
>>> +          'gpa': 'uint64',
>>> +          'message': 'str'}}

Note that my proposed doc string has the members in a different order.
Recommend to use the same order here.

>>> +
>>>   ##
>>>   # @MEMORY_FAILURE:
>>>   #
>> 
>> [...]
>> 


