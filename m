Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78127EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigp-0004jT-Ub; Sat, 07 Feb 2026 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voiga-0003t2-AZ
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigY-0003IZ-Iy
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bUnt00SkKmzXgkXF9v5vh1BRVBWlK52wAXmRAjVjC8=;
 b=IV5lEaf/K/i0hG/2K1kpjj+/eO2yG2FjU9GBrCrNnJIxkohqN/Ais9tnmQiXL1+RCbn/QK
 +H3mihYN4y1qNBllLjHb+BZGFCR1KppMf7OCBoEhAKRYBXLcFJc2vQd6L+b9id5vc6dSRh
 oppPNp/WFoVeXD5EiW0xJuURHqSHD9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-zGtJ3BM1OF6Wrjf-WIMqXA-1; Sat,
 07 Feb 2026 08:49:16 -0500
X-MC-Unique: zGtJ3BM1OF6Wrjf-WIMqXA-1
X-Mimecast-MFC-AGG-ID: zGtJ3BM1OF6Wrjf-WIMqXA_1770472155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F6B31956096; Sat,  7 Feb 2026 13:49:15 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2467F18004AD; Sat,  7 Feb 2026 13:49:11 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 12/12] net/filter-mirror: keep mirroring while stopped
Date: Sat,  7 Feb 2026 21:47:28 +0800
Message-ID: <20260207134728.1495932-12-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During migration pre-switchover the VM runstate is stopped, which can cause tap read_poll to be disabled (qemu_send_packet_async() returns 0) and incoming tap frames stop reaching the redirector/mirror filter.

Re-enable tap read_poll when swredir is turned on while stopped, and allow the redirector outdev path to keep draining packets while stopped by adding a per-NetClientState allow_send_when_stopped bit used by qemu_can_send_packet().

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h   |  6 ++++++
 net/filter-mirror.c | 49 +++++++++++++++++++++++++++++++++++++--------
 net/net.c           | 10 ++++++++-
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index d2b2e6fc44..bde052acbb 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -126,6 +126,12 @@ struct NetClientState {
     char *name;
     char info_str[256];
     unsigned receive_disabled : 1;
+    /*
+     * Allow this sender to keep draining packets while VM is stopped.
+     * Used by COLO-style pre-switchover mirroring, where netfilter needs to
+     * see incoming tap frames even when runstate is not running.
+     */
+    unsigned allow_send_when_stopped:1;
     NetClientDestructor *destructor;
     unsigned int queue_index;
     unsigned rxfilter_notify_enabled:1;
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index de32028246..ad99bebec6 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -268,6 +268,10 @@ static void filter_redirector_cleanup(NetFilterState *nf)
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
     qemu_del_vm_change_state_handler(s->vmsentry);
+
+    if (nf->netdev) {
+        nf->netdev->allow_send_when_stopped = 0;
+    }
 }
 
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
@@ -322,6 +326,27 @@ static void redirector_rs_finalize(SocketReadState *rs)
     redirector_to_filter(nf, QEMU_NET_PACKET_FLAG_RAW, buf, len);
 }
 
+static void
+filter_redirector_refresh_allow_send_when_stopped(NetFilterState *nf)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    NetClientState *nc = nf->netdev;
+
+    if (!nc) {
+        return;
+    }
+
+    /*
+     * Allow sending when stopped if enable_when_stopped is set and we have
+     * an outdev. This must be independent of nf->on (status) so that packets
+     * can still flow through the filter chain to other filters even when this
+     * redirector is disabled. Otherwise, tap_send() will disable read_poll
+     * when qemu_can_send_packet() returns false, preventing further packet
+     * processing.
+     */
+    nc->allow_send_when_stopped = (s->enable_when_stopped && s->outdev);
+}
+
 static void filter_redirector_vm_state_change(void *opaque, bool running,
                                               RunState state)
 {
@@ -409,24 +434,30 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         filter_redirector_vm_state_change, nf);
 
     filter_redirector_maybe_enable_read_poll(nf);
+
+    filter_redirector_refresh_allow_send_when_stopped(nf);
 }
 
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
 
-    if (!s->indev) {
-        return;
+    if (s->indev) {
+        if (nf->on) {
+            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
+                                     redirector_chr_read, redirector_chr_event,
+                                     NULL, nf, NULL, true);
+        } else {
+            qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
+                                     NULL, NULL, NULL, true);
+        }
     }
 
     if (nf->on) {
-        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
-                                 redirector_chr_read, redirector_chr_event,
-                                 NULL, nf, NULL, true);
-    } else {
-        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
-                                 NULL, NULL, NULL, true);
+        filter_redirector_maybe_enable_read_poll(nf);
     }
+
+    filter_redirector_refresh_allow_send_when_stopped(nf);
 }
 
 static char *filter_redirector_get_indev(Object *obj, Error **errp)
@@ -538,6 +569,8 @@ static void filter_redirector_set_enable_when_stopped(Object *obj,
     if (value) {
         filter_redirector_maybe_enable_read_poll(nf);
     }
+
+    filter_redirector_refresh_allow_send_when_stopped(nf);
 }
 
 static void filter_mirror_class_init(ObjectClass *oc, const void *data)
diff --git a/net/net.c b/net/net.c
index b15f4db65e..06f54eebb4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -632,7 +632,7 @@ int qemu_can_send_packet(NetClientState *sender)
 {
     int vm_running = runstate_is_running();
 
-    if (!vm_running) {
+    if (!vm_running && !sender->allow_send_when_stopped) {
         return 0;
     }
 
@@ -640,6 +640,14 @@ int qemu_can_send_packet(NetClientState *sender)
         return 1;
     }
 
+    /*
+     * When VM is stopped (e.g. migration pre-switchover), allow draining tap
+     * packets so netfilters (redirector/mirror) can operate.
+     */
+    if (!vm_running && sender->allow_send_when_stopped) {
+        return 1;
+    }
+
     return qemu_can_receive_packet(sender->peer);
 }
 
-- 
2.52.0


