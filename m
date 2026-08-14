Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33982C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuor9-0002Zz-W8; Fri, 14 Aug 2026 06:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuor2-0002Z2-KH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuoqy-0001i5-84
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786702171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDnA5EbS2SujH8j99fbEfzBj9813RFIjqUx0PvCdrt8=;
 b=KUdLch0jyJ+tZ80pxSEg7jOPS+e8y/4D4GrP+xaSHtpKiWwxxiF8ROyDsHsNl3ZL4BjZRU
 ibSie50cToflWopzNKdaE7SUL4A7SsX8L48ijXH6JXqV4Ohq2/fcwMsbX8+c2Hv/R5FoXU
 gwJHTe+pyTOrVDhgu9j3o3FlkD5m4aI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-pCrUw5trO6qmOODjPJ4iMQ-1; Fri,
 14 Aug 2026 06:09:30 -0400
X-MC-Unique: pCrUw5trO6qmOODjPJ4iMQ-1
X-Mimecast-MFC-AGG-ID: pCrUw5trO6qmOODjPJ4iMQ_1786702169
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC021195608E; Fri, 14 Aug 2026 10:09:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2657423; Fri, 14 Aug 2026 10:09:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Feifan Qian <bea1e@proton.me>
Subject: [PULL 4/6] hw/usb/dev-uas: Don't abort if guest provided an
 undersized buffer for status
Date: Fri, 14 Aug 2026 12:09:15 +0200
Message-ID: <20260814100917.163448-5-thuth@redhat.com>
In-Reply-To: <20260814100917.163448-1-thuth@redhat.com>
References: <20260814100917.163448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


