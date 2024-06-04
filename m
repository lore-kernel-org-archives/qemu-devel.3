Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD6FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYE-0006Lg-TQ; Tue, 04 Jun 2024 09:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYB-0006G2-59
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUY8-0002s9-NT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvVdmvrfznP9V0eIinbgDAEQLHjATsC14h6U1iExSrc=;
 b=NTHY+wMOKqfB2xrw9FRbqpxMQ1vS9QwC+cFS1eP5Y35BYd2mHDi9e1TPoLAQqKMGw7kfxl
 TFBxBhQSZojh+5YXBSVPFVyIrcpIFyK19g81Vs/pTaX08BegxPLAwfONv1K8AmzZR4b4a3
 Zj0iSGY02E6nzWEHnHRtYnvfWXfLeDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-kYbAGB5qPHS_MthZyc46lw-1; Tue, 04 Jun 2024 09:49:59 -0400
X-MC-Unique: kYbAGB5qPHS_MthZyc46lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA00185A78E;
 Tue,  4 Jun 2024 13:49:59 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20E5C15C48;
 Tue,  4 Jun 2024 13:49:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 10/20] qga: conditionalize schema for commands requiring
 getifaddrs
Date: Tue,  4 Jun 2024 14:49:23 +0100
Message-ID: <20240604134933.220112-11-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Rather than creating stubs for every comamnd that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the network interface command on
POSIX platforms lacking getifaddrs().

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.

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


