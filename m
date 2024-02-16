Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BDFC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QL-000662-Jr; Fri, 16 Feb 2024 16:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QJ-00062p-Tm
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Q5-0005KD-U6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pKaNgALqkqV+wgYpjhPtk/rIkMycQM15hKr9oR9g1qk=; b=QNwgnCG0TKugjqwoVZFXwCt7J4
 PJnNm/5GbfQNcHxJG68RNfxS7OjHtpaiPEC2e715LodEsNnPwF5EGp8YAnzFsmBa/yUB93rlBKqCs
 1Qw0IU7zPtjJye8Vw+F8UHm0om7uAAeW8HxHfUteYf8KNljxxwIwNjHEwNaV3Tla33rEfjBpzp1cm
 Z/N+kOcUOmHq1tAqtr2OUsOMeR0VxEbeKhG32GTQbd6lEgMfndI5Q4DJigfXJbC21+pymwC3V+2YP
 aXnn6Nw3VEj5t2Fq/pFsaqZNvEYcgdvhcwbjABx5eOd5UVajLhJnMB4ZCMtaY42A1TiDuP0n5wi79
 yrZG3yD6XJD/YpnCVu7ZISHKcYB1G4XhzOJXTulVOjyQa5/jORv8KQ/iuS3YVVe5udyJc1fAnVzU7
 jAhxF0u8ZeVH4zbEO1meV+lkjveTieR5SuQP3iOZpdeMQ0sjXVZ1zeMn2s2vYdqhY2RVSLMM+Nk2G
 B8DWG75te6YFANSnbB2J5qADg1ObRJdWWw99VPyPyng0Kx2GrRC3kQp/I0uLyUatahqvLmFbpkuMC
 QyyhmJWhFMUWcmAAKgdVJ5CGqSyHd0m1HjEhGom1IMZ0Cd8pHMEeyGpbBTxXGc270/DYSXUmekmZC
 jFFymH8KEEhnVCUXbkKJSCOMca03seXSBrszIHT8I=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5PE-0000vT-1F; Fri, 16 Feb 2024 21:06:04 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:20 +0000
Message-Id: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/13] esp: avoid explicit setting of DRQ within ESP state
 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ESP device has a DRQ (DMA request) signal that is used to handle flow control
during DMA transfers. At the moment the DRQ signal is explicitly raised and
lowered at various points in the ESP state machine as required, rather than
implementing the logic described in the datasheet:

"DREQ will remain true as long as either the FIFO contains at least one word (or
one byte if 8-bit mode) to send to memory during DMA read, or has room for one more
word (or byte if 8-bit mode) in the FIFO during DMA write."

This series updates the ESP device to use the same logic as described above which
also fixes a couple of outstanding GitLab issues related to recovery handling
during FIFO overflow on 68k Macs using PDMA.

Patches 1-3 update existing users of esp_fifo_pop_buf() and esp_fifo_pop() with
the internal cmdfifo to use the underlying Fifo8 device directly. The aim is
to ensure that all the esp_fifo_*() functions only operate on the ESP's hardware
FIFO.

Patches 4-5 update esp_fifo_push() and esp_fifo_pop() to take ESPState directly
as a parameter to prevent any usage that doesn't reference the ESP hardware
FIFO.

Patch 6 ensures that any usage of fifo8_push() for the ESP hardware FIFO is
updated to use esp_fifo_push() instead.

Patch 7 updates esp_fifo_pop_buf() to take ESPState directly as a parameter
to prevent any usage that doesn't reference the ESP hardware FIFO.

Patch 8 introduces the esp_fifo_push_buf() function for pushing multiple bytes
to the ESP hardware FIFO, and updates callers to use it accordingly.

Patch 9 is just code movement which avoids the use of a forward declaration whilst
also making it easier to locate the mapping between ESP SCSI phases and their
names.

Patches 10-11 introduce a new esp_update_drq() function that implements the above
DRQ logic which is called by both esp_fifo_{push,pop}_buf().

Patch 11 updates esp_fifo_push() and esp_fifo_pop() to use the new esp_update_drq()
function. At this point all reads/writes to the ESP FIFO use the esp_fifo_*()
functions and will set DRQ correctly.

Patch 12 is a small update to the logic in esp_pdma_write() to ensure that
esp_fifo_push() is always called for PDMA writes to the FIFO, thereby ensuring
that esp_update_drq() remains correct even in the case of FIFO overflow.

Finally patch 13 removes all manual calls to esp_raise_drq() and esp_lower_drq()
since the DRQ signal is now updated correctly upon each FIFO read/write access.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (13):
  esp.c: replace cmdfifo use of esp_fifo_pop_buf() in do_command_phase()
  esp.c: replace cmdfifo use of esp_fifo_pop_buf() in do_message_phase()
  esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
  esp.c: change esp_fifo_push() to take ESPState
  esp.c: change esp_fifo_pop() to take ESPState
  esp.c: use esp_fifo_push() instead of fifo8_push()
  esp.c: change esp_fifo_pop_buf() to take ESPState
  esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
  esp.c: move esp_set_phase() and esp_get_phase() towards the beginning
    of the file
  esp.c: introduce esp_update_drq() and update esp_fifo_{push,pop}_buf()
    to use it
  esp.c: update esp_fifo_{push,pop}() to call esp_update_drq()
  esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
  esp.c: remove explicit setting of DRQ within ESP state machine

 hw/scsi/esp.c | 189 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 120 insertions(+), 69 deletions(-)

-- 
2.39.2


