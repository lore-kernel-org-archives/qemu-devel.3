Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2168C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6L-00081s-Uc; Fri, 18 Sep 2026 18:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6K-0007x3-9a
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6G-0000fb-Mj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4421C21ECF;
 Fri, 18 Sep 2026 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCYExgrU5b7muvAYE8Ab9+v9ShlW58rboZcrfPhQoKo=;
 b=zcRua9ui6ec/d6BCZMXDDGoMFHb6hHSomycaRKRatEGcYS2A741JXIGVlNoc7c+iPaUjHi
 +njizHidMqJyApTtn0kJsL9Xoflv/15em6s6vBgmjPMn+898zA/cfX/f1fsANWadRuUvfp
 85wx8P4/nKcactYloCz/yU0TpLCSVbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCYExgrU5b7muvAYE8Ab9+v9ShlW58rboZcrfPhQoKo=;
 b=kiu4ERkozAGSRavyyobkhbo8eZ4MrFSaiuw5ouvXbOcGEyQD2V+JyXH49sdcQXpThXYs6g
 iU0dF1vSYBFrH8BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dQS3J5cB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P5ggqldU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCYExgrU5b7muvAYE8Ab9+v9ShlW58rboZcrfPhQoKo=;
 b=dQS3J5cBt+P0yrkn97cGFMtpVWrmcZT9MnLVMbLCrpBYY9XlKzUT5HjMH5KIDjQgu8frvM
 sVQl4Vtb4b+8Mq4RGbVdkAyYX6HyhdGx98k1j+ezcJDX5k8JY3CsAWgTp19HxCPs0E0P41
 87WtfCy07lqW/ts/Wg80CWZINAEGHmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCYExgrU5b7muvAYE8Ab9+v9ShlW58rboZcrfPhQoKo=;
 b=P5ggqldU2sbVaAjCjYgEhDvu1F2e6QzCy0Urmc/kqPRjBu5TOJ6gU4KhjLMv+LUKJjqydK
 lunkh4ivEaC+eXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC7013927;
 Fri, 18 Sep 2026 22:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T10
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 09/14] qemu-options: Change qemu_opts_parse_noisily() to
 take the group
Date: Fri, 18 Sep 2026 19:29:56 -0300
Message-ID: <20260918223002.1892021-10-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4421C21ECF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,qemu.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pass the group name as argument to qemu_opts_parse_noisily() to make
it simmetric with qemu_opts_parse().

This change solves the issue of qemu_opts_parse_noisily() crashing on
a NULL return from qemu_find_opts(), which can happen when an option
is invoked for code in a module that is not loaded.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 blockdev.c                     |  2 +-
 chardev/char-hmp-cmds.c        |  5 +--
 include/qemu/option.h          |  2 +-
 plugins/loader.c               |  2 +-
 qemu-img.c                     |  3 +-
 semihosting/config.c           |  4 +-
 system/vl.c                    | 75 ++++++++++++----------------------
 tests/unit/test-char.c         | 12 ++----
 tests/unit/test-seccomp.c      |  6 +--
 trace/control.c                |  3 +-
 ui/vnc.c                       |  3 +-
 util/qemu-option.c             | 14 ++++++-
 13 files changed, 54 insertions(+), 79 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index cbd64166ec..d94a07314f 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -101,7 +101,7 @@ void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("drive"), optstr, false);
+    opts = qemu_opts_parse_noisily("drive", optstr, false);
     if (!opts)
         return;
 
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..21554500dc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -203,7 +203,7 @@ QemuOpts *drive_add(BlockInterfaceType type, int index, const char *file,
 
     GLOBAL_STATE_CODE();
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("drive"), optstr, false);
+    opts = qemu_opts_parse_noisily("drive", optstr, false);
     if (!opts) {
         return NULL;
     }
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index fb0560054b..938dbd3ba2 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -83,7 +83,7 @@ void hmp_chardev_add(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"), args, true);
+    opts = qemu_opts_parse_noisily("chardev", args, true);
     if (opts == NULL) {
         error_setg(&err, "Parsing chardev args failed");
     } else {
@@ -100,8 +100,7 @@ void hmp_chardev_change(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
     ChardevBackend *backend = NULL;
     ChardevReturn *ret = NULL;
-    QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"), args,
-                                             true);
+    QemuOpts *opts = qemu_opts_parse_noisily("chardev", args, true);
     if (!opts) {
         error_setg(&err, "Parsing chardev args failed");
         goto end;
diff --git a/include/qemu/option.h b/include/qemu/option.h
index df68da9aa8..2955ed3b2d 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -128,7 +128,7 @@ void qemu_opts_del(QemuOpts *opts);
 bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp);
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                         const char *firstname, Error **errp);
-QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
+QemuOpts *qemu_opts_parse_noisily(const char *group, const char *params,
                                   bool permit_abbrev);
 QemuOpts *qemu_opts_parse(const char *group, const char *params,
                           bool permit_abbrev, Error **errp);
diff --git a/plugins/loader.c b/plugins/loader.c
index b10ebe8cc0..1808679c82 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -147,7 +147,7 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head)
     struct qemu_plugin_parse_arg arg;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optstr, true);
