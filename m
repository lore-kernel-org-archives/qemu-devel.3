Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C370C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQuw-0006UY-Lp; Tue, 20 Feb 2024 09:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcQuu-0006UG-LS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:16:16 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcQuq-0002Uc-MZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708438572; x=1739974572;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZzOxx9Qf2X8K1Cl7sBHn+bbSKmwAI3HepkVQZN65h5s=;
 b=fEwgUQibACAhGbQMg1xJvrWwm3PBmf+vSu9r4v48TzSTMe1BKECDw44T
 ECzGNqeNWg5t+ZSkd1N6klEkH+QokVorIcnRen9nIHDrpVvQi4yhkpeXe
 19JcqyYf40bCRaFA0meTkogTDI92iYT6f+3lyMfpPyKGYfja6EfUENPBi
 5D+GKdewrahFaG2Kt2dfLrKSgKD7OFll6Mk46pPxhS0N2rMtc4O3uivRf
 JA37pPvHatJxJ4ZRfZ99gknFAUgZvz4AFukeHvINFf4ifuASB3tbjZrXZ
 Mj8Iqn+r22Nhpr54IEfnUJK1F+sD93E+4JRsiB0jXwVY/q0hR5ZbjFJ5f Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="20073622"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; d="scan'208";a="20073622"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 06:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9432630"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 06:16:04 -0800
Message-ID: <47975bb8-6c7a-413b-9152-1686d8d72ab7@intel.com>
Date: Tue, 20 Feb 2024 22:16:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 50/66] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-51-xiaoyao.li@intel.com>
 <87zfvwehyz.fsf@pond.sub.org> <ZdNPpcNiGcY4Jefi@redhat.com>
 <8734tojz2q.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8734tojz2q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 2/19/2024 10:41 PM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Mon, Feb 19, 2024 at 01:50:12PM +0100, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>
>>>> Add property "quote-generation-socket" to tdx-guest, which is a property
>>>> of type SocketAddress to specify Quote Generation Service(QGS).
>>>>
>>>> On request of GetQuote, it connects to the QGS socket, read request
>>>> data from shared guest memory, send the request data to the QGS,
>>>> and store the response into shared guest memory, at last notify
>>>> TD guest by interrupt.
>>>>
>>>> command line example:
>>>>    qemu-system-x86_64 \
>>>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"1","port":"1234"}}' \
>>>>      -machine confidential-guest-support=tdx0
>>>>
>>>> Note, above example uses vsock type socket because the QGS we used
>>>> implements the vsock socket. It can be other types, like UNIX socket,
>>>> which depends on the implementation of QGS.
>>>>
>>>> To avoid no response from QGS server, setup a timer for the transaction.
>>>> If timeout, make it an error and interrupt guest. Define the threshold of
>>>> time to 30s at present, maybe change to other value if not appropriate.
>>>>
>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>> Changes in v4:
>>>> - merge next patch "i386/tdx: setup a timer for the qio channel";
>>>>
>>>> Changes in v3:
>>>> - rename property "quote-generation-service" to "quote-generation-socket";
>>>> - change the type of "quote-generation-socket" from str to
>>>>    SocketAddress;
>>>> - squash next patch into this one;
>>>> ---
>>>>   qapi/qom.json                         |   6 +-
>>>>   target/i386/kvm/meson.build           |   2 +-
>>>>   target/i386/kvm/tdx-quote-generator.c | 170 ++++++++++++++++++++
>>>>   target/i386/kvm/tdx-quote-generator.h |  95 +++++++++++
>>>>   target/i386/kvm/tdx.c                 | 216 ++++++++++++++++++++++++++
>>>>   target/i386/kvm/tdx.h                 |   6 +
>>>>   6 files changed, 493 insertions(+), 2 deletions(-)
>>>>   create mode 100644 target/i386/kvm/tdx-quote-generator.c
>>>>   create mode 100644 target/i386/kvm/tdx-quote-generator.h
>>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 15445f9e41fc..c60fb5710961 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -914,13 +914,17 @@
>>>>   #     e.g., specific to the workload rather than the run-time or OS.
>>>>   #     base64 encoded SHA384 digest.
>>>>   #
>>>> +# @quote-generation-socket: socket address for Quote Generation
>>>> +#     Service(QGS)
>>>
>>> Space between "Service" and "(QGS)", please.
>>>
>>> The description feels too terse.  What is the "Quote Generation
>>> Service", and why should I care?
>>
>> The "Quote Generation Service" is a daemon running on the host.
>> The reference implementation is at
>>
>>    https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration/quote_wrapper/qgs
>>
>> If you don't provide this, then quests won't bet able to generate
>> quotes needed for attestation. So although this is technically
>> optional, in practice for a sane deployment, an admin should always
>> provide this
> 
> Thanks.  Care to work some of this information into the doc comment?

Sure. Will add a new section of Attestation in the last patch.

>>>> +#
>>>>   # Since: 9.0
>>>>   ##
>>>>   { 'struct': 'TdxGuestProperties',
>>>>     'data': { '*sept-ve-disable': 'bool',
>>>>               '*mrconfigid': 'str',
>>>>               '*mrowner': 'str',
>>>> -            '*mrownerconfig': 'str' } }
>>>> +            '*mrownerconfig': 'str',
>>>> +            '*quote-generation-socket': 'SocketAddress' } }
>>>>   
>>>>   ##
>>>>   # @ThreadContextProperties:
>>>
>>> [...]
>>>
>>
>> With regards,
>> Daniel
> 


