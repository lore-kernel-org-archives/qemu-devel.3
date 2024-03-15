Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF76CC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl38e-000309-NW; Fri, 15 Mar 2024 04:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rl38d-0002zR-Ch
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:42:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rl38a-0002Hv-EA
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710492120; x=1742028120;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BYZszatMuj1dV4ezUXHmmsX3KR1L4424PjD+Q8n/3kc=;
 b=bEHefrxMaJdGt2SzCT+X7xfGJbsIVws31Tm8hOoHfTGFDFCpyU8YW4wa
 rKBl3OdkNvsVWZxawEcL7b6u0EW6bWEroPRlqw2VIoHw5GYPr6i31Zg28
 VUoJu0VJKaCcjlgakrXCi5fMFlQdiF0oThD5JHH3K23pwAiAHIntWcRN1
 W0GevfEeNyp6Qwha7X88res0VIDtuBS1qPQlsmClbXLY7CBOQyLerov4E
 GUX1iqVyNhnu/14unsmFUuYumB9qAd/iVaFHZbtavnv0H+puviypi9hu4
 Ti5YbmBkUwJGkcmVu1xXAR9HJho8B/byOzsgS+OnwuwS3b347ZzY7XwUO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15900038"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="15900038"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 01:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; d="scan'208";a="13005450"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.243.127])
 ([10.125.243.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 01:41:50 -0700
Message-ID: <b23d6983-27f2-4e1d-b13e-1bdfda97cc56@intel.com>
Date: Fri, 15 Mar 2024 16:41:47 +0800
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
 <0f5e1559-bd65-4f3b-bd7a-b166f53dce38@intel.com>
 <ZfHG2DHqf_cnq5tk@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZfHG2DHqf_cnq5tk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 3/13/2024 11:31 PM, Daniel P. Berrangé wrote:
> On Tue, Mar 12, 2024 at 03:44:32PM +0800, Xiaoyao Li wrote:
>> On 3/11/2024 5:27 PM, Daniel P. Berrangé wrote:
>>> On Thu, Feb 29, 2024 at 01:37:10AM -0500, Xiaoyao Li wrote:
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
>>>
>>> Can you illustrate this with 'unix' sockets, not 'vsock'.
>>
>> Are you suggesting only updating the commit message to an example of unix
>> socket? Or you want the code to test with some unix socket QGS?
>>
>> (It seems the QGS I got for testing, only supports vsock socket. Because at
>> the time when it got developed, it was supposed to communicate with drivers
>> inside TD guest directly not via VMM (KVM+QEMU). Anyway, I will talk to
>> internal folks to see if any plan to support unix socket.)
> 
> The QGS provided as part of DCAP supports running with both
> UNIX sockets and VSOCK, and I would expect QEMU to be made
> to work with this, since its is Intel's OSS reference impl.

After synced with internal folks, yes, the QGS I used does support unix 
socket. I tested it and it worked.

-object 
'{"qom-type":"tdx-guest","id":"tdx","quote-generation-socket":{"type":"unix", 
"path":"/var/run/tdx-qgs/qgs.socket"}}'

> Exposing QGS to the guest when we only intend for it to be
> used by the host QEMU is needlessly expanding the attack
> surface.
> 
> With regards,
> Daniel


