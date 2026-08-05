Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DD6C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDb-0003f5-H5; Wed, 05 Aug 2026 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDW-0003Uc-Pi
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDV-0007W9-8X
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ttk74vB5a13FGZBeP2t5AzMqh/E4OV0LHnpApA8Rukg=;
 b=Z8cxPB53WGThtVMFn9wuZI/QJV+xolUrYBtEOETrdT273OXzmpvdsp78i5pC832oxndv+r
 63g5Q8U0ADDfj0i4oogq+1C+r4i2CTtCzssErpexAPKwDSpm0+GFjepbRAhmnMmnc3Rfu9
 zIrSMmoQMxpp3+XOTDzZh5UWeav5ahA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-vzyE6PguOIGjPzxPgciIiQ-1; Wed,
 05 Aug 2026 07:55:23 -0400
X-MC-Unique: vzyE6PguOIGjPzxPgciIiQ-1
X-Mimecast-MFC-AGG-ID: vzyE6PguOIGjPzxPgciIiQ_1785930922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EEA11956080
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:55:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58EEC1800348; Wed,  5 Aug 2026 11:55:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:14 +0400
Subject: [PATCH 24/27] hw/usb/dev-smartcard-reader: use usb_packet_size()
 accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-smartcard-fixes-v1-24-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3488;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oKj3znzcWH9h2NBqI7QwuC+RA4aQIgVkNCe/GI2lqSA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOvH+ONxbFtzKeTc7eXYHHmHcBcC7Y2vvxUS
 B66vp50j7KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrwAKCRDa6OEJdZac
 5cqnD/479A/cVtMrqfYh04WcokY6W86JwiW1VZkhWWQx9E6rqK3vcosPFtakKNwqh6GunYI8Cqi
 hEGMGTA0OIpTAt7puHtDweF+kO4RJELIPFqQmlPxSn0Al5reB/uSQ2aeiiWUTY5g9F0ClxJgghx
 UKObliqBHbwshFHzidFsHq78+yYYnYRpVpOPenqrjyKeVQXr5cMoV4PriJt+4e/BgqbDk5gQYk/
 7prYOP47KBqZPQ1LMIDUZygLk0t2UA6oMc1HaRjI1spM9y3/F1r1oT0RycmBJ4zMzQPDo0xAVIh
 zTh5NTQwmO7flZcF9APiSKrXUGpUKNg99flguj8Diy1uj4IjHAVftBrZk1AI9kzydrf//TXEN2q
 RYimVlRGx2KtoOCyO+ujUcEKTkWF6Eu6gWzGMI5nt8r3b0icNGAbCQhkTOYmNJWIgpZYLqagbYg
 JhaO4QHChj9ERfyoz5aTnE6TNBRVjiDMzyiVvkxf5Xoy5PFv5Ox7lrTUhoBvMn+dzxMjlBjUyT6
 6YvtQpx12j+z4xUWOzPBFqy2Jj4Ez8xxHhdG5kP4iage3bUJD2w1w22s+ngooSoGSEmlcyEqJTW
 JYPyTqkVFwaRX4zQlb6xtTHcECsPq4Sm6u5mtwGyBiLQ9LhyJ1pQcEYUfnpxGNYyygLTR7XYiBN
 qg5CiVVrQJrqKsw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

Replace direct p->iov.size accesses with usb_packet_size(), which
correctly handles combined packets.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bee118cb4ff9..8520a2dab216 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1142,11 +1142,11 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         return;
     }
 
-    if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
+    if (usb_packet_size(p) + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
     }
-    usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
-    s->bulk_out_pos += p->iov.size;
+    usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, usb_packet_size(p));
+    s->bulk_out_pos += usb_packet_size(p);
     if (s->bulk_out_pos < 10) {
         DPRINTF(s, 1, "%s: header incomplete\n", __func__);
         goto err;
@@ -1155,7 +1155,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     ccid_header = (CCID_Header *)s->bulk_out_data;
     payload_len = le32_to_cpu(ccid_header->dwLength);
     if ((s->bulk_out_pos - 10 < payload_len) &&
-        (p->iov.size == CCID_MAX_PACKET_SIZE)) {
+        (usb_packet_size(p) == CCID_MAX_PACKET_SIZE)) {
         DPRINTF(s, D_VERBOSE,
                 "usb-ccid: bulk_in: expecting more packets (%u/%u)\n",
                 s->bulk_out_pos - 10, payload_len);
@@ -1298,7 +1298,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
     bulk_in = ccid_bulk_in_peek(s);
     if (bulk_in != NULL) {
         assert(bulk_in->pos <= bulk_in->len);
-        len = MIN(bulk_in->len - bulk_in->pos, p->iov.size);
+        len = MIN(bulk_in->len - bulk_in->pos, usb_packet_size(p));
         if (len) {
             usb_packet_copy(p, bulk_in->data + bulk_in->pos, len);
         }
@@ -1314,12 +1314,12 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
     if (len) {
         DPRINTF(s, D_MORE_INFO,
                 "%s: %zd/%d req/act to guest (BULK_IN)\n",
-                __func__, p->iov.size, len);
+                __func__, usb_packet_size(p), len);
     }
-    if (len < p->iov.size) {
+    if (len < usb_packet_size(p)) {
         DPRINTF(s, 1,
                 "%s: returning short (EREMOTEIO) %d < %zd\n",
-                __func__, len, p->iov.size);
+                __func__, len, usb_packet_size(p));
     }
 }
 
@@ -1340,7 +1340,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
             break;
         case CCID_INT_IN_EP:
             if (s->notify_slot_change) {
-                if (p->iov.size < 2) {
+                if (usb_packet_size(p) < 2) {
                     p->status = USB_RET_STALL;
                     break;
                 }
@@ -1353,7 +1353,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
                 DPRINTF(s, D_INFO,
                         "handle_data: int_in: notify_slot_change %X, "
                         "requested len %zd\n",
-                        s->bmSlotICCState, p->iov.size);
+                        s->bmSlotICCState, usb_packet_size(p));
             } else {
                 p->status = USB_RET_NAK;
             }

-- 
2.55.0


