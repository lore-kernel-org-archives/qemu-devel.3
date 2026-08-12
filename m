Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2456C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8dH-0006U7-D4; Wed, 12 Aug 2026 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dF-0006LA-4V; Wed, 12 Aug 2026 09:04:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dD-0004U5-7s; Wed, 12 Aug 2026 09:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=SndFf6wpDh9BKo52My83sPiQ67/6jnB04Xro4r75hK8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E0VZ5jRhVV/o/Mf/3Ie2dRBCwVwTT7LQ0Gw/BaX8NCpMZwKlkFqr0yxwmcctx7ZJl
 HyFCM65MZbI34R+9EJWw2gqk3BhNTc/NNbw4RAhfWsxZSme96TzTXzRnO3IPJgE6jn
 4paGojBWm5LCEzg4AXjmNY0JLLVtvXMsL/GCpjTLkXut79sJl3wQU0Z0F9dlpioFzF
 qUDGvvS+61rgsvDKjeqApuAX7iAMQRigTDpQgrm5duYJTEghc+C/aN6SwgokvBJ2YN
 RmucHWl8C+CAqAPCfdRfhZIzLPB5YfUrxbXHyMuxOoIUaXV3aaSFAafGoy4CaAkdB2
 RTi8nmDT0f3Pg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FC561CA492;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 95587409B75;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F23F92F8BA; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 019/102] hw/usb/dev-uas: Fix guest-triggerable heap
 OOB access
Date: Wed, 12 Aug 2026 16:00:54 +0300
Message-ID: <20260812130233.621965-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

The stream ID is under control of the guest, and some spots in the
code currently use it for indexing into the status3[] array without
checking it for being in range first, so the code accesses the heap
beyond the limit of the status3 array.

Since our status delivery code depends on having a valid stream ID,
we must not try to generate a fake sense code in this situation.
Simply log a guest error and return early in usb_uas_command().

And to make sure that we really cannot access the status3[] array
beyond its limit anymore, add some assert() statements in the
affected functions, too.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
Reported-by: Reported-by: huntr bubble
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260720134809.573757-1-thuth@redhat.com>
(cherry picked from commit b7520c9a59128d7e616876a511821c70edab2a90)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 44e30013d73..eea687cb821 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -363,6 +363,7 @@ static void usb_uas_send_status_bh(void *opaque)
 
     while ((st = QTAILQ_FIRST(&uas->results)) != NULL) {
         if (uas_using_streams(uas)) {
+            assert(st->stream <= UAS_MAX_STREAMS);
             p = uas->status3[st->stream];
             uas->status3[st->stream] = NULL;
         } else {
@@ -384,8 +385,14 @@ static void usb_uas_send_status_bh(void *opaque)
 
 static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
 {
-    USBPacket *p = uas_using_streams(uas) ?
-        uas->status3[st->stream] : uas->status2;
+    USBPacket *p;
+
+    if (uas_using_streams(uas)) {
+        assert(st->stream <= UAS_MAX_STREAMS);
+        p = uas->status3[st->stream];
+    } else {
+        p = uas->status2;
+    }
 
     st->length += length;
     QTAILQ_INSERT_TAIL(&uas->results, st, next);
@@ -701,14 +708,22 @@ static void usb_uas_command(UASDevice *uas, uas_iu *iu)
     uint16_t tag = be16_to_cpu(iu->hdr.tag);
     size_t cdb_len = sizeof(iu->command.cdb) + iu->command.add_cdb_length;
 
+    if (uas_using_streams(uas) && tag > UAS_MAX_STREAMS) {
+        /*
+         * Our status delivery only works with valid tags, so in case the
+         * stream ID is out of bounds, we have to return immediately here
+         * without sending a fake sense_code_INVALID_TAG to the guest.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "invalid tag 0x%x for USB UAS command\n", tag);
+        return;
+    }
+
     if (iu->command.add_cdb_length > 0) {
         qemu_log_mask(LOG_UNIMP, "additional adb length not yet supported\n");
         goto unsupported_len;
     }
 
-    if (uas_using_streams(uas) && tag > UAS_MAX_STREAMS) {
-        goto invalid_tag;
-    }
     req = usb_uas_find_request(uas, tag);
     if (req) {
         goto overlapped_tag;
@@ -745,10 +760,6 @@ unsupported_len:
     usb_uas_queue_fake_sense(uas, tag, sense_code_INVALID_PARAM_VALUE);
     return;
 
-invalid_tag:
-    usb_uas_queue_fake_sense(uas, tag, sense_code_INVALID_TAG);
-    return;
-
 overlapped_tag:
     usb_uas_queue_fake_sense(uas, tag, sense_code_OVERLAPPED_COMMANDS);
     return;
-- 
2.47.3


