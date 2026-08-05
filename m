Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5B1C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraCI-0000nM-09; Wed, 05 Aug 2026 07:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCF-0000ah-Pt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCD-0007PH-Rx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNF4m7ci2HpS4FLloHT0Tdnt7xTANURrOcHGQaUioKA=;
 b=erb9SSFcy/PUuhcIe5cgKXXS+uk01RZ5ntQqttcfS6aqvBwUiUaI63GaQMYTw/2VAnz6Ra
 E9EyyollM0LA7P83vpt+ur06b7Zar63tCXL/xmzmJQ/P3yGdHkqWUJxC8EsbDiuPoWmIUk
 9C3XXrBJURI1dRq7DjfbxXd4lEX5dcs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-XqSnDyqhPliJ_7APD2Tg6w-1; Wed,
 05 Aug 2026 07:54:04 -0400
X-MC-Unique: XqSnDyqhPliJ_7APD2Tg6w-1
X-Mimecast-MFC-AGG-ID: XqSnDyqhPliJ_7APD2Tg6w_1785930843
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45D7B180035C
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:54:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB4CC1956041; Wed,  5 Aug 2026 11:54:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:06 +0400
Subject: [PATCH 16/27] hw/usb/dev-smartcard-reader: derive queue counts
 from start/end indices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-16-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7282;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1eY9L4oL2U9UI9yiBIqtLr7IOpTEn1kS0NTCXyCacf0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOuIVgqzSwje6deBGO0n71oFACC0BKKg7Uvp
 JSSq9/YXU+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5SUrD/9ry6/tzKa0EDycUWC1SZGAliuNsUurlhXrfF7cxK/Qr3q9439T0u54ahlYy3VbW086N6l
 5wOqtB82H2Wjc4KG3f81yQaFuIH9+raqIMRCpMeSNbhYS/AYp2aTsMqvBHzZybWMxVT/eyvKrZj
 B/Uh52QznoTtQLrth1EBOLuyJvgyOTsj5L/wR3ePXTpjuzzphYh58LlXP2sZmuWaFIMpmkCCBxx
 y1R/XnWMFtcQ0L5PuE3/iJicMLzbsJJZvM/ji+IxTf6Ga27nORZk1ZKRIBljXti3i7jX0Cx/hv4
 apHTvlBez2mItplw3cboMGW+9RDcEZjtaCv7Gi4oU+glNkqzzVIAd/597OUTGLCrDfZRY1/sKRD
 h/NjCGGxgItuZl+a/9y+W/FOHnjyjpabHJ3DHVajdOOr6LbvDVmVVpQQ9L9/8nsCKM/DdEE8idP
 r+1r+qz/EvsdJcOP2umiVyR+Qqe4h/xKXr/e9ta17mWBx71aRcJGAib+ObfEWtF4dQsuVqHrq8n
 qMLPAWs0zCvIq0+XpNMeh++CDnO60LzCN2gfsfhQFCoZFO1Ejdp9s6v3fyvP4LAwqLrDn3X/Th9
 H3D23tyQncopMxBoUAoT9IaT2/GywyNa4wqgaRl/t4Qa3v99R+lAS/0uU1QGk0Kpt3eQpFzDwSW
 6CS1b+5DdX9m9iw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Replace the redundant bulk_in_pending_num and pending_answers_num shadow
counters with helper functions that compute the count from (end - start).
This removes redundant bookkeeping and potential issues.

