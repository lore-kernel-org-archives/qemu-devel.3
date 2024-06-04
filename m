Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9l-0006hD-Il; Tue, 04 Jun 2024 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9j-0006fw-Jo
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9h-0001Ie-6w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZ7XhB389gErPmQqZrRj2jtKor6/J0PzR8obW4Gr+Tc=;
 b=VhTQttFME+i7FaLMiXqskUBmLJwXR9iQhcaOrD2RuE7LlY0naPHtqu/5c1lqRfQ3wch29C
 q03nsT8Rg5qOkKiWTNnn7+hJWg7HIO9+iHFnkWt7bd0jjjdxqUuPT4mKXXKkW8ESee6Kil
 VQEyVl8iNRWwmm37dTrt1hDVeMw61Fw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-DmXzJVklM1206VFxXgpsnQ-1; Tue,
 04 Jun 2024 11:32:53 -0400
X-MC-Unique: DmXzJVklM1206VFxXgpsnQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29A541C05130;
 Tue,  4 Jun 2024 15:32:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 452BF492BD5;
 Tue,  4 Jun 2024 15:32:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/14] qga: use special feature to mark those that can run
 when FS are frozen
Date: Tue,  4 Jun 2024 16:32:35 +0100
Message-ID: <20240604153242.251334-8-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently a list of commands which are safe to run when FS are frozen
is hardcoded in the source. Now that the QAPI schema allows custom
special features, a 'fs-frozen' feature can be added to track this
metadata.

This has the benefit that the restrictions on commands permitted when
frozen are now recorded in the QGA generated documentation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/main.c           | 22 ++--------------------
 qga/qapi-schema.json | 44 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index c7b7b0a9bc..7bf5ec49ba 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -128,17 +128,6 @@ struct GAState {
 struct GAState *ga_state;
 QmpCommandList ga_commands;
 
-/* commands that are safe to issue while filesystems are frozen */
-static const char *ga_freeze_allowlist[] = {
-    "guest-ping",
-    "guest-info",
-    "guest-sync",
-    "guest-sync-delimited",
-    "guest-fsfreeze-status",
-    "guest-fsfreeze-thaw",
-    NULL
-};
-
 #ifdef _WIN32
 DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
                                   LPVOID ctx);
@@ -421,7 +410,6 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
 
 static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
 {
-    int i = 0;
     GAConfig *config = state->config;
     const char *name = qmp_command_name(cmd);
     /* Fallback policy is allow everything */
@@ -453,15 +441,9 @@ static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
      * If frozen, this filtering must take priority over
      * absolutely everything
      */
-    if (state->frozen) {
+    if (state->frozen &&
+        !qmp_command_has_feature(cmd, QAPI_FEATURE_FS_FROZEN)) {
         allowed = false;
-
-        while (ga_freeze_allowlist[i] != NULL) {
-            if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
-                allowed = true;
-            }
-            i++;
-        }
     }
 
     return allowed;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 571be3a914..8b1eff3abc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -36,7 +36,11 @@
         'guest-sync-delimited' ],
     # Types and commands with undocumented members:
     'documentation-exceptions': [
-        'GuestNVMeSmart' ] } }
+        'GuestNVMeSmart' ],
+    'command-features': [
+        # Commands permitted while FS are frozen
+        'fs-frozen'
+    ] } }
 
 ##
 # @guest-sync-delimited:
@@ -67,11 +71,16 @@
 #
 # Returns: The unique integer id passed in by the client
 #
+# Features:
+#
+# @fs-frozen: permitted to execute when filesystems are frozen
+#
 # Since: 1.1
 ##
 { 'command': 'guest-sync-delimited',
   'data':    { 'id': 'int' },
-  'returns': 'int' }
+  'returns': 'int',
+  'features': [ 'fs-frozen'] }
 
 ##
 # @guest-sync:
@@ -104,20 +113,30 @@
 #
 # Returns: The unique integer id passed in by the client
 #
+# Features:
+#
+# @fs-frozen: permitted to execute when filesystems are frozen
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-sync',
   'data':    { 'id': 'int' },
-  'returns': 'int' }
+  'returns': 'int',
+  'features': [ 'fs-frozen'] }
 
 ##
 # @guest-ping:
 #
 # Ping the guest agent, a non-error return implies success
 #
+# Features:
+#
+# @fs-frozen: permitted to execute when filesystems are frozen
+#
 # Since: 0.15.0
 ##
-{ 'command': 'guest-ping' }
+{ 'command': 'guest-ping',
+  'features': [ 'fs-frozen'] }
 
 ##
 # @guest-get-time:
@@ -196,10 +215,15 @@
 #
 # Returns: @GuestAgentInfo
 #
+# Features:
+#
+# @fs-frozen: permitted when filesystems are frozen
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-info',
-  'returns': 'GuestAgentInfo' }
+  'returns': 'GuestAgentInfo',
+  'features': [ 'fs-frozen'] }
 
 ##
 # @guest-shutdown:
@@ -426,10 +450,15 @@
 # Note: This may fail to properly report the current state as a result
 #     of some other guest processes having issued an fs freeze/thaw.
 #
+# Features:
+#
+# @fs-frozen: permitted when filesystems are frozen
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-status',
   'returns': 'GuestFsfreezeStatus',
+  'features': [ 'fs-frozen'],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
@@ -488,10 +517,15 @@
 #     filesystems were unfrozen before this call, and that the
 #     filesystem state may have changed before issuing this command.
 #
+# Features:
+#
+# @fs-frozen: permitted when filesystems are frozen
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-thaw',
   'returns': 'int',
+  'features': [ 'fs-frozen'],
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
-- 
2.45.1


