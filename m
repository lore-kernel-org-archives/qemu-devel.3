Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2911ACA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsu-0001Er-4S; Thu, 01 Oct 2026 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsb-0008Vx-Cj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsY-0006RQ-GK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFNUv8RjeNsH9jAUIjQp8KNl9pB7eLaPjsoWErgPNfU=;
 b=UE/K7kQ92vkKyfQN5bRg5bFWPwY2dlsy2bL8uR8snkYo4HU7/sc4/bprO98LkEmilyyN6a
 pfWXbEyjRvuVo5JNrqj7rvpOktV8YGdJamloc7qhWwNwmzFlx0P1Rp19PxVq16hluQSLQ1
 skZJkmicmJ1UNY02J+QyfrTUUCMLRzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-hS_YHhlLNh-vNnHQpZXb-g-1; Thu,
 01 Oct 2026 09:31:11 -0400
X-MC-Unique: hS_YHhlLNh-vNnHQpZXb-g-1
X-Mimecast-MFC-AGG-ID: hS_YHhlLNh-vNnHQpZXb-g_1790861469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1F101809CB2; Thu,  1 Oct 2026 13:31:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0688118005B3; Thu,  1 Oct 2026 13:31:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:03 +0400
Subject: [GIT PULL 24/27] hw/usb/dev-smartcard-reader: use
 usb_packet_size() accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-24-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dm40QCDQhaUf0+8KvvG9NEurnfi+Acexw9HoRYzOVFY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIRKSFKmsyTCoddc4R7Hml3OEb7/ZkgKSBH
 WkZVxzVKJGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5YTND/0Yq9jYCLbFOY9+jCBqmEuO2gHNKkGQ/0skEFFZQ3Gu2p9HNgN2TzPv3S3ijK8h/g+asbu
 +CozPzj+EGPAMOqXy14z903ccYZOiNtqsryoTNxMaEL/Dr0LTKJPN9DbEdwWIyBkTtLOIYDtTay
 4wlZbz0ed1ztRaAzQYck12tOmHfr/9rdkdN7nvmHWtHl4FolvBr6MfXX4Vf+X2B8Ftmw//uZ1qA
 wl0WvswJNAWjtc2PECZVabQsm962TBIED/NTNRvp61lZ6QEatqTnmAw+b9NAkegG6W3vQwK0L+L
 iTk8oO0lAKAouP2JfVLdlfqAb+ebIMqVf7lcLew79qbhV2xlDBMuTD/eEzzk0kCKLTNrApokvAa
 Ujd4huDj8fPeqnov20oTtmUMmV8Db2Q22LYYO4YkcPG4MqJteiGYUxJYmhLIRyoTG9EoooEybIG
 LY/zaq7wW5v7bqzXODA7Ro98kWpqtAnnPtWkOOJjvn9P9GBnp9UAyoL7T4zMRUEYRLCxgNZ/ldu
 d5e7GZykW9h/hjd8aHTGFSm+sQ8vwVXhqjvRKoKIQ4BNvHD7XetkVRidOrlVz0Op38Yk3tCvJDv
 pIUBpUM0icuA81YH/qpglbL2BAe33GRmloMbYWzjirjMw4WyJ9HZK4ZcjeCltvgkrkU7/38b/au
 GIGX6jY0skLMn4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

Replace direct p->iov.size accesses with usb_packet_size(), which
correctly handles combined packets.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
2.56.0.rc0.29.g47ce80527c56


