Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E01EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn4A-000341-Td; Mon, 22 Jul 2024 03:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3y-0001Xw-Kk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3w-0006fK-Tg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfA1AIhnaodupyeke/XSvXwEWxdqwDhPzBrAZ19WWi4=;
 b=F5IoV7t9GHBku1qP8sWNfXbZhvfdribgSrWULZy7xtLWHC1OSRPb5Zb7e9DUQsfWr37ToW
 Pk8TtXK//N2uxJ4yuYFN4JqaqL1RHx01goDJx5wAE9SkJk4dPU/jeHesRtD5V+gTyiJCzk
 phtn6sovUv2Ca8FOQgokWSyN+nJ83ic=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-S0aba-GKO8qCDrOEj6aNbg-1; Mon,
 22 Jul 2024 03:02:17 -0400
X-MC-Unique: S0aba-GKO8qCDrOEj6aNbg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E83D19054A3; Mon, 22 Jul 2024 07:02:11 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1A0C1944A95; Mon, 22 Jul 2024 07:02:06 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 14/25] qga: conditionalize schema for commands requiring fstrim
Date: Mon, 22 Jul 2024 10:01:11 +0300
Message-ID: <20240722070122.27615-15-kkostiuk@redhat.com>
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
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the filesystem trimming commands
on POSIX platforms lacking required APIs.

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
Message-ID: <20240712132459.3974109-15-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 13 -------------
 qga/qapi-schema.json |  9 ++++++---
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9207cb7a8f..d92fa0ec87 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1144,22 +1144,9 @@ error:
 
 #endif /* HAVE_GETIFADDRS */
 
-#if !defined(CONFIG_FSTRIM)
-GuestFilesystemTrimResponse *
-qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-#endif
-
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(CONFIG_FSTRIM)
-    blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-fstrim"));
-#endif
-
     return blockedrpcs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 62462f092c..21c65d1806 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -510,7 +510,8 @@
 ##
 { 'struct': 'GuestFilesystemTrimResult',
   'data': {'path': 'str',
-           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'} }
+           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'},
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @GuestFilesystemTrimResponse:
@@ -520,7 +521,8 @@
 # Since: 2.4
 ##
 { 'struct': 'GuestFilesystemTrimResponse',
-  'data': {'paths': ['GuestFilesystemTrimResult']} }
+  'data': {'paths': ['GuestFilesystemTrimResult']},
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-fstrim:
@@ -542,7 +544,8 @@
 ##
 { 'command': 'guest-fstrim',
   'data': { '*minimum': 'int' },
-  'returns': 'GuestFilesystemTrimResponse' }
+  'returns': 'GuestFilesystemTrimResponse',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-suspend-disk:
-- 
2.45.2


