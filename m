Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1FDCCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IlO-0006fW-AB; Mon, 13 Oct 2025 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlI-0006dB-Kj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlC-0006au-Ga
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1010680859;
 Mon, 13 Oct 2025 16:38:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ccOm1D2F0Cg0-QxzBLNKH; Mon, 13 Oct 2025 16:38:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760362723;
 bh=gGtQ/UnrHXk+W76Hl4SsEutQEnTKqDNL1Q6CcvGaUIY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IqyxXYHo9C/bPmKjukby+OUSBpqEcfFmLT7YD9mUCiqrF/bsBPNi//6EGeaa/GPx3
 EP9GqrvK7GlK/8uA2JmNJHmLE9AkUxNLzOrHSoW2y7sIVO2eM2v41rUR+JlJGG8wn2
 7fOCIRcTSdPKV2C13+Vwo5anASJbA9ePnoNH1x5U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
Date: Mon, 13 Oct 2025 16:38:34 +0300
Message-ID: <20251013133836.852018-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013133836.852018-1-vsementsov@yandex-team.ru>
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll need a possibility to postpone connect step to later point in
time to implement backend-transfer migration feature for vhost-user-blk
in further commits. Let's start with new char interface for backends.

.init() takes QAPI parameters and should parse them, called early

.connect() should actually establish a connection, and postponed to
the point of attaching to frontend. Called at later point, either
at time of attaching frontend, either from qemu_chr_wait_connected().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-fe.c      |  4 ++++
 chardev/char.c         | 40 +++++++++++++++++++++++++++++++++++++---
 include/chardev/char.h | 22 +++++++++++++++++++++-
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 158a5f4f55..973fed5bea 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     unsigned int tag = 0;
 
+    if (!qemu_chr_connect(s, errp)) {
+        return false;
+    }
+
     if (s) {
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
diff --git a/chardev/char.c b/chardev/char.c
index 6498d53daa..01ffe37acf 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
+#include "qom/object.h"
 #include "system/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
@@ -338,10 +339,29 @@ static bool qemu_chr_is_busy(Chardev *s)
     }
 }
 
+bool qemu_chr_connect(Chardev *chr, Error **errp)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+
+    if (chr->connect_postponed) {
+        assert(cc->connect);
+        chr->connect_postponed = false;
+        if (!cc->connect(chr, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
+    if (!qemu_chr_connect(chr, errp)) {
+        return -1;
+    }
+
     if (cc->chr_wait_connected) {
         return cc->chr_wait_connected(chr, errp);
     }
@@ -1029,7 +1049,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    Error *local_err = NULL;
+    ChardevClass *cc;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1044,8 +1064,22 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    if (!qemu_char_open(chr, backend, typename + 8, &local_err)) {
-        goto fail;
+    cc = CHARDEV_GET_CLASS(chr);
+
+    if (cc->init) {
+        assert(!cc->open);
+        assert(cc->connect);
+
+        if (!cc->init(chr, backend, errp)) {
+            goto fail;
+        }
+        assert(chr->filename);
+
+        chr->connect_postponed = true;
+    } else {
+        if (!qemu_char_open(chr, backend, typename + 8, errp)) {
+            goto fail;
+        }
     }
 
     return chr;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 429852f8d9..ebadaf3482 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -63,6 +63,7 @@ struct Chardev {
     CharBackend *be;
     char *label;
     char *filename;
+    bool connect_postponed;
     int logfd;
     int be_open;
     /* used to coordinate the chardev-change special-case: */
@@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
                                 bool permit_mux_mon);
 int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
+bool qemu_chr_connect(Chardev *chr, Error **errp);
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 
 #define TYPE_CHARDEV "chardev"
@@ -259,10 +261,28 @@ struct ChardevClass {
     /* parse command line options and populate QAPI @backend */
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
-    /* called after construction, open/starts the backend */
+    /*
+     * Called after construction, create and open/starts the backend,
+     * mutual exclusive with .init. .connect must not be defined when
+     * .open is defined.
+     */
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
+    /*
+     * Called after construction, create the backend, mutual exclusive
+     * with .open, and must be accompanied by .connect.
+     * Must set chr-filename.
+     */
+    bool (*init)(Chardev *chr, ChardevBackend *backend,
+                 Error **errp);
+
+    /*
+     * Called after .init(), open/starts the backend, mutual exclusive
+     * with .open. Must send CHR_EVENT_OPENED.
+     */
+    bool (*connect)(Chardev *chr, Error **errp);
+
     /* write buf to the backend */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
 
-- 
2.48.1


