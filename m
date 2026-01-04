Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFDBC2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 07:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcIwY-00084Z-US; Sun, 04 Jan 2026 02:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwV-00083U-U6
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwT-0002Ip-TR
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767513264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVPAboRi8GsKhqIEX/T0rUfTBNXcx/r1uGbvlJ8zEgw=;
 b=Ma2POqDnYukHy6m5GazP+Yw5lppMi5OuRmjiwnOzTO0cmr58SkNu1/JLHSq9EyViqx/WRg
 Oxb5ZNxuyqwBPOcOMcwHeItWp/kPBxQaTMSIowITFKuz0dV6zvNpD6zn6KvFQEoHzMi93G
 JskqufFAwwj6ByGYZ4AL1vQ/3znChX4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-w250x8OVM_WQmWH1qtkVTA-1; Sun,
 04 Jan 2026 02:54:23 -0500
X-MC-Unique: w250x8OVM_WQmWH1qtkVTA-1
X-Mimecast-MFC-AGG-ID: w250x8OVM_WQmWH1qtkVTA_1767513262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBF341956050; Sun,  4 Jan 2026 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19FE2180044F; Sun,  4 Jan 2026 07:54:18 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: zhangckid@gmail.com, lizhijian@fujitsu.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: lulu@redhat.com
Subject: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
Date: Sun,  4 Jan 2026 15:54:10 +0800
Message-ID: <20260104075412.1262-2-jasowang@redhat.com>
In-Reply-To: <20260104075412.1262-1-jasowang@redhat.com>
References: <20260104075412.1262-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, filter-redirector does not implement the status_changed
callback, which means the 'status' property cannot be used to
dynamically enable/disable the filter at runtime. When status is
set to 'off' via QMP/HMP, the filter still receives data from the
indev chardev because the chardev handlers remain registered.

This patch adds proper support for the 'status' property:

1. Implement filter_redirector_status_changed() callback:
   - When status changes to 'off': remove chardev read handlers
   - When status changes to 'on': re-register chardev handlers
     (only if chardev is already open)

2. Update filter_redirector_setup() to respect initial status:
   - If filter is created with status=off, do not register handlers
   - This allows creating disabled filters via command line or QMP

3. Handle chardev OPENED/CLOSED events to re-arm handlers on reconnect:
   - Keep the chr_event callback installed on CLOSE so a later OPENED
     can re-register the read handlers when nf->on
   - Use qemu_chr_fe_set_handlers_full(..., set_open=false, sync_state=false)
     instead of qemu_chr_fe_set_handlers() because the latter forces
     sync_state=true and may emit CHR_EVENT_OPENED for an already-open
     backend. Doing that from inside the chr_event callback would cause
     recursive/re-entrant OPENED handling.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 8e01e98f40..aa2ab452fd 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaque, QEMUChrEvent event)
     MirrorState *s = FILTER_REDIRECTOR(nf);
 
     switch (event) {
+    case CHR_EVENT_OPENED:
+        if (nf->on) {
+            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector_chr_can_read,
+                                          redirector_chr_read, redirector_chr_event,
+                                          NULL, nf, NULL, false, false);
+        }
+        break;
     case CHR_EVENT_CLOSED:
-        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
-                                 NULL, NULL, NULL, true);
+        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, redirector_chr_event,
+                                      NULL, nf, NULL, false, false);
         break;
     default:
         break;
@@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
             return;
         }
 
-        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
-                                 redirector_chr_read, redirector_chr_event,
-                                 NULL, nf, NULL, true);
+        if (nf->on) {
+            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
+                                     redirector_chr_read, redirector_chr_event,
+                                     NULL, nf, NULL, true);
+        }
     }
 
     if (s->outdev) {
@@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
     }
 }
 
+static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+
+    if (!s->indev) {
+        return;
+    }
+
+    if (nf->on) {
+        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
+                                 redirector_chr_read, redirector_chr_event,
+                                 NULL, nf, NULL, true);
+    } else {
+        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
+                                 NULL, NULL, NULL, true);
+    }
+}
+
 static char *filter_redirector_get_indev(Object *obj, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
@@ -440,6 +467,7 @@ static void filter_redirector_class_init(ObjectClass *oc, const void *data)
     nfc->setup = filter_redirector_setup;
     nfc->cleanup = filter_redirector_cleanup;
     nfc->receive_iov = filter_redirector_receive_iov;
+    nfc->status_changed = filter_redirector_status_changed;
 }
 
 static void filter_mirror_init(Object *obj)
-- 
2.34.1


