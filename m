Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F7EEE57D4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1var0Z-00080d-0F; Wed, 31 Dec 2025 02:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1var0W-00080K-GK
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:52:36 -0500
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1var0U-0002M0-NG
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:52:36 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id DA7157823B7;
 Wed, 31 Dec 2025 07:52:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com
 (100-113-119-120.trex-nlb.outbound.svc.cluster.local [100.113.119.120])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 013767823DE;
 Wed, 31 Dec 2025 07:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1767167549;
 b=peZJMpfG8TITwTugXcc5mzsylQStWOp/s9568rxnxYgnTKNwQ0XxxMhqwQgXoWcGMX9dG7
 ssuQjDIbPv7pbvqTR7zqN1n9NzOEBsPZNsRv1fZ5QN3QsGgGPGtS+1xUrC/IzWUy1NFmS4
 e1rc9JzoAR5JTWAUNn3J/9wnStHcoHMD/UwlBvD9IMN2rgSPpg2S/ILVMjvgW4TScucEdn
 9b2D0y8ke1lMgZGzmrYRDWh2F8Va0csXGfozOW3aHUXZzAmpHHH58rtC7hmrRa1iGzTAza
 8IV3FJpOYQM319WCU53DNBVezuwswYdAQX3yE3siKUuYywkj7UZINB5HVvga1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1767167549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=zjKj5zUtUukLIBCdnEqcVWD27aAhqZBtOuVCH6aWtJM=;
 b=ufFpA6lvWTlFLNRxIko8eDfAKDzJT6knvFgRxbtO8l0sjpsEWywI2la6F3NPOpeCYJ5n+S
 7qSyKENg/LCS7CiaTBfngawcGOTVbK0G4XLyvt8UJ6CekNSsvvTrNxKrtQawmg/uirDViO
 byzwHz2G/7SwXm3otQsVQkvsBdT47EsQtziqIxBuQDp46kAejFbm4EPFLV/aVE+taL4cCD
 sBtYXs6Y5bLDLDRFRYwB1hOZ0FSgPK39dduNAX4lBVjQmeYO4lQbk6bs9GghO8So3q+HZB
 iFd60rLp5A3IYSE8fN6okdEB8GB65RlPxFtFX9M8S5JtnXqoh4X3JzqTH9uZ3g==
ARC-Authentication-Results: i=1; rspamd-85db7f4c96-t7gj4;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Arch: 0300a45c522d25af_1767167551272_1126787258
X-MC-Loop-Signature: 1767167551272:138142507
X-MC-Ingress-Time: 1767167551271
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.119.120 (trex/7.1.3); Wed, 31 Dec 2025 07:52:31 +0000
Received: from [IPV6:2607:fb90:fa85:cea:c1aa:4813:f755:98f6] (unknown
 [172.56.10.2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4dh2HJ1wbZz105C;
 Tue, 30 Dec 2025 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1767167548;
 bh=zjKj5zUtUukLIBCdnEqcVWD27aAhqZBtOuVCH6aWtJM=;
 h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
 b=Ntg9C3q63XIvr+hvfGASQYZVHUsOw1ooGQRShJdchT0RexbMG/yDR4Ioqn2Wfs3Qx
 YoXzdmDSjj3L6wx9Eub2SwXLgLjLAXQes3/UtpSVDVVjOJc0lfG24rga9pNwtud69Z
 ofx2WyZp96aftUjOQ/cQKfuvivnCA01E/KSlajFKCNSR5f4L/6apgF98VCLCkNQkkZ
 e3tY5hZRuzWYqp0+5c60DC46zx4RfNrE2NkuAqG2mjI81ZOAibuQxVzAFTAk7WNEK9
 ZrEQspvogdSRfKFoyr3VcrkFrRcsYz5KE8oa8QrlS+MGuDqGrYvfWWKG1U0it2Nsp1
 zq8hRdTHZsXRg==
Message-ID: <f189995e-09f7-456d-b860-ee6a3dc8fc49@landley.net>
Date: Wed, 31 Dec 2025 01:52:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
From: Rob Landley <rob@landley.net>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Thorsten Glaser <tg@debian.org>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Magnus Damm <magnus.damm@gmail.com>
References: <20251124095109.66091-1-philmd@linaro.org>
 <20251124095109.66091-2-philmd@linaro.org>
 <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
Content-Language: en-US
In-Reply-To: <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=rob@landley.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/31/25 01:32, Rob Landley wrote:
> I fixed it up by hand for testing in the meantime, and it loaded the 
> kernel with -m 192 but then initramfs couldn't find init. Without the 
> patch series the same git version (942b0d378a1d) booted to a shell 
> prompt. I can try to track down what happened in the morning...

Ah, it boots with the full patch stack applied for -m 64 but not -m 128. 
It's mapping in the extra memory that breaks it.

The initramfs doesn't seem to be extracting with the second memory block 
enabled? What's the diff in the output...

--- out.txt     2025-12-31 01:42:33.487421358 -0600
+++ out2.txt    2025-12-31 01:42:47.359676340 -0600
@@ -105,7 +105,6 @@
  NET: Registered PF_UNIX/PF_LOCAL protocol family
  PCI: CLS 0 bytes, default 32
  Unpacking initramfs...
-Freeing initrd memory: 528K
  workingset: timestamp_bits=30 max_order=14 bucket_order=0
  squashfs: version 4.0 (2009/01/31) Phillip Lougher
  SuperH (H)SCI(F) driver initialized
@@ -121,50 +120,14 @@
  Segment Routing with IPv6
  In-situ OAM (IOAM) with IPv6
  NET: Registered PF_PACKET protocol family
+Freeing initrd memory: 528K
  netconsole: network logging started
-check access for rdinit=/init failed: -2, ignoring
-/dev/root: Can't open blockdev
-VFS: Cannot open root device "" or unknown-block(1,0): error -6
... [filesystem list and panic dump elided]
- [<8c3d0e24>] kernel_init+0x0/0x104
-
-Rebooting in 1 seconds..
+devtmpfs: mounted
+Freeing unused kernel image (initmem) memory: 132K
+This architecture does not have kernel memory protection.
+Run /init as init process
+8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
+ESC[?7hType exit when done.
+$ exit
+reboot: Restarting system

Why on earth did the "freeing initrd memory" move? (Interrupts shouldn't 
be enabled until right before it spawns PID 1, unless they rewrote that 
part when I wasn't looking...)

Ah, the - is the fail and the + is the success, I'm guessing the extract 
failed and the error path freed it early. Possibly the new memory block 
is either overwriting the cpio.gz or changing where it lives in a way 
the kernel isn't finding it.

Anyway, you've got the tarball if you want to smoketest it yourself. 
Unless this is expected and we need kernel tweaks just to boot even when 
not using the new memory, in which case -m 256 warning and dropping down 
to 192 would _still_ lose backwards compatibility. (If there's an 
address range conflict, could the -initrd loaded contents be IN the new 
memory block, as if it had been loaded rather than a mapped in ROM?)

Thanks,

Rob

