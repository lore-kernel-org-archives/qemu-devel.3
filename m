Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4DDE7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 01:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSnUD-0002k4-AL; Tue, 31 Dec 2024 20:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tSnU8-0002jj-6n
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 20:25:22 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tSnU6-00028z-9S
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 20:25:19 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C6AAE1A4156;
 Wed,  1 Jan 2025 01:19:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com
 (trex-5.trex.outbound.svc.cluster.local [100.106.32.31])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6666C1A416E;
 Wed,  1 Jan 2025 01:19:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1735694390; a=rsa-sha256;
 cv=none;
 b=u4JnS2Bs9KsiszzULMWxtNO2x2wXAozyP4UQ3TUKxNyrN9qvlFBjz/ZShMdtJopiEGJfpQ
 GWkWm4yOLkawvL1zptqXgZ3rRgu7mDeGF86ijLgly0/3jH0cQgSDtfVfZOrF99XGkUyHvT
 zm8mMcRg8whVZmqrG53AHjcPbID/SC38Z+SoDucql7nl8HHA+lSev0Xb58k5sQF7oEO9Bx
 gL+PyBEmMq4W2h1IC9iqW2KBclfD9X7T5GOt0MA0PSUlH4A9VQ8R9sQllyr6yVCdgHpCe8
 MDEB4qFMhEaTuvsKLPByMw9EOcmxNu5nmLpI99AuaTCrhE/SN7YE5btaKeQpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1735694390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=eQJIll9YFBRQGIhRmACb3Movs9nkgFb7H3YST2OrFEo=;
 b=JOIEi1VMCPCU+/ZpQu7sMH3SQg7rbQKERexdmLRIKe4+OaP4rWInl9j7lpzv9qOPqLGM5w
 FigYVN/+ZlkWu1hL9eMsg6/h2/FvhtGuGZxHeOVeO5hBMOd9wuNPrAHRiRvE30CChB7nqZ
 XWKB3mkRcp0TIRy0BZXYYGENZspnR8+GhvEIskNuOC5JICcZClGpCwGBeqLK725KwKkqlw
 guhjerk3QCQk3FUGQMCqQO75gkbtkSCLfgzotACLErRHxpAzTtg/u/v/HCWwu/FnPBfRNT
 vLW4fkukKn9vpls6d+vXopjnbVz6KoPOfQMUAstDZPf/0COJWSUac3k8LC790w==
ARC-Authentication-Results: i=1; rspamd-56bf78cbd4-x6hv9;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Print: 1863e413774fd868_1735694390658_1754250486
X-MC-Loop-Signature: 1735694390658:3130659201
X-MC-Ingress-Time: 1735694390657
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.32.31 (trex/7.0.2); Wed, 01 Jan 2025 01:19:50 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4YNBpF4X3CzGN; 
 Tue, 31 Dec 2024 17:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1735694390;
 bh=eQJIll9YFBRQGIhRmACb3Movs9nkgFb7H3YST2OrFEo=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=uzfAMkS1a8UkvWD1gKNrPQ/75xJ5zOEn9hAZGidIModqy6tPZcV5snV9NhJiQc59g
 1g8dc42AV0HI4b8w9Exi00ykPvn4GW4z2A1u1Qek+n7IAFJRqiN8aqmVO9k2gqPehm
 wYiXGEbl4BnkGS49iJ3T6HLD5JX1RcheHM7cJnCsL7gOLpO0dEZtsOF/puUsGFeX2+
 j/83Qd3ytN7nYFO2wUHZ6QAqjKSBGoLzVK/CODczfgV52+GryWNcW+dHGiK3fvsIY6
 SXjTzvF2briGY76GhKx1prYW2NhGAE3EQ5k17yb0YPAOec3CGXlZwMw3Y/w/SwTgYb
 xqyDRrjDU67Zg==
Message-ID: <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
Date: Tue, 31 Dec 2024 19:19:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Z2lgL31ZeSkO59MZ@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=rob@landley.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

On 12/23/24 07:05, Stafford Horne wrote:
>> The kernel config looks like it should have virt block device support, but
>> nether -hda README nor "-drive file=README,format=raw,id=hd0 -device
>> virtio-blk-device,drive=hd0" seem to be wiring it up in qemu where the
>> kernel can find it?
> 
> The default virt_defconfig should have the drivers we need.  The OpenRISC virt
> platform supports PCI and virtio devices, so I select many of the related
> drivers.

For some reason this message did not show up in qemu-devel's web 
archive, but when I reply all qemu-devel is in the list? Weird.

>      $ grep -C1 -e PCI -e VIRT arch/openrisc/configs/virt_defconfig
>      # CONFIG_WIRELESS is not set
>      CONFIG_PCI=y
>      CONFIG_PCIEPORTBUS=y
>      CONFIG_PCI_HOST_GENERIC=y
>      CONFIG_DEVTMPFS=y
>      --
>      CONFIG_BLK_DEV_NBD=y
>      CONFIG_VIRTIO_BLK=y
>      CONFIG_NETDEVICES=y
>      CONFIG_VIRTIO_NET=y
>      CONFIG_ETHOC=y

I've already got all those except VIRTIO_BLK and VIRTIO_NET.

> In my qemu startup I wire in the hard drive and network in my qemu start script:
> 
>   - https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-linux
> 
> This uses:
> 
>    -device virtio-net-pci,netdev=user -netdev user,id=user,net=$IPRANGE.1/24,host=$IPRANGE.100

My other virto targets are just doing:

   -netdev user,id=net0 -device virtio-net-device,netdev=net0

And yes, that works here with VIRTIO_NET enabled. (Dunno why it isn't in 
the kernel defconfig...)

>    -device virtio-blk-device,drive=d0 -drive file=${DISK},id=d0,if=none,format=qcow2

-drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0

My -device looks similar but -drive is file=file.img,format=raw,id=hd0

No idea what if= does? I haven't seemed to need it...

>> Haven't tried to get fancy with the network yet. The buildroot config is
>> still or1ksim...
> 
> Yeah, its nothing fancy for me either. The buildroot with systemV init scripts
> get everything working for me.

My init script (the HERE document starting around 
https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L102 ) 
ancestrally goes back to 
https://linuxfromscratch.org/hints/downloads/files/OLD/bsd-init.txt and 
boils down to "call stuff like mount/ifconfig/route in a shell script 
until it's time to exec whatever inherits PID 1".

*shrug* Works fine for embedded systems and small automated containers 
that do a thing and then exit. (You'll notice this one tries to mount 
/dev/?da on /mnt and then run /mnt/init if it exists: that way I can 
plug in an -hda blah.squashfs and have it do stuff automatically. 
Toybox's timeout command has a -i option that's an inactivity timer: if 
nothing is produced on stdout for X seconds, kill the child. So it can 
run forever as long as it's DOING something, but if it stops producing 
output for X seconds it gets ended.)

> -Stafford

Thanks, I think this target is good for release. Now to figure out why 
sh2eb network isn't working after the restore (it used to!). Nor is 
microblaze's network...

Rob

