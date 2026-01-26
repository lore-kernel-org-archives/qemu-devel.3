Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F4ED1950C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQDv-0008NQ-Tj; Mon, 26 Jan 2026 12:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vkQDc-00082o-RE
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:17:48 -0500
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vkQDa-0002gC-9s
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:17:40 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id AE2D258266F;
 Mon, 26 Jan 2026 17:17:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a224.dreamhost.com
 (trex-green-7.trex.outbound.svc.cluster.local [100.96.80.125])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 430D65834A4;
 Mon, 26 Jan 2026 17:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1769447852;
 b=6OoHJVWvjD6bvrrn/QuQPkpFU4gAzx2bCoiP2m5hF8ajswLAiCHtj8vODUZ7gCcEt2cq6t
 RjWeFfZxwoig3Kqbd6XlXVUTgCrUcBmvdoAXNBrLcwxBAzPZGyuVGhyhK8kOr14mQgf+Db
 mTyqZZr4qnwbF8bVKI1JnA6QDBS3reqVxX6TrSKq+znUfPLusgZnw8GVz8DcoCZtrhPD6z
 Hny/JNHTlOHe5AaONeKUAoVYALBXgAf20RRfCZOsh7Tii1Pf7d8aSiwvoER84jgmbWYM7Q
 antYFOzN9/ra42XuddcCghZk7ne9YIs2gco8SAVNgRfWHVQLIVHexYatEcc/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1769447852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=M7a/IjpddKIvyQ4YbmPomGd3bdJa2WayhGcxRcEN3FM=;
 b=IMu6FwRix+yrqOoKDVUERMqW5BCqngGtC76KV8h8SwZ6n2xIkGB5S9M3aKPDcJ2o02nygy
 lYp7Q6ebOrybAYHu6HBlOoBbrSEXBmtt56DGZKqOEG/0WB4UvFDbUiZQOVU+malUn92xeV
 v42gkxIApwk04OYOl5bgkW6Lj02jl8kdqLqxz4VziEWewGG88qEVLydqDRfjx1UmMnywUQ
 yXT4AM7LYyKr6YPBxfOAYkU4oVah9Q6RFHBUFRTDfq5sNluwLM4YbEfDevK3duJhIt685Q
 WxTTnbbLOqZnBHM0hCkMudvzpgJvAyS1qmohMj+XtdUNt0wtPwNY1GCSP91W/A==
ARC-Authentication-Results: i=1; rspamd-687cd87ff8-t7vvw;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Print: 75b7493a42596d45_1769447854569_2974274026
X-MC-Loop-Signature: 1769447854569:4243345005
X-MC-Ingress-Time: 1769447854568
Received: from pdx1-sub0-mail-a224.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.80.125 (trex/7.1.3); Mon, 26 Jan 2026 17:17:34 +0000
Received: from [IPV6:2607:fb90:fa00:cff2:b35:7c5b:46bd:1fa2] (unknown
 [172.58.10.254])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a224.dreamhost.com (Postfix) with ESMTPSA id 4f0FbH2xtdz1Nc; 
 Mon, 26 Jan 2026 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1769447852;
 bh=M7a/IjpddKIvyQ4YbmPomGd3bdJa2WayhGcxRcEN3FM=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=wHskRx7ukRl6HNVI6Ln79fZxfj7yHhcJ9kK/J97TwoDKabsHmxzG96TKtxD7hbSiz
 ifdm7i/qq0/LxfR76+hziMYju20Nm56z8UetCMfcOmsp9NwJZHbtPKCvwnX/vd8gRZ
 e4OC6mRHdugNtDl/Lh+29zCYSoBlW0P2OUOBZEjAzHvS88pF1+zAa3eVaLBr2ztN4s
 bT28+6nb9dHnz5iROrlEWGZwKx+O2piVeSU9f4mkApZ+5+TbcgQbNLBqVkB6LFKRhT
 cFXv2/ZvPatLdc97bGQzVjDbN47btlOZPKHwNLNWdBjRqVRY8848zJcFHgJnGFYHhv
 za1KXBAqF/vqw==
Message-ID: <2446284b-b76c-4335-929d-eeef8ed0c6cc@landley.net>
Date: Mon, 26 Jan 2026 11:17:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20251124095109.66091-1-philmd@linaro.org>
 <20251124095109.66091-2-philmd@linaro.org>
 <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
 <f189995e-09f7-456d-b860-ee6a3dc8fc49@landley.net>
 <9334f855-8e54-0fa3-a2f9-604f72012ace@eik.bme.hu>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <9334f855-8e54-0fa3-a2f9-604f72012ace@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=rob@landley.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/31/25 06:01, BALATON Zoltan wrote:
