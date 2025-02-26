Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107CC021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGQA-0007Il-N4; Wed, 26 Feb 2025 07:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGQ0-0007FT-Nr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPy-0000gj-79
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740572496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xxo1EoxclsZHDgyMTn/59QwyUvAbBAPEu3qtTq1RmvM=;
 b=Z98iggH3y6xKIuUcTQjSlkcbm1mT7yCpWSQfn/7Q0ktTKt1PLgn3YEq0bRQNNqFsc7KzIs
 6VLyNvMjYNKq13VT75qL2HyWKFbSNSnNzh0GKa49zFc0mAY5hC+h5s0oVeLPAh0hTH0GzG
 sijgUPYqy+2u3vWTBzubupAfF7qfVp4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-LvGWVOcoO1iAF9UexXgb8w-1; Wed,
 26 Feb 2025 07:21:35 -0500
X-MC-Unique: LvGWVOcoO1iAF9UexXgb8w-1
X-Mimecast-MFC-AGG-ID: LvGWVOcoO1iAF9UexXgb8w_1740572494
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A58F19039C2; Wed, 26 Feb 2025 12:21:33 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.227.242])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECA2C19560AE; Wed, 26 Feb 2025 12:21:31 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/3] qga: Don't daemonize before channel is initialized
Date: Wed, 26 Feb 2025 14:21:20 +0200
Message-ID: <20250226122120.85790-4-kkostiuk@redhat.com>
In-Reply-To: <20250226122120.85790-1-kkostiuk@redhat.com>
References: <20250226122120.85790-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Michal Privoznik <mprivozn@redhat.com>

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
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <7a42b0cbda5c7e01cf76bc1b29a1210cd018fa78.1736261360.git.mprivozn@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index eccfa33871..72c39b042f 100644
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
2.48.1


