Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BF5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9m-0006hl-7Y; Tue, 04 Jun 2024 11:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9j-0006gC-UT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9h-0001Im-Qt
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zUc1+i0TloZjdrrmpIgHGps0532WQ7fdKFCuLWdL1I=;
 b=DM6WGQBxq/Oxo/HSwR5MgoQL0H1NICMvEYrFBl0rmxJTyu4ywX6YoQlsu8lSf+f/WUGrM8
 7az+/LEC5WU2vtWN8jyCYMcOusnoYPT6krKybWSMXY90ZQNc+3jE79kdv7SdXezwd3MIY9
 wMtZAmgMShwKzDY5QPfWBlK/U8ypvH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-yVh-L1_yO92AEeOifqAilw-1; Tue, 04 Jun 2024 11:32:55 -0400
X-MC-Unique: yVh-L1_yO92AEeOifqAilw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A704811E81;
 Tue,  4 Jun 2024 15:32:55 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3BE8492BD3;
 Tue,  4 Jun 2024 15:32:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/14] qga: add command line to block unrestricted
 command/file access
Date: Tue,  4 Jun 2024 16:32:38 +0100
Message-ID: <20240604153242.251334-11-berrange@redhat.com>
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

The commands supporting arbitrary file access / command exec though
are giving the guest agent client effectively unrestricted access to
do anything at all in the guest OS.

The guest agent client is the host OS, so in effect running the QEMU
guest agent gives the host admin a trivial direct backdoor into the
guest OS, with no authentication, authorization or auditing of what
they do.

In the absense of confidential computing, the host admin already has
to be considered largely trustworthy, as they will typically have
direct access to any guest RAM regardless.

None the less, to limit their exposure, guest OS admins may choose
to limit these commands by passing '--no-unrestricted' / '-u' to
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
index 12b91eb713..66068ad535 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -87,6 +87,7 @@ struct GAConfig {
     GList *blockedrpcs;
     GList *allowedrpcs;
     bool only_confidential;
+    bool no_unrestricted;
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
@@ -425,6 +426,16 @@ static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
         allowed = false;
     }
 
+    /*
+     * If unrestricted commands are not allowed that sets
+     * a new default, but an explicit allow/block list can
+     * override
+     */
+    if (config->no_unrestricted &&
+        qmp_command_has_feature(cmd, QAPI_FEATURE_UNRESTRICTED)) {
+        allowed = false;
+    }
+
     if (config->allowedrpcs) {
         /*
          * If an allow-list is given, this changes the fallback
@@ -1208,6 +1219,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "statedir", 1, NULL, 't' },
         { "retry-path", 0, NULL, 'r' },
         { "confidential", 0, NULL, 'i' },
+        { "no-unrestricted", 0, NULL, 'u' },
         { NULL, 0, NULL, 0 }
     };
 
@@ -1307,6 +1319,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         case 'i':
             config->only_confidential = true;
             break;
+        case 'u':
+            config->no_unrestricted = true;
+            break;
         case 'h':
             usage(argv[0]);
             exit(EXIT_SUCCESS);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 48ea95cdba..de7c1de0b7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -42,7 +42,10 @@
         'fs-frozen',
         # Commands which do not violate privacy
         # of a confidential guest
-        'confidential'
+        'confidential',
+        # Commands which allow unrestricted access to or
+        # modification of guest files or execute arbitrary commands
+        'unrestricted'
     ] } }
 
 ##
-- 
2.45.1


