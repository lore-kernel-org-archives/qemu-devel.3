Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BC2C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGI6-0006gr-57; Fri, 12 Jul 2024 09:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHO-0003Bb-Nr
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHI-0003yE-II
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsypKy0RLH8U+aksh5lUjY4xuLFGqR/cckyvbjG+Bos=;
 b=Cg8kgp3mBllpiTRTZhFbgliwD6SV1OGeS9F/c9/4ty+H0P1+O16T7y2J5ftGYRZ73vxWOn
 Vk4rSd7RX2cxRk6EHb+AvBLwuGAVhUw6HyUlwXqT0uHJ9CyracrPtmGn0HvS9amqQBkKGk
 quTYX4dMwODcqj7binUc2WhWF74dTGo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-bvhLKrrEPH6kLAZe3vjlqg-1; Fri,
 12 Jul 2024 09:25:34 -0400
X-MC-Unique: bvhLKrrEPH6kLAZe3vjlqg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4927B19560B1; Fri, 12 Jul 2024 13:25:33 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59BE11955E70; Fri, 12 Jul 2024 13:25:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 08/22] qga: conditionalize schema for commands unsupported
 on Windows
Date: Fri, 12 Jul 2024 14:24:45 +0100
Message-ID: <20240712132459.3974109-9-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the commands on Windows.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This also fixes an accidental inconsistency where some commands
(guest-get-diskstats & guest-get-cpustats) are implemented as
stubs, yet not added to the blockedrpc list. Those change their
error message from

    {"class": "GenericError, "desc": "this feature or command is not currently supported"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

The final additional benefit is that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c |  2 +-
 qga/commands-win32.c | 56 +-------------------------------------------
 qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
 3 files changed, 32 insertions(+), 71 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 2a3bef7445..0dd8555867 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1280,7 +1280,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
             "guest-get-memory-blocks", "guest-set-memory-blocks",
             "guest-get-memory-block-info",
             NULL};
-        char **p = (char **)list;
+        const char **p = list;
 
         while (*p) {
             blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9fe670d5b4..2533e4c748 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1494,11 +1494,6 @@ out:
     }
 }
 
-void qmp_guest_suspend_hybrid(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
 static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
 {
     IP_ADAPTER_ADDRESSES *adptr_addrs = NULL;
@@ -1862,12 +1857,6 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
     return NULL;
 }
 
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return -1;
-}
-
 static gchar *
 get_net_error_message(gint error)
 {
@@ -1969,46 +1958,15 @@ done:
     g_free(rawpasswddata);
 }
 
-GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestMemoryBlockResponseList *
-qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-    const char *list_unsupported[] = {
-        "guest-suspend-hybrid",
-        "guest-set-vcpus",
-        "guest-get-memory-blocks", "guest-set-memory-blocks",
-        "guest-get-memory-block-info",
-        NULL};
-    char **p = (char **)list_unsupported;
-
-    while (*p) {
-        blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
-    }
-
     if (!vss_init(true)) {
         g_debug("vss_init failed, vss commands are going to be disabled");
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
-        p = (char **)list;
+        char **p = (char **)list;
 
         while (*p) {
             blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
@@ -2505,15 +2463,3 @@ char *qga_get_host_name(Error **errp)
 
     return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
 }
-
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 1273d85bb5..2f0215afc7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -637,7 +637,8 @@
 #
 # Since: 1.1
 ##
-{ 'command': 'guest-suspend-hybrid', 'success-response': false }
+{ 'command': 'guest-suspend-hybrid', 'success-response': false,
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestIpAddressType:
@@ -807,7 +808,8 @@
 ##
 { 'command': 'guest-set-vcpus',
   'data':    {'vcpus': ['GuestLogicalProcessor'] },
-  'returns': 'int' }
+  'returns': 'int',
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestDiskBusType:
@@ -1100,7 +1102,8 @@
 { 'struct': 'GuestMemoryBlock',
   'data': {'phys-index': 'uint64',
            'online': 'bool',
-           '*can-offline': 'bool'} }
+           '*can-offline': 'bool'},
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @guest-get-memory-blocks:
@@ -1116,7 +1119,8 @@
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-blocks',
-  'returns': ['GuestMemoryBlock'] }
+  'returns': ['GuestMemoryBlock'],
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestMemoryBlockResponseType:
@@ -1139,7 +1143,8 @@
 ##
 { 'enum': 'GuestMemoryBlockResponseType',
   'data': ['success', 'not-found', 'operation-not-supported',
-           'operation-failed'] }
+           'operation-failed'],
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestMemoryBlockResponse:
@@ -1157,7 +1162,8 @@
 { 'struct': 'GuestMemoryBlockResponse',
   'data': { 'phys-index': 'uint64',
             'response': 'GuestMemoryBlockResponseType',
-            '*error-code': 'int' }}
+            '*error-code': 'int' },
+  'if': 'CONFIG_POSIX'}
 
 ##
 # @guest-set-memory-blocks:
@@ -1188,7 +1194,8 @@
 ##
 { 'command': 'guest-set-memory-blocks',
   'data':    {'mem-blks': ['GuestMemoryBlock'] },
-  'returns': ['GuestMemoryBlockResponse'] }
+  'returns': ['GuestMemoryBlockResponse'],
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestMemoryBlockInfo:
@@ -1200,7 +1207,8 @@
 # Since: 2.3
 ##
 { 'struct': 'GuestMemoryBlockInfo',
-  'data': {'size': 'uint64'} }
+  'data': {'size': 'uint64'},
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @guest-get-memory-block-info:
@@ -1212,7 +1220,8 @@
 # Since: 2.3
 ##
 { 'command': 'guest-get-memory-block-info',
-  'returns': 'GuestMemoryBlockInfo' }
+  'returns': 'GuestMemoryBlockInfo',
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestExecStatus:
@@ -1702,7 +1711,8 @@
   'data': {'name': 'str',
            'major': 'uint64',
            'minor': 'uint64',
-           'stats': 'GuestDiskStats' } }
+           'stats': 'GuestDiskStats' },
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @guest-get-diskstats:
@@ -1714,7 +1724,8 @@
 # Since: 7.1
 ##
 { 'command': 'guest-get-diskstats',
-  'returns': ['GuestDiskStatsInfo']
+  'returns': ['GuestDiskStatsInfo'],
+  'if': 'CONFIG_POSIX'
 }
 
 ##
@@ -1727,7 +1738,8 @@
 # Since: 7.1
 ##
 { 'enum': 'GuestCpuStatsType',
-  'data': [ 'linux' ] }
+  'data': [ 'linux' ],
+  'if': 'CONFIG_POSIX' }
 
 
 ##
@@ -1772,7 +1784,8 @@
            '*steal': 'uint64',
            '*guest': 'uint64',
            '*guestnice': 'uint64'
-           } }
+           },
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @GuestCpuStats:
@@ -1786,7 +1799,8 @@
 { 'union': 'GuestCpuStats',
   'base': { 'type': 'GuestCpuStatsType' },
   'discriminator': 'type',
-  'data': { 'linux': 'GuestLinuxCpuStats' } }
+  'data': { 'linux': 'GuestLinuxCpuStats' },
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @guest-get-cpustats:
@@ -1798,5 +1812,6 @@
 # Since: 7.1
 ##
 { 'command': 'guest-get-cpustats',
-  'returns': ['GuestCpuStats']
+  'returns': ['GuestCpuStats'],
+  'if': 'CONFIG_POSIX'
 }
-- 
2.45.1


