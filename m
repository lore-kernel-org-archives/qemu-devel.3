Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFADC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riEBS-0005eF-3A; Thu, 07 Mar 2024 08:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riE9R-0001Ht-Rw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riE9Q-0002fn-19
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709819471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pzi7sdNZeGs1dGXxkhkbvPNWB5w1qE1yGq6BNriwoh4=;
 b=MljLUkW/Wn0S1aUrk5sjB0EguRVHglL9gqRdMIboMfcPd5vfFFXjj6olmyZkYrBnnugI6D
 +meRBlpTaxFvUP5jgccRcbVKLak1UjqXzy6xRWckevuZVPKA/yp9AnU8/rFVg8BYNb74VB
 zOOn6Fmv4muSnjhmsjB5vT1elNcsZkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-gs78qwJkMz6nYKxsNPaW9g-1; Thu, 07 Mar 2024 08:51:06 -0500
X-MC-Unique: gs78qwJkMz6nYKxsNPaW9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 060C9101CC67;
 Thu,  7 Mar 2024 13:51:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9224016A9C;
 Thu,  7 Mar 2024 13:51:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F6E621E6A24; Thu,  7 Mar 2024 14:51:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 52/65] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
In-Reply-To: <d5cb6e5e-0bc1-40bd-8fc1-50a03f42e9cf@intel.com> (Xiaoyao Li's
 message of "Thu, 7 Mar 2024 19:30:37 +0800")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-53-xiaoyao.li@intel.com>
 <874jdr1wmt.fsf@pond.sub.org>
 <d5cb6e5e-0bc1-40bd-8fc1-50a03f42e9cf@intel.com>
Date: Thu, 07 Mar 2024 14:51:03 +0100
Message-ID: <87y1au881k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/29/2024 4:51 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>=20
>>> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>>>
>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>> Changes in v5:
>>> - mention additional error information in gpa when it presents;
>>> - refine the documentation; (Markus)
>>>
>>> Changes in v4:
>>> - refine the documentation; (Markus)
>>>
>>> Changes in v3:
>>> - Add docmentation of new type and struct; (Daniel)
>>> - refine the error message handling; (Daniel)
>>> ---
>>>   qapi/run-state.json   | 31 +++++++++++++++++++++--
>>>   system/runstate.c     | 58 +++++++++++++++++++++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.c | 24 +++++++++++++++++-
>>>   3 files changed, 110 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>> index dd0770b379e5..b71dd1884eb6 100644
>>> --- a/qapi/run-state.json
>>> +++ b/qapi/run-state.json
>>> @@ -483,10 +483,12 @@
>>>  #
>>>  # @s390: s390 guest panic information type (Since: 2.12)
>>>  #
>>> +# @tdx: tdx guest panic information type (Since: 9.0)
>>> +#
>>>  # Since: 2.9
>>>  ##
>>>  { 'enum': 'GuestPanicInformationType',
>>> -  'data': [ 'hyper-v', 's390' ] }
>>> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>>>     ##
>>> # @GuestPanicInformation:
>>> @@ -501,7 +503,8 @@
>>>    'base': {'type': 'GuestPanicInformationType'},
>>>    'discriminator': 'type',
>>>    'data': {'hyper-v': 'GuestPanicInformationHyperV',
>>> -          's390': 'GuestPanicInformationS390'}}
>>> +          's390': 'GuestPanicInformationS390',
>>> +          'tdx' : 'GuestPanicInformationTdx'}}
>>>  ##
>>>  # @GuestPanicInformationHyperV:
>>> @@ -564,6 +567,30 @@
>>>             'psw-addr': 'uint64',
>>>             'reason': 'S390CrashReason'}}
>>> +##
>>> +# @GuestPanicInformationTdx:
>>> +#
>>> +# TDX Guest panic information specific to TDX, as specified in the
>>> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
>>> +# section TDG.VP.VMCALL<ReportFatalError>.
>>> +#
>>> +# @error-code: TD-specific error code
>>> +#
>>> +# @message: Human-readable error message provided by the guest. Not
>>> +#     to be trusted.
>>> +#
>>> +# @gpa: guest-physical address of a page that contains more verbose
>>> +#     error information, as zero-terminated string.  Present when the
>>> +#     "GPA valid" bit (bit 63) is set in @error-code.
>>
>> Uh, peeking at GHCI Spec section 3.4 TDG.VP.VMCALL<ReportFatalError>, I
>> see operand R12 consists of
>>
>>      bits    name                        description
>>      31:0    TD-specific error code      TD-specific error code
>>                                          Panic =E2=80=93 0x0.
>>                                          Values =E2=80=93 0x1 to 0xFFFFF=
FFF
>>                                          reserved.
>>      62:32   TD-specific extended        TD-specific extended error code.
>>              error code                  TD software defined.
>>      63      GPA Valid                   Set if the TD specified additio=
nal
>>                                          information in the GPA parameter
>>                                          (R13).
>> Is @error-code all of R12, or just bits 31:0?
>> If it's all of R12, description of @error-code as "TD-specific error
>> code" is misleading.
>
> We pass all of R12 to @error_code.
>
> Here it wants to use "error_code" as generic as the whole R12. Do you hav=
e any better description of it ?

Sadly, the spec is of no help: it doesn't name the entire thing, only
the three sub-fields TD-specific error code, TD-specific extended error
code, GPA valid.

We could take the hint, and provide the sub-fields instead:

* @error-code contains the TD-specific error code (bits 31:0)

* @extended-error-code contains the TD-specific extended error code
  (bits 62:32)

* we don't need @gpa-valid, because it's the same as "@gpa is present"

If we decide to keep the single member, we do need another name for it.
@error-codes (plural) doesn't exactly feel wonderful, but it gives at
least a subtle hint that it's not just *the* error code.

>> If it's just bits 31:0, then 'Present when the "GPA valid" bit (bit 63)
>> is set in @error-code' is wrong.  Could go with 'Only present when the
>> guest provides this information'.
>>=20
>>> +#
>>> +#
>>
>> Drop one of these two lines, please.
>>=20
>>> +# Since: 9.0
>>> +##
>>> +{'struct': 'GuestPanicInformationTdx',
>>> + 'data': {'error-code': 'uint64',
>>> +          'message': 'str',
>>> +          '*gpa': 'uint64'}}
>>> +
>>>   ##
>>>   # @MEMORY_FAILURE:
>>>   #
>>=20


