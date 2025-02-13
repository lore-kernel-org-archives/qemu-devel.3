Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C573C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 22:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiheC-00015v-A6; Thu, 13 Feb 2025 17:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tihe9-00015N-2e; Thu, 13 Feb 2025 17:25:25 -0500
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tihe7-0004mR-C5; Thu, 13 Feb 2025 17:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739485524; x=1771021524;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AhGb81AL7FQLqyJblBY54Scpdy8nLptMezQfMN+OzPI=;
 b=p26mQgBKPNYg7VzBMbjm2tLUNL53y4ubD9tcsWJ/2YHkCNrrkcdQ58DW
 tvPbhIAMvJ6IyFGfL4X/3duzACI+xzRNJkPtAqqZjojK0KOhEzDIrBdIc
 byhAT+AiVEFDi/JKXYNiCfqrbwezC7Cpmbt6KgTQFqlsj1ek1CuWpUdWZ I=;
X-IronPort-AV: E=Sophos;i="6.13,284,1732579200"; d="scan'208";a="271011974"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:25:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:37483]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.97:2525]
 with esmtp (Farcaster)
 id 031fe074-2353-4ad6-9ea9-6ec42be02d85; Thu, 13 Feb 2025 22:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 031fe074-2353-4ad6-9ea9-6ec42be02d85
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 22:25:11 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Thu, 13 Feb 2025
 22:25:08 +0000
Message-ID: <342a1bd9-52e9-4a6d-8a2a-63d2b478d896@amazon.com>
Date: Thu, 13 Feb 2025 23:25:06 +0100
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
References: <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
 <f59bb48f-051d-4681-a702-6aed3420c2f7@amazon.com>
 <jnxvyw6q4vkng7jztu7q5rabgeohhpoxojdn4wt6xckc6pzmqz@ateji77pl5j7>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <jnxvyw6q4vkng7jztu7q5rabgeohhpoxojdn4wt6xckc6pzmqz@ateji77pl5j7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.119.213.154;
 envelope-from=prvs=1325cea77=graf@amazon.de; helo=smtp-fw-52004.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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


On 13.02.25 15:54, Gerd Hoffmann wrote:
> On Thu, Feb 13, 2025 at 11:14:03AM +0100, Alexander Graf wrote:
>>> I don't think so.  The firmware driver knows this actually is normal ram
>>> and can setup mappings and memory attributes accordingly.  The situation
>>> is a bit different from vga memory bars which are handled by pci bus
>>> management which doesn't know anything about virtualization specifics.
>>>
>>> Well, unless macos thinks it knows everything better and goes setup
>>> uncached mappings ...
>> It's not only macOS. After SetVirtualAddressMap, the OS owns the virtual
>> address space of Runtime Services. So in theory it also owns cacheability
>> attributes of all mappings.
> Hmm.  Played around with the device memory approach a bit today.  Looks
> workable for both arm/sysbus and x86/isa.  Problem is, if that does
> leave any unsolved corner cases on the table it doesn't buy us much, and
> the arm caching issues start to make me a bit nervous ...
>
> So, maybe allowing pio data transfers is the better approach after all.
>
> How do your patches pick the transfer mode?  Is that dictated by the
> host?  Or is the guest free to choose?  In case of the latter:  How does
> the guest decide what to do?


In our version, the guest gets to pick. It defaults to the DMA interface 
unless it detects that it's running either the macOS logic (a case you 
can ignore for now) or is running with SEV-SNP.

I think for the upstream interface, it would be best to have the host 
indicate which one it recommends the guest to use. That way you can 
force the fallback path without requiring tedious edk2 changes.


>
>> Yes, IIRC we advertise where the hole is. I'm sure we can find a spot.
>> Somewhere next to the HPET :).
> 0xfef1000 seems to be free, which is kida fun b/c of the 'ef1' in the
> address.


True, I love it! :)

It's not enough address space to fit the full 64k buffer though, right? 
Would all of 0xfef00000 be free by chance? Then you could just direct 
map the transfer buffer there.


Alex


