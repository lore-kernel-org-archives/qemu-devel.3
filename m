Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2775C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmcy-0005ZH-4W; Thu, 13 Jun 2024 11:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmco-0005Ss-Om
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmcm-0003bx-Sv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feUX1TzeXKrW7AzJJVm5gnHuAWgGPJiMlxDBu6sLo0A=;
 b=Pu4l0+g3muALUNAjo6R9uasQPBf+e5qaTB+uclOalMlfejRdnx/Ltb6HYys2qZej+bS0FY
 P8yFh+J66wC4bteZ/EAnfZjBpNjL48kIn2UtdGVTr1bI9OBp14HGT4TlipDEKyEldSgtQw
 Cr1CpCjD3UwGNu+cz/6FweazQkCqir8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-B1eSkoITMY6gJwuK1w1QSA-1; Thu,
 13 Jun 2024 11:44:24 -0400
X-MC-Unique: B1eSkoITMY6gJwuK1w1QSA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D71AF19560B5; Thu, 13 Jun 2024 15:44:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E1463000219; Thu, 13 Jun 2024 15:44:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/22] qga: conditionalize schema for commands unsupported
 on non-Linux POSIX
Date: Thu, 13 Jun 2024 16:43:53 +0100
Message-ID: <20240613154406.1365469-4-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the commands on non-Linux POSIX
platforms

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
 qga/commands-posix.c | 66 --------------------------------------------
 qga/qapi-schema.json | 30 +++++++++++---------
 2 files changed, 17 insertions(+), 79 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dd8555867..559d71ffae 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -887,56 +887,6 @@ void qmp_guest_set_user_password(const char *username,
 }
 #endif /* __linux__ || __FreeBSD__ */
 
-#ifndef __linux__
-
-void qmp_guest_suspend_disk(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-void qmp_guest_suspend_ram(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-void qmp_guest_suspend_hybrid(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
-
-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return -1;
-}
-
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
-#endif
-
 #ifdef HAVE_GETIFADDRS
 static GuestNetworkInterface *
 guest_find_interface(GuestNetworkInterfaceList *head,
@@ -1272,22 +1222,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(__linux__)
-    {
-        const char *list[] = {
-            "guest-suspend-disk", "guest-suspend-ram",
-            "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus",
-            "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-info",
-            NULL};
-        const char **p = list;
-
-        while (*p) {
-            blockedrpcs = g_list_append(blockedrpcs, g_strdup(*p++));
-        }
-    }
-#endif
-
 #if !defined(HAVE_GETIFADDRS)
     blockedrpcs = g_list_append(blockedrpcs,
                               g_strdup("guest-network-get-interfaces"));
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b91456e9ad..d164c30ec3 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -565,7 +565,8 @@
 #
 # Since: 1.1
 ##
-{ 'command': 'guest-suspend-disk', 'success-response': false }
+{ 'command': 'guest-suspend-disk', 'success-response': false,
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-suspend-ram:
@@ -601,7 +602,8 @@
 #
 # Since: 1.1
 ##
-{ 'command': 'guest-suspend-ram', 'success-response': false }
+{ 'command': 'guest-suspend-ram', 'success-response': false,
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-suspend-hybrid:
@@ -637,7 +639,7 @@
 # Since: 1.1
 ##
 { 'command': 'guest-suspend-hybrid', 'success-response': false,
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestIpAddressType:
@@ -750,7 +752,8 @@
 { 'struct': 'GuestLogicalProcessor',
   'data': {'logical-id': 'int',
            'online': 'bool',
-           '*can-offline': 'bool'} }
+           '*can-offline': 'bool'},
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-get-vcpus:
@@ -765,7 +768,8 @@
 # Since: 1.5
 ##
 { 'command': 'guest-get-vcpus',
-  'returns': ['GuestLogicalProcessor'] }
+  'returns': ['GuestLogicalProcessor'],
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-set-vcpus:
@@ -808,7 +812,7 @@
 { 'command': 'guest-set-vcpus',
   'data':    {'vcpus': ['GuestLogicalProcessor'] },
   'returns': 'int',
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestDiskBusType:
@@ -1102,7 +1106,7 @@
   'data': {'phys-index': 'uint64',
            'online': 'bool',
            '*can-offline': 'bool'},
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-memory-blocks:
@@ -1119,7 +1123,7 @@
 ##
 { 'command': 'guest-get-memory-blocks',
   'returns': ['GuestMemoryBlock'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockResponseType:
@@ -1143,7 +1147,7 @@
 { 'enum': 'GuestMemoryBlockResponseType',
   'data': ['success', 'not-found', 'operation-not-supported',
            'operation-failed'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockResponse:
@@ -1162,7 +1166,7 @@
   'data': { 'phys-index': 'uint64',
             'response': 'GuestMemoryBlockResponseType',
             '*error-code': 'int' },
-  'if': 'CONFIG_POSIX'}
+  'if': 'CONFIG_LINUX'}
 
 ##
 # @guest-set-memory-blocks:
@@ -1194,7 +1198,7 @@
 { 'command': 'guest-set-memory-blocks',
   'data':    {'mem-blks': ['GuestMemoryBlock'] },
   'returns': ['GuestMemoryBlockResponse'],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestMemoryBlockInfo:
@@ -1207,7 +1211,7 @@
 ##
 { 'struct': 'GuestMemoryBlockInfo',
   'data': {'size': 'uint64'},
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-memory-block-info:
@@ -1220,7 +1224,7 @@
 ##
 { 'command': 'guest-get-memory-block-info',
   'returns': 'GuestMemoryBlockInfo',
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestExecStatus:
-- 
2.45.1


