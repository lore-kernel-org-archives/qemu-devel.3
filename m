Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E09C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAx3-0007nX-Ra; Wed, 12 Feb 2025 06:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiAww-0007i7-Kg; Wed, 12 Feb 2025 06:30:40 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=131cd17d8=graf@amazon.de>)
 id 1tiAwt-00077v-Hv; Wed, 12 Feb 2025 06:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739359835; x=1770895835;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wPowBh902/NMkf3e0FAdBuDE1qyjSLGuJyPelB6y2Tk=;
 b=VyUhhZKM2euf3UkMEFdRiUaFYRDbIBX9KeZrSFsVLUumVsWtrRw4jcLg
 ookxL13H6QKJG7ZxUTzXEssS1bG/ncZyHTfJbjc9qqEmvTf5kc1jOlLKD
 ENPWHA/OpHIlHFpEJ5eWXImbYLFIjUxDDyB90Lzr0b9V0y0ajwXBt7KIQ Y=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; d="scan'208";a="471510023"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:30:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:26382]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525]
 with esmtp (Farcaster)
 id 7912e840-784c-440e-9d98-5fc2e8379b8f; Wed, 12 Feb 2025 11:30:26 +0000 (UTC)
X-Farcaster-Flow-ID: 7912e840-784c-440e-9d98-5fc2e8379b8f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 11:30:26 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Wed, 12 Feb 2025
 11:30:23 +0000
Message-ID: <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
Date: Wed, 12 Feb 2025 12:30:20 +0100
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
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=131cd17d8=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 12.02.25 11:24, Gerd Hoffmann wrote:
>    Hi,
>
>>> +    /* read header */
>>> +    dma_memory_read(&address_space_memory, dma,
>>> +                    uv->buffer, sizeof(*mhdr),
>>> +                    MEMTXATTRS_UNSPECIFIED);
>> Depending on DMA sounds appealing at first, but can fall apart in corner
>> cases. I know of 2 cases where DMA failed for me in the EC2 equivalent of
>> this:
>>
>> 1) SEV-SNP. If you want the hypervisor to implement UEFI variable services
>> for you, the buffer region must always be in shared state. Ensuring that
>> during boot time is tricky but doable. At runtime you no longer really have
>> control over the sharability of pages.
> With SEV-SNP I don't see the point in using this.
>
> Why do you use confidential computing in the first place if you trust
> the host with your EFI variables?  I'd rather see something simliar
> running under guest control, in svsm context.


That depends heavily on your threat model. You can use a host provided 
variable store to gain variable persistence for things like boot 
variables and then have an ephemeral SVSM based TPM that you use to 
measure the loaded payloads. A malicious host can already replace your 
root volume, so extending the threat to variables is not the end of the 
world.


>
>> 2) Mac OS X. MacOS is the only OS I'm aware of that really makes use of
>> relocation. They move your physical pages to random locations, give you a
>> non-1:1 mapping to that and once you're in real OS land, you have no more
>> knowledge at all about the physical location of anything.
> On the host side you have no insight into this indeed.
>
> The firmware knows all this very well though.  The OS passes a mapping
> table to the firmware, efi runtime drivers can subscribe to mapping
> updates and can use RT->ConvertPointer to translate addresses from
> physical to virtual.
>
> The edk2 code (https://github.com/tianocore/edk2/pull/10695) does
> exactly that.
>
> I see your driver does that too, so in theory it should work just fine.
> I'm wondering what exactly the problem with macOS is?


You get to know the new virtual address, but ConvertPointer never tells 
you what the new *physical* address is. That means you have no idea 
where to DMA from once you're in virtual land. Most OSs just keep a 1:1 
map of virtual to physical, but MacOS does not.


>> Also, I'm surprised you cut the variable service off at the SMM boundary
>> instead of the RTS callback boundary. Why is that cleaner/better than
>> implementing variables completely in QEMU?
> Well, the variable service /is/ completely in qemu.  See patch #6 which
> implements getvariable & friends.  edk2 serializes the variable calls
> into a buffer and sends them over to the SMM side (or to qemu with the
> patches).
>
> I didn't feel like inventing a new serialization protocol if we already
> have a proven one in the edk2 code base.  Also it is possible to send
> over more than just the variable call.  There is a variable policy
> protocol implementation (patch #8), and we also get some events
> forwarded.  More can easily be added should the need for that arise.
>
>> It would be nice to agree on a single external variable store implementation
>> :).
> It would be nice to have nitro support merged upstream,
> especially with BYOF coming.


Yes. Or converge on this protocol instead to simplify the firmware 
implementation so we don't create needless work if someone wants to do 
an actually trivial (and reusable?) UEFI firmware for BYOF.


Alex


