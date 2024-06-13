Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1ADC27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmdP-00061F-Bm; Thu, 13 Jun 2024 11:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmd5-0005dA-Am
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmd1-0003cz-E7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LU0ZfC1sZotfq+U6nN9utYgF4YG3jZsgeIkOpJiTWIs=;
 b=JjHm4i9WnJ1uSO1Aqv8mDHNlqFCAh75UzZCjZgqH3KogzSQQenq5lybKM5gSVgt4MXfsGv
 L/7vySjwXsZigwOG1y9yyK+hvXn8NbowQGM3XQfXyqr+AvWKKZC50glZLKvqpJd6fL7vNZ
 fzc14xh26eK8GScSsOg37+0J3e+eMTg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-fU6_lQUzM4GdKaku7rvYxw-1; Thu,
 13 Jun 2024 11:44:38 -0400
X-MC-Unique: fU6_lQUzM4GdKaku7rvYxw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55B2E19560AD; Thu, 13 Jun 2024 15:44:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC4133000219; Thu, 13 Jun 2024 15:44:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 13/22] qga: conditionalize schema for commands requiring
 fsfreeze
Date: Thu, 13 Jun 2024 16:43:57 +0100
Message-ID: <20240613154406.1365469-8-berrange@redhat.com>
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

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
exclude generation of the filesystem freezing commands on POSIX
platforms lacking the required APIs.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 47 --------------------------------------------
 qga/qapi-schema.json | 15 +++++++++-----
 2 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index b7f96aa005..9207cb7a8f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1144,39 +1144,6 @@ error:
 
 #endif /* HAVE_GETIFADDRS */
 
-#if !defined(CONFIG_FSFREEZE)
-
-GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return 0;
-}
-
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return 0;
-}
-
-int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
-                                       strList *mountpoints,
-                                       Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return 0;
-}
-
-int64_t qmp_guest_fsfreeze_thaw(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return 0;
-}
-#endif /* CONFIG_FSFREEZE */
-
 #if !defined(CONFIG_FSTRIM)
 GuestFilesystemTrimResponse *
 qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
@@ -1189,20 +1156,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(CONFIG_FSFREEZE)
-    {
-        const char *list[] = {
-            "guest-fsfreeze-status",
-            "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", NULL};
-        char **p = (char **)list;
-
-        while (*p) {
-            blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
-        }
-    }
-#endif
-
 #if !defined(CONFIG_FSTRIM)
     blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-fstrim"));
 #endif
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 2704b814ab..098fa7a08b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -412,7 +412,8 @@
 # Since: 0.15.0
 ##
 { 'enum': 'GuestFsfreezeStatus',
-  'data': [ 'thawed', 'frozen' ] }
+  'data': [ 'thawed', 'frozen' ],
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-status:
@@ -428,7 +429,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-status',
-  'returns': 'GuestFsfreezeStatus' }
+  'returns': 'GuestFsfreezeStatus',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze:
@@ -450,7 +452,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-freeze',
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze-list:
@@ -470,7 +473,8 @@
 ##
 { 'command': 'guest-fsfreeze-freeze-list',
   'data':    { '*mountpoints': ['str'] },
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-thaw:
@@ -487,7 +491,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-thaw',
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @GuestFilesystemTrimResult:
-- 
2.45.1


