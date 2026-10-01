Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41396CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsJ-0008A5-TV; Thu, 01 Oct 2026 09:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrn-0007fP-QR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrl-0006Kx-Im
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzXfffnWSNHmW+TEOhH4ElaUYO0d3+YddCcBShim0Zk=;
 b=EfWl3N3eLEjPUp8fMx5BPnP/NJwe3DJ1Jxzs+QREMm/ryejS//EdpR327aZ6qvj00oSxch
 pxV6iq+CPATsf/2oj75POgWEaGps90A3f2ZuO4bvzSmyUVKb2SgSId8RlJEJdvEDXdKbVw
 GhdCJhuG0V0W7pqrVOALE/X+Y7ongoo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-PkcWELfiNfKidfVWPXWG6A-1; Thu,
 01 Oct 2026 09:30:25 -0400
X-MC-Unique: PkcWELfiNfKidfVWPXWG6A-1
X-Mimecast-MFC-AGG-ID: PkcWELfiNfKidfVWPXWG6A_1790861423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7C01955F22; Thu,  1 Oct 2026 13:30:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6508830000E6; Thu,  1 Oct 2026 13:30:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:49 +0400
Subject: [GIT PULL 10/27] hw/usb/dev-smartcard-reader: reset all I/O state
 on device reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-10-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hYFaAXo7E7kMCZjlWcmSX37LRvdqJFDVQU55mcJ2O0g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHVC6VUS579DfVd75i3iEMuBH1zVbf8jojo
 at+6dvZtIuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5c4xD/wIME1r/DxJBVO2V54YQCQ/7Odc+LwRtK4jfak8b1wFzK01OxiBYR5f1AvoAgHoSCrxEaA
 cFr4d1OlnrFEERt1eO9xYwDhspnJ93kWDpmWZveyGYMzfawW4oFr+LrKDh3W0sisgSO2zxf0DzR
 G6VnCfbxjz4rBDoAUAaSIoeZb75CXbXGDGPNMolG4YtvfNtFC09MQc0/dM5H89pfutlLQXh7DXM
 hlUa3nastQw71VXt0Lrrd2dHCqzUJvCkO0PLaxyCyVe5SlTvjxLYtC/Iccw0LujCnLGJ9GutS4M
 R0hkpjbyjepZSmC3p3MuRvxtegQU2YburCExbpbck4oQxAGoLkpqvRrLMQph8CFiY6TB3DqTFJ+
 SiLDVUvB99SQMywFCGg01gWLOyznAxrP/49OCFV59jwpUCpc2tltLXjZTpEayRfCgwlcplbgtFM
 pjy/EZAmk6HSkEdjsYgQktPO3MwYQXDzm3neCA3g2xSp3uAl7oSk/dY2o5pt88MYfhtLb94ryjl
 UByPexJ/82cU2TK3/cgw42IVX7IYqAx07MzQ5OxSx9Djji3dCB2jRh+sJOEH1BLFlVdTiPQB6/t
 xewG420uEOwzvixUL1ACaWOvbkzZcXDOGWpsgfDmQlutKgQgs/u1wp2kNrOgjSWP6cdpliHnC/Q
 5Lexug2pgI7boqQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Clear bulk-in entries (len/pos), current_bulk_in pointer, bulk-out
position, error status, and protocol parameters during reset. Previously
only the bulk-in ring buffer indices and pending answers were cleared,
leaving stale state that could corrupt subsequent transfers.

Move ccid_reset() after its callees to avoid forward declarations.

Drop redundant initialization from realize() since it calls reset().

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 62 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 52d6f7e8d4de..12c82c8f6458 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -574,13 +574,16 @@ static void ccid_remove_pending_answer(USBCCIDState *s,
 
 static void ccid_bulk_in_clear(USBCCIDState *s)
 {
-    if (s->current_bulk_in != NULL) {
-        s->current_bulk_in->pos = 0;
-        s->current_bulk_in = NULL;
+    int i;
+
+    for (i = 0; i < BULK_IN_PENDING_NUM; i++) {
+        s->bulk_in_pending[i].len = 0;
+        s->bulk_in_pending[i].pos = 0;
     }
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
     s->bulk_in_pending_num = 0;
+    s->current_bulk_in = NULL;
 }
 
 static void ccid_bulk_in_release(USBCCIDState *s)
@@ -625,26 +628,6 @@ static void *ccid_reserve_recv_buf(USBCCIDState *s, uint16_t len)
     return bulk_in->data;
 }
 
-static void ccid_reset(USBCCIDState *s)
-{
-    ccid_bulk_in_clear(s);
-    ccid_clear_pending_answers(s);
-}
-
-static void ccid_detach(USBCCIDState *s)
-{
-    ccid_reset(s);
-}
-
-static void ccid_handle_reset(USBDevice *dev)
-{
-    USBCCIDState *s = USB_CCID_DEV(dev);
-
-    DPRINTF(s, 1, "Reset\n");
-
-    ccid_reset(s);
-}
-
 static const char *ccid_control_to_str(USBCCIDState *s, int request)
 {
     switch (request) {
@@ -922,6 +905,31 @@ static void ccid_reset_parameters(USBCCIDState *s)
    s->abProtocolDataStructure = defaultProtocolDataStructure;
 }
 
+static void ccid_reset(USBCCIDState *s)
+{
+    ccid_bulk_in_clear(s);
+    ccid_clear_pending_answers(s);
+    s->bulk_out_pos = 0;
+    s->last_answer_error = 0;
+    s->notify_slot_change = false;
+    ccid_reset_error_status(s);
+    ccid_reset_parameters(s);
+}
+
+static void ccid_detach(USBCCIDState *s)
+{
+    ccid_reset(s);
+}
+
+static void ccid_handle_reset(USBDevice *dev)
+{
+    USBCCIDState *s = USB_CCID_DEV(dev);
+
+    DPRINTF(s, 1, "Reset\n");
+
+    ccid_reset(s);
+}
+
 /* NOTE: only a single slot is supported (SLOT_0) */
 static void ccid_on_slot_change(USBCCIDState *s, bool full)
 {
@@ -1353,14 +1361,6 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     s->dev.speedmask = USB_SPEED_MASK_FULL;
     s->notify_slot_change = false;
     s->powered = true;
-    s->pending_answers_num = 0;
-    s->last_answer_error = 0;
-    s->bulk_in_pending_start = 0;
-    s->bulk_in_pending_end = 0;
-    s->current_bulk_in = NULL;
-    ccid_reset_error_status(s);
-    s->bulk_out_pos = 0;
-    ccid_reset_parameters(s);
     ccid_reset(s);
     s->debug = parse_debug_env("QEMU_CCID_DEBUG", D_VERBOSE, s->debug);
 }

-- 
2.56.0.rc0.29.g47ce80527c56


