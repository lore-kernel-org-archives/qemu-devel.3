Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D556D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRIO-0002ze-2X; Mon, 26 Jan 2026 13:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vkRIE-0002nM-OU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:26:32 -0500
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vkRIB-0000Vd-AK
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:26:30 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5FE977E222C;
 Mon, 26 Jan 2026 18:26:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com
 (trex-green-6.trex.outbound.svc.cluster.local [100.119.189.139])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id B500A7E28FC;
 Mon, 26 Jan 2026 18:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1769451982;
 b=JqsLDSbPlDlFKcn8A4GlWv5RAP8Gq+BnJ+4E0M8tvMBSUUM8rxLRyvVi7s+y3HY1XxKNR9
 5pfWWUgPjq+J2xV6BFBxWh9YHSFemSBXJtSftVQqzgHAFCar4GyNuSDw9qu+aHEiG/PNbu
 jGbGm6/ZW5gi5GXSJakW9La+T5kAL980HS8b9BoKcPONaRNrVuoKl8NbB/oOh19Sw33cem
 v8gBosxC9mQ+Z54VwD4jhYvqKWksp+VznxhDUVVKUFWI0dLfPnb5GWTh+a0ydsxpVyH1b3
 9pL9IMnU/D1MF7eaweq0IPYo/skMPA4JaNu6Ccofveml29xCzStOVJWQOTTvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1769451982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=hBJqccVOMPcXQJaXWhWvb8KYRLWv8bRRy/U5IWbz448=;
 b=eqs2CD9+y7HM16Did9ed06foMXWbI9PaTHVpGXvYtXG055+cqHFTimnV85Vb1FoQCC6/e4
 Eb/IeUnYE4lYBavA2qrdbG/GW1zgMIHdp/tid2tlqvLbkzggOXeu0hpjaVksuieF0mspzb
 EMS0BFgMSigUZRyX5K7YVcldZbVralnc5xxCXG8HjH6jhJs9tgc11y4WIvlLo1t3AAcjk/
 m1ZSDopnB7Tfn0M5/EY3ZOyv8zLA1fip7x6J1kg6/Hu1NnkuzhYlrQlZPgkM1Tk9h1/t2/
 Qa6Z3pyk7JU1FqJrBKvY+cadvL6QVUCdfwVp2rqKO3h3GJQDhgCUQAwMnsmwUQ==
ARC-Authentication-Results: i=1; rspamd-5cbb8c6dcc-tpzcs;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Left: 48da621258b53328_1769451985198_2313387053
X-MC-Loop-Signature: 1769451985198:2201568499
X-MC-Ingress-Time: 1769451985197
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.189.139 (trex/7.1.3); Mon, 26 Jan 2026 18:26:25 +0000
Received: from [IPV6:2607:fb90:fa00:cff2:b35:7c5b:46bd:1fa2] (unknown
 [172.58.10.254])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4f0H6j67Spz106j;
 Mon, 26 Jan 2026 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1769451982;
 bh=hBJqccVOMPcXQJaXWhWvb8KYRLWv8bRRy/U5IWbz448=;
 h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
 b=l2UdCYfrNkcDlmLwSU06gJs3sjSLMiDilcTHkQcDoBb0vAVxempTPoA7XWCGAw6I4
 4fplsdFxtSSZ6/VcDtS2HZQbjVPYq+p5Z9HbJzNXM0bCBrEMC46fyoxmYLeJTVbxek
 gG+5IgqOe8c8ZTA0b8CTnmDStXgdf/FdG/etwZktx67F36SAPWY8Q1BL/2GZQJKudl
 sLjqh/9wg5fJedkGtu5xEJ5YBMxfM6/1O/iYetbDVP1GdpmAmT1Sx8wHZfRrXJ1vs7
 Md7QQLA/nTijAOKiBV8euAFWvTZ+pJbN/bU1taOPm70creLEGoQMQM3ELlg/V+XcPa
 IMQdsGIuKZE+g==
Message-ID: <98c1c422-b58b-4850-9b5d-f71e2ad69278@landley.net>
Date: Mon, 26 Jan 2026 12:26:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
From: Rob Landley <rob@landley.net>
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
 <2446284b-b76c-4335-929d-eeef8ed0c6cc@landley.net>
Content-Language: en-US
In-Reply-To: <2446284b-b76c-4335-929d-eeef8ed0c6cc@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=rob@landley.net;
 helo=shrimp.cherry.relay.mailchannels.net
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

On 1/26/26 11:17, Rob Landley wrote:
> On 12/31/25 06:01, BALATON Zoltan wrote:
> Which SEEMS to say that the 64m of sram is at offset ZERO, despite hw/ 
> sh4/rd2.c (before all these patches) doing:
> 
> #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
> #define SDRAM_SIZE 0x04000000
> 
>      /* Allocate memory space */
>      memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, 
> &error_fatal);
>      memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
Right, it looks like if I don't care what the real hardware is doing but 
just want to mangle the emulation to gimme a native build environment 
with enough ram to build linux from scratch etc in for the architecture, 
I can tweak hw/sh4/r2d2.c to have SDRAM_BASE of 0x4100000 and SDRAM_SIZE 
of 0xbf00000 which gives me ~200 megs, and then in the linux kernel 
config set CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE to match and I 
don't even need a kernel patch, just a config change...

And yes!

