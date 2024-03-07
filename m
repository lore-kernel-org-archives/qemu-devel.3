Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020F4C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBtD-0004VC-2O; Thu, 07 Mar 2024 06:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBst-0004Sg-2i
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:26:02 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBsr-0000GE-DN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709810758; x=1741346758;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1CmSZHBal2aoFmC/opGyMVJfHE9puXGcDcFD3caXTmo=;
 b=aXBbpbsgi+iqk5MVi36X6P4bT71U/KfHxmTseCAep3mk1rz9BX6YyuHW
 v68yuakobkpmD29rIFUvbLL2P/JvqpOwSxMzUo0B+T54zr8/Mabuh3eaG
 v6BcRkrhYW7jkjY4vgPcV7eQOR7eyKnxbiJxq/keYSjXpW3Cx6ZwVvhKp
 TCUrtMJkWOlp4Dr5utumpm1mNdRVEHSG9jumC7yX498lsWjGUmv4jtfda
 dbPSIAr3GgOkQw1f3EoSG/z2H3F1D0xymgUy1X01P/JZa1LeNqe/DIMJ/
 p8E/zDJVvcgkWfPLhrvvJrMr0T+OhKWrUU2WF+Oi3eM/aYkU1EVTXfMY+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4327681"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4327681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="10527765"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:25:49 -0800
Message-ID: <a0fa9dc9-221c-4ab4-81f6-b692e26d8a23@intel.com>
Date: Thu, 7 Mar 2024 19:25:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
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
 <20240229063726.610065-50-xiaoyao.li@intel.com> <87a5nj1x4l.fsf@pond.sub.org>
 <8a2c760d-6310-42eb-b632-5f67b12e2149@intel.com>
 <87wmqnwga4.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87wmqnwga4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
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

On 2/29/2024 9:28 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 2/29/2024 4:40 PM, Markus Armbruster wrote:
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
>>>>     qemu-system-x86_64 \
>>>>       -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"1","port":"1234"}}' \
>>>>       -machine confidential-guest-support=tdx0
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
>>>
>>> [...]
>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index cac875349a3a..7b26b0a0d3aa 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -917,13 +917,19 @@
>>>>   #     (base64 encoded SHA384 digest). (A default value 0 of SHA384 is
>>>>   #     used when absent).
>>>>   #
>>>> +# @quote-generation-socket: socket address for Quote Generation
>>>> +#     Service (QGS).  QGS is a daemon running on the host.  User in
>>>> +#     TD guest cannot get TD quoting for attestation if QGS is not
>>>> +#     provided.  So admin should always provide it.
>>>
>>> This makes me wonder why it's optional.  Can you describe a use case for
>>> *not* specifying @quote-generation-socket?
>>
>> Maybe at last when all the TDX support lands on all the components, attestation will become a must for a TD guest to be usable.
>>
>> However, at least for today, booting and running a TD guest don't require attestation. So not provide it, doesn't affect anything excepting cannot get a Quote.
> 
> Maybe
> 
>    # @quote-generation-socket: Socket address for Quote Generation
>    #     Service (QGS).  QGS is a daemon running on the host.  Without
>    #     it, the guest will not be able to get a TD quote for
>    #     attestation.

Thanks! will update to it.

> [...]
> 


