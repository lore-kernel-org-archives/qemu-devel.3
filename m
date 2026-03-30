Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4319CFB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78dM-0005P4-4B; Mon, 30 Mar 2026 05:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dI-0005Nj-8Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dF-00009n-Gl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpaQMvAeBNymiB0YG0aOQ6XAIGIw2HM3uBe02GRoBK0=;
 b=hx3Gt88GE4dGBs01eQ49/2RdGLa8woam5V8y/qHbspbrjYSZce8CcOrW9fvmi1ht4bZ4W/
 aJhYc/5Nvpu/wvPz8R/jxSn0WuwavxuiyTmagOpbjcQjM1j7gzjWhluxvASdkleoo3Kcsu
 W14AeKW3ahYCPu1RgpM56bUJhWByRAY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-TtB7zClROKezXDPPt7hBWw-1; Mon,
 30 Mar 2026 05:09:59 -0400
X-MC-Unique: TtB7zClROKezXDPPt7hBWw-1
X-Mimecast-MFC-AGG-ID: TtB7zClROKezXDPPt7hBWw_1774861798
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E367218005BA; Mon, 30 Mar 2026 09:09:57 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95C0A30001A2; Mon, 30 Mar 2026 09:09:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 1/7] net/filter-mirror: keep mirroring while stopped
Date: Mon, 30 Mar 2026 16:58:09 +0800
Message-ID: <20260330090944.1008027-2-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
References: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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
index c1b9dabacd..ab711e8835 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -267,6 +267,10 @@ static void filter_redirector_cleanup(NetFilterState *nf)
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
     qemu_del_vm_change_state_handler(s->vmsentry);
+
+    if (nf->netdev) {
+        nf->netdev->allow_send_when_stopped = 0;
+    }
 }
 
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
@@ -302,6 +306,27 @@ static void redirector_rs_finalize(SocketReadState *rs)
     redirector_to_filter(nf, rs->buf, rs->packet_len);
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
@@ -389,24 +414,30 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
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
@@ -518,6 +549,8 @@ static void filter_redirector_set_enable_when_stopped(Object *obj,
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


