Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3824CC3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn48-0002oX-ST; Mon, 22 Jul 2024 03:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3x-0001Vj-0s
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3v-0006en-7F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jCxwWkVPe6MoXwtRPqnvk5WpSWgmfRj9bnpimrpPq8=;
 b=JW2H2sb0cEGNUDhIQr5UPGGGiVmQ4N48twt31gVJaRMNYKfuDNskZztY38k5mx15UU8zFn
 jb4wjnq4VR4WHMzMnyQJ3AKYHqk0bEY8ba9EXDElKXtaq4kv2kgUYj4IiHmG8mJfMC4rFI
 bgKkgLPrb1dLDl7Q+E9+u1bGbg3MhO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-HfZ97_blPW-iKawHI_5Zdw-1; Mon,
 22 Jul 2024 03:02:20 -0400
X-MC-Unique: HfZ97_blPW-iKawHI_5Zdw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45C441979042; Mon, 22 Jul 2024 07:02:11 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2DCA1944A9A; Mon, 22 Jul 2024 07:02:04 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 13/25] qga: conditionalize schema for commands requiring
 fsfreeze
Date: Mon, 22 Jul 2024 10:01:10 +0300
Message-ID: <20240722070122.27615-14-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-14-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
index de3fc46d2e..62462f092c 100644
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
@@ -429,7 +430,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-status',
-  'returns': 'GuestFsfreezeStatus' }
+  'returns': 'GuestFsfreezeStatus',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze:
@@ -451,7 +453,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-freeze',
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-freeze-list:
@@ -471,7 +474,8 @@
 ##
 { 'command': 'guest-fsfreeze-freeze-list',
   'data':    { '*mountpoints': ['str'] },
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @guest-fsfreeze-thaw:
@@ -488,7 +492,8 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-thaw',
-  'returns': 'int' }
+  'returns': 'int',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSFREEZE'] } }
 
 ##
 # @GuestFilesystemTrimResult:
-- 
2.45.2


