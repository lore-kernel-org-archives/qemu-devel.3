Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B371C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKp7-00007B-2Z; Mon, 27 Jul 2026 08:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKok-0008Q2-3e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woKog-0004Yw-2W
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785156741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n70EVbkyj4FsnRI25X971EdwRrzj2ROVm/gCaW+V0+w=;
 b=ZyrdS/bRmww4yzbVt5dywkVkQDwWwA4pIbtw7+fHER0VWQNFEN4jnZOAadkW7ka8Ee8Qg8
 34zVZrSlgdyD1pH8rYjw6NWhFawcT6bhgww/QS4KByxz0REYT0TsGZneUgbAPe4GY16aDV
 BRRQVRT+gwx68jLx5cnT+oLdLX4XRQo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-hxOcB7YIPP2Kkg-DY_cTPQ-1; Mon,
 27 Jul 2026 08:52:17 -0400
X-MC-Unique: hxOcB7YIPP2Kkg-DY_cTPQ-1
X-Mimecast-MFC-AGG-ID: hxOcB7YIPP2Kkg-DY_cTPQ_1785156736
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35AB91956070; Mon, 27 Jul 2026 12:52:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6047A1955F7F; Mon, 27 Jul 2026 12:52:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tristan Madani <tristan@talencesecurity.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
Date: Mon, 27 Jul 2026 14:52:04 +0200
Message-ID: <20260727125207.646148-3-thuth@redhat.com>
In-Reply-To: <20260727125207.646148-1-thuth@redhat.com>
References: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Thomas Huth <thuth@redhat.com>

The stream ID is under control of the guest, and some spots in the
code currently use it for indexing into the status3[] array without
checking it for being in range first, so the code accesses the heap
beyond the limit of the status3 array.

Since our status delivery code depends on having a valid stream ID,
we must not try to generate a fake sense code in this situation.
Simply log a guest error and return early in usb_uas_command().

And to make sure that we really cannot access the status3[] array
beyond its limit anymore, add some assert() statements in the
affected functions, too.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
Reported-by: Reported-by: huntr bubble
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260720134809.573757-1-thuth@redhat.com>
---
 hw/usb/dev-uas.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 8576dfec96f..963c0433b38 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -362,6 +362,7 @@ static void usb_uas_send_status_bh(void *opaque)
 
     while ((st = QTAILQ_FIRST(&uas->results)) != NULL) {
         if (uas_using_streams(uas)) {
+            assert(st->stream <= UAS_MAX_STREAMS);
             p = uas->status3[st->stream];
             uas->status3[st->stream] = NULL;
         } else {
@@ -383,8 +384,14 @@ static void usb_uas_send_status_bh(void *opaque)
 
 static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
 {
-    USBPacket *p = uas_using_streams(uas) ?
-        uas->status3[st->stream] : uas->status2;
+    USBPacket *p;
+
+    if (uas_using_streams(uas)) {
+        assert(st->stream <= UAS_MAX_STREAMS);
+        p = uas->status3[st->stream];
+    } else {
+        p = uas->status2;
+    }
 
     st->length += length;
     QTAILQ_INSERT_TAIL(&uas->results, st, next);
@@ -700,14 +707,22 @@ static void usb_uas_command(UASDevice *uas, uas_iu *iu)
     uint16_t tag = be16_to_cpu(iu->hdr.tag);
     size_t cdb_len = sizeof(iu->command.cdb) + iu->command.add_cdb_length;
 
+    if (uas_using_streams(uas) && tag > UAS_MAX_STREAMS) {
+        /*
+         * Our status delivery only works with valid tags, so in case the
+         * stream ID is out of bounds, we have to return immediately here
+         * without sending a fake sense_code_INVALID_TAG to the guest.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "invalid tag 0x%x for USB UAS command\n", tag);
+        return;
+    }
+
     if (iu->command.add_cdb_length > 0) {
         qemu_log_mask(LOG_UNIMP, "additional adb length not yet supported\n");
         goto unsupported_len;
     }
 
-    if (uas_using_streams(uas) && tag > UAS_MAX_STREAMS) {
-        goto invalid_tag;
-    }
     req = usb_uas_find_request(uas, tag);
     if (req) {
         goto overlapped_tag;
@@ -744,10 +759,6 @@ unsupported_len:
     usb_uas_queue_fake_sense(uas, tag, sense_code_INVALID_PARAM_VALUE);
     return;
 
-invalid_tag:
-    usb_uas_queue_fake_sense(uas, tag, sense_code_INVALID_TAG);
-    return;
-
 overlapped_tag:
     usb_uas_queue_fake_sense(uas, tag, sense_code_OVERLAPPED_COMMANDS);
     return;
-- 
2.55.0


