Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F8BD6261A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGAq-0005Pg-G8; Fri, 23 Jan 2026 07:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAT-000569-JQ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAR-00053z-90
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRG2QgvHCpXDQBjeUQQjipXHIFMKfDOPRE3sdL4JVxk=;
 b=fupIrAbBVLCMX6Ni4/aC069yqRwynDpPBoCdl0QL27BP44nCJdKr2uJL3aQ42Pa1qNULtU
 0IeLVCsVdKW0SRimrUpvP6adt5eHK4HLqTqOPiBDP7oHgUo/d+wCFlY2QZAnn7ki6svtJA
 GdgSH/Nq47bDflXFvuVibCAfP4XLETU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-JWYKmzRlMV-a5pvkngsanA-1; Fri,
 23 Jan 2026 07:21:31 -0500
X-MC-Unique: JWYKmzRlMV-a5pvkngsanA-1
X-Mimecast-MFC-AGG-ID: JWYKmzRlMV-a5pvkngsanA_1769170890
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 734DF1944EA8; Fri, 23 Jan 2026 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17A9930002D1; Fri, 23 Jan 2026 12:21:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/13] net/tap: setup exit notifier only when needed
Date: Fri, 23 Jan 2026 20:20:55 +0800
Message-ID: <20260123122102.51422-7-jasowang@redhat.com>
In-Reply-To: <20260123122102.51422-1-jasowang@redhat.com>
References: <20260123122102.51422-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

No reason to setup notifier on each queue of multique tap,
when we actually want to run downscript only once.
As well, let's not setup notifier, when downscript is
not enabled (downsciprt="no").

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c7d8e1a3be..5af157164e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -326,11 +326,9 @@ static void tap_exit_notify(Notifier *notifier, void *data)
     TAPState *s = container_of(notifier, TAPState, exit);
     Error *err = NULL;
 
-    if (s->down_script[0]) {
-        launch_script(s->down_script, s->down_script_arg, s->fd, &err);
-        if (err) {
-            error_report_err(err);
-        }
+    launch_script(s->down_script, s->down_script_arg, s->fd, &err);
+    if (err) {
+        error_report_err(err);
     }
 }
 
@@ -346,8 +344,11 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_purge_queued_packets(nc);
 
-    tap_exit_notify(&s->exit, NULL);
-    qemu_remove_exit_notifier(&s->exit);
+    if (s->exit.notify) {
+        tap_exit_notify(&s->exit, NULL);
+        qemu_remove_exit_notifier(&s->exit);
+        s->exit.notify = NULL;
+    }
 
     tap_read_poll(s, false);
     tap_write_poll(s, false);
@@ -443,9 +444,6 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     tap_read_poll(s, true);
     s->vhost_net = NULL;
 
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
-
     return s;
 }
 
@@ -733,6 +731,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
+            s->exit.notify = tap_exit_notify;
+            qemu_add_exit_notifier(&s->exit);
         }
     }
 
-- 
2.42.0


