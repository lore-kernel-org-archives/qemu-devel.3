Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AEAC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Yl-00072l-04; Tue, 23 Jul 2024 03:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yh-0006q5-4N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yf-0000u5-9T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/aLY9j85tIKxahhbA97kPju5Ah6xdvwRuy6dBmevuM=;
 b=B6sGjmo5zV2grm1WuRmDsPgfGgUvz/zEJ/1Pi9Il0+L3YfpDOeP7hWJgXftZFutfIpQQ2U
 RQPTaCj3bfO7h+3uHhfBcectKGOk7GwfypZb5tmuTx2eEgrunEmDU8OFB2euh2kbwBVBdK
 OayhnEvlXeTpuH153+akOaFBgFKWgWk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-zPQ4muykMrqqcokiDXYd9g-1; Tue,
 23 Jul 2024 03:03:32 -0400
X-MC-Unique: zPQ4muykMrqqcokiDXYd9g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCB8519560B0; Tue, 23 Jul 2024 07:03:31 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61C003000192; Tue, 23 Jul 2024 07:03:30 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 18/25] qga: don't disable fsfreeze commands if vss_init fails
Date: Tue, 23 Jul 2024 10:02:44 +0300
Message-ID: <20240723070251.25575-19-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The fsfreeze commands are already written to report an error if
vss_init() fails. Reporting a more specific error message is more
helpful than a generic "command is disabled" message, which cannot
between an admin config decision and lack of platform support.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240712132459.3974109-19-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 18 +++---------------
 qga/main.c           |  4 ++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2533e4c748..5866cc2e3c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1203,7 +1203,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
 {
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
         return 0;
     }
 
@@ -1231,7 +1231,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     Error *local_err = NULL;
 
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
         return 0;
     }
 
@@ -1266,7 +1266,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     int i;
 
     if (!vss_initialized()) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "fsfreeze not possible as VSS failed to initialize");
         return 0;
     }
 
@@ -1961,18 +1961,6 @@ done:
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-    if (!vss_init(true)) {
-        g_debug("vss_init failed, vss commands are going to be disabled");
-        const char *list[] = {
-            "guest-get-fsinfo", "guest-fsfreeze-status",
-            "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
-        char **p = (char **)list;
-
-        while (*p) {
-            blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
-        }
-    }
-
     return blockedrpcs;
 }
 
diff --git a/qga/main.c b/qga/main.c
index f4d5f15bb3..17b6ce18ac 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1395,6 +1395,10 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
                    " '%s': %s", config->state_dir, strerror(errno));
         return NULL;
     }
+
+    if (!vss_init(true)) {
+        g_debug("vss_init failed, vss commands will not function");
+    }
 #endif
 
     if (ga_is_frozen(s)) {
-- 
2.45.2


