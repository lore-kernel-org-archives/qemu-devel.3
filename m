Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF4CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsO-0008Fj-Mi; Thu, 01 Oct 2026 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrs-0007m4-68
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrp-0006LR-Iu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrZF6cdcnqviib3gja16Mvyqjbw8z+nCL3N0PjPyR7c=;
 b=D9GVOuQqi6w899QoMb1jng1+/K4YkXZIy5odc+4jsYKSejlOxjjGrffvx/jQcAYbBmJMcL
 91enIWXXmDLuqldzvFGfWCONWNau/xJQfpFUHaVWmYMSpWQWMRH0OZnj7zkSMurzrtm9lA
 HjYUdzlKOPzoq5KLGFIqEvenXOlJqeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-WW1jT4X3NS-FI21k1fa89A-1; Thu,
 01 Oct 2026 09:30:30 -0400
X-MC-Unique: WW1jT4X3NS-FI21k1fa89A-1
X-Mimecast-MFC-AGG-ID: WW1jT4X3NS-FI21k1fa89A_1790861426
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63443193611C; Thu,  1 Oct 2026 13:30:26 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F4C946E; Thu,  1 Oct 2026 13:30:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:50 +0400
Subject: [GIT PULL 11/27] hw/usb/dev-smartcard-reader: apply backpressure
 to bulk-out
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-11-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4392;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j53eiN9DcSL9MXPj9EvF47pIBzJmmq/32PTbmZDAsvI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHckdTKmkdY9nKNKdhqwMxMQcVVUxuhCDbl
 slZCtjGk06JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5STpD/99xvFGbTcrwtjP0aTtM6GnupIvXgUFKqduiu/6mh5fPfc6ejjz7lq5BkxUGNZKQm3gW5x
 yjH2gv/2uQWEH/avusAFYMOmJsU/fBo4nd0h+Ai/pEzEMi+45WPfEqsyflBQCUMqUSuVy+J4t0U
 mOT7oN9NBiQkm4E0unaFxAF6cEaFmYUc3BlfZhIpxHeHrrMKfjx1jfbx+KCGHgWmD10A5m89ZLY
 GFo1KVmO5aiLcMHcPyuybsqCsoDoMZz0FFZnVPKl3SUP0rbe6q8vt9InSKkQP4TWqWxuoPRj8Gd
 GIF4WwaSa1EJaKIbttjDBMCyTtUNhGT92qumABU0CCtWbPrpzrG3WunuIqEumBL/2bGT15a3gpT
 rFeP0X1SfH8VQ1zhRiBNqVIhQFzSO9V8HdZM6EHXvNrMrzw5uJooEglsByyTN7T1mMPolG+QHw7
 CRpTQdxbYskT5VPaOHjMlzq0xSof5eaHKtle8ECvh0zCQUvhGPyYKwv6NFTX727A+VpOYO7fCUk
 RugsSSV0meR6F8b8nD9NSv5L6qgUhX/ODocivVCtaKx/xdZ3M8iH1WBBTlRokWWNs9wzkw2O3X4
 xCg/ySCDgtxddjZX5LuxuIpCIihBRtP1w+bJOv6sPlkooQV5YgY9m5CRTOkpI+uyflEyJq2VDjo
 sGv3sQHHVOGh+bQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

A guest can send bulk-out commands faster than the card backend produces
responses. Each XfrBlock adds a pending answer slot, and other commands
immediately allocate a bulk_in_pending entry. Once all
BULK_IN_PENDING_NUM slots are full, ccid_reserve_recv_buf() returns NULL
and responses are silently dropped.

NAK the bulk-out endpoint at message boundaries when bulk_in_pending_num
+ pending_answers_num >= BULK_IN_PENDING_NUM, so the guest retries
later, giving the response pipeline time to drain.

Change ccid_write_data_block_answer() to peek the next answer before
attempting to write the data block: if the bulk-in ring is full, the
pending answer is preserved for retry rather than being consumed and
lost. Update ccid_flush_pending_answers() to break on failure so it does
not loop forever when the ring is full.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 12c82c8f6458..279fef03652b 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -765,13 +765,13 @@ static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
     usb_wakeup(s->bulk, 0);
 }
 
-static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
+static bool ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
                                   const uint8_t *data, uint32_t len)
 {
     CCID_DataBlock *p = ccid_reserve_recv_buf(s, sizeof(*p) + len);
 
     if (p == NULL) {
-        return;
+        return false;
     }
     p->b.hdr.bMessageType = CCID_MESSAGE_TYPE_RDR_to_PC_DataBlock;
     p->b.hdr.dwLength = cpu_to_le32(len);
@@ -788,6 +788,7 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
     }
     ccid_reset_error_status(s);
     usb_wakeup(s->bulk, 0);
+    return true;
 }
 
 static void ccid_report_error_failed(USBCCIDState *s, uint8_t error)
@@ -796,19 +797,26 @@ static void ccid_report_error_failed(USBCCIDState *s, uint8_t error)
     s->bError = error;
 }
 
-static void ccid_write_data_block_answer(USBCCIDState *s,
-    const uint8_t *data, uint32_t len)
+static Answer *ccid_peek_next_answer(USBCCIDState *s);
+
+static bool ccid_write_data_block_answer(USBCCIDState *s,
+                                         const uint8_t *data, uint32_t len)
 {
-    uint8_t seq;
     uint8_t slot;
+    uint8_t seq;
+    Answer *answer;
 
     if (!ccid_has_pending_answers(s)) {
         DPRINTF(s, D_WARN, "error: no pending answer to return to guest\n");
         ccid_report_error_failed(s, ERROR_ICC_MUTE);
-        return;
+        return false;
+    }
+    answer = ccid_peek_next_answer(s);
+    if (!ccid_write_data_block(s, answer->slot, answer->seq, data, len)) {
+        return false;
     }
     ccid_remove_pending_answer(s, &slot, &seq);
-    ccid_write_data_block(s, slot, seq, data, len);
+    return true;
 }
 
 static uint8_t atr_get_protocol_num(const uint8_t *atr, uint32_t len)
@@ -1008,6 +1016,18 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     CCID_Header *ccid_header;
     uint32_t payload_len;
 
+    /*
+     * Every accepted command either queues a response immediately or commits a
+     * slot to a later APDU response. Apply backpressure before consuming the
+     * first packet when all response slots are committed.
+     */
+    if (s->bulk_out_pos == 0 && /* start of message */
+        s->bulk_in_pending_num + s->pending_answers_num >=
+            BULK_IN_PENDING_NUM) {
+        p->status = USB_RET_NAK;
+        return;
+    }
+
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
     }
@@ -1190,7 +1210,9 @@ static void ccid_unrealize(USBDevice *dev)
 static void ccid_flush_pending_answers(USBCCIDState *s)
 {
     while (ccid_has_pending_answers(s)) {
-        ccid_write_data_block_answer(s, NULL, 0);
+        if (!ccid_write_data_block_answer(s, NULL, 0)) {
+            break;
+        }
     }
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


