Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2721DC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwob-0007Wy-BR; Tue, 12 Mar 2024 03:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjwoZ-0007WU-ES
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:44:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rjwoW-00029n-6q
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710229484; x=1741765484;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ITHHng38MZjgwsFAiVPoxSwyDU+9QQOdTagp+LPjzog=;
 b=kWoWZ+mJENLnsPoEs/bhqFtlN0LtBweCPHt04qVFu6YnoCXu7CMs4O+m
 cglygRmjZHc+PNQgNcy/sEcFDrCOPiJLEcmfElAOi7dIGJeXGPJHg2SMk
 Mis/PQQPsGNUIWlwyudyTbNTaG8pnj+eyXimVVgyyjSYoX9ITw8lqRWia
 nROl0cD7nS8FCcfpRgL9+Hr/AU6GvNCTT4q7/oOKn97+l4QBfgQitX30h
 ypAaibx4sHvZ9ZU27909b5N/X9LLqlDMxSnnLiSp/JCNKEiHOY08Sok4v
 fy9fXl6PXhMmBFYWokzVRSk/7prdn96c2SRmOCCqTyzAYbTYyt0DMisEs A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5059748"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="5059748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 00:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16139002"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 00:44:36 -0700
Message-ID: <0f5e1559-bd65-4f3b-bd7a-b166f53dce38@intel.com>
Date: Tue, 12 Mar 2024 15:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-50-xiaoyao.li@intel.com> <Ze7Ojzty99AbShE3@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Ze7Ojzty99AbShE3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
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

On 3/11/2024 5:27 PM, Daniel P. Berrangé wrote:
> On Thu, Feb 29, 2024 at 01:37:10AM -0500, Xiaoyao Li wrote:
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
> 
> Can you illustrate this with 'unix' sockets, not 'vsock'.

Are you suggesting only updating the commit message to an example of 
unix socket? Or you want the code to test with some unix socket QGS?

(It seems the QGS I got for testing, only supports vsock socket. Because 
at the time when it got developed, it was supposed to communicate with 
drivers inside TD guest directly not via VMM (KVM+QEMU). Anyway, I will 
talk to internal folks to see if any plan to support unix socket.)

> It makes no conceptual sense to be using vsock for two
> processes on the host to be using vsock to talk to
> each other. vsock is only needed for the guest to talk
> to the host.
> 
>>      -machine confidential-guest-support=tdx0
>>
>> Note, above example uses vsock type socket because the QGS we used
>> implements the vsock socket. It can be other types, like UNIX socket,
>> which depends on the implementation of QGS.
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
>> Changes in v5:
>> - add more decription of quote-generation-socket property;
>>
>> Changes in v4:
>> - merge next patch "i386/tdx: setup a timer for the qio channel";
>>
>> Changes in v3:
>> - rename property "quote-generation-service" to "quote-generation-socket";
>> - change the type of "quote-generation-socket" from str to
>>    SocketAddress;
>> - squash next patch into this one;
>> ---
>>   qapi/qom.json                         |   8 +-
>>   target/i386/kvm/meson.build           |   2 +-
>>   target/i386/kvm/tdx-quote-generator.c | 170 ++++++++++++++++++++
>>   target/i386/kvm/tdx-quote-generator.h |  95 +++++++++++
>>   target/i386/kvm/tdx.c                 | 216 ++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h                 |   6 +
>>   6 files changed, 495 insertions(+), 2 deletions(-)
>>   create mode 100644 target/i386/kvm/tdx-quote-generator.c
>>   create mode 100644 target/i386/kvm/tdx-quote-generator.h
> 
> 
> With regards,
> Daniel


