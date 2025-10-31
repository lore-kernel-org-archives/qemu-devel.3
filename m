Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C189CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErXd-0007Ac-1s; Fri, 31 Oct 2025 11:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXN-00076V-Bo
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXG-0005zy-3Z
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:37 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 14EF28088A;
 Fri, 31 Oct 2025 18:59:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fxip9o0FqiE0-bF6TNGtS; Fri, 31 Oct 2025 18:59:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761926363;
 bh=K896VjWcrOPIeJ05AQfDV1xDA9uM8UKPhfeRgDqDo1E=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=TovYVN1YSWFtnx8HZ+/ALzZ2+Ye/bQ1/EvHSVOTCGrhGtYskXuF/kxnKmR0AJ/2dF
 r9uWSZOpFWiAFRPB3NNF0eJflxiHPXx+1QCQYVPMsZT+XKZSjNyrC0X/6aM/+XSXs5
 XITv8Lv1POGl3EkEGEWGJHtDYqE5pdnGlcr41LoY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v5 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
Date: Fri, 31 Oct 2025 18:59:12 +0300
Message-ID: <20251031155914.189112-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155914.189112-1-vsementsov@yandex-team.ru>
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
at time of attaching frontend, or from qemu_chr_wait_connected().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-fe.c      |  4 ++++
 chardev/char.c         | 39 +++++++++++++++++++++++++++++++++++++--
 include/chardev/char.h | 30 +++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 34b83fc1c4..c67b4d640f 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
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
index 7a029b0eb9..33eba0cdc0 100644
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
@@ -1030,6 +1050,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
+    ChardevClass *cc;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1044,8 +1065,22 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    if (!qemu_char_open(chr, backend, typename + 8, errp)) {
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
index b65e9981c1..24c449b07b 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -63,6 +63,7 @@ struct Chardev {
     CharFrontend *fe;
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
@@ -259,7 +261,33 @@ struct ChardevClass {
     /* parse command line options and populate QAPI @backend */
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
-    /* called after construction, open/starts the backend */
+    /*
+     * Called after construction, create the backend, mutually exclusive
+     * with @open, and should be followed by @connect().
+     * Must set the Chardev's chr->filename on success.
+     */
+    bool (*init)(Chardev *chr, ChardevBackend *backend,
+                 Error **errp);
+
+    /*
+     * Called after @init(), starts the backend, mutually exclusive
+     * with @open. Should care to send CHR_EVENT_OPENED when connected
+     * (this may happen asynchronously after .connect() call alredy
+     * returned).
+     */
+    bool (*connect)(Chardev *chr, Error **errp);
+
+    /*
+     * Called after construction, an alternative to @init + @connect
+     * and should do the work for both: create and start the backend.
+     * Mutually exclusive with @init and @connect.
+     *
+     * May not set the Chardev's chr->filename (generic code will care),
+     * and may not send CHR_EVENT_OPENED when connected (@be_opened
+     * should not be touched in this case, to signal the generic code
+     * to care about CHR_EVENT_OPENED). If the backend cares about
+     * CHR_EVENT_OPENED, it should set @be_opened to false.
+     */
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
-- 
2.48.1


