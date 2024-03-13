Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1242EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRj-0007aH-OB; Wed, 13 Mar 2024 04:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRi-0007Zn-9E
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRd-0002Bi-Ve
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qByUFJgtA6VIhxdvtzTQjbGdS8p4RoxAkkEIt7l5gNQ=; b=HARrkNW1Q7J7ZHeZMZluwJ79sI
 q4O9sJw0vN6Ruyv6VNQRml9LfJ0upJxmCEt5Jj/HizBQNTbF86TZ/Sk7D89XVGSnIBF8jyPSv6ln1
 FisTZU8ADyBmPV4VgbvoKrknuY/fDe9MiVKejgETn5kWivo/6fCYY9ZXFh3dln1/O0Ca9NRJ+Ndmu
 GNChASDrzu1GAJNPEm+tyGdGpOoWmCUYBMNjKLLK4ZgNWvyDr1uJipgk4Fj61p82kApnNakh2KMDY
 fbCAXbdTisT2R+owPHcv5KpmsmDfOvy92EzZdJjPCfQdgkYIS1ixiFz1/K1j7jTCZ3BAr/s77ImRn
 TYC1il94jjOOhCXqr42UxlBrVx3+gTm5tAVJH54fhaMtU2RcJNuWRAqvHAP/H+22TEUqZ0tKpWe+K
 TBGoIoJVek7IgiyTZPyDJqHF7e3o9CQUoFoZpC3rweLWuu239Lzc9PsRS6r/yBiqsX2s4DkIDWIvK
 fhS6DktHnlT4jRNWa9b3U+MyquUDonMNNNT4MtD/LWEK4q6vPMqASDwyFqhOQ1FFYUNVj3gFitgi2
 FKOfsBkztbM40yau1mV3zSp+3ngUTUX4bz6m2hUSjvUpzE4j24ibXWcWZZ0mOuvpF0/3LwKRdRVFl
 NCznhMZ21pkpwcqnKs13+W91gti1ZGwMyOiisvX5Y=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKQh-000CUN-1d; Wed, 13 Mar 2024 08:57:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:57:54 +0000
Message-Id: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/16] [for-9.0] esp: avoid explicit setting of DRQ within
 ESP state machine
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

[MCA: Since v1 I've received a few reports of FIFO assert()s being triggered and a
cmdfifo buffer overflow discovered by fuzzing the updated ESP code. The updating of
all FIFO push/pop operations to use the esp_fifo_*() functions in this series
provides protection against this, and in conjunction with new patches 9-11 is
enough to prevent all qtest reproducers that I have been sent.

For these reasons I would recommend that this series be applied for 9.0. Many thanks
to Chuhong Yuan <hslester96@gmail.com> for reporting the issues and providing qtest
reproducers.]

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

Patches 9-11 incorporate additional protection to prevent FIFO assert()s and a
cmdfifo buffer overflow discovered via fuzzing.

Patch 12 is just code movement which avoids the use of a forward declaration whilst
also making it easier to locate the mapping between ESP SCSI phases and their
names.

Patches 13 introduce a new esp_update_drq() function that implements the above
DRQ logic which is called by both esp_fifo_{push,pop}_buf().

Patch 14 updates esp_fifo_push() and esp_fifo_pop() to use the new esp_update_drq()
function. At this point all reads/writes to the ESP FIFO use the esp_fifo_*()
functions and will set DRQ correctly.

Patch 15 is a small update to the logic in esp_pdma_write() to ensure that
esp_fifo_push() is always called for PDMA writes to the FIFO, thereby ensuring
that esp_update_drq() remains correct even in the case of FIFO overflow.

Finally patch 16 removes all manual calls to esp_raise_drq() and esp_lower_drq()
since the DRQ signal is now updated correctly upon each FIFO read/write access.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rebase onto master
- Add patches 9-12 to handle FIFO assert()s and cmdfifo overflow as reported by
  Chuhong Yuan <hslester96@gmail.com>


Mark Cave-Ayland (16):
  esp.c: replace cmdfifo use of esp_fifo_pop_buf() in do_command_phase()
  esp.c: replace cmdfifo use of esp_fifo_pop_buf() in do_message_phase()
  esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
  esp.c: change esp_fifo_push() to take ESPState
  esp.c: change esp_fifo_pop() to take ESPState
  esp.c: use esp_fifo_push() instead of fifo8_push()
  esp.c: change esp_fifo_pop_buf() to take ESPState
  esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
  esp.c: don't assert() if FIFO empty when executing non-DMA SELATNS
  esp.c: don't assert() if FIFO empty when executing esp_cdb_length()
  esp.c: don't overflow cmdfifo if cmdfifo_cdb_offset >= ESP_CMDFIFO_SZ
  esp.c: move esp_set_phase() and esp_get_phase() towards the beginning
    of the file
  esp.c: introduce esp_update_drq() and update esp_fifo_{push,pop}_buf()
    to use it
  esp.c: update esp_fifo_{push,pop}() to call esp_update_drq()
  esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
  esp.c: remove explicit setting of DRQ within ESP state machine

 hw/scsi/esp.c | 193 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 70 deletions(-)

-- 
2.39.2


