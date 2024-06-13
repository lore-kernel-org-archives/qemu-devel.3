Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6822C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmeO-0007Xv-20; Thu, 13 Jun 2024 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdW-0006AS-GB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdR-0003sZ-4N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyJq/IoZYsA04SPJg1aDK+sobF2/8ZlbHC1i0TuUHYo=;
 b=BuZBUWe9iQVckEsX55iBYWeyakltp7tac0eLEUaUefCI9+9VHfuDagj/k5Uf2yYZ7wPPtz
 ri54M7Ygl0zazxeI21yv2zlLrf/2DWYkcpvlK0Vw5kiQDJBFWYEtTanGWu5lyGv538f0dR
 /DYthWJYIh4vsx63sKRiP94hfLJUSb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-g8EDD6PUOYSC8LNkOX-Bdw-1; Thu,
 13 Jun 2024 11:45:03 -0400
X-MC-Unique: g8EDD6PUOYSC8LNkOX-Bdw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAFA919560AA; Thu, 13 Jun 2024 15:45:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79828300021A; Thu, 13 Jun 2024 15:44:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 21/22] qga: allow configuration file path via the cli
Date: Thu, 13 Jun 2024 16:44:05 +0100
Message-ID: <20240613154406.1365469-16-berrange@redhat.com>
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

Allowing the user to set the QGA_CONF environment variable to change
the default configuration file path is very unusual practice, made
more obscure since this ability is not documented.

This introduces the more normal '-c PATH'  / '--config=PATH' command
line argument approach. This requires that we parse the comamnd line
twice, since we want the command line arguments to take priority over
the configuration file settings in general.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/interop/qemu-ga.rst |  5 +++++
 qga/main.c               | 35 +++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 72fb75a6f5..e42b370319 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -33,6 +33,11 @@ Options
 
 .. program:: qemu-ga
 
+.. option:: -c, --config=PATH
+
+  Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
+  unless overriden by the QGA_CONF environment variable)
+
 .. option:: -m, --method=METHOD
 
   Transport method: one of ``unix-listen``, ``virtio-serial``, or
diff --git a/qga/main.c b/qga/main.c
index 6ff022a85d..f68a32bf7b 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1018,15 +1018,14 @@ static GList *split_list(const gchar *str, const gchar *delim)
     return list;
 }
 
-static void config_load(GAConfig *config)
+static void config_load(GAConfig *config, const char *confpath, bool required)
 {
     GError *gerr = NULL;
     GKeyFile *keyfile;
-    g_autofree char *conf = g_strdup(g_getenv("QGA_CONF")) ?: get_relocated_path(QGA_CONF_DEFAULT);
 
     /* read system config */
     keyfile = g_key_file_new();
-    if (!g_key_file_load_from_file(keyfile, conf, 0, &gerr)) {
+    if (!g_key_file_load_from_file(keyfile, confpath, 0, &gerr)) {
         goto end;
     }
     if (g_key_file_has_key(keyfile, "general", "daemon", NULL)) {
@@ -1092,10 +1091,10 @@ static void config_load(GAConfig *config)
 
 end:
     g_key_file_free(keyfile);
-    if (gerr &&
-        !(gerr->domain == G_FILE_ERROR && gerr->code == G_FILE_ERROR_NOENT)) {
+    if (gerr && (required ||
+                 !(gerr->domain == G_FILE_ERROR && gerr->code == G_FILE_ERROR_NOENT))) {
         g_critical("error loading configuration from path: %s, %s",
-                   conf, gerr->message);
+                   confpath, gerr->message);
         exit(EXIT_FAILURE);
     }
     g_clear_error(&gerr);
@@ -1167,12 +1166,13 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
-    const char *sopt = "hVvdm:p:l:f:F::b:a:s:t:Dr";
+    const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
     int opt_ind = 0, ch;
     bool block_rpcs = false, allow_rpcs = false;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
         { "version", 0, NULL, 'V' },
+        { "config", 1, NULL, 'c' },
         { "dump-conf", 0, NULL, 'D' },
         { "logfile", 1, NULL, 'l' },
         { "pidfile", 1, NULL, 'f' },
@@ -1192,6 +1192,26 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "retry-path", 0, NULL, 'r' },
         { NULL, 0, NULL, 0 }
     };
+    g_autofree char *confpath = g_strdup(g_getenv("QGA_CONF")) ?:
+        get_relocated_path(QGA_CONF_DEFAULT);
+    bool confrequired = false;
+
+    while ((ch = getopt_long(argc, argv, sopt, lopt, NULL)) != -1) {
+        switch (ch) {
+        case 'c':
+            g_free(confpath);
+            confpath = g_strdup(optarg);
+            confrequired = true;
+            break;
+        default:
+            break;
+        }
+    }
+
+    config_load(config, confpath, confrequired);
+
+    /* Reset for second pass */
+    optind = 1;
 
     while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
         switch (ch) {
@@ -1582,7 +1602,6 @@ int main(int argc, char **argv)
     qga_qmp_init_marshal(&ga_commands);
 
     init_dfl_pathnames();
-    config_load(config);
     config_parse(config, argc, argv);
 
     if (config->pid_filepath == NULL) {
-- 
2.45.1


