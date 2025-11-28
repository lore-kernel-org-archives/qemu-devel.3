Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1163AD116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 20:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP4j6-0002WW-0c; Fri, 28 Nov 2025 15:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4j1-0002UR-JR
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:51 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4ix-0000Ru-DS
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 149B681172;
 Fri, 28 Nov 2025 23:05:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:894::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b5mcgZ0FDuQ0-XltlNhT2; Fri, 28 Nov 2025 23:05:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764360339;
 bh=SeytG3v7nZ3UnEGfTy35SUMEpij0sc1khpDxV0rfvUM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vSoZv8sXcfRYYXlzPhiefuxsDHjkaylT300KqB1pZ4pP23fnf3dYe7MyN1o0zel2m
 PjyfsT91UggBZVI2Gms922V8YU4ERsVhct/orVWaBD2p5lvGymyo4VhTLxLk+gTHdX
 Q5InP8JEBYIs750/slsg/5UVD/9z4qxXoySmnLns=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH 3/3] chardev: add logtimestamp option
Date: Fri, 28 Nov 2025 23:05:35 +0300
Message-ID: <20251128200536.207344-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251128200536.207344-1-vsementsov@yandex-team.ru>
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add an option to inject timestamps into serial log file.
That simplifies debugging a lot, when you can simply compare
QEMU logs with guest console logs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char.c         | 63 ++++++++++++++++++++++++++++++++++++++----
 include/chardev/char.h |  2 ++
 qapi/char.json         |  6 +++-
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 64006a3119..57c65544d0 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -82,12 +82,8 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
 }
 
-static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
+static void do_write_log(Chardev *s, const uint8_t *buf, size_t len)
 {
-    if (s->logfd < 0) {
-        return;
-    }
-
     if (qemu_write_full(s->logfd, buf, len) < len) {
         /*
          * qemu_write_full() is defined with G_GNUC_WARN_UNUSED_RESULT,
@@ -96,6 +92,55 @@ static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
     }
 }
 
+static void do_write_log_timestamps(Chardev *s, const uint8_t *buf, size_t len)
+{
+    g_autofree char *timestr = NULL;
+
+    while (len) {
+        size_t i;
+
+        if (s->log_line_start) {
+            if (!timestr) {
+                timestr = real_time_iso8601();
+            }
+            do_write_log(s, (const uint8_t *)timestr, strlen(timestr));
+            do_write_log(s, (const uint8_t *)" ", 1);
+            s->log_line_start = false;
+        }
+
+        for (i = 0; i < len; i++) {
+            if (buf[i] == '\n') {
+                break;
+            }
+        }
+
+        if (i == len) {
+            /* not found \n */
+            do_write_log(s, buf, len);
+            return;
+        }
+
+        i += 1;
+        do_write_log(s, buf, i);
+        buf += i;
+        len -= i;
+        s->log_line_start = true;
+    }
+}
+
+static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
+{
+    if (s->logfd < 0) {
+        return;
+    }
+
+    if (s->logtimestamp) {
+        do_write_log_timestamps(s, buf, len);
+    } else {
+        do_write_log(s, buf, len);
+    }
+}
+
 static int qemu_chr_write_buffer(Chardev *s,
                                  const uint8_t *buf, int len,
                                  int *offset, bool write_all)
@@ -249,6 +294,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
         } else {
             flags |= O_TRUNC;
         }
+        chr->logtimestamp = common->has_logtimestamp && common->logtimestamp;
         chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
         if (chr->logfd < 0) {
             return;
@@ -266,6 +312,7 @@ static void char_init(Object *obj)
 
     chr->handover_yank_instance = false;
     chr->logfd = -1;
+    chr->log_line_start = true;
     qemu_mutex_init(&chr->chr_write_lock);
 
     /*
@@ -505,6 +552,9 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend)
     backend->logfile = g_strdup(logfile);
     backend->has_logappend = true;
     backend->logappend = qemu_opt_get_bool(opts, "logappend", false);
+
+    backend->has_logtimestamp = true;
+    backend->logtimestamp = qemu_opt_get_bool(opts, "logtimestamp", false);
 }
 
 static const ChardevClass *char_get_class(const char *driver, Error **errp)
@@ -956,6 +1006,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "logappend",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "logtimestamp",
+            .type = QEMU_OPT_BOOL,
         },{
             .name = "mouse",
             .type = QEMU_OPT_BOOL,
diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c1..6a5318c918 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -64,6 +64,8 @@ struct Chardev {
     char *label;
     char *filename;
     int logfd;
+    bool logtimestamp;
+    bool log_line_start;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
     bool handover_yank_instance;
diff --git a/qapi/char.json b/qapi/char.json
index 140614f82c..a4abafa680 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -197,11 +197,15 @@
 # @logappend: true to append instead of truncate (default to false to
 #     truncate)
 #
+# @logtimestamp: true to insert timestamps into logfile
+#     (default false) (since 11.0)
+#
 # Since: 2.6
 ##
 { 'struct': 'ChardevCommon',
   'data': { '*logfile': 'str',
-            '*logappend': 'bool' } }
+            '*logappend': 'bool',
+            '*logtimestamp': 'bool' } }
 
 ##
 # @ChardevFile:
-- 
2.48.1