Freeing unused kernel image (initmem) memory: 132K
This architecture does not have kernel memory protection.
Run /init as init process
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Type exit when done.
$ head /proc/cpuinfo
machine		: RTS7751R2D
processor	: 0
cpu family	: sh4
cpu type	: SH7751R
cut		: unknown
cpu flags	: fpu ptea
cache type	: split (harvard)
icache size	:  4KiB (2-way)
dcache size	:  4KiB (2-way)
address sizes	: 29 bits physical
$ head /proc/meminfo
MemTotal:         188356 kB
MemFree:          182852 kB
MemAvailable:     180324 kB
Buffers:               0 kB
Cached:              724 kB
SwapCached:            0 kB
Active:              620 kB
Inactive:            292 kB
Active(anon):        620 kB
Inactive(anon):      292 kB

The kernel and qemu have to agree where the memory base is or the 
-kernel -initrd and -append can't hand off their blobs (which are 
relative to the start of the big SRAM block), but it works.

Sigh, I wouldn't need to patch qemu either if -m argument's csv format 
wasn't pointless. Instead of letting me specify address ranges (ala -m 
64m@c0000000,16m@2000000), it's got:

-m [size=]megs[,slots=n,maxmem=size]
                 configure guest RAM
                 size: initial amount of guest memory
                 slots: number of hotplug slots (default: none)
                 maxmem: maximum amount of guest memory (default: none)

Which makes NO sense to me. (What's the point of specifying hotplug 
slots if I can't say what's IN each hotplug slot? Something somewhere in 
the board had to DEFINE the hardware slots, so what is the point of this 
slots= thing? You're just reiterating.)

Oh well. If I wanted to get clever I could read the -m 123 value, do a 
floor at the exiting 64 and a ceiling at 200, and subtract from the 
starting address to provide the requested amount of memory. So if you 
DON'T specify -m (or -m 64 the existing value), it works with existing 
kernels. And then you can just -m a different number and use a matching 
kernel .config to get more memory up to the "one bit contiguous block" size.

In theory with device tree support I wouldn't have to recompile the 
kernel to tell it about the extra memory. We did device tree support in 
the new j-core board, I wonder what it would take to use that as a model 
to port r2d...

(Alas I have NO IDEA how to add such support to qemu. Or how to teach 
its -kernel to load a vmlinux instead of mandating a zImage...)

But if I _did_ have device tree support there's a lot more places to 
shove ram into:

>   Root memory region: system
>    0000000000000000-0000000000ffffff (prio 0, romd): r2d.flash

1000000-4000000 is a 64 meg gap

>    0000000004000000-000000000400003f (prio 0, i/o): r2d-fpga

The one it's using above.

>    000000000c000000-000000000fffffff (prio 0, ram): r2d.sdram
>    0000000010000000-00000000107fffff (prio 0, ram): sm501.local

11000000-13e00000 is ~48 meg gap

>    0000000013e00000-0000000013e0006b (prio 0, i/o): sm501-system-config
>    0000000013e10040-0000000013e10053 (prio 0, i/o): sm501-i2c
>    0000000013e30000-0000000013e3001f (prio 0, i/o): serial
>    0000000013e40000-0000000013e400ff (prio 0, i/o): ohci
>    0000000013e80000-0000000013e80fff (prio 0, i/o): sm501-disp-ctrl
>    0000000013f00000-0000000013f00053 (prio 0, i/o): sm501-2d-engine
>    000000001400080c-000000001400080f (prio 0, i/o): ide-mmio.2
>    0000000014001000-000000001400101f (prio 0, i/o): ide-mmio.1

14100000-1e000000 is 128+48 meg gap.

>    000000001e080000-000000001e080003 (prio 0, i/o): intc @000000001e080000
>    000000001e080040-000000001e080043 (prio 0, i/o): intc @000000001e080040
>    000000001e080060-000000001e080063 (prio 0, i/o): intc @000000001e080060
>    000000001e100000-000000001e10002f (prio 0, i/o): timer
>    000000001e200000-000000001e200223 (prio 0, i/o): sh_pci
>    000000001f000000-000000001f000fff (prio 0, i/o): memory 
> @000000001f000000
>    000000001f800000-000000001f800fff (prio 0, i/o): memory 
> @000000001f800000
>    000000001fc00000-000000001fc00fff (prio 0, i/o): memory 
> @000000001fc00000
>    000000001fd00004-000000001fd00013 (prio 0, i/o): intc @000000001fd00004
>    000000001fd80000-000000001fd8002f (prio 0, i/o): timer
>    000000001fe00000-000000001fe00027 (prio 0, i/o): sci
>    000000001fe80000-000000001fe80027 (prio 0, i/o): scif

This one's huge but I vaguely recall some hardware limitations in the 
TLB or something? (I should ask.)

Still, the above adds up somewhere near 500 megs and that's PLENTY for 
doing real work on a 32 bit headless build node. (Honestly in mkroot I 
set even the 64 bit targets to 256 megs by default. When I do heavy 
lifting I run distcc hooked up to a cross compiler and have it move the 
heavy lifting of compilation outside the emulator while the build still 
_acts_ fully native, since there's only one set of headers, one set of 
libraries, and you can run anything you build and all the questions 
configure asks from uname and sysinfo and /proc and such get the right 
answers. The virtual network card becomes the bottleneck somewhere 
around -j3, not counting that "autoconf is always the bottleneck" even 
on -j32 build native machines. You can sing "autoconf is useless" to 
"every sperm is sacred", and I often do while it's endlessly running to 
ask three different ways if this system is compliant with posix-2008...)

And yes, I've been doing this for a while:

https://landley.net/aboriginal/about.html
https://landley.net/aboriginal/control-images/

Haven't learned how to set up a debian build node yet, but it's on the 
todo list. :)

Rob

