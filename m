Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97B1C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wozAr-0008Jy-EN; Wed, 29 Jul 2026 03:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wozAq-0008Jb-GA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wozAo-00020k-Pe
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785311873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YOZULDzniFj/gLf5QOhTIR4ke0Ws5kBaUguwO34pDsM=;
 b=hEbyikAMYR17Ss9aqQco3+S7NR7/rn1ZUrs2IUPh7U0W2KPSMLemjeOWUH3xg5QiYs+Tdy
 OZ6khj05F8V4rw3GZcPlEOO/IvT1gqpkvVyDHt7Zo0XvBSFuYXRGORUuhzJyvbz8BSUECt
 klQ+D9poiY/0ETfogWXAdiG5HkuBVcw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-BPl52zrpM8Kk-4MhG7L-mw-1; Wed,
 29 Jul 2026 03:57:50 -0400
X-MC-Unique: BPl52zrpM8Kk-4MhG7L-mw-1
X-Mimecast-MFC-AGG-ID: BPl52zrpM8Kk-4MhG7L-mw_1785311870
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0895C180048E
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:57:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E478B300019F; Wed, 29 Jul 2026 07:57:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/usb/dev-smartcard-reader: fix OOB read from pending
 bulk-in ring
Date: Wed, 29 Jul 2026 11:57:43 +0400
Message-ID: <20260729075743.333920-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
active, but the slot is only truly free after ccid_bulk_in_release().  A
guest can fill all 8 ring slots, partially read one (leaving pos
non-zero), then send another command whose response reuses the active
slot. The stale pos > new len makes the uint32_t subtraction in
ccid_bulk_in_copy_to_guest() wrap, reading past data[].

Move the decrement to ccid_bulk_in_release() so the slot stays busy
until then. Add an assert(pos <= len) before the substraction.

In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
host never has more than one command in flight and the ring never fills.

Fixes: CVE-2026-18204
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
Reported-by: Warisjeet Singh <sinxx198@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 964c142d1066..5f8b95be46b2 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -580,6 +580,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
     assert(s->current_bulk_in != NULL);
     s->current_bulk_in->pos = 0;
     s->current_bulk_in = NULL;
+    s->bulk_in_pending_num--;
 }
 
 static void ccid_bulk_in_get(USBCCIDState *s)
@@ -587,8 +588,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
     if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
         return;
     }
-    assert(s->bulk_in_pending_num > 0);
-    s->bulk_in_pending_num--;
     s->current_bulk_in =
         &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
 }
@@ -1078,6 +1077,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
 
     ccid_bulk_in_get(s);
     if (s->current_bulk_in != NULL) {
+        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
         len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
                   p->iov.size);
         if (len) {
-- 
2.55.0