+    opts = qemu_opts_parse_noisily("plugin", optstr, true);
     if (opts == NULL) {
         exit(1);
     }
diff --git a/qemu-img.c b/qemu-img.c
index 4996618a4e..0459faac5f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -358,8 +358,7 @@ static BlockBackend *img_open(bool image_opts,
             error_report("--image-opts and --format are mutually exclusive");
             return NULL;
         }
-        opts = qemu_opts_parse_noisily(qemu_find_opts("source"),
-                                       filename, true);
+        opts = qemu_opts_parse_noisily("source", filename, true);
         if (!opts) {
             return NULL;
         }
diff --git a/semihosting/config.c b/semihosting/config.c
index 56283b5c3c..c8c865ebae 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -134,8 +134,8 @@ void qemu_semihosting_enable(void)
 
 int qemu_semihosting_config_options(const char *optstr)
 {
-    QemuOptsList *opt_list = qemu_find_opts("semihosting-config");
-    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optstr, false);
+    QemuOpts *opts = qemu_opts_parse_noisily("semihosting-config", optstr,
+                                             false);
 
     semihosting.enabled = true;
 
diff --git a/system/vl.c b/system/vl.c
index adda7b0f70..4a6c3e5582 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1870,8 +1870,7 @@ static void object_option_parse(const char *str)
         v = qobject_input_visitor_new(obj);
         qobject_unref(obj);
     } else {
-        opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
-                                       str, true);
+        opts = qemu_opts_parse_noisily("object", str, true);
         if (!opts) {
             exit(1);
         }
@@ -1897,8 +1896,7 @@ static void overcommit_parse(const char *str)
     QemuOpts *opts;
     const char *mem_lock_opt;
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
-                                   str, false);
+    opts = qemu_opts_parse_noisily("overcommit", str, false);
     if (!opts) {
         exit(1);
     }
