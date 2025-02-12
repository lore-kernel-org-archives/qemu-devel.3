Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177D9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKGD-0001rs-50; Wed, 12 Feb 2025 16:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiKFx-0001r6-VE; Wed, 12 Feb 2025 16:26:54 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiKFu-0008A2-Ua; Wed, 12 Feb 2025 16:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739395611; x=1770931611;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oT81K49Xsa2SJv24Kp3+uTsDVxMAUY2ffI5tRIzxybA=;
 b=sqyBRw74yu8W3DJeYu12vdTuVopJ/gUA4STNMl3AAMV6LSp7PScmGAeu
 BIJIJwZRKiEdr6fVJuKMBa66CUvYESv6g5ZOF4ZcbK9fAVOJ++x2WbpS0
 U87cGlQDNla+BubE3UPYLCv/zZj25ICBSztGFnowd5Je236NkPjexUtC8 U=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; d="scan'208";a="471665595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:26:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:44711]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.1:2525] with
 esmtp (Farcaster)
 id f0861896-2dcc-4525-aa01-f1c13c01e0be; Wed, 12 Feb 2025 21:26:45 +0000 (UTC)
X-Farcaster-Flow-ID: f0861896-2dcc-4525-aa01-f1c13c01e0be
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 21:26:45 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Wed, 12 Feb 2025
 21:26:41 +0000
Message-ID: <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
Date: Wed, 12 Feb 2025 22:26:39 +0100
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
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=131cd17d8=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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


On 12.02.25 16:18, Gerd Hoffmann wrote:
>    Hi,
>
>>> Yes.  Knowing both physical and virtual address works only for memory
>>> you allocated yourself before ExitBootServices.  So you can't pass on
>>> pointers from the OS, you have to copy the data to a buffer where you
>>> know the physical address instead.  Yes, some overhead.  Should still
>>> be much faster than going to pio transfer mode ...
>> MacOS takes over the full physical address map past ExitBootServices: Your
>> code no longer has VA access to random code
> That is totally fine.  EFI drivers must register everything they need as
> runtime memory.  Anything else can be unmapped by the OS when calling
> EFI services.
>
>> and it literally memcpy()'s all preserved (virtual available) code and
>> data to different physical addresses.
> Uhm.  I have my doubts this copying behavior is blessed by the UEFI spec.


I don't remember anything in the spec prohibiting it.


>> You simply have nothing that is all of 1) RAM (mapped as cacheable on
>> ARM), 2) known VA 3) known PA.
> Bummer.
>
>> So we really really need a fallback mechanism that works without DMA
>> :).
> On arm it should be relatively simple to move the buffer to device
> memory.  Just place one more region on the platform bus, advertise
> address + size via device tree, done.


That will bring back all issues with cached vs non-cached memory 
accesses, no? So edk2 will always access that memory as device memory 
which means it bypasses the cache, while QEMU will access it through the 
cache. So that buffer would need to actually be MMIO memory I suppose?


> Not sure how to do that best on x86 though.  Find 64k unused address
> space over ioapic?  Do we have enough free space there?  And how
> future-proof would that be?


I'm not worried yet about where we place that memory, but more about 
ensuring that we actually have a working path to access it. We can 
always find space in the PCI hole, as long as we properly advertise it 
to all stakeholders via ACPI and memory map.


Alex


