Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6102DCA5FD2
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2X1-0007yE-So; Wed, 30 Sep 2026 18:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wk-0007wY-V4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wi-00052p-AN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 243721F7EE;
 Wed, 30 Sep 2026 22:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lBTCs/EyQSwar58n+/JjwbwaSnHhs158e0LdfcFJuo=;
 b=qmjlPLMCtYrcevf+XLq/177ZPM90tHLAa+83neLK0k9R/MY335nxkxz4MX9uKDm7XPsZfJ
 omvWHZbUyQhpNSar/5am+QNePw0Z2MsEQQa3Q2LhSw2kRiHKVhOpLINpRXb2o8Ll3QzC9p
 CNdKa2YJvlltrN5B1P2L8I9BGQhBB44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lBTCs/EyQSwar58n+/JjwbwaSnHhs158e0LdfcFJuo=;
 b=+6CVMGidnujLXy0v8TVyHJM7TODiNnNt2oMdn+cIm2w0b8nJZflqvm0enCcNgXPnGQiF9P
 r/ahs5WwE++K9HCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iXF6c1bn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=70YBWPYV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lBTCs/EyQSwar58n+/JjwbwaSnHhs158e0LdfcFJuo=;
 b=iXF6c1bnzC4avTdKkmjdp7fTLfuMHhAUtv0b7O4/6+xD+twkROc5zm18V3TgTs0kSeNMmC
 yrQqtYjkYRyRRmKwRCsykZvLLqgpEh+OMQ4I+lrK7XUdE9BuqCRlCvnnCp4IxzxwRxwrQt
 l97dd+o1YKoOW0W+So73UFsxZYaDAx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lBTCs/EyQSwar58n+/JjwbwaSnHhs158e0LdfcFJuo=;
 b=70YBWPYVltwjDoLwGgyrnvWDu39rOP7FxXcLQTKJZHI8E3lCnVPLMSThoycqDg/WbKP1Pl
 mQHiJTX9jduMYbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DD1213B21;
 Wed, 30 Sep 2026 22:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T9
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 08/11] qemu-option: Use qemu_opts_parse_list_noisily where
 appropriate
Date: Wed, 30 Sep 2026 19:11:02 -0300
Message-ID: <20260930221105.2262063-9-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 243721F7EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,treblig.org,gmail.com,yandex-team.ru,linux.vnet.ibm.com,web.de];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 RCPT_COUNT_TWELVE(0.00)[13]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Change the callers of qemu_opts_parse_noisily() that currently take a
QemuOptsList pointer to call qemu_opts_parse_list_noisily().

This is done to free up the qemu_opts_parse_noisily() version to be
used to take the group name instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/monitor/block-hmp-cmds.c       | 2 +-
 monitor/hmp.c                        | 2 +-
 net/net.c                            | 2 +-
 qemu-img.c                           | 8 ++++----
 qemu-io-cmds.c                       | 2 +-
 qemu-io.c                            | 7 ++++---
 qemu-nbd.c                           | 6 +++---
 storage-daemon/qemu-storage-daemon.c | 4 ++--
 system/qdev-monitor.c                | 2 +-
 system/tpm.c                         | 2 +-
 system/vl.c                          | 6 +++---
 tests/unit/test-replication.c        | 6 +++---
 tools/qemu-vnc/qemu-vnc.c            | 2 +-
 13 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7bae4d425c..cbd64166ec 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -63,7 +63,7 @@ static void hmp_drive_add_node(MonitorHMP *hmp, const char *optstr)
     QDict *qdict;
     Error *err = NULL;
 
