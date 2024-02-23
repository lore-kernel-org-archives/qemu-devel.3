Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCB0C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 01:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdK1Y-0001lZ-3d; Thu, 22 Feb 2024 20:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rdK1Q-0001fH-3M
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:06:41 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rdK1M-0004cE-Az
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708650396; x=1740186396;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UYf7Lpk+4RWbwrAMIQ5hC6FFwZoS9ehF7K5lptzklNI=;
 b=cT8BVibJsCwM7hLcr5/LUWgqOkECDrM1/PdQvGbvaSr/ZVLAoRr13Nln
 rUZODHMcrNdZKLzbgaQKrqucvfp0zh4xl+z4TxFzHI+rQJ0XS+Xgl4Ukc
 mYH5UhOI1aFeeISciOvEsy2VvlBJAeiKmvr8rFcnQIo7qIoVpALA7sXyD
 /Mo9psW6aHhH1OXecsaddUQ0EMdLPws4a4Fy/cp8/qtcOW5d3M07f58OC
 aEWvtNj4juDRLXCH1SalVzlsG15Eix/c8N6N6vbiXQcV2R1MokITMOJiC
 acgrQAh/LsVWLsLGOkDwoTeGbkNLUFuSJqDVbV5lpdemxj5gPJf0NC7i4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13572782"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="13572782"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 17:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6130250"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 17:06:26 -0800
Message-ID: <7968b9fa-af4b-4eca-893d-a9b3bb81803a@intel.com>
Date: Fri, 23 Feb 2024 09:06:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 50/66] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 feng.qiu@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-51-xiaoyao.li@intel.com>
 <Zdd2oSFOiIparDIe@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zdd2oSFOiIparDIe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

+ Feng Qiu,

On 2/23/2024 12:30 AM, Daniel P. Berrangé wrote:
> On Wed, Jan 24, 2024 at 10:23:12PM -0500, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Add property "quote-generation-socket" to tdx-guest, which is a property
>> of type SocketAddress to specify Quote Generation Service(QGS).
>>
>> On request of GetQuote, it connects to the QGS socket, read request
>> data from shared guest memory, send the request data to the QGS,
>> and store the response into shared guest memory, at last notify
>> TD guest by interrupt.
>>
>> command line example:
>>    qemu-system-x86_64 \
>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"1","port":"1234"}}' \
>>      -machine confidential-guest-support=tdx0
>>
>> Note, above example uses vsock type socket because the QGS we used
>> implements the vsock socket. It can be other types, like UNIX socket,
>> which depends on the implementation of QGS.
> 
> Can you confirm again exactly what QGS impl you are testing against ?
> > I've tried the impl at
> 
>     https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration/quote_wrapper/qgs
> 
> which supports UNIX sockets and VSOCK. In both cases, however, it
> appears to be speaking a different protocol than your QEMU impl
> below uses.
> 
> Specifically here:
> 
>    https://github.com/intel/SGXDataCenterAttestationPrimitives/blob/master/QuoteGeneration/quote_wrapper/qgs/qgs_server.cpp#L143
> 
> it is reading 4 bytes of header, which are interpreted as the length
> of the payload which will then be read off the wire. IIUC the payload
> it expects is the TDREPORT struct.
> 
> Your QEMU patches here meanwhile are just sending the payload from
> the GetQuote hypercall which is the TDREPORT struct.
> 
> IOW, QEMU is not sending the 4 byte length header the QGS expects.
> and whole thing fails.

I'm using the one provided by internal folks, which supports 
interpreting the payload without the header.

I don't know when will the updated implementation show up in public 
github. @Feng Liu can help on it.

>>
>> To avoid no response from QGS server, setup a timer for the transaction.
>> If timeout, make it an error and interrupt guest. Define the threshold of
>> time to 30s at present, maybe change to other value if not appropriate.
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
> 
> With regards,
> Daniel


