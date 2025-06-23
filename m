Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F426C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 07:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTbDn-0001Dy-DO; Mon, 23 Jun 2025 03:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uTbDk-0001D9-4j
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 03:04:00 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uTbDh-0005Da-SC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 03:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750662238; x=1782198238;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/5kJrZkidYndVUj0ftyAdJNTNVDkKRZ3ymWBvpOsvNc=;
 b=m+R004bD02Pqn0ezdq8bXTq3ShJza3q4KHo+IgCwWtlGPT8nwmULUy16
 uRiT3aT5z62JP3xqAnqZw3w28247VFShWodWBOUpwqHhZZ2q0KKyymoGT
 14CE1sl/bNt3deMGPUJtRdB/IA48mXeGq5j1N9Oww0TwF3ehabXttt6Fw
 CH85MGvZoydRXWy0OtoY1N5ZoO6E0LEUIqXoy1yAUNIzLTQzVfuv6txVz
 oqcb+5912MiwR8BTSgMZXIiFfS83vMpF5D1q2N6rXjumf1gjVkjpw46wH
 dBZU0SyjXg7hAB3Rqt2Kx1WjAe1vJWR6k4pxwnXkm3v3xDJe6BGLbpoCV g==;
X-CSE-ConnectionGUID: ME4eWUk6SsOEDrJ0BwSLbQ==
X-CSE-MsgGUID: XU7nFDgiTDGE+XxH0RunIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63462909"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63462909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 00:03:26 -0700
X-CSE-ConnectionGUID: ORy9CO55QRinZ64AK3wTXQ==
X-CSE-MsgGUID: /K6bd4ADT9+j3g+ajbvABA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182385052"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 00:03:24 -0700
Message-ID: <4ffdb62b-8fe4-4b34-9efa-aecff7f8e77b@intel.com>
Date: Mon, 23 Jun 2025 15:03:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
 <20250620164053.579416-25-pbonzini@redhat.com>
 <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/2025 2:43 PM, Cédric Le Goater wrote:
> Hello,
> 
> On 6/20/25 18:40, Paolo Bonzini wrote:
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
>>    qemu-system-x86_64 \
>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation- 
>> socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
>>      -machine confidential-guest-support=tdx0
>>
>> Note, above example uses the unix socket. It can be other types, like 
>> vsock,
>> which depends on the implementation of QGS.
>>
>> To avoid no response from QGS server, setup a timer for the transaction.
>> If timeout, make it an error and interrupt guest. Define the threshold of
>> time to 30s at present, maybe change to other value if not appropriate.
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   qapi/qom.json                         |   8 +-
>>   target/i386/kvm/tdx-quote-generator.h |  82 +++++++
>>   target/i386/kvm/tdx.h                 |  10 +
>>   target/i386/kvm/kvm.c                 |   3 +
>>   target/i386/kvm/tdx-quote-generator.c | 300 ++++++++++++++++++++++++++
>>   target/i386/kvm/tdx-stub.c            |   4 +
>>   target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
>>   target/i386/kvm/meson.build           |   2 +-
>>   8 files changed, 582 insertions(+), 3 deletions(-)
>>   create mode 100644 target/i386/kvm/tdx-quote-generator.h
>>   create mode 100644 target/i386/kvm/tdx-quote-generator.c
> 
> These changes broke the build on 32-bit host.
> 
> Could you please send a patch to avoid compiling TDX in such environment ?

Paolo is on vacation.

I would like to help, but I don't have 32-bit host environment on hand. 
Do you know how to set up such environment quickly? (I tried to set up 
within a 32-bit VM but the 32-bit OS is too old and I didn't get it work 
to install the required package for building QEMU)

> Thanks,
> 
> C.


