Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FD4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnl4-0002g4-Jy; Fri, 31 Oct 2025 07:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEnl1-0002fO-4r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEnkq-0006e3-HB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JV7DvWyQMEkQPB88AGf+gjHKUeIDsrDUKee2VP/vlw=;
 b=e5KjD4A/T5u6aF6VE4U/3R52tvodq9KAtMkbXL51NsH5AsJOdwoz2pRU/W+enVMBDcWDE6
 /EBO6L2JWY1Ep6DGEh65+KC+9j0/8OYUAVuGB+zTtpiYGXJiBEE8DYSOprLOg2L0DIfcVw
 NorhEL5viTot/8ymZmRACwd28s97oIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-CGMlH7KYPJif3_530XPBTw-1; Fri,
 31 Oct 2025 07:57:10 -0400
X-MC-Unique: CGMlH7KYPJif3_530XPBTw-1
X-Mimecast-MFC-AGG-ID: CGMlH7KYPJif3_530XPBTw_1761911829
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C8219540DF; Fri, 31 Oct 2025 11:57:01 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.146])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAF0119560B6; Fri, 31 Oct 2025 11:56:59 +0000 (UTC)
Date: Fri, 31 Oct 2025 12:56:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
Message-ID: <aQSkCSjgyoDRZCB6@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 <87ms5cmtqh.fsf@pond.sub.org>
 <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
 <877bwbcy3e.fsf@pond.sub.org>
 <CAJ307EiBBKDiLAX=CCx3d9n6PQQ5JnBv8RCWZpQqartVzWcBKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ307EiBBKDiLAX=CCx3d9n6PQQ5JnBv8RCWZpQqartVzWcBKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 31.10.2025 um 10:47 hat Clément Chigot geschrieben:
> > > I was unable to make `vvfat.c` recognize the "size" argument passed
> > > along `format=raw`, even if hardcoding the value in `vvfat.c` did make
> > > a difference. And that's why I'm adding the warning in the commit
> > > message.
> >
> > This one:
> >
> >     Some limitations remains, the size parameter is recognized only when
> >     "format=vvfat" is passed. In particular, "format=raw,size=xxx" is
> >     keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
> >     FAT12. FAT32 has not been adjusted and thus still default to 504MB.

I actually wonder if we should give the vvfat option a different name to
make it less error prone. Forgetting format=vvfat is easy and then raw
will be autodetected and size will be interpreted as an option for raw.

> > > I've also realized that following my patch, the mismatch in between
> > > the disk and the partition in Linux was going away when using `-drive
> > > format=vvfat,size=xxx`. Making it not just QNX-oriented.
> > >   | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
> > > -nographic -no-reboot -append "earlycon=pl011,mmio32,0xfe201000
> > > console=ttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
> > > rootfs.cpio.gz  -drive
> > > id=sdcard,file=fat:rw:<host_folder>,format=vvfat,if=sd,size=256M
> > >   | (QEMU) # fdisk -l /dev/mmcblk1
> > >   | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
> > >   | 1024 cylinders, 16 heads, 32 sectors/track
> > >   | Units: sectors of 1 * 512 = 512 bytes
> > >   |
> > >   | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
> > > Sectors  Size Id Type
> > >   | /dev/mmcblk1p1 *  0,1,32      1023,15,32          63     524287
> > >  524225  255M  6 FAT16
> >
> > EndLBA matches disk size.  EndCHS still matches EndLBA.  Good.
> >
> > The difference to the command line you showed above is format=raw (bad)
> > vs. format=vvfat (good).
> >
> > With format=raw,size=256M you get that size, but a bogus partition
> > table.
> >
> > With format=vvfat,size=256M you get that size, and a sensible partition
> > table.
> >
> > Correct?
> 
> Yes and the main reason for that is because I don't know how to
> retrieve the size given to "raw" within `vvfat_open`.
> My understanding is that raw-format.c is suppressing that option,
> through `qemu_opts_del` in `raw_read_options`, before calling its
> block childs (here vvfat). Hence, it assumes the default size 512M.

The order is the other way around. You always get the protocol level
openen first and only then the image format level.

Imagine the simple case of a qcow2 image file used for the VM. You get
things stacked like this:

        virtio-blk
            |
            v
          qcow2
            |
            v
          file

You need to open them from bottom to top. Opening a qcow2 image must be
able to read from the file, so first the file layer must be opened. And
obvious a virtio-blk device can only use the image after the qcow2
layered has been opened.

In your case, this is raw over vvfat. vvfat gets opened first, and then
raw gets instantiated on top of it. (If you use format=vvfat, then the
raw layer is left away.)

Top level options you give to -drive go to the topmost block driver. You
should be able to still set it on the vvfat level with -drive
format=raw,file.size=... Deciding which option goes to which node is
part of the (rather complicated) bdrv_open() logic in block.c.

What raw does when a size option is given is that it just truncates the
lower level to the given size. So as vvfat doesn't know the size, it
still creates a 504 MB image, but raw shows only the first part of it to
the guest. This results not only in an invalid partition table, but also
means that as soon as vvfat decides to put a cluster after your limited
size, you'll see filesystem corruption in the guest.

So your approach to deal with this in vvfat and create a smaller
filesystem to start with does look right to me.

Kevin


