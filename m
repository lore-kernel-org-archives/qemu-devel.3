Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A010D132A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tn4-0002Wn-I5; Mon, 04 Nov 2024 04:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tn1-0002W2-Dv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tmz-0002l7-TX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9v8SCMDlF3R7yXlMspK48ptRVyriV+ZxTnL5VAk4Og=;
 b=DklacSbBAjSg7iGhCw1y/oTRnVXYF5jfkWKxm6+r8ADe90ZEptOF6wIplAlgxvctGLU0Er
 vNg8oHbJjp7EP89kXlcIAzn5O2rsYs4PNt/DmnBy/dBy2TkmHupQnLCi1oqZDUXArUzBsd
 ekn6Zb8Ewz5wv1Saxlim4fgJxipj8Pk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-DfDBM4xFMwm_ULYFuPhdlg-1; Mon,
 04 Nov 2024 04:54:21 -0500
X-MC-Unique: DfDBM4xFMwm_ULYFuPhdlg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FAC21956096; Mon,  4 Nov 2024 09:54:20 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7EE0300019B; Mon,  4 Nov 2024 09:54:18 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 3/4] qga: Don't daemonize before channel is initialized
Date: Mon,  4 Nov 2024 10:54:09 +0100
Message-ID: <699917b7868f7fbae3c076f013850ba9f8a5cb8d.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
References: <cover.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the agent is set to daemonize but for whatever reason fails to
init the channel, the error message is lost. Worse, the agent
daemonizes needlessly and returns success. For instance:

  # qemu-ga -m virtio-serial \
            -p /dev/nonexistent_device \
            -f /run/qemu-ga.pid \
            -t /run \
            -d
  # echo $?
  0

This makes it needlessly hard for init scripts to detect a
failure in qemu-ga startup. Though, they shouldn't pass '-d' in
the first place.

Let's open the channel first and only after that become a daemon.

Related bug: https://bugs.gentoo.org/810628

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/main.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index c003aacbe0..6240845f39 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1430,7 +1430,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
         if (config->daemonize) {
             /* delay opening/locking of pidfile till filesystems are unfrozen */
             s->deferred_options.pid_filepath = config->pid_filepath;
-            become_daemon(NULL);
         }
         if (config->log_filepath) {
             /* delay opening the log file till filesystems are unfrozen */
@@ -1438,9 +1437,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
         }
         ga_disable_logging(s);
     } else {
-        if (config->daemonize) {
-            become_daemon(config->pid_filepath);
-        }
         if (config->log_filepath) {
             FILE *log_file = ga_open_logfile(config->log_filepath);
             if (!log_file) {
@@ -1487,6 +1483,20 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
 
     ga_apply_command_filters(s);
 
+    if (!channel_init(s, s->config->method, s->config->channel_path,
+                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
+        g_critical("failed to initialize guest agent channel");
+        return NULL;
+    }
+
+    if (config->daemonize) {
+        if (ga_is_frozen(s)) {
+            become_daemon(NULL);
+        } else {
+            become_daemon(config->pid_filepath);
+        }
+    }
+
     ga_state = s;
     return s;
 }
@@ -1513,12 +1523,6 @@ static void cleanup_agent(GAState *s)
 
 static int run_agent_once(GAState *s)
 {
-    if (!channel_init(s, s->config->method, s->config->channel_path,
-                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
-        g_critical("failed to initialize guest agent channel");
-        return EXIT_FAILURE;
-    }
-
     g_main_loop_run(s->main_loop);
 
     if (s->channel) {
-- 
2.45.2


