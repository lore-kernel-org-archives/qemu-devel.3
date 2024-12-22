Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083ACE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLZR-00051i-6o; Sun, 22 Dec 2024 08:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZI-000517-3R
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:28 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZG-0000YU-52
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=KqzAwKHTveouGEQvOj5DSs5g/Bu2ZAxMF6M+gboZO4M=; b=b8XgQnm/X7GAxNVpbRwLm/m70+
 5tR62LdLDEerTz7eCVvWLMS4RjwaxFW9vs7oWRmIWIE991iHdkbyU2wyEL82dzy8F2ErlvhvgECtQ
 NdGL0ZzWu/EzGJ/55O477q8rDMt8rRGaUhKMZqukQ/Hry5rflEaY9i3L4Q9vEY9tol4M6YNEJX8LL
 PG4RR67bIIajrm+EjE2uNxoWXFH3WH4SKmd9NjVFkis0kr+ostgSKtlD8nGDGciIu0aw+WQyXybMS
 T//yFYyg4tkjbIx6ZyScPpCtBcPdWEoed6z3+syR4mxZ0JGi4YraMyOMhnugMaifNoXWCEM43C7XR
 3s18lIkQmKw95ynjntkam0MSnlocheWT5Nw9eJ9JnUD9oQBZ5rApFPNe/zj5Pp3TT36Ift6xM+bDA
 2VSOUzEKzIsxptNKynt2j4Nl1YL3fBYil7Nx2C860MkgLzOvMhuk3IO5r+qQiU2LugDq2Ooe9LWFl
 h7NQ2jqyrZPKiGCB1VTg0rW5Y82xHmhiR5GptY4QFCY12cPBS742gzlOFE14ynp4Cq1AIvd+PKAnI
 LThxjzvaP/0foV02/4gmuPlORTnEc/Gw7FYXEzZAgt9j82m1oqOSTAWBHU4QUcd+31ehjLPfAKNTj
 qYC/ryuG0BeB+CkXT3UvWLHiHrKrR00WQC3fdhtrQ=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLYc-0002L7-Qs; Sun, 22 Dec 2024 12:59:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:39 +0000
Message-Id: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 00/33] next-cube: more tidy-ups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series contains a number of tidy-ups and improvements to the NeXTCube machine
which include:

  - Bringing the code up-to-date with our latest coding standards/APIs, in particular
    related to the board configuration and IRQ wiring

  - Remove the remaining overlapping memory regions and consolidating multiple
    register implementations into a single place

  - Add a new next-scsi device containing the ESP device and its associated
    CSRs

  - Adding the empty_slot device to fill unimplemented devices and removing
    the "catch-all" next.scr memory region

  - QOMifying the next-rtc device and wiring it up with gpios as required

The next-cube machine looks in fairly good shape now, the main remaining work is to
create a separate device for the DMA controller and update the wiring of the IRQs
(including to the CPU) accordingly.

There is no change to the behaviour of the next-cube machine with this series in
that the next-cube machine with a suitable ROM image can now load the kernel from
a pre-installed NeXTStep image and start executing it.

Note that due to the device model changes this is a migration break, however since
the next-cube machine is currently unable to boot anything useful, I don't see
this as an issue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[Patches still needing review: 21, 25, 28, 29, 30]

v3:
- Rebase onto master
- Fix addresses in comments for patch 2 as noted by Thomas
- Add R-B tags from Thomas and Phil
- Use s->rtc directly in patch 25 rather than object_resolve_path_component()
- Use s->escc directly in patch 11 rather than object_resolve_path_component()
- Add numeric suffixes for empty slot names in patch 14
- Drop patch 34 due to legal uncertainty of replace boilerplate licence text
  with SPDX equivalent as indicated by Daniel

v2:
- Rebase onto master
- Drop patches 1 and 4 (these have been merged separately as bugfixes)
- Add R-B tags from Thomas and Phil
- Update commit message in patch 2
- Add comments containing system register addresses as requested by Thomas in
  patch 2
- Update description for patch 7 explaining that the SCSI CSRs are also now
  modelled as standard registers (similar to Previous)
- Update description for patch 8 explaining why the previously hardcoded value
  has been dropped
- Add comments suggesting unimplemented devices in patch 14
- Remove next_rtc_vmstate from next_pc_vmstate in patch 25
- Fix cut/paste error in patch 30 headline

Mark Cave-Ayland (33):
  next-cube: remove 0x14020 dummy value from next_mmio_read()
  next-cube: remove overlap between next.dma and next.mmio memory
    regions
  next-cube: create new next.scsi container memory region
  next-cube: move next_scsi_init() to next_pc_realize()
  next-cube: introduce next_pc_init() object init function
  next-cube: introduce next-scsi device
  next-cube: move SCSI CSRs from next-pc to the next-scsi device
  next-cube: move SCSI 4020/4021 logic from next-pc device to next-scsi
    device
  next-cube: move floppy disk MMIO to separate memory region in next-pc
  next-cube: map ESCC registers as a subregion of the next.scr memory
    region
  next-cube: move ESCC to be QOM child of next-pc device
  next-cube: move timer MMIO to separate memory region on next-pc device
  next-cube: move en ethernet MMIO to separate memory region on next-pc
    device
  next-cube: add empty slots for unknown accesses to next.scr memory
    region
  next-cube: remove unused next.scr memory region
  next-cube: rearrange NeXTState declarations to improve readability
  next-cube: convert next-pc device to use Resettable interface
  next-cube: rename typedef struct NextRtc to NeXTRTC
  next-cube: use qemu_irq to drive int_status in next_scr2_rtc_update()
  next-cube: separate rtc read and write shift logic
  next-cube: always use retval to return rtc read values
  next-cube: use named gpio to set RTC data bit in scr2
  next-cube: use named gpio to read RTC data bit in scr2
  next-cube: don't use rtc phase value of -1
  next-cube: QOMify NeXTRTC
  next-cube: move reset of next-rtc fields from next-pc to next-rtc
  next-cube: move rtc-data-in gpio from next-pc to next-rtc device
  next-cube: use named gpio output for next-rtc data
  next-cube: add rtc-cmd-reset named gpio to reset the rtc state machine
  next-cube: add rtc-power-out named gpio to trigger the NEXT_PWR_I
    interrupt
  next-cube: move next_rtc_cmd_is_write() and next_rtc_data_in_irq()
    functions
  next-cube: rename old_scr2 and scr2_2 in next_scr2_rtc_update()
  next-cube: add my copyright to the top of the file

 hw/m68k/Kconfig     |    1 +
 hw/m68k/next-cube.c | 1021 ++++++++++++++++++++++++++++---------------
 2 files changed, 658 insertions(+), 364 deletions(-)

-- 
2.39.5


