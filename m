Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C273C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn4B-00035M-34; Mon, 22 Jul 2024 03:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3s-0001SB-TN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3q-0006XV-Oi
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOicOYD38yRq9S9QWOEkM+4EGRe93blGX0zFcQggxnI=;
 b=inv+X2jCMm+tXupAO9jn+gJsIkzE9WPkdErokh7J8x3Jq1I6+e/LiQ+FiRzjZPZRL0jmfF
 N/njLyLKSYZ/Y2z4jQLydu0vYcX17A9acuQ1r7igj6VU+A1oCSpp6M+PRvQ7pefmYWjKuV
 0HTaaJKMeIc6EvW1u7FOzQ+iRNQ3b0I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-3vhdAMckOUu9avS4CuGwWQ-1; Mon,
 22 Jul 2024 03:02:02 -0400
X-MC-Unique: 3vhdAMckOUu9avS4CuGwWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 944471955F56; Mon, 22 Jul 2024 07:01:53 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69794196BB78; Mon, 22 Jul 2024 07:01:48 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 10/25] qga: conditionalize schema for commands requiring
 getifaddrs
Date: Mon, 22 Jul 2024 10:01:07 +0300
Message-ID: <20240722070122.27615-11-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-11-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
index 38483652ac..79ed4f0e21 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -654,7 +654,8 @@
 # Since: 1.1
 ##
 { 'enum': 'GuestIpAddressType',
-  'data': [ 'ipv4', 'ipv6' ] }
+  'data': [ 'ipv4', 'ipv6' ],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestIpAddress:
@@ -670,7 +671,8 @@
 { 'struct': 'GuestIpAddress',
   'data': {'ip-address': 'str',
            'ip-address-type': 'GuestIpAddressType',
-           'prefix': 'int'} }
+           'prefix': 'int'},
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterfaceStat:
@@ -702,7 +704,8 @@
             'tx-packets': 'uint64',
             'tx-errs': 'uint64',
             'tx-dropped': 'uint64'
-           } }
+           },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestNetworkInterface:
@@ -722,7 +725,8 @@
   'data': {'name': 'str',
            '*hardware-address': 'str',
            '*ip-addresses': ['GuestIpAddress'],
-           '*statistics': 'GuestNetworkInterfaceStat' } }
+           '*statistics': 'GuestNetworkInterfaceStat' },
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @guest-network-get-interfaces:
@@ -734,7 +738,8 @@
 # Since: 1.1
 ##
 { 'command': 'guest-network-get-interfaces',
-  'returns': ['GuestNetworkInterface'] }
+  'returns': ['GuestNetworkInterface'],
+  'if': { 'any': ['CONFIG_WIN32', 'HAVE_GETIFADDRS'] } }
 
 ##
 # @GuestLogicalProcessor:
-- 
2.45.2