pending_answers_num is kept for migration reasons, but since
pending_answers_{start,end} are not migrated, we can just do a best
effort for the following migration fix.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 47 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 3f128791f3ef..e3c86cb90e6c 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -295,14 +295,13 @@ struct USBCCIDState {
     BulkIn bulk_in_pending[BULK_IN_PENDING_NUM]; /* circular */
     uint32_t bulk_in_pending_start;
     uint32_t bulk_in_pending_end; /* first free */
-    uint32_t bulk_in_pending_num;
     uint8_t  bulk_out_data[BULK_OUT_DATA_SIZE];
     uint32_t bulk_out_pos;
     uint64_t last_answer_error;
     Answer pending_answers[PENDING_ANSWERS_NUM];
     uint32_t pending_answers_start;
     uint32_t pending_answers_end;
-    uint32_t pending_answers_num;
+    uint32_t pending_answers_num; /* for migration compatibility */
     uint8_t  bError;
     uint8_t  bmCommandStatus;
     uint8_t  bProtocolNum;
@@ -315,6 +314,20 @@ struct USBCCIDState {
     bool accurate_message_length;
 };
 
+static uint32_t ccid_bulk_in_pending_num(USBCCIDState *s)
+{
+    uint32_t n = s->bulk_in_pending_end - s->bulk_in_pending_start;
+    assert(n <= BULK_IN_PENDING_NUM);
+    return n;
+}
+
+static uint32_t ccid_pending_answers_num(USBCCIDState *s)
+{
+    uint32_t n = s->pending_answers_end - s->pending_answers_start;
+    assert(n <= PENDING_ANSWERS_NUM);
+    return n;
+}
+
 /*
  * CCID Spec chapter 4: CCID uses a standard device descriptor per Chapter 9,
  * "USB Device Framework", section 9.6.1, in the Universal Serial Bus
@@ -513,12 +526,11 @@ static void ccid_card_apdu_from_guest(CCIDCardState *card,
 
 static bool ccid_has_pending_answers(USBCCIDState *s)
 {
-    return s->pending_answers_num > 0;
+    return ccid_pending_answers_num(s) > 0;
 }
 
 static void ccid_clear_pending_answers(USBCCIDState *s)
 {
-    s->pending_answers_num = 0;
     s->pending_answers_start = 0;
     s->pending_answers_end = 0;
 }
@@ -533,7 +545,7 @@ static void ccid_print_pending_answers(USBCCIDState *s)
         DPRINTF(s, D_VERBOSE, " empty\n");
         return;
     }
-    for (i = s->pending_answers_start, count = s->pending_answers_num ;
+    for (i = s->pending_answers_start, count = ccid_pending_answers_num(s) ;
          count > 0; count--, i++) {
         answer = &s->pending_answers[i % PENDING_ANSWERS_NUM];
         if (count == 1) {
@@ -548,8 +560,7 @@ static void ccid_add_pending_answer(USBCCIDState *s, CCID_Header *hdr)
 {
     Answer *answer;
 
-    assert(s->pending_answers_num < PENDING_ANSWERS_NUM);
-    s->pending_answers_num++;
+    assert(ccid_pending_answers_num(s) < PENDING_ANSWERS_NUM);
     answer =
         &s->pending_answers[(s->pending_answers_end++) % PENDING_ANSWERS_NUM];
     answer->slot = hdr->bSlot;
@@ -562,8 +573,7 @@ static void ccid_remove_pending_answer(USBCCIDState *s,
 {
     Answer *answer;
 
-    assert(s->pending_answers_num > 0);
-    s->pending_answers_num--;
+    assert(ccid_pending_answers_num(s) > 0);
     answer =
         &s->pending_answers[(s->pending_answers_start++) % PENDING_ANSWERS_NUM];
     *slot = answer->slot;
@@ -581,24 +591,22 @@ static void ccid_bulk_in_clear(USBCCIDState *s)
     }
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
-    s->bulk_in_pending_num = 0;
 }
 
 static void ccid_bulk_in_release(USBCCIDState *s)
 {
     BulkIn *bulk_in;
 
-    assert(s->bulk_in_pending_num > 0);
+    assert(ccid_bulk_in_pending_num(s) > 0);
     bulk_in =
         &s->bulk_in_pending[s->bulk_in_pending_start % BULK_IN_PENDING_NUM];
     bulk_in->pos = 0;
     s->bulk_in_pending_start++;
-    s->bulk_in_pending_num--;
 }
 
 static BulkIn *ccid_bulk_in_peek(USBCCIDState *s)
 {
-    if (s->bulk_in_pending_num == 0) {
+    if (ccid_bulk_in_pending_num(s) == 0) {
         return NULL;
     }
     return &s->bulk_in_pending[
@@ -618,14 +626,13 @@ static void *ccid_reserve_recv_buf(USBCCIDState *s, uint16_t len)
                            __func__, len, BULK_IN_BUF_SIZE);
         return NULL;
     }
-    if (s->bulk_in_pending_num >= BULK_IN_PENDING_NUM) {
+    if (ccid_bulk_in_pending_num(s) >= BULK_IN_PENDING_NUM) {
         DPRINTF(s, D_WARN, "usb-ccid.c: %s: No free bulk_in buffers. "
                            "discarding message.\n", __func__);
         return NULL;
     }
     bulk_in =
         &s->bulk_in_pending[(s->bulk_in_pending_end++) % BULK_IN_PENDING_NUM];
-    s->bulk_in_pending_num++;
     bulk_in->len = len;
     return bulk_in->data;
 }
@@ -988,7 +995,7 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
         ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
         return;
     }
-    if (s->pending_answers_num > 0) {
+    if (ccid_pending_answers_num(s) > 0) {
         DPRINTF(s, D_WARN,
                 "usb-ccid: slot already busy, rejecting apdu\n");
         ccid_report_error_failed(s, ERROR_CMD_SLOT_BUSY);
@@ -1039,7 +1046,7 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
      * first packet when all response slots are committed.
      */
     if (s->bulk_out_pos == 0 && /* start of message */
-        s->bulk_in_pending_num + s->pending_answers_num >=
+        ccid_bulk_in_pending_num(s) + ccid_pending_answers_num(s) >=
             BULK_IN_PENDING_NUM) {
         p->status = USB_RET_NAK;
         return;
@@ -1233,7 +1240,7 @@ static void ccid_flush_pending_answers(USBCCIDState *s)
 
 static Answer *ccid_peek_next_answer(USBCCIDState *s)
 {
-    return s->pending_answers_num == 0
+    return ccid_pending_answers_num(s) == 0
         ? NULL
         : &s->pending_answers[s->pending_answers_start % PENDING_ANSWERS_NUM];
 }
@@ -1440,7 +1447,7 @@ static bool ccid_pre_save(void *opaque, Error **errp)
 {
     USBCCIDState *s = opaque;
 
-    if (s->pending_answers_num || s->bulk_in_pending_num) {
+    if (ccid_pending_answers_num(s) || ccid_bulk_in_pending_num(s)) {
         error_setg(errp, "usb-ccid has pending queue state which cannot be "
                    "migrated safely");
         return false;
@@ -1512,7 +1519,7 @@ static const VMStateDescription ccid_vmstate = {
         VMSTATE_UINT32(bulk_in_pending_end, USBCCIDState),
         VMSTATE_STRUCT_ARRAY(pending_answers, USBCCIDState,
                         PENDING_ANSWERS_NUM, 1, answer_vmstate, Answer),
-        VMSTATE_UINT32(pending_answers_num, USBCCIDState),
+        VMSTATE_UINT32(pending_answers_num, USBCCIDState), /* for compatibility */
         VMSTATE_UNUSED(1), /* was migration_state */
         VMSTATE_UINT32(state_vmstate, USBCCIDState),
         VMSTATE_END_OF_LIST()

-- 
2.55.0