>> Ah, the - is the fail and the + is the success, I'm guessing the 
>> extract failed and the error path freed it early. Possibly the new 
>> memory block is either overwriting the cpio.gz or changing where it 
>> lives in a way the kernel isn't finding it.
> 
> I don't know anything about this

Unfortunately I know about it less than I like, but I'm digging into the 
code in the absence of further replies from people who presumably do know...

> but have you tried comparing 'info 
> mtree' output from QEMU Monitor to see what changed? That may show if 
> some memory block moved or overlaps something now.

I said "Possibly the new memory block is..." because the purpose of the 
patch series I was replying to was adding more memory blocks to the r2d 
board so it could have more than 64 megs ram. (Seems like this is like a 
10 line change not a big series, but...) I was regression testing to see 
if unchanged kernels still worked fine, hence finding (what seems to be) 
a conflict with qemu's command line initrd loader. (Sorry for the delay 
following up, a dementia patient declared war on the city I live in.)

Alas "info mtree" is a bit verbose to wade through, although I'll 
probably take a swing at it if I can't parse the rest of this. (It would 
be nice if it WASN'T always printing 8 leading zeroes for every number 
on a 32 bit platform.) What I'd really like to get out of the monitor is 
the device tree, but that doesn't seem to be an option...

https://qemu-project.gitlab.io/qemu/system/monitor.html said that "info 
mem" is an option, but my qemu build disagred, so I did:

(qemu) info roms
info roms
addr=000000000c010000 size=0x000200 mem=ram name="boot_params"
addr=000000000c800000 size=0x31e020 mem=ram name="./linux-kernel"
addr=000000000d800000 size=0x084411 mem=ram name="./initramfs.cpio.gz"
(qemu) info ramblock
               Block Name    PSize              Offset 
Used              Total                HVA  RO
                r2d.sdram    4 KiB  0x0000000000000000 
0x0000000004000000 0x0000000004000000 0x00007fd6d7e00000  rw
                r2d.flash    4 KiB  0x0000000004800000 
0x0000000001000000 0x0000000001000000 0x00007fd6e2e00000  rw
              sm501.local    4 KiB  0x0000000004000000 
0x0000000000800000 0x0000000000800000 0x00007fd728c00000  rw
     pci:02.0/rtl8139.rom    4 KiB  0x0000000005800000 
0x0000000000040000 0x0000000000040000 0x00007fd728a00000  ro

Which SEEMS to say that the 64m of sram is at offset ZERO, despite 
hw/sh4/rd2.c (before all these patches) doing:

#define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
#define SDRAM_SIZE 0x04000000

     /* Allocate memory space */
     memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, 
&error_fatal);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);

And then the boot params, kernel, and initrd.cpio.gz are loaded as 
_roms_ in what would otherwise be the ram area...? (Again, the docs are 
pointing me at nonexistent commands, so...)

I've just been reading the qemu source, but it's a bit eldritch in 
places and has bloated by about 3x since I last went through it...

You're right the mtree subset for "memory" shows things in the expected 
places, or at least sort of. (There's also address-space: I/O, 
cpu-memory-0, rtl8139, sh_pci_host, intc, timer, sh_pci, ANOTHER one 
called "memory", timer, sci, scif, rtl8139 _again_, I/O again, and then 
"system" seems to be "memory" again...)

"What does a kernel running on this emulated hardware see" would be a 
nice thing to get an answer to, but that doesn't appear to have occurred 
to the people who wrote "monitor". Or if it did, it's like -hda where 
the simple interface was deprecated, and it's one of the:

(qemu) info memdev
info memdev

(qemu) info memory-devices
info memory-devices
(qemu) info memory_size_summary
info memory_size_summary
base memory: 67108864

(Don't ask me why the first one has a blank line and the others don't. 
The third one doesn't say WHERE the memory is, or what mapping holes I 
could put more memory in...)

Hmmm... ah, this ALMOST seems to do what I want:

