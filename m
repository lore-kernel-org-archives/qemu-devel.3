Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E62C56203
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraAn-0005lO-BF; Wed, 05 Aug 2026 07:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAm-0005l5-0T
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAk-0006uW-DJ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Osfx8gZJrB7dh/sUZUFu7wXoAjXOKWpsoAdI1+KIrJ4=;
 b=hfkQQAVe3W9SBSYKN2G8q0I7WNFS1LUIp2AmsYq4SJ+LkjGMcvEKohqw1cqE6CesdmS7Y4
 DKEBY44nheQCKdsChjxpzU5RWZFOEYhT+qqbCyoYV83zI+Mh1w+GDsbtdnUHggYJLKQqgB
 fFR+8wW17P7v7cZanXiBu64yRqBnJfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-eHNH-eN9Pe6CPG8v2WK9tg-1; Wed,
 05 Aug 2026 07:52:27 -0400
X-MC-Unique: eHNH-eN9Pe6CPG8v2WK9tg-1
X-Mimecast-MFC-AGG-ID: eHNH-eN9Pe6CPG8v2WK9tg_1785930746
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8811A1955DBE
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:52:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC5C6422; Wed,  5 Aug 2026 11:52:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:57 +0400
Subject: [PATCH 07/27] hw/usb/dev-smartcard-reader: block migration with
 pending queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-7-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xzskyDLi6FbuDSwTo5I/zb0dvLyg/dAAIh1/km1p3Xo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOs4IDy37k+DXBdi2iKm1NJxCZ/4f38m7avz
 euH/rcoaVGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5aWoD/0c75VSrVEZNCourY5CMQbXlBtUuj+nXf82Nnrj28MhNvl++st3cDZn3CG3oP80J9SQps6
 M40vRmHHflhaotIb9qAAOTZV0NDqxZqOXyjtPDIrK/O39r/gGVjAGFd9Y96bjKjCGaNoITtbLoB
 aSBrYZatHb6TMK2eroHqi2Mpsc4I5umx0HJAbveZXNobvf7xAOP6I68J1LFP3SYgSw6QcLmpgea
 hsAmTPSgtXuz7G/rpmBWP3RKeBwR5WTRE728ODmVbw2wtEpKbUnMBzpQis+njTZFksKGyhZQ1bO
 mlkNxnhKWhwRSK0BMGO6xMORM4SrO6SEIjfTk4zuFiNCtjHnA4mEZFqba7D9XwW0KNUd8YcxHYP
 ZOYNkNIQ8uDkUMWe35Ws1laMO5+Nw+Kxm4W5s/6QEXo/kfYZWzcn63kb/JO8pimBlr2auq4rr0W
 SAJ7JAkg6kbuzt/FoFy0iHDVkA9h1K/MO0UvM9cIzmVJURzbrHt0RU30PwlFRBIYkg9uhvE7Ewp
 oq6BS/cb68Nq2BZvr1nPw1dnY25hYsOrkHj8SQLfDeKtDjaGrZuysiPGUhdpWRWyvIpkG+/fUP+
 RuVncv6zJZ9SvGGCcRqkwC5SBKcAIxkp9W3U/qfLfzj6y0WOLsZFGydZ4QK7ykzjz6RrP1qnJXp
 bAqxXLRyLFkwS6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Several queue state fields are not included in the vmstate:
bulk_in_pending_num, pending_answers_start, and pending_answers_end.
Also if current_bulk_in != NULL (ongoing transfer). Migrating while any
of these are non-zero produces inconsistent state on the destination.

Rather than extending the vmstate (which would require a version bump
and migration compat machinery), block migration when the queues are
non-empty. In practice this window is very short since the CMD_SLOT_BUSY
enforcement limits pending_answers to at most one entry.

Convert pre_save to the pre_save_errp form so it can report the error
cleanly. Follow up patches will add migration blocker and new migration
version.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index a147cd19f388..1b8f0e10e172 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1377,13 +1377,20 @@ static int ccid_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static int ccid_pre_save(void *opaque)
+static bool ccid_pre_save(void *opaque, Error **errp)
 {
     USBCCIDState *s = opaque;
 
+    if (s->pending_answers_num || s->bulk_in_pending_num ||
+        s->current_bulk_in) {
+        error_setg(errp, "usb-ccid has pending queue state which cannot be "
+                   "migrated safely");
+        return false;
+    }
+
     s->state_vmstate = s->dev.state;
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription bulk_in_vmstate = {
@@ -1426,7 +1433,7 @@ static const VMStateDescription ccid_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ccid_post_load,
-    .pre_save = ccid_pre_save,
+    .pre_save_errp = ccid_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(dev, USBCCIDState, 1, usb_device_vmstate, USBDevice),
         VMSTATE_UINT8(debug, USBCCIDState),

-- 
2.55.0


