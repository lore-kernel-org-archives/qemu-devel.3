Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B8AC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTmv-0007X1-Of; Thu, 30 Jul 2026 12:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpTmu-0007Wg-9d
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpTms-0008Df-Nc
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785429553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=43P7i+PH3R93Mpl0oa1bgU1c/KBrgka5q7h3ziFXuLQ=;
 b=DSvtqeVNhXyJhk6mrtaZoxflvsKg6S8WqI8rDQS2d6hg+ufsMgp1ND/95KK1Gf7TbX0id2
 e+CQ7d+aYn03Rijq5Wtc0itxFYoPrQ5x71cCaTT0peyt6DTUmzX/RQsdsE5gBXmLN8Ko4P
 uNCErUdhl/Hsqxkt/7ESrb4R5b/XxZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-XUpUsWkAOdit2If3UqEP6w-1; Thu,
 30 Jul 2026 12:39:10 -0400
X-MC-Unique: XUpUsWkAOdit2If3UqEP6w-1
X-Mimecast-MFC-AGG-ID: XUpUsWkAOdit2If3UqEP6w_1785429548
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1404E18002C6; Thu, 30 Jul 2026 16:39:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E15A1956089; Thu, 30 Jul 2026 16:39:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Feifan Qian <bea1e@proton.me>, Peter Maydell <peter.maydell@linaro.org>,
 kraxel@redhat.com, qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/usb/dev-uas: Don't abort if guest provided an undersized
 buffer for status
Date: Thu, 30 Jul 2026 18:39:01 +0200
Message-ID: <20260730163901.1154791-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/usb/dev-uas.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 963c0433b38..be8c3667e83 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -359,6 +359,7 @@ static void usb_uas_send_status_bh(void *opaque)
     UASDevice *uas = opaque;
     UASStatus *st;
     USBPacket *p;
+    uint32_t length;
 
     while ((st = QTAILQ_FIRST(&uas->results)) != NULL) {
         if (uas_using_streams(uas)) {
@@ -373,7 +374,14 @@ static void usb_uas_send_status_bh(void *opaque)
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
 
@@ -875,7 +883,14 @@ static void usb_uas_handle_data(USBDevice *dev, USBPacket *p)
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
2.55.0


