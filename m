Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3A3C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmd5-0005ag-64; Thu, 13 Jun 2024 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmct-0005Tr-Ux
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmcp-0003c4-6i
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ohhoscbN1UXDKO5Qc8X1VF0cGOQhAlHOnQ3BheVODo=;
 b=dxzKG4KMg1EiVG4vyD9sfBKwqz1BMXOtLC8NC7ONxd9X5+px6eeUNomzsg9zXm+2u/NaGt
 1pzlU3/C6ignmiCpWihXzmTFny9LxcTGOd7eaE0yl5mVSXhyP5e8Jd44UfHC6R0xHPT2Jb
 jZKKFJo/xBmJOVvMnfyreSh+Rx0SEcs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-FSGAqVOXMiqZ5D-xXR0lSQ-1; Thu,
 13 Jun 2024 11:44:28 -0400
X-MC-Unique: FSGAqVOXMiqZ5D-xXR0lSQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1250219560AE; Thu, 13 Jun 2024 15:44:27 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50B693000226; Thu, 13 Jun 2024 15:44:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/22] qga: conditionalize schema for commands requiring
 getifaddrs
Date: Thu, 13 Jun 2024 16:43:54 +0100
Message-ID: <20240613154406.1365469-5-berrange@redhat.com>
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

Rather than creating stubs for every comamnd that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the network interface command on
POSIX platforms lacking getifaddrs().

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
 qga/commands-posix.c | 13 -------------
 qga/qapi-schema.json | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 559d71ffae..09d08ee2ca 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1142,14 +1142,6 @@ error:
     return NULL;
 }
 
-#else
-
-GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
 #endif /* HAVE_GETIFADDRS */
 
 #if !defined(CONFIG_FSFREEZE)
@@ -1222,11 +1214,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(HAVE_GETIFADDRS)
-    blockedrpcs = g_list_append(blockedrpcs,
-                              g_strdup("guest-network-get-interfaces"));
-#endif
-
 #if !defined(CONFIG_FSFREEZE)
     {
         const char *list[] = {
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d164c30ec3..c37c904aae 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -653,7 +653,8 @@
 # Since: 1.1
 ##
 { 'enum': 'GuestIpAddressType',
-  'data': [ 'ipv4', 'ipv6' ] }
+  'data': [ 'ipv4', 'ipv6' ],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestIpAddress:
@@ -669,7 +670,8 @@
 { 'struct': 'GuestIpAddress',
   'data': {'ip-address': 'str',
            'ip-address-type': 'GuestIpAddressType',
-           'prefix': 'int'} }
+           'prefix': 'int'},
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterfaceStat:
@@ -701,7 +703,8 @@
             'tx-packets': 'uint64',
             'tx-errs': 'uint64',
             'tx-dropped': 'uint64'
-           } }
+           },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterface:
@@ -721,7 +724,8 @@
   'data': {'name': 'str',
            '*hardware-address': 'str',
            '*ip-addresses': ['GuestIpAddress'],
-           '*statistics': 'GuestNetworkInterfaceStat' } }
+           '*statistics': 'GuestNetworkInterfaceStat' },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @guest-network-get-interfaces:
@@ -733,7 +737,8 @@
 # Since: 1.1
 ##
 { 'command': 'guest-network-get-interfaces',
-  'returns': ['GuestNetworkInterface'] }
+  'returns': ['GuestNetworkInterface'],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestLogicalProcessor:
-- 
2.45.1


