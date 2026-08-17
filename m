Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD4BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxWa-0005u3-TF; Mon, 17 Aug 2026 09:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWY-0005ik-Ik; Mon, 17 Aug 2026 09:37:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWW-0007VW-JW; Mon, 17 Aug 2026 09:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=6oZ0U5XXJDCa6VjZZTl5ebos4MAoPCvu/HghL0zqG9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lx+kKUQTE1Vx1TsrWhQ/Cg3iKortFzCh0Gpd89JSrR3GppI1D6XcLmPslUA1MfG/h
 cTLSu6wwhoxddMr4DFzRXJX+zyGyY3PjJKlfrmsHdLyuJypfaU0CQbBa1S3avnxNbm
 4MGBloUZUkUFcdINasXIy3Dc/apdgzChVAjL3vraCfuqsvbaZ1EFtFgVW1SbiwHfrT
 nJ+78021VA8Y3L/wRxZbtAX4XAEgUyFzpxCM/zXJyEWyrC3XXi4c2ompq48kJb/UGQ
 GexUfcJgY5SScqGNAv9EaGyOxfaaYO691sd5zsSXqzfjhJ2HbwLhropLUMVxRpkiDn
 Xi4E9bcSErXfg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D3061CBCC9;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 984C640D426;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C1B3E30F9C; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 122/135] hw/usb/dev-uas: Don't abort if guest
 provided an undersized buffer for status
Date: Mon, 17 Aug 2026 16:34:32 +0300
Message-ID: <20260817133451.2384630-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently aborts if the guest provides an undersized buffer
for the status packet (8 bytes):

 hw/usb/core.c:623: usb_packet_copy:
  Assertion `p->actual_length + bytes <= iov->size' failed.

If we hit this situation, log a guest error and continue by simply
only providing the bytes that the guest asked for.
(Note: This is e.g. similar to the UAS_PIPE_ID_COMMAND case that
also clamps the length with: length = MIN(sizeof(iu), p->iov.size))

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3900
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260730163901.1154791-1-thuth@redhat.com>
(cherry picked from commit 15700a66ecb53c52717c913c2c4501372c0115ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index eea687cb821..757e340711b 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -360,6 +360,7 @@ static void usb_uas_send_status_bh(void *opaque)
     UASDevice *uas = opaque;
     UASStatus *st;
     USBPacket *p;
+    uint32_t length;
 
     while ((st = QTAILQ_FIRST(&uas->results)) != NULL) {
         if (uas_using_streams(uas)) {
@@ -374,7 +375,14 @@ static void usb_uas_send_status_bh(void *opaque)
             break;
         }
 
-        usb_packet_copy(p, &st->status, st->length);
+        length = st->length;
+        if (length > p->iov.size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "usb uas: packet (%zd) too small for status (%d)\n",
+                          p->iov.size, length);
+            length = p->iov.size;
+        }
+        usb_packet_copy(p, &st->status, length);
         QTAILQ_REMOVE(&uas->results, st, next);
         g_free(st);
 
@@ -876,7 +884,14 @@ static void usb_uas_handle_data(USBDevice *dev, USBPacket *p)
                 break;
             }
         }
-        usb_packet_copy(p, &st->status, st->length);
+        length = st->length;
+        if (length > p->iov.size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "usb uas: packet (%zd) too small for status (%d)\n",
+                          p->iov.size, length);
+            length = p->iov.size;
+        }
+        usb_packet_copy(p, &st->status, length);
         QTAILQ_REMOVE(&uas->results, st, next);
         g_free(st);
         break;
-- 
2.47.3


