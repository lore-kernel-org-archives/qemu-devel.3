Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gvs-00071v-5N; Tue, 14 Oct 2025 11:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvo-00070H-OB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:21 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gvk-0007h8-JT
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:27:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 80FC18084E;
 Tue, 14 Oct 2025 18:27:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7RRbiX2F1mI0-jg6F337t; Tue, 14 Oct 2025 18:27:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760455633;
 bh=bC9Y5ShAH+SVjgWS9ppwse+2lSNdalehyTgtqyTpO3c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wQ9jpq/Kh5qDfoNBc2PSAge5/tQBQhq9s9A3LvR6asBB+qz/veeWbjGA48qGRUSeP
 Uc857nts+vuWC22I8IxH/TsKohGi3vWcEiue2h0+9GD0/EhIV7HGqi5d10BaJ4J+nN
 n6TeALriqQbGq7NmOgQANi8mk9AX7szZHGXyC41k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v3 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
Date: Tue, 14 Oct 2025 18:26:44 +0300
Message-ID: <20251014152644.954762-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014152644.954762-1-vsementsov@yandex-team.ru>
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
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

For further vhost-user-blk backend-transfer migration realization we
want to give it (vhost-user-blk) a possibility (and responsibility) to
decide when do connect.

For incoming migration we'll need to postpone connect at least until
early stage of migrate-incoming command, when we already know all
migration parameters and can decide, are we going to do incoming
backend-transfer (and get chardev fd from incoming stream), or we
finally need to connect.

With this patch, we only provide new macro, to define chardev property,
later it will be used in vhost-user-blk instead of DEFINE_PROP_CHR.
Then, vhost-user-blk will call qemu_chr_connect() by hand when needed
(for example through qemu_chr_fe_wait_connected(), which is already
called in vhost_user_blk_realize_connect()).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-fe.c                   | 10 ++++++++--
 hw/core/qdev-properties-system.c    | 26 +++++++++++++++++++++++---
 include/chardev/char-fe.h           |  6 +++++-
 include/hw/qdev-properties-system.h |  3 +++
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 973fed5bea..a0218393e4 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -189,11 +189,12 @@ bool qemu_chr_fe_backend_open(CharBackend *be)
     return be->chr && be->chr->be_open;
 }
 
-bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
+bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, bool connect,
+                         Error **errp)
 {
     unsigned int tag = 0;
 
-    if (!qemu_chr_connect(s, errp)) {
+    if (connect && !qemu_chr_connect(s, errp)) {
         return false;
     }
 
@@ -218,6 +219,11 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
     return true;
 }
 
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
+{
+    return qemu_chr_fe_init_ex(b, s, true, errp);
+}
+
 void qemu_chr_fe_deinit(CharBackend *b, bool del)
 {
     assert(b);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1f810b7ddf..6a0572ca03 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -266,8 +266,8 @@ static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     g_free(p);
 }
 
-static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
-                    Error **errp)
+static void do_set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
+                       bool connect, Error **errp)
 {
     ERRP_GUARD();
     const Property *prop = opaque;
@@ -297,13 +297,25 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     if (s == NULL) {
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
                    object_get_typename(obj), name, str);
-    } else if (!qemu_chr_fe_init(be, s, errp)) {
+    } else if (!qemu_chr_fe_init_ex(be, s, connect, errp)) {
         error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
                       object_get_typename(obj), name, str);
     }
     g_free(str);
 }
 
+static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    do_set_chr(obj, v, name, opaque, true, errp);
+}
+
+static void set_chr_no_connect(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    do_set_chr(obj, v, name, opaque, false, errp);
+}
+
 static void release_chr(Object *obj, const char *name, void *opaque)
 {
     const Property *prop = opaque;
@@ -320,6 +332,14 @@ const PropertyInfo qdev_prop_chr = {
     .release = release_chr,
 };
 
+const PropertyInfo qdev_prop_chr_no_connect = {
+    .type  = "str",
+    .description = "ID of a chardev to use as a backend",
+    .get   = get_chr,
+    .set   = set_chr_no_connect,
+    .release = release_chr,
+};
+
 /* --- mac address --- */
 
 /*
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8ef05b3dd0..32013623b3 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -25,15 +25,19 @@ struct CharBackend {
 };
 
 /**
- * qemu_chr_fe_init:
+ * qemu_chr_fe_init(_ex):
  *
  * Initializes a front end for the given CharBackend and
  * Chardev. Call qemu_chr_fe_deinit() to remove the association and
  * release the driver.
+ * Call qemu_chr_connect(), except for the case when connect=false
+ * parameter set for _ex() version.
  *
  * Returns: false on error.
  */
 bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
+bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, bool connect,
+                         Error **errp);
 
 /**
  * qemu_chr_fe_deinit:
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 9601a11a09..41f68f60b9 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -7,6 +7,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
                                        Error **errp);
 
 extern const PropertyInfo qdev_prop_chr;
+extern const PropertyInfo qdev_prop_chr_no_connect;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
@@ -39,6 +40,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 
 #define DEFINE_PROP_CHR(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
+#define DEFINE_PROP_CHR_NO_CONNECT(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_chr_no_connect, CharBackend)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
-- 
2.48.1


