Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58807FED2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aFu-0004Xa-Io; Thu, 12 Mar 2026 03:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFs-0004X7-Cs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFq-0008G0-93
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCykG0adtQpHg4+q0MaYgweYslGKZ/kfSJSMGgAR2x4=;
 b=USHd3xJ+48x9jdjAC8v9hi2WwBWclc/U4iia9YqC1CYDewj6Uev+pNa2e+kJo9eUsSBnHn
 HghrCZI8LiWB2zEbgc8ou2U0dl+zkyISXxsm6YLrcO7oBU/pFBb/OP4M1lpVEyCj9pXAGE
 M2OtMLVeU9Jjv5L6v2XnH0GvZgL/e2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-cqp-gFC6M82O75-sZUb5Kw-1; Thu,
 12 Mar 2026 03:14:38 -0400
X-MC-Unique: cqp-gFC6M82O75-sZUb5Kw-1
X-Mimecast-MFC-AGG-ID: cqp-gFC6M82O75-sZUb5Kw_1773299677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D94D18005B0; Thu, 12 Mar 2026 07:14:37 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE1C4180058C; Thu, 12 Mar 2026 07:14:33 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 2/9] net/filter-redirector: add role helpers for AF_PACKET
 paths
Date: Thu, 12 Mar 2026 15:09:30 +0800
Message-ID: <20260312071415.1836655-3-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Add helpers that tell whether a redirector instance should create an
AF_PACKET capture socket or inject socket. Later commits use them when
wiring up the TAP datapath.

While here, let the indev-only inject role enable
allow_send_when_stopped, and guard
filter_redirector_vm_state_change() against a missing nc.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index ab711e8835..376b7da025 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
+#include "net/vhost_net.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "block/aio-wait.h"
@@ -62,6 +63,24 @@ typedef struct FilterSendCo {
     int ret;
 } FilterSendCo;
 
+static bool filter_redirector_use_inject_netdev(NetFilterState *nf)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+
+    return s->indev && !s->outdev &&
+           nf->netdev &&
+           get_vhost_net(nf->netdev);
+}
+
+static bool filter_redirector_use_capture_netdev(NetFilterState *nf)
+{
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+
+    return s->outdev && !s->indev &&
+           nf->netdev &&
+           get_vhost_net(nf->netdev);
+}
+
 static int _filter_send(MirrorState *s,
                        char *buf,
                        ssize_t size)
@@ -318,13 +337,13 @@ filter_redirector_refresh_allow_send_when_stopped(NetFilterState *nf)
 
     /*
      * Allow sending when stopped if enable_when_stopped is set and we have
-     * an outdev. This must be independent of nf->on (status) so that packets
-     * can still flow through the filter chain to other filters even when this
-     * redirector is disabled. Otherwise, tap_send() will disable read_poll
-     * when qemu_can_send_packet() returns false, preventing further packet
-     * processing.
+     * a redirector output endpoint and the redirector is enabled.
+     * Keeping this active while redirector status=off can unexpectedly
+     * drain packets in migration stop windows and perturb vhost ring state.
      */
-    nc->allow_send_when_stopped = (s->enable_when_stopped && s->outdev);
+    nc->allow_send_when_stopped = (s->enable_when_stopped &&
+                                   (s->outdev ||
+                                    filter_redirector_use_inject_netdev(nf)));
 }
 
 static void filter_redirector_vm_state_change(void *opaque, bool running,
@@ -334,7 +353,7 @@ static void filter_redirector_vm_state_change(void *opaque, bool running,
     MirrorState *s = FILTER_REDIRECTOR(nf);
     NetClientState *nc = nf->netdev;
 
-    if (!running && s->enable_when_stopped && nc->info->read_poll) {
+    if (!running && nc && s->enable_when_stopped && nc->info->read_poll) {
         nc->info->read_poll(nc, true);
     }
 }
-- 
2.52.0


