Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6772C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmeI-0006xd-Fx; Thu, 13 Jun 2024 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdH-0005nQ-9v
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdF-0003fz-3N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVuBDIZZOyn5t7Xih+pc8oT7BIICiUmNgiCc/L5Wy6c=;
 b=b7I/GX6O07KqewIfKjrdIOiq9n+he+RRfRb7wXoCsETtlJUtR0V6ZdFnkJ0x5pSOkpOUmv
 +AScExpReFbehjufnIDFKwNV/QG1eqdFuMLNPBnZZ+aAgcmV0LVWKgIJTIXdBYB5/nCfiY
 UaKiokRFiklPT8Y8feIypjdfAmq5gdM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-ov4nU2nzN-mLT2BmdE_SYQ-1; Thu,
 13 Jun 2024 11:44:54 -0400
X-MC-Unique: ov4nU2nzN-mLT2BmdE_SYQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ED441956096; Thu, 13 Jun 2024 15:44:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B89C63000219; Thu, 13 Jun 2024 15:44:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 18/22] qga: don't disable fsfreeze commands if vss_init
 fails
Date: Thu, 13 Jun 2024 16:44:02 +0100
Message-ID: <20240613154406.1365469-13-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The fsfreeze commands are already written to report an error if
vss_init() fails. Reporting a more specific error message is more
helpful than a generic "command is disabled" message, which cannot
beteween an admin config decision and lack of platform support.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.45.1