@@ -2475,7 +2473,7 @@ static void configure_accelerators(const char *progname)
              * such as "-machine accel=tcg,,thread=single".
              */
             if (accel_find(*tmp)) {
-                qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+                qemu_opts_parse_noisily("accel", *tmp, true);
             } else {
                 init_failed = true;
                 error_report("invalid accelerator %s", *tmp);
@@ -2975,8 +2973,7 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_drive:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
-                                             optarg, false)) {
+                if (!qemu_opts_parse_noisily("drive", optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -3001,8 +2998,7 @@ void qemu_init(int argc, char **argv)
                 replay_add_blocker("-snapshot");
                 break;
             case QEMU_OPTION_numa:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("numa"),
-                                             optarg, true)) {
+                if (!qemu_opts_parse_noisily("numa", optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3061,8 +3057,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_LIBISCSI
             case QEMU_OPTION_iscsi:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
-                                             optarg, false)) {
+                if (!qemu_opts_parse_noisily("iscsi", optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -3115,8 +3110,7 @@ void qemu_init(int argc, char **argv)
                 exit(0);
                 break;
             case QEMU_OPTION_m:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("memory"),
-                                             optarg, true)) {
+                if (!qemu_opts_parse_noisily("memory", optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3244,15 +3238,13 @@ void qemu_init(int argc, char **argv)
                     "See '-object' docs in the QEMU manual for further "
                     "configuration guidance: "
                     "https://www.qemu.org/docs/master/system/invocation.html");
-                if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
-                                             true)) {
+                if (!qemu_opts_parse_noisily("mon", optarg, true)) {
                     exit(1);
                 }
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_chardev:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                             optarg, true)) {
+                if (!qemu_opts_parse_noisily("chardev", optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3356,9 +3348,8 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             case QEMU_OPTION_action:
-                olist = qemu_find_opts("action");
-                if (!qemu_opts_parse_noisily(olist, optarg, false)) {
-                     exit(1);
+                if (!qemu_opts_parse_noisily("action", optarg, false)) {
+                    exit(1);
                 }
                 break;
             case QEMU_OPTION_watchdog_action: {
@@ -3390,24 +3381,21 @@ void qemu_init(int argc, char **argv)
                 object_register_sugar_prop("ide-device", "win2k-install-hack", "true", true);
                 break;
             case QEMU_OPTION_acpitable:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("acpi"),
-                                               optarg, true);
+                opts = qemu_opts_parse_noisily("acpi", optarg, true);
                 if (!opts) {
                     exit(1);
                 }
                 acpi_table_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_smbios:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("smbios"),
-                                               optarg, false);
+                opts = qemu_opts_parse_noisily("smbios", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
                 smbios_entry_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_fwcfg:
-                if (!qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
-                                             optarg, true)) {
+                if (!qemu_opts_parse_noisily("fw_cfg", optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3430,8 +3418,7 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_accel:
-                accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
-                                                     optarg, true);
+                accel_opts = qemu_opts_parse_noisily("accel", optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
                     printf("Accelerators supported in QEMU binary:\n");
@@ -3470,8 +3457,7 @@ void qemu_init(int argc, char **argv)
                     assert(opt->opts != NULL);
                     QTAILQ_INSERT_TAIL(&device_opts, opt, next);
                 } else {
-                    if (!qemu_opts_parse_noisily(qemu_find_opts("device"),
-                                                 optarg, true)) {
+                    if (!qemu_opts_parse_noisily("device", optarg, true)) {
                         exit(1);
                     }
                 }
@@ -3487,12 +3473,10 @@ void qemu_init(int argc, char **argv)
                 break;
 #endif
             case QEMU_OPTION_no_reboot:
-                olist = qemu_find_opts("action");
-                qemu_opts_parse_noisily(olist, "reboot=shutdown", false);
+                qemu_opts_parse_noisily("action", "reboot=shutdown", false);
                 break;
             case QEMU_OPTION_no_shutdown:
-                olist = qemu_find_opts("action");
-                qemu_opts_parse_noisily(olist, "shutdown=pause", false);
+                qemu_opts_parse_noisily("action", "shutdown=pause", false);
                 break;
             case QEMU_OPTION_uuid:
                 if (qemu_uuid_parse(optarg, &qemu_uuid) < 0) {
@@ -3506,8 +3490,7 @@ void qemu_init(int argc, char **argv)
                     error_report("too many option ROMs");
                     exit(1);
                 }
-                opts = qemu_opts_parse_noisily(qemu_find_opts("option-rom"),
-                                               optarg, true);
+                opts = qemu_opts_parse_noisily("option-rom", optarg, true);
                 if (!opts) {
                     exit(1);
                 }
@@ -3529,8 +3512,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             case QEMU_OPTION_name:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("name"),
-                                               optarg, true);
+                opts = qemu_opts_parse_noisily("name", optarg, true);
                 if (!opts) {
                     exit(1);
                 }
@@ -3546,15 +3528,13 @@ void qemu_init(int argc, char **argv)
                 nb_prom_envs++;
                 break;
             case QEMU_OPTION_rtc:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
-                                               false);
+                opts = qemu_opts_parse_noisily("rtc", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
                 break;
             case QEMU_OPTION_icount:
-                icount_opts = qemu_opts_parse_noisily(qemu_find_opts("icount"),
-                                                      optarg, true);
+                icount_opts = qemu_opts_parse_noisily("icount", optarg, true);
                 if (!icount_opts) {
                     exit(1);
                 }
@@ -3603,7 +3583,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_SPICE
             case QEMU_OPTION_spice:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
+                opts = qemu_opts_parse_noisily("spice", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
@@ -3633,8 +3613,7 @@ void qemu_init(int argc, char **argv)
                 break;
             case QEMU_OPTION_add_fd:
 #ifndef _WIN32
-                opts = qemu_opts_parse_noisily(qemu_find_opts("add-fd"),
-                                               optarg, false);
+                opts = qemu_opts_parse_noisily("add-fd", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
@@ -3666,8 +3645,7 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_msg:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("msg"), optarg,
-                                               false);
+                opts = qemu_opts_parse_noisily("msg", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
@@ -3697,8 +3675,7 @@ void qemu_init(int argc, char **argv)
                 break;
             case QEMU_OPTION_run_with: {
                 const char *str;
-                opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
-                                                         optarg, false);
+                opts = qemu_opts_parse_noisily("run-with", optarg, false);
                 if (!opts) {
                     exit(1);
                 }
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index b88b557133..bbcdf9a9ce 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1210,8 +1210,7 @@ static void char_socket_server_test(gconstpointer opaque)
                                          config->fd_pass,
                                          NULL,
                                          true);
-    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                   optstr, true);
+    opts = qemu_opts_parse_noisily("chardev", optstr, true);
     g_assert_nonnull(opts);
     chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     qemu_opts_del(opts);
@@ -1352,8 +1351,7 @@ static void char_socket_client_dupid_test(gconstpointer opaque)
                                          config->reconnect,
                                          false);
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                   optstr, true);
+    opts = qemu_opts_parse_noisily("chardev", optstr, true);
     g_assert_nonnull(opts);
     chr1 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr1);
@@ -1412,8 +1410,7 @@ static void char_socket_client_test(gconstpointer opaque)
                                          config->reconnect,
                                          false);
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                   optstr, true);
+    opts = qemu_opts_parse_noisily("chardev", optstr, true);
     g_assert_nonnull(opts);
     chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     qemu_opts_del(opts);
@@ -1544,8 +1541,7 @@ static void char_socket_server_two_clients_test(gconstpointer opaque)
                                          false,
                                          NULL,
                                          true);
-    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                   optstr, true);
+    opts = qemu_opts_parse_noisily("chardev", optstr, true);
     g_assert_nonnull(opts);
     chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     qemu_opts_del(opts);