(qemu) info mtree -f
info mtree -f
FlatView #0
  AS "memory", root: system
  AS "cpu-memory-0", root: system
  AS "sh_pci_host", root: bus master container
  AS "rtl8139", root: bus master container
  Root memory region: system
   0000000000000000-0000000000ffffff (prio 0, romd): r2d.flash
   0000000004000000-000000000400003f (prio 0, i/o): r2d-fpga
   000000000c000000-000000000fffffff (prio 0, ram): r2d.sdram
   0000000010000000-00000000107fffff (prio 0, ram): sm501.local
   0000000013e00000-0000000013e0006b (prio 0, i/o): sm501-system-config
   0000000013e10040-0000000013e10053 (prio 0, i/o): sm501-i2c
   0000000013e30000-0000000013e3001f (prio 0, i/o): serial
   0000000013e40000-0000000013e400ff (prio 0, i/o): ohci
   0000000013e80000-0000000013e80fff (prio 0, i/o): sm501-disp-ctrl
   0000000013f00000-0000000013f00053 (prio 0, i/o): sm501-2d-engine
   000000001400080c-000000001400080f (prio 0, i/o): ide-mmio.2
   0000000014001000-000000001400101f (prio 0, i/o): ide-mmio.1
   000000001e080000-000000001e080003 (prio 0, i/o): intc @000000001e080000
   000000001e080040-000000001e080043 (prio 0, i/o): intc @000000001e080040
   000000001e080060-000000001e080063 (prio 0, i/o): intc @000000001e080060
   000000001e100000-000000001e10002f (prio 0, i/o): timer
   000000001e200000-000000001e200223 (prio 0, i/o): sh_pci
   000000001f000000-000000001f000fff (prio 0, i/o): memory @000000001f000000
   000000001f800000-000000001f800fff (prio 0, i/o): memory @000000001f800000
   000000001fc00000-000000001fc00fff (prio 0, i/o): memory @000000001fc00000
   000000001fd00004-000000001fd00013 (prio 0, i/o): intc @000000001fd00004
   000000001fd80000-000000001fd8002f (prio 0, i/o): timer
   000000001fe00000-000000001fe00027 (prio 0, i/o): sci
   000000001fe80000-000000001fe80027 (prio 0, i/o): scif
   00000000f0000000-00000000f7ffffff (prio 0, i/o): cache-and-tlb
   00000000fd040000-00000000fd0400ff (prio 1, i/o): rtl8139
   00000000fe080000-00000000fe080003 (prio 0, i/o): intc @000000001e080000
   00000000fe080040-00000000fe080043 (prio 0, i/o): intc @000000001e080040
   00000000fe080060-00000000fe080063 (prio 0, i/o): intc @000000001e080060
   00000000fe100000-00000000fe10002f (prio 0, i/o): timer
   00000000fe200000-00000000fe200223 (prio 0, i/o): sh_pci
   00000000fe240000-00000000fe240fff (prio 0, i/o): io
   00000000fe241000-00000000fe2410ff (prio 1, i/o): rtl8139
   00000000fe241100-00000000fe24ffff (prio 0, i/o): io @0000000000001100
   00000000ff000000-00000000ff000fff (prio 0, i/o): memory @000000001f000000
   00000000ff800000-00000000ff800fff (prio 0, i/o): memory @000000001f800000
   00000000ffc00000-00000000ffc00fff (prio 0, i/o): memory @000000001fc00000
   00000000ffd00004-00000000ffd00013 (prio 0, i/o): intc @000000001fd00004
   00000000ffd80000-00000000ffd8002f (prio 0, i/o): timer
   00000000ffe00000-00000000ffe00027 (prio 0, i/o): sci
   00000000ffe80000-00000000ffe80027 (prio 0, i/o): scif

FlatView #1
  AS "I/O", root: io
  Root memory region: io
   0000000000000000-0000000000000fff (prio 0, i/o): io
   0000000000001000-00000000000010ff (prio 1, i/o): rtl8139
   0000000000001100-000000000000ffff (prio 0, i/o): io @0000000000001100

Except for the "FlatView #1" part at the end? (Define "flat" if there's 
two of them...)

> The SH in QEMU is not much maintained

The subject says "Re: [PATCH... 01/13] because I was replying to a patch 
in a series to update sh in qemu.

Here's me first getting an sh4 kernel booted under qemu a couple decades 
ago now:

https://lists.gnu.org/archive/html/qemu-devel/2009-02/msg00961.html

I've regression tested both current linux/arch/sh and qemu-system-sh4 at 
least a couple times a year ever since: 
https://landley.net/bin/mkroot/latest/sh4.tgz is linux-6.17 because that 
was current at the time.

> and maybe there aren't many people 
> to look at it so don't expect much help with it.

Other than the people I cc'd on the email, including the patch's author, 
the linux arch/sh maintainer, a previous linux arch/sh maintainer... 
(Who were all cc'd on the original patch series.)

Rob

