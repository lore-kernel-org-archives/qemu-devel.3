Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6CAC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9s-0006oH-Gn; Tue, 04 Jun 2024 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9n-0006iH-7F
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9l-0001Je-MD
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJjYoiTj3WSsEa5+kzx49B/Y4qCMzV1a+UUijYo12BQ=;
 b=CF9WajvGcxT5rr8esgeijt2bGio37iTrU4G8M+Jtuk3uPlNsJGc1VdcscgnCngCTV9EZoa
 n7JcbBj9fiCOiUS3z5C0jbbB8Bznl541gTxbXfpBRwpcen/rfgKiUQ5KAAuNF4wiKLXOpc
 zcfaGrt7ObN0O6jFaAYWABySSmKgVww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-5lfOiD3mN1imtGEcTBYA5A-1; Tue, 04 Jun 2024 11:32:59 -0400
X-MC-Unique: 5lfOiD3mN1imtGEcTBYA5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0584101A520;
 Tue,  4 Jun 2024 15:32:58 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29F91492BCF;
 Tue,  4 Jun 2024 15:32:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/14] qga: add command line to block user authentication
 commands
Date: Tue,  4 Jun 2024 16:32:41 +0100
Message-ID: <20240604153242.251334-14-berrange@redhat.com>
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

Historically there has been no default policy on command usage in
the QEMU guest agent. A wide variety of commands have been added
for various purposes

 * Co-ordinating host mgmt tasks (FS freezing, CPU hotplug,
   memory block hotplug)
 * Guest information querying (CPU stats, mount info, etc)
 * Arbitrary file read/write and command execution
 * User account auth setup (passwords, SSH keys)

All of these have valid use cases, but they come with very different
levels of risk to the guest OS.

The commands supporting alteration of user authentication credentials
are giving the guest agent client effectively unrestricted access to
do anything at all in the guest OS by enabling them to subsequently
access a user login shell.

The guest agent client is the host OS, so in effect running the QEMU
guest agent gives the host admin a trivial direct backdoor into the
guest OS.

In the absense of confidential computing, the host admin already has
to be considered largely trustworthy, as they will typically have
direct access to any guest RAM regardless.

None the less, to limit their exposure, guest OS admins may choose
to limit these commands by passing '--no-user-auth' / '-e' to
QGA

The --allowedrpcs / --blockedrpcs arguments take precedence over the
--unrestricted arg (whether present or not), thus allowing fine tuning
the defaults further.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/main.c           | 15 +++++++++++++++
 qga/qapi-schema.json |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 66068ad535..0d792cd92e 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -88,6 +88,7 @@ struct GAConfig {
     GList *allowedrpcs;
     bool only_confidential;
     bool no_unrestricted;
+    bool no_user_auth;
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
@@ -436,6 +437,16 @@ static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
         allowed = false;
     }
 
+    /*
+     * If user auth commands are not allowed that sets
+     * a new default, but an explicit allow/block list can
+     * override
+     */
+    if (config->no_user_auth &&
+        qmp_command_has_feature(cmd, QAPI_FEATURE_USER_AUTH)) {
+        allowed = false;
+    }
+
     if (config->allowedrpcs) {
         /*
          * If an allow-list is given, this changes the fallback
@@ -1220,6 +1231,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "retry-path", 0, NULL, 'r' },
         { "confidential", 0, NULL, 'i' },
         { "no-unrestricted", 0, NULL, 'u' },
+        { "no-user-auth", 0, NULL, 'e' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1322,6 +1334,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         case 'u':
             config->no_unrestricted = true;
             break;
+        case 'e':
+            config->no_user_auth = true;
+            break;
         case 'h':
             usage(argv[0]);
             exit(EXIT_SUCCESS);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a4f8653446..25068b8110 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -45,7 +45,10 @@
         'confidential',
         # Commands which allow unrestricted access to or
         # modification of guest files or execute arbitrary commands
-        'unrestricted'
+        'unrestricted',
+        # Commands which allow changes to user account
+        # authentication credentials (keys, passwords)
+        'user-auth'
     ] } }
 
 ##
-- 
2.45.1


