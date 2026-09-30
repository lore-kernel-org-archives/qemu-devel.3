Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E895CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2X8-00080f-4V; Wed, 30 Sep 2026 18:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wr-0007xT-Bb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wp-00053M-0r
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8F41FB9A;
 Wed, 30 Sep 2026 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnJeels2bSuMuCJo2UZOcjws9Swp1uxf8tu/IZHLBk=;
 b=S269t8tk/9rHpFgsx+KsIYc9DGAnYcaZz2nTVbfLGYXOj+xaB3IKarIwOhG+XXC18JansN
 utE5kCxuvi5AZEVbDnu02Vd1a4HTGqaT1RII81BsqR+GyO9gySdP0L//BsmLlGKQIYnk5M
 E4jHa1pnt6R8mfmZ6aXkNtzAsuons0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnJeels2bSuMuCJo2UZOcjws9Swp1uxf8tu/IZHLBk=;
 b=ECLvAHSTrR+w1oTnAokko5hQ3ddoAyvsWvWfZhams2+kZziIyLWLWhSv8bLXoZFiVv4ogy
 SG0vdLioew5inBCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lxm3EXHc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OrcW5oyK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnJeels2bSuMuCJo2UZOcjws9Swp1uxf8tu/IZHLBk=;
 b=lxm3EXHcRhfRH4CNFEkjJhky0kTm7kDLBedm+nYgsuhvudNnk2T1il7dRt/VNySbNspTHD
 62NlDkIjGAgKpKCklGmM8yscUbWVTV4AoKVkIPTgk7qErC8qkjfK809HOghuozOLkJT9Uw
 PK7h7yo/D4U50lA7drTNiv6VuWg9+xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOnJeels2bSuMuCJo2UZOcjws9Swp1uxf8tu/IZHLBk=;
 b=OrcW5oyKaJFZvvjyJDcMu3nyVbqqvz3jVBnt6GSUJ3yomhlwK0TArbRR/4LPBNYPBVH9fe
 G4sRfV/UD7L0s6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B514913B25;
 Wed, 30 Sep 2026 22:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T12
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v2 11/11] qemu-option: Remove a few instances of noisily
 parsing
Date: Wed, 30 Sep 2026 19:11:05 -0300
Message-ID: <20260930221105.2262063-12-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.vnet.ibm.com,treblig.org,gmail.com,linaro.org,oss.qualcomm.com,crans.org,web.de];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 RCPT_COUNT_TWELVE(0.00)[13]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9A8F41FB9A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

With the removal of the support for short-form flags, the only other
source of "noise" in the qemu_parse_*noisily() functions aside from
errors is the printing of the help text.

Therefore, the only difference from the _noisily versions to the
normal ones is this block:

    if (qemu_opt_has_help_opt(opts) && !opts_accepts_any(list)) {
        qemu_opts_print_help(list, true);
        return NULL;
    }

Stop calling qemu_parse_*noisily() in any case where it's certain that
opts_accepts_any(list) returns true, i.e. when list->desc is empty.

This creates some instances of the pattern: error_report ->
exit(1). Use &error_fatal instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/monitor/block-hmp-cmds.c |  4 ++--
 include/system/tpm.h           |  3 ++-
 monitor/hmp.c                  |  4 +++-
 net/net.c                      |  4 +---
 plugins/loader.c               |  5 +---
 qemu-img.c                     |  5 +++-
 qemu-io-cmds.c                 |  2 +-
 qemu-io.c                      |  7 ++----
 system/tpm.c                   |  8 +++----
 system/vl.c                    | 42 +++++++++++++++-------------------
 tests/unit/test-replication.c  | 17 +++++++++++---
 util/qemu-option.c             |  3 +++
 12 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index d94a07314f..93b622227c 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -63,9 +63,9 @@ static void hmp_drive_add_node(MonitorHMP *hmp, const char *optstr)
     QDict *qdict;
     Error *err = NULL;
 
-    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, optstr, false);
+    opts = qemu_opts_parse_list(&qemu_drive_opts, optstr, false, &err);
     if (!opts) {
-        return;
+        goto out;
     }
 
     qdict = qemu_opts_to_qdict(opts, NULL);
diff --git a/include/system/tpm.h b/include/system/tpm.h
index 874068d19a..4132a3a641 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -17,7 +17,8 @@
 
 #ifdef CONFIG_TPM
 
