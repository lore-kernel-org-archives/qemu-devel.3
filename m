Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B1CE9E2FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9No-0001Ja-8p; Wed, 11 Feb 2026 07:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9Ne-00018T-4y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq9Nc-0000NK-CK
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770813099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oafPsMhhX2LYktt1mZytvPrd7reHuMI6cpisN3UVjHk=;
 b=aj445UeDgTtmkriiBG7dMmAJdELD6NkG3uNoUrYCkXLQeRhs/lu2oggiW//LVwmuDYX8yX
 s2uVXbaRM27ZmXdwLVlJWoxOBC+YZ2h2GJ3mTqXfwoQg/+fncAq2fneyq1de2EX0h0EVMQ
 B0L70j63ZFcaaIbKdoIWj0aQfzmc5iE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-WIujemrANsyyw5L1QkdvYg-1; Wed,
 11 Feb 2026 07:31:36 -0500
X-MC-Unique: WIujemrANsyyw5L1QkdvYg-1
X-Mimecast-MFC-AGG-ID: WIujemrANsyyw5L1QkdvYg_1770813094
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C10951955F27; Wed, 11 Feb 2026 12:31:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D7B130001BF; Wed, 11 Feb 2026 12:31:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Eric Blake <eblake@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 14/14] chardev: add logtimestamp option
Date: Wed, 11 Feb 2026 16:30:01 +0400
Message-ID: <20260211123007.3569932-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
References: <20260211123007.3569932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add an option to inject timestamps into serial log file.
That simplifies debugging a lot, when you can simply compare
QEMU logs with guest console logs.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260201173633.413934-4-vsementsov@yandex-team.ru>
---
 qapi/char.json         |  6 +++-
 include/chardev/char.h |  2 ++
 chardev/char.c         | 63 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 140614f82c3..a4abafa6803 100644
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
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 81bc0cbdf2a..c2c42e4b7a3 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -63,6 +63,8 @@ struct Chardev {
     CharFrontend *fe;
     char *label;
     int logfd;
+    bool logtimestamp;
+    bool log_line_start;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
     bool handover_yank_instance;
diff --git a/chardev/char.c b/chardev/char.c
index 4b285baf029..48b326d57b9 100644
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
@@ -248,6 +293,7 @@ static bool qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         } else {
             flags |= O_TRUNC;
         }
+        chr->logtimestamp = common->has_logtimestamp && common->logtimestamp;
         chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
         if (chr->logfd < 0) {
             return false;
@@ -267,6 +313,7 @@ static void char_init(Object *obj)
 
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
-- 
2.52.0


