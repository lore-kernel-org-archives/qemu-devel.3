Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25022CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGtI-0001wS-RX; Thu, 01 Oct 2026 09:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGs6-000813-KO
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGs4-0006OG-Hx
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/YBKrRAYzBzfTiYHtDwe4lXg+UiiNEnlFfnbIDDGss=;
 b=Wp8gz57WDAWSJFO9IEpsC7MjmwlNPp9yMBCNGKE0MaQwCsFlDazbgdT0oc6cvnuED6slic
 L0dVRy+VLgr4eG9+xx/arnBFbtY5OZwCmooLBNCgb9KtFVJ3Eo3IgNkSEcaYYDjdPn5mOV
 8YlrZlgeu+gDnp7WkRhJ2Kop77914F0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-FnStZXhfO0GVfhei5_ir8g-1; Thu,
 01 Oct 2026 09:30:40 -0400
X-MC-Unique: FnStZXhfO0GVfhei5_ir8g-1
X-Mimecast-MFC-AGG-ID: FnStZXhfO0GVfhei5_ir8g_1790861439
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B15411936122; Thu,  1 Oct 2026 13:30:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E50411956095; Thu,  1 Oct 2026 13:30:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:54 +0400
Subject: [GIT PULL 15/27] hw/usb/dev-smartcard-reader: drop current_bulk_in
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-15-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4172;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mz7FC7l6nRAjhl5MyuAWb9SEYek02WyouuK0jd/vk0g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBI845S3cX6ZMwGsnyooSCBdsOPHjM+PL6pr
 hqkWoUp1PaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5V2KEACNw2KtpFnBlAtzxqWeNK964Wmrm4hjLwPcHJxv8YiXB2bTGg8hsx4DHG++B00hYCVi/4S
 3msoU4z+aKi8Ne7unkq317z1rLsa3xIOCMdDKljPz6HmU7isFVbXdGBpR44or0A09STJVu9mcNy
 gN6Jx+eX6Cmc2hSzz5V4cjN3RYXPKRLniMHwohB8xuCW9i144zdjdnZ/mAlY9GX+gdD2uAb/1ha
 qiyDq9VwtdnYqaBQPpgLtR8Pce52Fr6UwOpV5Z/Z72q6vUMsjQ6CXC0uMKHTe4Yd8x00PsnioNG
 hjTlgoYsnmjMAKabNSgMWBccXPh0+JBM1SAMjvNxvzRgZ/r2TfAZzvScaQVMak2Qh5kI47OdvLz
 uAkzB4+SkmBYwzpYFtav4SYvVuy+Vc7nSP9eXFOEBOk8zfveZa4VfJo9cenMvtOvWyxGTqm1Os6
 SNdWzepsr/21Yva+7xsNAmVAvIYAIylR1nLgrO2OcNYMoNyT01qR8eDWDDidXImNAGD1kSdtk67
 pQ6a+ydmoP6zRKhTQfSsITrUnHMqWufGtznRy0xhgxhBUFd7fsu4emp/qt5R60ihrkrOHV9y7Bh
 OyOi5IpK0swpM72mSF8gTeJy7NI2HwXyIKnBbA282CR/V8amxKsMxICNj8M4vxWEdrDflNn4Nec
 Zy2W/DwaE8qE2NA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

Replace the eagerly-dequeued current_bulk_in pointer with a
ccid_bulk_in_peek() that returns the head of the ring without advancing
it. The element now stays at bulk_in_pending[start] while being
partially consumed, and start is advanced together with the num
decrement in ccid_bulk_in_release().

This removes a field from USBCCIDState and simplifies the bulk-in ring
buffer lifecycle from three states (queued, grabbed, released) down to
two (queued, released).

Note that this changes the semantic of bulk_in_pending_start in the
migration stream too. But since migration with pending current_bulk_in
was broken, this doesn't make further damages.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 699e236f624e..3f128791f3ef 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -296,7 +296,6 @@ struct USBCCIDState {
     uint32_t bulk_in_pending_start;
     uint32_t bulk_in_pending_end; /* first free */
     uint32_t bulk_in_pending_num;
-    BulkIn *current_bulk_in;
     uint8_t  bulk_out_data[BULK_OUT_DATA_SIZE];
     uint32_t bulk_out_pos;
     uint64_t last_answer_error;
@@ -583,24 +582,27 @@ static void ccid_bulk_in_clear(USBCCIDState *s)
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
     s->bulk_in_pending_num = 0;
-    s->current_bulk_in = NULL;
 }
 
 static void ccid_bulk_in_release(USBCCIDState *s)
 {
-    assert(s->current_bulk_in != NULL);
-    s->current_bulk_in->pos = 0;
-    s->current_bulk_in = NULL;
+    BulkIn *bulk_in;
+
+    assert(s->bulk_in_pending_num > 0);
+    bulk_in =
+        &s->bulk_in_pending[s->bulk_in_pending_start % BULK_IN_PENDING_NUM];
+    bulk_in->pos = 0;
+    s->bulk_in_pending_start++;
     s->bulk_in_pending_num--;
 }
 
-static void ccid_bulk_in_get(USBCCIDState *s)
+static BulkIn *ccid_bulk_in_peek(USBCCIDState *s)
 {
-    if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
-        return;
+    if (s->bulk_in_pending_num == 0) {
+        return NULL;
     }
-    s->current_bulk_in =
-        &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
+    return &s->bulk_in_pending[
+        s->bulk_in_pending_start % BULK_IN_PENDING_NUM];
 }
 
 static void *ccid_reserve_recv_buf(USBCCIDState *s, uint16_t len)
@@ -1135,18 +1137,17 @@ err:
 static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
 {
     int len = 0;
+    BulkIn *bulk_in;
 
-    ccid_bulk_in_get(s);
-    if (s->current_bulk_in != NULL) {
-        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
-        len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
-                  p->iov.size);
+    bulk_in = ccid_bulk_in_peek(s);
+    if (bulk_in != NULL) {
+        assert(bulk_in->pos <= bulk_in->len);
+        len = MIN(bulk_in->len - bulk_in->pos, p->iov.size);
         if (len) {
-            usb_packet_copy(p, s->current_bulk_in->data +
-                            s->current_bulk_in->pos, len);
+            usb_packet_copy(p, bulk_in->data + bulk_in->pos, len);
         }
-        s->current_bulk_in->pos += len;
-        if (s->current_bulk_in->pos == s->current_bulk_in->len
+        bulk_in->pos += len;
+        if (bulk_in->pos == bulk_in->len
             && (len != CCID_MAX_PACKET_SIZE || len < p->iov.size)) {
             ccid_bulk_in_release(s);
         }
@@ -1439,8 +1440,7 @@ static bool ccid_pre_save(void *opaque, Error **errp)
 {
     USBCCIDState *s = opaque;
 
-    if (s->pending_answers_num || s->bulk_in_pending_num ||
-        s->current_bulk_in) {
+    if (s->pending_answers_num || s->bulk_in_pending_num) {
         error_setg(errp, "usb-ccid has pending queue state which cannot be "
                    "migrated safely");
         return false;

-- 
2.56.0.rc0.29.g47ce80527c56


