Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D267EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Z7-0001Q2-Tc; Tue, 23 Jul 2024 03:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Z5-00011Q-6z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Z3-0000xE-6U
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrseMmuiX6II9DUgUI20KHP9sFWySY+HpgvK+lHSj1A=;
 b=aPcnXiCRqBLk7EYMfW9KhdwzRSfMowr65kMkoaGgXKrjnotTPPGKVhmZ21+S67JpdVQ4Xw
 77KBZgp1DxBIK1+X6imY5EAn+TlDvWuhLHvIZPzpVo1zddUEbNGY0p56qH563bRhB8f34B
 UHUysq84Kb7hnOAkmDhqfFa03jnBLqU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-EN1bl3WVN-mGzv6a9Rez9A-1; Tue,
 23 Jul 2024 03:03:41 -0400
X-MC-Unique: EN1bl3WVN-mGzv6a9Rez9A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43D611955F0D; Tue, 23 Jul 2024 07:03:37 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79073000198; Tue, 23 Jul 2024 07:03:35 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 21/25] qga: allow configuration file path via the cli
Date: Tue, 23 Jul 2024 10:02:47 +0300
Message-ID: <20240723070251.25575-22-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Allowing the user to set the QGA_CONF environment variable to change
the default configuration file path is very unusual practice, made
more obscure since this ability is not documented.

This introduces the more normal '-c PATH'  / '--config=PATH' command
line argument approach. This requires that we parse the comamnd line
twice, since we want the command line arguments to take priority over
the configuration file settings in general.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20240712132459.3974109-22-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 docs/interop/qemu-ga.rst |  5 +++++
 qga/main.c               | 43 ++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 10 deletions(-)

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
index 6ff022a85d..6ae911eb15 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -248,12 +248,16 @@ static void usage(const char *cmd)
 #ifdef CONFIG_FSFREEZE
     g_autofree char *fsfreeze_hook = get_relocated_path(QGA_FSFREEZE_HOOK_DEFAULT);
 #endif
+    g_autofree char *conf_path = get_relocated_path(QGA_CONF_DEFAULT);
 
     printf(
 "Usage: %s [-m <method> -p <path>] [<options>]\n"
 "QEMU Guest Agent " QEMU_FULL_VERSION "\n"
 QEMU_COPYRIGHT "\n"
 "\n"
+"  -c, --config=PATH configuration file path (default is\n"
+"                    %s/qemu-ga.conf\n"
+"                    unless overriden by the QGA_CONF environment variable)\n"
 "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
 "                    isa-serial, or vsock-listen (virtio-serial is the default)\n"
 "  -p, --path        device/socket path (the default for virtio-serial is:\n"
@@ -294,8 +298,8 @@ QEMU_COPYRIGHT "\n"
 "                    plug/unplug, etc.)\n"
 "  -h, --help        display this help and exit\n"
 "\n"
-QEMU_HELP_BOTTOM "\n"
-    , cmd, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
+QEMU_HELP_BOTTOM "\n",
+    cmd, conf_path, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
     dfl_pathnames.pidfile,
 #ifdef CONFIG_FSFREEZE
     fsfreeze_hook,
@@ -1018,15 +1022,14 @@ static GList *split_list(const gchar *str, const gchar *delim)
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
@@ -1092,10 +1095,10 @@ static void config_load(GAConfig *config)
 
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
@@ -1167,12 +1170,13 @@ static void config_dump(GAConfig *config)
 
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
@@ -1192,6 +1196,26 @@ static void config_parse(GAConfig *config, int argc, char **argv)
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
@@ -1582,7 +1606,6 @@ int main(int argc, char **argv)
     qga_qmp_init_marshal(&ga_commands);
 
     init_dfl_pathnames();
-    config_load(config);
     config_parse(config, argc, argv);
 
     if (config->pid_filepath == NULL) {
-- 
2.45.2


