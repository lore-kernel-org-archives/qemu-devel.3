Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE6BCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB25-0007xN-EH; Sat, 17 Oct 2026 16:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0h-00062g-RL; Sat, 17 Oct 2026 16:28:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0g-0003xQ-3M; Sat, 17 Oct 2026 16:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268841; bh=T29+x61vRVPGumRCB3fkn+sH97oemALwx2atp0ZP7x0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hfR07zX9oeDJxbhOTDus+yjXp4jg3wwjaUquDJoV5qqwSfhkx0iU9CIUOltJ8dDrq
 nk9ZZ8BZ0YRXUSt0hvBgp9xcoTX7P4QaQ2vq2D0vJhrsj1yg+9Pk7KZuqXH+pVW4hD
 HApfDDbIYSh8ik4pwlEmHsMUXYgqnKn5GwASrVPoMLIXDnXqEH+so/fDnJfy5Y9kNo
 XEO4dowClumgD2/YIQ2CmdGIplAW23OpFeijhWTA9h1A4QBz3cgx/ijdGUMa87Up5A
 cSg+FfKbeelsYNTylFnLk+qq8OcyVZEKInq/lFkJQu6dFR3vN22Fua+rYQryrJIEQm
 8oYBW0HQme6Fw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 115481DE74C;
 Sat, 17 Oct 2026 23:27:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 29540443423;
 Sat, 17 Oct 2026 23:27:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 17/73] hw/usb/dev-smartcard-reader: fix assert on
 pending answers overflow
Date: Sat, 17 Oct 2026 23:25:35 +0300
Message-ID: <20261017202638.728621-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

A guest can send PC_to_RDR_XfrBlock USB messages faster than the async
card backend can process them. When the pending_answers ring buffer
(128 entries) fills, ccid_add_pending_answer() hits an assert() and
crashes QEMU.

The CCID spec (section 4) states that a slot can only accept one
command at a time. A second command to a busy slot must be rejected
with CMD_SLOT_BUSY (section 6.2.6).

Enforce this by checking pending_answers_num before queuing a new
APDU. When the slot is already busy, report ERROR_CMD_SLOT_BUSY and
send a DataBlock error response back to the guest.

Fixes: CVE-2026-18410
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3997
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit d7f20657e756744fec8f84cd225a3b07cfb78526)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index aee966c0c9..9cbacf08e7 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -166,6 +166,7 @@ enum {
     ERROR_XFR_PARITY_ERROR  = -3,
     ERROR_XFR_OVERRUN       = -4,
     ERROR_HW_ERROR          = -5,
+    ERROR_CMD_SLOT_BUSY     = -32,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -949,6 +950,13 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
         ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
         return;
     }
+    if (s->pending_answers_num > 0) {
+        DPRINTF(s, D_WARN,
+                "usb-ccid: slot already busy, rejecting apdu\n");
+        ccid_report_error_failed(s, ERROR_CMD_SLOT_BUSY);
+        ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
+        return;
+    }
     len = le32_to_cpu(recv->hdr.dwLength);
     DPRINTF(s, 1, "%s: seq %d, len %u\n", __func__,
                 recv->hdr.bSeq, len);
-- 
2.47.3


