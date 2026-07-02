Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF894C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7BW-0004BL-1L; Wed, 01 Jul 2026 22:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BU-00049f-0j
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:48 -0400
Received: from ms-2004g-snip4-1.eps.apple.com ([57.103.74.132]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BQ-0002Ol-Qz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:47 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 C8B56180011E; Thu, 02 Jul 2026 02:29:35 +0000 (UTC)
X-ICL-RepId: 019f20a9-056b-7528-88fb-495b04c3d890
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQhIEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXAEALTgNaB1kCQgtBAVoZXwRFCEgeXBoGWhpYG1wPRARcMFQdHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782959378; x=1785551378; bh=ftMeY0UoQQQki6pRstFd1wM0VgUruvtD/ZySP9snuH8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=cFo7cP1YRDLNEQMspcts/gOARaBCbUQdaw6ztlqbOjo1sx9xLqLsN06bfDZvcbpD5rKYoKPu9CfMdUbkUYfBmVjD/Im4S5b7Kbr2KG0HUFrJdi2DfAGBtet3RfE0om+tgvzgpUxLSIkqTlAZLUol6o1g9Uh6kvMrBNErh9QGVDHkGAYLJBjmpgcou+PVBbuUQw2wFRIPPynijZ3sFPKCp0sJQDZoSdblazh4h847NmRfvI04gRO4HqpFgxLTSykoE3G1bQUeDS5AnkoYt/bgKYdXRjHqq5yf6WYoru1hQVRzIwDVcs5ItptYsrQ4IMdqnnEBPXkIcbHe2J1883/b7w==
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 023541800133; Thu, 02 Jul 2026 02:29:33 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v3 0/5] hw/m68k: add working floppy controller for q800
Date: Wed,  1 Jul 2026 22:29:22 -0400
Message-ID: <20260702022927.46510-1-mhjacobson@me.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2-Mp6C2iHsfX7IVczxyr5JmKSzw1HMF_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMyBTYWx0ZWRfX5EXoLtIEhAXD
 RtVAXIXe+ZcZr3BWAXH6oVsFGcHjq9GrHXJ5T/Cj6Ds+iyq1ovPiQC4xaEtyAWGURLMs0J70Sc3
 Qe1MKNzhrMtiyM0AozBMOgyNVhosILRejVie8Nu92C/Fw2WAQGrzaLYotfiDcdeUVn6S7piFr0r
 DOJ91yYYFxvfUNTOBwOSHjnzu7sBkNidULoymm+hlNzPygQZjsn1mYA7kJwyZigBEcNlaEB6BM/
 X/1N8k0l0GDssGIzVLos3ag2UTMscLMLQlIoUPq4tEy7re8uhFuQPdsu6+4u4QV53QEIUycdRER
 riJOZXfRuxtnLj4vqsr
X-Proofpoint-GUID: 2-Mp6C2iHsfX7IVczxyr5JmKSzw1HMF_
Received-SPF: pass client-ip=57.103.74.132; envelope-from=mhjacobson@me.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the SWIM2 floppy controller and SuperDrive for the q800 machine.

Reading and writing work, and booting a system disk works.
Both GCR and MFM paths work.
Tested with the Quadra 800 ROM running System 7 and A/UX 3.x.
Whole-disk formatting/duplication does not yet work.

Example usage:
$ qemu-system-m68k \
   -machine q800 \
   -m 128 \
   -bios "Quadra800.ROM" \
   -nodefaults \
   -drive if=mtd,file="pram.img",format=raw \
   -drive if=floppy \
   -drive if=floppy \
   -drive if=scsi,media=disk,file="harddisk.img",format=raw \
   -drive if=scsi,media=cdrom \
   -nic user,model=dp83932 \
   -audio none \
   -display cocoa \
   -name "Macintosh Quadra 800"

(To populate the floppy drive at boot, use
 `-drive if=floppy,file="floppy.img",format=raw`.  However, note that the
 Macintosh ROM will eject non-bootable floppies on boot.)

The Sony drive emulator takes raw images and will generate the GCR/MFM
encoding on the fly.  Here are a couple sample images (HFS) to play with:

<https://mjacobson.net/files/mac-disks/floppy-800.img>
<https://mjacobson.net/files/mac-disks/floppy-1440.img>

Matt Jacobson (5):
  hw/block: add Sony/Apple "SuperDrive" diskette drive
  fifo32: add fifo32_peek()
  hw/block: add SWIM2 floppy controller for q800
  hw/m68k: add working floppy controller for q800
  hw/block: remove unused SWIM1 floppy controller stub

 MAINTAINERS                        |    2 -
 hw/block/meson.build               |    2 +-
 hw/block/sony_superdrive.c         | 1032 ++++++++++++++++++++++++++++
 hw/block/swim.c                    |  577 ----------------
 hw/block/swim2.c                   |  711 +++++++++++++++++++
 hw/block/trace-events              |   25 +-
 hw/m68k/q800.c                     |    5 +-
 hw/misc/mac_via.c                  |   16 +
 include/hw/block/sony_superdrive.h |   55 ++
 include/hw/block/swim.h            |   72 --
 include/hw/block/swim2.h           |   58 ++
 include/hw/m68k/q800.h             |    4 +-
 include/hw/misc/mac_via.h          |    3 +
 include/qemu/fifo32.h              |   31 +-
 14 files changed, 1923 insertions(+), 670 deletions(-)
 create mode 100644 hw/block/sony_superdrive.c
 delete mode 100644 hw/block/swim.c
 create mode 100644 hw/block/swim2.c
 create mode 100644 include/hw/block/sony_superdrive.h
 delete mode 100644 include/hw/block/swim.h
 create mode 100644 include/hw/block/swim2.h

-- 
2.54.0


