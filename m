Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F01C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYY-0007JC-AD; Tue, 04 Jun 2024 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYV-00072n-Hd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYT-0003CN-QA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTyvFwWS+gOucVDy3woBokmJXuSY83NZdK8OqvfOv38=;
 b=KpcKOvoveNIvjuTDtjZrTUNhQmpvh9SUtVZSQGNQBO+dHn1XNRk/wRvVU0AjWTFc8b2KDS
 DfahzklnmWfB39bSp/x0O/0rhRyObf3S/ojc5yB2zPkqMANv50BNOFWbCTfVozbkWd1ggZ
 amjQeK5SZvoFCZDwslHahbaOjSf3yjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-PGxsypQiMCC7Z2go71FlWg-1; Tue, 04 Jun 2024 09:50:21 -0400
X-MC-Unique: PGxsypQiMCC7Z2go71FlWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72E398007A3;
 Tue,  4 Jun 2024 13:50:21 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14477C15C41;
 Tue,  4 Jun 2024 13:50:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 19/20] qga: move declare of QGAConfig struct to top of file
Date: Tue,  4 Jun 2024 14:49:32 +0100
Message-ID: <20240604134933.220112-20-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

It is referenced byy QGAState already, and it is clearer to declare all
data types at the top of the file, rather than have them mixed with
code later.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/main.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index bdf5344584..e8f52f0794 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -70,6 +70,28 @@ typedef struct GAPersistentState {
 
 typedef struct GAConfig GAConfig;
 
+struct GAConfig {
+    char *channel_path;
+    char *method;
+    char *log_filepath;
+    char *pid_filepath;
+#ifdef CONFIG_FSFREEZE
+    char *fsfreeze_hook;
+#endif
+    char *state_dir;
+#ifdef _WIN32
+    const char *service;
+#endif
+    gchar *bliststr; /* blockedrpcs may point to this string */
+    gchar *aliststr; /* allowedrpcs may point to this string */
+    GList *blockedrpcs;
+    GList *allowedrpcs;
+    int daemonize;
+    GLogLevelFlags log_level;
+    int dumpconf;
+    bool retry_path;
+};
+
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -996,28 +1018,6 @@ static GList *split_list(const gchar *str, const gchar *delim)
     return list;
 }
 
-struct GAConfig {
-    char *channel_path;
-    char *method;
-    char *log_filepath;
-    char *pid_filepath;
-#ifdef CONFIG_FSFREEZE
-    char *fsfreeze_hook;
-#endif
-    char *state_dir;
-#ifdef _WIN32
-    const char *service;
-#endif
-    gchar *bliststr; /* blockedrpcs may point to this string */
-    gchar *aliststr; /* allowedrpcs may point to this string */
-    GList *blockedrpcs;
-    GList *allowedrpcs;
-    int daemonize;
-    GLogLevelFlags log_level;
-    int dumpconf;
-    bool retry_path;
-};
-
 static void config_load(GAConfig *config)
 {
     GError *gerr = NULL;
-- 
2.45.1


