Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74F0C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiWEm-0004km-1o; Thu, 13 Feb 2025 05:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiWEi-0004iR-PM; Thu, 13 Feb 2025 05:14:24 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiWEg-00079z-UK; Thu, 13 Feb 2025 05:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739441664; x=1770977664;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NF6TsSr0bWdAlT9eyk9YvlvoTYhpihpBhptbLVZzBQE=;
 b=tqIBrf3cEvDvt3frVmxki0QSomYKnw06WUSdU5y9Sc7uM6qIRtKSpUUQ
 DWPzSFR4xCaCVp1mxan+n7/+nX5qU1wk4fHqc9JIh5PJ9h53k5Z+ngef2
 BiovCohuiRwciMg2wXwWJVEfhu8VsQmhNHf4myifvhqFWbIu8wrhNehhs Q=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; d="scan'208";a="376988335"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:14:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:59877]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525]
 with esmtp (Farcaster)
 id 23d80605-072c-4b49-b2af-acac7eaca184; Thu, 13 Feb 2025 10:14:15 +0000 (UTC)
X-Farcaster-Flow-ID: 23d80605-072c-4b49-b2af-acac7eaca184
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 10:14:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Thu, 13 Feb 2025
 10:14:05 +0000
Message-ID: <f59bb48f-051d-4681-a702-6aed3420c2f7@amazon.com>
Date: Thu, 13 Feb 2025 11:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
To: Gerd Hoffmann <kraxel@redhat.com>
CC: <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, <qemu-arm@nongnu.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Ard Biesheuvel
 <ardb@kernel.org>
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=1325cea77=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


On 13.02.25 10:52, Gerd Hoffmann wrote:
>    Hi,
>
>> That will bring back all issues with cached vs non-cached memory accesses,
>> no? So edk2 will always access that memory as device memory which means it
>> bypasses the cache, while QEMU will access it through the cache. So that
>> buffer would need to actually be MMIO memory I suppose?
> I don't think so.  The firmware driver knows this actually is normal ram
> and can setup mappings and memory attributes accordingly.  The situation
> is a bit different from vga memory bars which are handled by pci bus
> management which doesn't know anything about virtualization specifics.
>
> Well, unless macos thinks it knows everything better and goes setup
> uncached mappings ...


It's not only macOS. After SetVirtualAddressMap, the OS owns the virtual 
address space of Runtime Services. So in theory it also owns 
cacheability attributes of all mappings.

>
>>> Not sure how to do that best on x86 though.  Find 64k unused address
>>> space over ioapic?  Do we have enough free space there?  And how
>>> future-proof would that be?
>> I'm not worried yet about where we place that memory, but more about
>> ensuring that we actually have a working path to access it. We can always
>> find space in the PCI hole, as long as we properly advertise it to all
>> stakeholders via ACPI and memory map.
> Well, the host can't easily place stuff in the pci hole because the
> guest will manage that (map pci bars etc).  But making the pci hole
> a bit smaller to make room is an option I think.


Yes, IIRC we advertise where the hole is. I'm sure we can find a spot. 
Somewhere next to the HPET :).


Alex


