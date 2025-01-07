Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957BFE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVAwZ-0003Hd-QP; Tue, 07 Jan 2025 09:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tVAwU-0003FZ-68
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tVAwQ-0007k0-Ok
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736261541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykVXfQSv6QdQnvZoPkKQ+tHuBLJ6v9t5jGthxZwquzY=;
 b=fm5Yk34Tj00LkSXy05+sXvYa0qbkcOonhv2bypuIgoUUp/g/EhhQrvdmO/jCIvj7GeUd6k
 wObJr11KAbRMUn/8PE0PfGOevIrs45r1pV4j+n494zcrJZrcpWrLSh9ZQvO50rYVXtj9Wh
 ugoPmKkvJ2NNkanSvmxndDmoEp1gfFc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-YcogWWYFPzGUsxVqSKB9OQ-1; Tue,
 07 Jan 2025 09:52:19 -0500
X-MC-Unique: YcogWWYFPzGUsxVqSKB9OQ-1
X-Mimecast-MFC-AGG-ID: YcogWWYFPzGUsxVqSKB9OQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007A8195609E; Tue,  7 Jan 2025 14:52:19 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C1C33000197; Tue,  7 Jan 2025 14:52:17 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	michael.roth@amd.com,
	jtomko@redhat.com
Subject: [PATCH v3 2/2] qga: Don't daemonize before channel is initialized
Date: Tue,  7 Jan 2025 15:52:07 +0100
Message-ID: <7a42b0cbda5c7e01cf76bc1b29a1210cd018fa78.1736261360.git.mprivozn@redhat.com>
In-Reply-To: <cover.1736261360.git.mprivozn@redhat.com>
References: <cover.1736261360.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Ján Tomko <jtomko@redhat.com>
---
 qga/main.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 68ea7f275a..35f061b5ea 100644
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
@@ -1513,8 +1523,9 @@ static void cleanup_agent(GAState *s)
 
 static int run_agent_once(GAState *s)
 {
-    if (!channel_init(s, s->config->method, s->config->channel_path,
-                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
+    if (!s->channel &&
+        channel_init(s, s->config->method, s->config->channel_path,
+                     s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
         g_critical("failed to initialize guest agent channel");
         return EXIT_FAILURE;
     }
@@ -1523,6 +1534,7 @@ static int run_agent_once(GAState *s)
 
     if (s->channel) {
         ga_channel_free(s->channel);
+        s->channel = NULL;
     }
 
     return EXIT_SUCCESS;
-- 
2.45.2