-int tpm_config_parse(QemuOptsList *opts_list, const char *optstr);
+bool tpm_config_parse(QemuOptsList *opts_list, const char *optstr,
+                      Error **errp);
 int tpm_init(void);
 void tpm_cleanup(void);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index fc32cfd1ff..6a6be8f12f 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -883,6 +883,7 @@ static QDict *monitor_parse_arguments(MonitorHMP *mon,
             {
                 QemuOptsList *opts_list;
                 QemuOpts *opts;
+                Error *err = NULL;
 
                 opts_list = qemu_find_opts(key);
                 if (!opts_list || opts_list->desc->name) {
@@ -897,8 +898,9 @@ static QDict *monitor_parse_arguments(MonitorHMP *mon,
                 if (get_str(buf, sizeof(buf), &p) < 0) {
                     goto fail;
                 }
-                opts = qemu_opts_parse_list_noisily(opts_list, buf, true);
+                opts = qemu_opts_parse_list(opts_list, buf, true, &err);
                 if (!opts) {
+                    error_report_err(err);
                     goto fail;
                 }
                 qemu_opts_to_qdict(opts, qdict);
diff --git a/net/net.c b/net/net.c
index 37401ab2b4..09ed34557d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -2029,9 +2029,7 @@ void netdev_parse_modern(const char *optstr)
 
 void net_client_parse(QemuOptsList *opts_list, const char *optstr)
 {
-    if (!qemu_opts_parse_list_noisily(opts_list, optstr, true)) {
-        exit(1);
-    }
+    qemu_opts_parse_list(opts_list, optstr, true, &error_fatal);
 }
 
 /* From FreeBSD */
diff --git a/plugins/loader.c b/plugins/loader.c
index 1808679c82..db6ae6d1f4 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -147,10 +147,7 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head)
     struct qemu_plugin_parse_arg arg;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse_noisily("plugin", optstr, true);
-    if (opts == NULL) {
-        exit(1);
-    }
+    opts = qemu_opts_parse("plugin", optstr, true, &error_fatal);
     arg.head = head;
     arg.curr = NULL;
     qemu_opt_foreach(opts, plugin_add, &arg, &error_fatal);
diff --git a/qemu-img.c b/qemu-img.c
index 5e58ccc587..18501f7fb9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -354,12 +354,15 @@ static BlockBackend *img_open(bool image_opts,
     BlockBackend *blk;
     if (image_opts) {
         QemuOpts *opts;
+        Error *err = NULL;
+
         if (fmt) {
             error_report("--image-opts and --format are mutually exclusive");
             return NULL;
         }
-        opts = qemu_opts_parse_noisily("source", filename, true);
+        opts = qemu_opts_parse("source", filename, true, &err);
         if (!opts) {
+            error_report_err(err);
             return NULL;
         }
         blk = img_open_opts(filename, opts, flags, writethrough, quiet,
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 6c8c4c9540..fa52fbb900 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2540,7 +2540,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv, Error **errp)
             has_cache_option = true;
             break;
         case 'o':
-            if (!qemu_opts_parse_list_noisily(&reopen_opts, optarg, 0)) {
+            if (!qemu_opts_parse_list(&reopen_opts, optarg, 0, errp)) {
                 qemu_opts_reset(&reopen_opts);
                 return -EINVAL;
             }
diff --git a/qemu-io.c b/qemu-io.c
index db0ee499e4..837e5048ba 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -659,11 +659,8 @@ int main(int argc, char **argv)
     if ((argc - optind) == 1) {
         if (imageOpts) {
             QemuOpts *qopts = NULL;
-            qopts = qemu_opts_parse_list_noisily(&file_opts, argv[optind],
-                                                 false);
-            if (!qopts) {
-                exit(1);
-            }
+            qopts = qemu_opts_parse_list(&file_opts, argv[optind], false,
+                                         &error_fatal);
             opts = qemu_opts_to_qdict(qopts, NULL);
             if (openfile(NULL, flags, writethrough, force_share, opts)) {
                 exit(1);
diff --git a/system/tpm.c b/system/tpm.c
index f0f5a64d9a..31aeaa5cc6 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -176,7 +176,7 @@ int tpm_init(void)
  * Parse the TPM configuration options.
  * To display all available TPM backends the user may use '-tpmdev help'
  */
-int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
+bool tpm_config_parse(QemuOptsList *opts_list, const char *optstr, Error **errp)
 {
     QemuOpts *opts;
 
@@ -184,11 +184,11 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
         tpm_display_backend_drivers();
         exit(EXIT_SUCCESS);
     }
-    opts = qemu_opts_parse_list_noisily(opts_list, optstr, true);
+    opts = qemu_opts_parse_list(opts_list, optstr, true, errp);
     if (!opts) {
-        return -1;
+        return false;
     }
-    return 0;
+    return true;
 }
 
 /*
diff --git a/system/vl.c b/system/vl.c
index 4a3fa80c5c..8382bb902b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1871,11 +1871,7 @@ static void object_option_parse(const char *str)
         v = qobject_input_visitor_new(obj);
         qobject_unref(obj);
     } else {
-        opts = qemu_opts_parse_noisily("object", str, true);
-        if (!opts) {
-            exit(1);
-        }
-
+        opts = qemu_opts_parse("object", str, true, &error_fatal);
         type = qemu_opt_get(opts, "qom-type");
         if (!type) {
             error_report(QERR_MISSING_PARAMETER, "qom-type");
@@ -2483,12 +2479,15 @@ static void configure_accelerators(const char *progname)
         accel_list = g_strsplit(accelerators, ":", 0);
 
         for (tmp = accel_list; *tmp; tmp++) {
+            Error *err = NULL;
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
              */
             if (accel_find(*tmp)) {
-                qemu_opts_parse_noisily("accel", *tmp, true);
+                if (!qemu_opts_parse("accel", *tmp, true, &err)) {
+                    error_report_err(err);
+                }
             } else {
                 init_failed = true;
                 error_report("invalid accelerator %s", *tmp);
@@ -3013,9 +3012,7 @@ void qemu_init(int argc, char **argv)
                 replay_add_blocker("-snapshot");
                 break;
             case QEMU_OPTION_numa:
-                if (!qemu_opts_parse_noisily("numa", optarg, true)) {
-                    exit(1);
-                }
+                qemu_opts_parse("numa", optarg, true, &error_fatal);
                 break;
             case QEMU_OPTION_display:
                 parse_display(optarg);
@@ -3131,9 +3128,7 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_TPM
             case QEMU_OPTION_tpmdev:
-                if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) < 0) {
-                    exit(1);
-                }
+                tpm_config_parse(qemu_find_opts("tpmdev"), optarg, &error_fatal);
                 break;
 #endif
             case QEMU_OPTION_mempath:
@@ -3396,17 +3391,11 @@ void qemu_init(int argc, char **argv)
                 object_register_sugar_prop("ide-device", "win2k-install-hack", "true", true);
                 break;
             case QEMU_OPTION_acpitable:
-                opts = qemu_opts_parse_noisily("acpi", optarg, true);
-                if (!opts) {
-                    exit(1);
-                }
+                opts = qemu_opts_parse("acpi", optarg, true, &error_fatal);
                 acpi_table_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_smbios:
-                opts = qemu_opts_parse_noisily("smbios", optarg, false);
-                if (!opts) {
-                    exit(1);
-                }
+                opts = qemu_opts_parse("smbios", optarg, false, &error_fatal);
                 smbios_entry_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_fwcfg:
@@ -3433,7 +3422,13 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_accel:
-                accel_opts = qemu_opts_parse_noisily("accel", optarg, true);
+            {
+                Error *err = NULL;
+
+                accel_opts = qemu_opts_parse("accel", optarg, true, &err);
+                if (!accel_opts) {
+                    error_report_err(err);
+                }
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
                     printf("Accelerators supported in QEMU binary:\n");
@@ -3459,6 +3454,7 @@ void qemu_init(int argc, char **argv)
                     exit(0);
                 }
                 break;
+            }
             case QEMU_OPTION_usb:
                 qdict_put_str(machine_opts_dict, "usb", "on");
                 break;
@@ -3475,9 +3471,7 @@ void qemu_init(int argc, char **argv)
                     assert(opt->opts != NULL);
                     QTAILQ_INSERT_TAIL(&device_opts, opt, next);
                 } else {
-                    if (!qemu_opts_parse_noisily("device", optarg, true)) {
-                        exit(1);
-                    }
+                    qemu_opts_parse("device", optarg, true, &error_fatal);
                 }
                 break;
             case QEMU_OPTION_smp:
diff --git a/tests/unit/test-replication.c b/tests/unit/test-replication.c
index 101f72acdc..dbed415f87 100644
--- a/tests/unit/test-replication.c
+++ b/tests/unit/test-replication.c
@@ -174,12 +174,16 @@ static BlockBackend *start_primary(void)
     QemuOpts *opts;
     QDict *qdict;
     char *cmdline;
+    Error *err = NULL;
 
     cmdline = g_strdup_printf("driver=replication,mode=primary,node-name=xxx,"
                               "file.driver=qcow2,file.file.filename=%s,"
                               "file.file.locking=off"
                               , p_local_disk);
-    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list(&qemu_drive_opts, cmdline, false, &err);
+    if (!opts) {
+        error_report_err(err);
+    }
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
@@ -290,12 +294,16 @@ static BlockBackend *start_secondary(void)
     QDict *qdict;
     BlockBackend *blk;
     char *cmdline;
+    Error *err = NULL;
 
     /* add s_local_disk and forge S_LOCAL_DISK_ID */
     cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
                               "file.locking=off",
                               s_local_disk);
-    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list(&qemu_drive_opts, cmdline, false, &err);
+    if (!opts) {
+        error_report_err(err);
+    }
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
@@ -321,7 +329,10 @@ static BlockBackend *start_secondary(void)
                               "file.backing.backing=%s"
                               , S_ID, s_active_disk, s_hidden_disk
                               , S_LOCAL_DISK_ID);
-    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list(&qemu_drive_opts, cmdline, false, &err);
+    if (!opts) {
+        error_report_err(err);
+    }
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 83fa2399d3..833c69f6a5 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -995,6 +995,9 @@ QemuOpts *qemu_opts_parse_list_noisily(QemuOptsList *list, const char *params,
     Error *err = NULL;
     QemuOpts *opts;
 
+    assert(g_str_equal("drive", list->name) ||
+           !opts_accepts_any(list));
+
     opts = opts_parse(list, params, permit_abbrev, &err);
     if (!opts) {
         error_report_err(err);
-- 
2.53.0