diff --git a/tests/unit/test-seccomp.c b/tests/unit/test-seccomp.c
index 71d4083439..4438012989 100644
--- a/tests/unit/test-seccomp.c
+++ b/tests/unit/test-seccomp.c
@@ -31,15 +31,11 @@ static void test_seccomp_helper(const char *args, bool killed,
                                 int errnum, int (*doit)(void))
 {
     if (g_test_subprocess()) {
-        QemuOptsList *olist;
         QemuOpts *opts;
         int ret;
 
         module_call_init(MODULE_INIT_OPTS);
-        olist = qemu_find_opts("sandbox");
-        g_assert(olist != NULL);
-
-        opts = qemu_opts_parse_noisily(olist, args, true);
+        opts = qemu_opts_parse_noisily("sandbox", args, true);
         g_assert(opts != NULL);
 
         parse_sandbox(NULL, opts, &error_abort);
diff --git a/trace/control.c b/trace/control.c
index 49f0a4c5cd..51cecf5827 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -288,8 +288,7 @@ bool trace_init_backends(void)
 
 void trace_opt_parse(const char *optstr)
 {
-    QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("trace"),
-                                             optstr, true);
+    QemuOpts *opts = qemu_opts_parse_noisily("trace", optstr, true);
     if (!opts) {
         exit(1);
     }
diff --git a/ui/vnc.c b/ui/vnc.c
index 656768f9c9..7ddf660856 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4324,8 +4324,7 @@ static char *vnc_auto_assign_id(QemuOpts *opts)
 
 void vnc_parse(const char *str)
 {
-    QemuOptsList *olist = qemu_find_opts("vnc");
-    QemuOpts *opts = qemu_opts_parse_noisily(olist, str, !is_help_option(str));
+    QemuOpts *opts = qemu_opts_parse_noisily("vnc", str, !is_help_option(str));
 
     if (!opts) {
         exit(1);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index c762eb20a3..f8494c8842 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -941,6 +941,8 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
     bool noisily = !errp;
     QemuOpts *opts = NULL;
 
+    assert(list);
+
     if (noisily) {
         Error *err = NULL;
         bool help_wanted = !opts_accepts_any(list);
@@ -958,16 +960,24 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
 }
 
 /**
- * Create a QemuOpts in @list and with options parsed from @params.
+ * Find the @group and create a QemuOpts with options parsed from @params.
  * If @permit_abbrev, the first key=value in @params may omit key=,
  * and is treated as if key was @list->implied_opt_name.
  * Report errors with error_report_err().  This is inappropriate in
  * QMP context.  Do not use this function there!
  * Return the new QemuOpts on success, null pointer on error.
  */
-QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
+QemuOpts *qemu_opts_parse_noisily(const char *group, const char *params,
                                   bool permit_abbrev)
 {
+    Error *err = NULL;
+    QemuOptsList *list = qemu_find_opts_err(group, &err);
+
+    if (!list) {
+        error_report_err(err);
+        return NULL;
+    }
+
     return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
 }
 
-- 
2.53.0


