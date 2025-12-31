Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648FEE642F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 12:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vautN-0002MX-MN; Wed, 31 Dec 2025 07:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vautD-0002Gg-TL
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 07:01:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vautB-0005X0-OY
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 07:01:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D44CB596A03;
 Wed, 31 Dec 2025 13:01:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id WmEK_4lrUU88; Wed, 31 Dec 2025 13:01:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C4FC75969FA; Wed, 31 Dec 2025 13:01:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C33535969F6;
 Wed, 31 Dec 2025 13:01:12 +0100 (CET)
Date: Wed, 31 Dec 2025 13:01:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rob Landley <rob@landley.net>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 qemu-devel@nongnu.org, Thorsten Glaser <tg@debian.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
In-Reply-To: <f189995e-09f7-456d-b860-ee6a3dc8fc49@landley.net>
Message-ID: <9334f855-8e54-0fa3-a2f9-604f72012ace@eik.bme.hu>
References: <20251124095109.66091-1-philmd@linaro.org>
 <20251124095109.66091-2-philmd@linaro.org>
 <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
 <f189995e-09f7-456d-b860-ee6a3dc8fc49@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Wed, 31 Dec 2025, Rob Landley wrote:
> On 12/31/25 01:32, Rob Landley wrote:
>> I fixed it up by hand for testing in the meantime, and it loaded the kernel 
>> with -m 192 but then initramfs couldn't find init. Without the patch series 
>> the same git version (942b0d378a1d) booted to a shell prompt. I can try to 
>> track down what happened in the morning...
>
> Ah, it boots with the full patch stack applied for -m 64 but not -m 128. It's 
> mapping in the extra memory that breaks it.
>
> The initramfs doesn't seem to be extracting with the second memory block 
> enabled? What's the diff in the output...
>
> --- out.txt     2025-12-31 01:42:33.487421358 -0600
> +++ out2.txt    2025-12-31 01:42:47.359676340 -0600
> @@ -105,7 +105,6 @@
> NET: Registered PF_UNIX/PF_LOCAL protocol family
> PCI: CLS 0 bytes, default 32
> Unpacking initramfs...
> -Freeing initrd memory: 528K
> workingset: timestamp_bits=30 max_order=14 bucket_order=0
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> SuperH (H)SCI(F) driver initialized
> @@ -121,50 +120,14 @@
> Segment Routing with IPv6
> In-situ OAM (IOAM) with IPv6
> NET: Registered PF_PACKET protocol family
> +Freeing initrd memory: 528K
> netconsole: network logging started
> -check access for rdinit=/init failed: -2, ignoring
> -/dev/root: Can't open blockdev
> -VFS: Cannot open root device "" or unknown-block(1,0): error -6
> ... [filesystem list and panic dump elided]
> - [<8c3d0e24>] kernel_init+0x0/0x104
> -
> -Rebooting in 1 seconds..
> +devtmpfs: mounted
> +Freeing unused kernel image (initmem) memory: 132K
> +This architecture does not have kernel memory protection.
> +Run /init as init process
> +8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
> +ESC[?7hType exit when done.
> +$ exit
> +reboot: Restarting system
>
> Why on earth did the "freeing initrd memory" move? (Interrupts shouldn't be 
> enabled until right before it spawns PID 1, unless they rewrote that part 
> when I wasn't looking...)
>
> Ah, the - is the fail and the + is the success, I'm guessing the extract 
> failed and the error path freed it early. Possibly the new memory block is 
> either overwriting the cpio.gz or changing where it lives in a way the kernel 
> isn't finding it.

I don't know anything about this but have you tried comparing 'info mtree' 
output from QEMU Monitor to see what changed? That may show if some memory 
block moved or overlaps something now.

> Anyway, you've got the tarball if you want to smoketest it yourself. Unless 
> this is expected and we need kernel tweaks just to boot even when not using 
> the new memory, in which case -m 256 warning and dropping down to 192 would 
> _still_ lose backwards compatibility. (If there's an address range conflict, 
> could the -initrd loaded contents be IN the new memory block, as if it had 
> been loaded rather than a mapped in ROM?)

The SH in QEMU is not much maintained and maybe there aren't many people 
to look at it so don't expect much help with it.

Regards,
BALATON Zoltan