-    opts = qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
+    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, optstr, false);
     if (!opts) {
         return;
     }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937..fc32cfd1ff 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -897,7 +897,7 @@ static QDict *monitor_parse_arguments(MonitorHMP *mon,
                 if (get_str(buf, sizeof(buf), &p) < 0) {
                     goto fail;
                 }
-                opts = qemu_opts_parse_noisily(opts_list, buf, true);
+                opts = qemu_opts_parse_list_noisily(opts_list, buf, true);
                 if (!opts) {
                     goto fail;
                 }
diff --git a/net/net.c b/net/net.c
index d7fa637ce5..37401ab2b4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -2029,7 +2029,7 @@ void netdev_parse_modern(const char *optstr)
 
 void net_client_parse(QemuOptsList *opts_list, const char *optstr)
 {
-    if (!qemu_opts_parse_noisily(opts_list, optstr, true)) {
+    if (!qemu_opts_parse_list_noisily(opts_list, optstr, true)) {
         exit(1);
     }
 }
diff --git a/qemu-img.c b/qemu-img.c
index 2f63d31141..c645de6462 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2383,8 +2383,8 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
-                sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
-                                                  optarg, false);
+                sn_opts = qemu_opts_parse_list_noisily(&internal_snapshot_opts,
+                                                       optarg, false);
                 if (!sn_opts) {
                     error_report("Failed in parsing snapshot param '%s'",
                                  optarg);
@@ -5768,8 +5768,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
-                sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
-                                                  optarg, false);
+                sn_opts = qemu_opts_parse_list_noisily(&internal_snapshot_opts,
+                                                       optarg, false);
                 if (!sn_opts) {
                     error_report("Failed in parsing snapshot param '%s'",
                                  optarg);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index aa795fd87a..6c8c4c9540 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2540,7 +2540,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv, Error **errp)
             has_cache_option = true;
             break;
         case 'o':
-            if (!qemu_opts_parse_noisily(&reopen_opts, optarg, 0)) {
+            if (!qemu_opts_parse_list_noisily(&reopen_opts, optarg, 0)) {
                 qemu_opts_reset(&reopen_opts);
                 return -EINVAL;
             }
diff --git a/qemu-io.c b/qemu-io.c
index 598d5b1c9c..db0ee499e4 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -220,7 +220,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
                 qemu_opts_reset(&empty_opts);
                 return -EINVAL;
             }
-            if (!qemu_opts_parse_noisily(&empty_opts, optarg, false)) {
+            if (!qemu_opts_parse_list_noisily(&empty_opts, optarg, false)) {
                 qemu_opts_reset(&empty_opts);
                 return -EINVAL;
             }
@@ -240,7 +240,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     }
 
     if (imageOpts && (optind == argc - 1)) {
-        if (!qemu_opts_parse_noisily(&empty_opts, argv[optind], false)) {
+        if (!qemu_opts_parse_list_noisily(&empty_opts, argv[optind], false)) {
             qemu_opts_reset(&empty_opts);
             return -EINVAL;
         }
@@ -659,7 +659,8 @@ int main(int argc, char **argv)
     if ((argc - optind) == 1) {
         if (imageOpts) {
             QemuOpts *qopts = NULL;
-            qopts = qemu_opts_parse_noisily(&file_opts, argv[optind], false);
+            qopts = qemu_opts_parse_list_noisily(&file_opts, argv[optind],
+                                                 false);
             if (!qopts) {
                 exit(1);
             }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5895861b..749c915b58 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -706,8 +706,8 @@ int main(int argc, char **argv)
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
-                sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
-                                                  optarg, false);
+                sn_opts = qemu_opts_parse_list_noisily(&internal_snapshot_opts,
+                                                       optarg, false);
                 if (!sn_opts) {
                     error_report("Failed in parsing snapshot param `%s'",
                                  optarg);
@@ -1117,7 +1117,7 @@ int main(int argc, char **argv)
             error_report("--image-opts and -f are mutually exclusive");
             exit(EXIT_FAILURE);
         }
-        o = qemu_opts_parse_noisily(&file_opts, opts.srcpath, true);
+        o = qemu_opts_parse_list_noisily(&file_opts, opts.srcpath, true);
         if (!o) {
             qemu_opts_reset(&file_opts);
             exit(EXIT_FAILURE);
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 50dbfbd97a..5d63ef2efc 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -283,8 +283,8 @@ static void process_options(int argc, char *argv[], bool pre_init_pass)
         case OPTION_CHARDEV:
             {
                 /* TODO This interface is not stable until we QAPIfy it */
-                QemuOpts *opts = qemu_opts_parse_noisily(&qemu_chardev_opts,
-                                                         optarg, true);
+                QemuOpts *opts = qemu_opts_parse_list_noisily(
+                    &qemu_chardev_opts, optarg, true);
                 if (opts == NULL) {
                     exit(EXIT_FAILURE);
                 }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 8185822daa..dc2d9e76bc 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -1204,7 +1204,7 @@ int qemu_global_option(const char *str)
         return 0;
     }
 
-    opts = qemu_opts_parse_noisily(&qemu_global_opts, str, false);
+    opts = qemu_opts_parse_list_noisily(&qemu_global_opts, str, false);
     if (!opts) {
         return -1;
     }
diff --git a/system/tpm.c b/system/tpm.c
index 903b29c043..f0f5a64d9a 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -184,7 +184,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
         tpm_display_backend_drivers();
         exit(EXIT_SUCCESS);
     }
-    opts = qemu_opts_parse_noisily(opts_list, optstr, true);
+    opts = qemu_opts_parse_list_noisily(opts_list, optstr, true);
     if (!opts) {
         return -1;
     }
diff --git a/system/vl.c b/system/vl.c
index 87398cc8d0..bf5146d1c0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3277,7 +3277,7 @@ void qemu_init(int argc, char **argv)
                     error_report("fsdev support is disabled");
                     exit(1);
                 }
-                if (!qemu_opts_parse_noisily(olist, optarg, true)) {
+                if (!qemu_opts_parse_list_noisily(olist, optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3292,7 +3292,7 @@ void qemu_init(int argc, char **argv)
                     error_report("virtfs support is disabled");
                     exit(1);
                 }
-                opts = qemu_opts_parse_noisily(olist, optarg, true);
+                opts = qemu_opts_parse_list_noisily(olist, optarg, true);
                 if (!opts) {
                     exit(1);
                 }
@@ -3644,7 +3644,7 @@ void qemu_init(int argc, char **argv)
                     exit(1);
                 }
 
-                opts = qemu_opts_parse_noisily(olist, optarg, true);
+                opts = qemu_opts_parse_list_noisily(olist, optarg, true);
                 if (!opts) {
                     exit(1);
                 }
diff --git a/tests/unit/test-replication.c b/tests/unit/test-replication.c
index 3aa98e6f56..101f72acdc 100644
--- a/tests/unit/test-replication.c
+++ b/tests/unit/test-replication.c
@@ -179,7 +179,7 @@ static BlockBackend *start_primary(void)
                               "file.driver=qcow2,file.file.filename=%s,"
                               "file.file.locking=off"
                               , p_local_disk);
-    opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
@@ -295,7 +295,7 @@ static BlockBackend *start_secondary(void)
     cmdline = g_strdup_printf("file.filename=%s,driver=qcow2,"
                               "file.locking=off",
                               s_local_disk);
-    opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
@@ -321,7 +321,7 @@ static BlockBackend *start_secondary(void)
                               "file.backing.backing=%s"
                               , S_ID, s_active_disk, s_hidden_disk
                               , S_LOCAL_DISK_ID);
-    opts = qemu_opts_parse_noisily(&qemu_drive_opts, cmdline, false);
+    opts = qemu_opts_parse_list_noisily(&qemu_drive_opts, cmdline, false);
     g_free(cmdline);
 
     qdict = qemu_opts_to_qdict(opts, NULL);
diff --git a/tools/qemu-vnc/qemu-vnc.c b/tools/qemu-vnc/qemu-vnc.c
index 5c2ba3b7a5..10ac76298a 100644
--- a/tools/qemu-vnc/qemu-vnc.c
+++ b/tools/qemu-vnc/qemu-vnc.c
@@ -377,7 +377,7 @@ setup_vnc_opts(const char *vnc_addr, const char *tls_creds_dir,
         g_string_append(opts_str, ",non-adaptive=on");
     }
 
-    opts = qemu_opts_parse_noisily(olist, opts_str->str, true);
+    opts = qemu_opts_parse_list_noisily(olist, opts_str->str, true);
     if (!opts) {
         return false;
     }
-- 
2.53.0


