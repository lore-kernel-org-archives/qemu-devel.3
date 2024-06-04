Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B95C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9l-0006h4-3B; Tue, 04 Jun 2024 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9j-0006fh-Al
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9g-0001IZ-Ub
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PC9b9zdl5x37neT0fm6L/j00JU90/UGjPDU7u57umto=;
 b=iUWAGMqG8K2JQXO8/hpG28QxAoe0KqQ1s3jf9zO3fphr90tVbaRpBDv2Ed2AxC7U1vyqQk
 Ll5TKXLtqDdX7kSvWzjZdKZb2urjGu8JOhQsZ26ge6rbvVVZ9XKs8+JDLUCCobTS0xLohN
 PZ55dmy25qEMYt+TP3avdjFv3mcBY1c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-UfIxTNOIO5KySLij-riYcw-1; Tue,
 04 Jun 2024 11:32:53 -0400
X-MC-Unique: UfIxTNOIO5KySLij-riYcw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33BE81C05131;
 Tue,  4 Jun 2024 15:32:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC4A492BD5;
 Tue,  4 Jun 2024 15:32:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/14] qga: add command line to limit commands for
 confidential guests
Date: Tue,  4 Jun 2024 16:32:36 +0100
Message-ID: <20240604153242.251334-9-berrange@redhat.com>
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

When running in a confidential guest, a very large number of QGA
commands are unsafe to permit, since they can be used to violate
the privacy of the guest.

This introduces a new command line "--confidential" / "-i" which,
if set, will run the guest in confidential mode, which should
avoid leaking information to the host, while still allowing
important VM mgmt tasks to be performed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/main.c           | 14 ++++++++++++++
 qga/qapi-schema.json |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 7bf5ec49ba..12b91eb713 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -86,6 +86,7 @@ struct GAConfig {
     gchar *aliststr; /* allowedrpcs may point to this string */
     GList *blockedrpcs;
     GList *allowedrpcs;
+    bool only_confidential;
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
@@ -415,6 +416,15 @@ static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
     /* Fallback policy is allow everything */
     bool allowed = true;
 
+    /*
+     * If running in confidential mode, block commands that
+     * would violate guest data privacy
+     */
+    if (config->only_confidential &&
+        !qmp_command_has_feature(cmd, QAPI_FEATURE_CONFIDENTIAL)) {
+        allowed = false;
+    }
+
     if (config->allowedrpcs) {
         /*
          * If an allow-list is given, this changes the fallback
@@ -1197,6 +1207,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
 #endif
         { "statedir", 1, NULL, 't' },
         { "retry-path", 0, NULL, 'r' },
+        { "confidential", 0, NULL, 'i' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1293,6 +1304,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             }
             break;
 #endif
+        case 'i':
+            config->only_confidential = true;
+            break;
         case 'h':
             usage(argv[0]);
             exit(EXIT_SUCCESS);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8b1eff3abc..9a213dfc06 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -39,7 +39,10 @@
         'GuestNVMeSmart' ],
     'command-features': [
         # Commands permitted while FS are frozen
-        'fs-frozen'
+        'fs-frozen',
+        # Commands which do not violate privacy
+        # of a confidential guest
+        'confidential'
     ] } }
 
 ##
-- 
2.45.1


