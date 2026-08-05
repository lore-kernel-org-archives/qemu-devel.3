Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B16C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraBM-0007ud-OV; Wed, 05 Aug 2026 07:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBL-0007uN-WC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBK-0007JR-I9
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PMTkvaIVO4jhh0ZLegntqLtMpH+bSV5zE9b/jru5SI=;
 b=ecV6u7lk2h3GgvEh2lpdMUkWd/BiHULAIOb3h8v9QpF6IC88TqaaSkFFzJZzQ1mkjGKiJ5
 jaP4SXzqDR1bKKJtACTIOwGXPeqOn25gG3n0vEwscK2OtT07VVkn5ZOMENdFVsSs7yIp65
 uA8CJ3C6zRR3YSi+StYG64CGaJUL4lo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-v9HxG4iZNoO8CIW_g-9Flg-1; Wed,
 05 Aug 2026 07:53:08 -0400
X-MC-Unique: v9HxG4iZNoO8CIW_g-9Flg-1
X-Mimecast-MFC-AGG-ID: v9HxG4iZNoO8CIW_g-9Flg_1785930788
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 079C519560AA
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:53:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6CD3180049F; Wed,  5 Aug 2026 11:53:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:00 +0400
Subject: [PATCH 10/27] hw/usb/dev-smartcard-reader: reset all I/O state on
 device reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-10-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PUVI70oyctTz1sag9yfTLK9ruJyZ7AFi1cPL+bm/MWE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOtQjv4bSKqQGnitCXc1gOq+O4OcFALNHb3g
 17FIU9PZfGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrQAKCRDa6OEJdZac
 5YeyD/9Pd903+XcETamlodI78G5D9tJxOEjCsE1yblGkIT4sAxXJehPZ4iBShWDgAvNxCtW8Wbv
 4beADbBdH27vJ9ZUNB8DMqZnyNriJs924zPOXHoOFB+AM6BF43XVTaamK5XgWPfDcFFb+SSyJ2Y
 NjIy559EBSd3R2kmN7hUdP4RBmGxAwFkMHbSkI6GvgPdnSkDQGSOKcvHtqRWkcKu9Hf9T6db/FH
 P7AxF2haKB7ixaQY3IGNeYEpKybEbKG0Q7JLUVLD9bz6QyxBc/w4lzn1yNGGiDukhc1qkIDflO9
 +y7ypjESTylUT6WoZt80RGe5uxxVIn2r+n22i1a/ciOvhTyUd3MmZG17D/8iTkzQN+nx4SBBHyB
 56XyejvNOjAbymeeoo5MmzvyC3rEotPcTThRWD491wP5jq60oNBv0iwbyPPSjczIKsgccy7nZm7
 AMzCjUI3WXYI6gVPhgNKLmhfMHwGTpw01dgGX6+P+9G6oPoQ5YFzf73S1Cto6SZsa42voKOuPwk
 mZ3c0zRX0FqUrgXSya7R1OOQvy8CZQ54gFnkTew5brWGA2pf/0gpbESCsKHVEl8XOks0ieP1QJg
 R3cEDVIHEoDViKrquPphxdanv6nU0gkZD+0QkA7PAzWe1+NRru9CHqoZw8GwqzCN9E5d7Gl9ORj
 lZbLgEpOOVTJtBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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
---
 hw/usb/dev-smartcard-reader.c | 60 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bed641be4512..12c82c8f6458 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -574,9 +574,16 @@ static void ccid_remove_pending_answer(USBCCIDState *s,
 
 static void ccid_bulk_in_clear(USBCCIDState *s)
 {
+    int i;
+
+    for (i = 0; i < BULK_IN_PENDING_NUM; i++) {
+        s->bulk_in_pending[i].len = 0;
+        s->bulk_in_pending[i].pos = 0;
+    }
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
     s->bulk_in_pending_num = 0;
+    s->current_bulk_in = NULL;
 }
 
 static void ccid_bulk_in_release(USBCCIDState *s)
@@ -621,26 +628,6 @@ static void *ccid_reserve_recv_buf(USBCCIDState *s, uint16_t len)
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
@@ -918,6 +905,31 @@ static void ccid_reset_parameters(USBCCIDState *s)
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
@@ -1349,14 +1361,6 @@ static void ccid_realize(USBDevice *dev, Error **errp)
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
2.55.0


