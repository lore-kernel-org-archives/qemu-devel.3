Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB151C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGIC-0007OK-Bi; Fri, 12 Jul 2024 09:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHo-00052x-9F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHi-00043q-PX
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drcvdI3Sgud7lXkxoulsFG0PxIzW9TIqU8jDisNYR3M=;
 b=RpWFrXkAylqAeDz1JQ5PXKn3qvijEvw2gVAQI+mpn/Mwh0FcfX3tiAreiW6XGtoK7spNWj
 6i60flkTmEfRWw7EQxOlqSgn2TJUOlNhg98htvy2veNKtboVs7w4CrOy6LKCHVMdOe7WZv
 /n4vwdXn5ZwJiPMqfQaRACDpPjiVD7o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-26ZOWBT-Ny-U1IPWun5KxA-1; Fri,
 12 Jul 2024 09:25:54 -0400
X-MC-Unique: 26ZOWBT-Ny-U1IPWun5KxA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C04D5196E094; Fri, 12 Jul 2024 13:25:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C4281955F40; Fri, 12 Jul 2024 13:25:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 14/22] qga: conditionalize schema for commands requiring
 fstrim
Date: Fri, 12 Jul 2024 14:24:51 +0100
Message-ID: <20240712132459.3974109-15-berrange@redhat.com>
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
2.45.1


