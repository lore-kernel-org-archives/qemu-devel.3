Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F44D6261A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGAf-0005Fe-0s; Fri, 23 Jan 2026 07:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAO-00053Z-Es
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vjGAL-00052V-Ly
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769170888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4Dq+fUO8dxbp9hG+7gZc96RrwC1q1Qc8B/brKxVYUs=;
 b=YFrrRRB4o+24apeEw7ntl6l8IIpyUNvhYp3S3+M+OkXq8CU1E5TYa2CVDNsyyahweUOHQw
 4xR3nC6tN3oZenll+2sPa4cITn5pXyMEDJMlKY0pQvYsmU701hp8BU40BDA/qc+BVINdw6
 UF3fMBhxklOnUBxIQBgfxM8fx8W9/ZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-9gdjj7vOMX-GHC9piksX5Q-1; Fri,
 23 Jan 2026 07:21:26 -0500
X-MC-Unique: 9gdjj7vOMX-GHC9piksX5Q-1
X-Mimecast-MFC-AGG-ID: 9gdjj7vOMX-GHC9piksX5Q_1769170885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44CF8195608D; Fri, 23 Jan 2026 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8025D30002D1; Fri, 23 Jan 2026 12:21:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/13] net/tap: rework scripts handling
Date: Fri, 23 Jan 2026 20:20:54 +0800
Message-ID: <20260123122102.51422-6-jasowang@redhat.com>
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

Simplify handling scripts: parse all these "no" and '\0' once, and
then keep simpler logic for net_tap_open() and net_init_tap_one(): NULL
means no script to run, otherwise run script.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 8182f39851..c7d8e1a3be 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -91,6 +91,21 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static char *tap_parse_script(const char *script_arg, const char *default_path)
+{
+    g_autofree char *res = g_strdup(script_arg);
+
+    if (!res) {
+        res = get_relocated_path(default_path);
+    }
+
+    if (res[0] == '\0' || strcmp(res, "no") == 0) {
+        return NULL;
+    }
+
+    return g_steal_pointer(&res);
+}
+
 static void tap_update_fd_handler(TAPState *s)
 {
     qemu_set_fd_handler(s->fd,
@@ -676,9 +691,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
         return -1;
     }
 
-    if (setup_script &&
-        setup_script[0] != '\0' &&
-        strcmp(setup_script, "no") != 0) {
+    if (setup_script) {
         launch_script(setup_script, ifname, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -714,9 +727,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         qemu_set_info_str(&s->nc, "helper=%s", tap->helper);
     } else {
         qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
-                          script, downscript);
+                          script ?: "no", downscript ?: "no");
 
-        if (strcmp(downscript, "no") != 0) {
+        if (downscript) {
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
@@ -970,23 +983,16 @@ free_fail:
             return -1;
         }
     } else {
-        const char *script = tap->script;
-        const char *downscript = tap->downscript;
-        g_autofree char *default_script = NULL;
-        g_autofree char *default_downscript = NULL;
+        g_autofree char *script =
+            tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
+        g_autofree char *downscript =
+            tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
         }
 
-        if (!script) {
-            script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
-        }
-        if (!downscript) {
-            downscript = default_downscript =
-                                 get_relocated_path(DEFAULT_NETWORK_DOWN_SCRIPT);
-        }
-
         if (tap->ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
         } else {
@@ -994,7 +1000,7 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
@@ -1009,8 +1015,8 @@ free_fail:
             }
 
             net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
+                             i >= 1 ? NULL : script,
+                             i >= 1 ? NULL : downscript,
                              vhostfdname, vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
-- 
2.42.0


