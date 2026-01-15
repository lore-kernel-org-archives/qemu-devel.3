Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1D1D44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOcq-0005aG-E1; Thu, 15 Jan 2026 09:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOcH-0004kF-Rf
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:43 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgOcC-0002rc-On
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:46:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bca6:0:640:3d05:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 54D4EC0209;
 Thu, 15 Jan 2026 17:46:21 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b8d::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8kWwj30BHuQ0-7J5TUSWO; Thu, 15 Jan 2026 17:46:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768488380;
 bh=H/bX/Anw/6rlKINMAotFT7jwt9W/yiN609ztiVY5So0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=P3g4qcF8Xf+23YP2Pfee4p+CWC25kcw5+HMDhl4Bnex7exHTKkgUDeno9eqnxXssJ
 i9+XJjFgFQbD83QLU/Pnb39zW1mJNtY3/Mb0n4XF7RiG++3vBThhedK+90N8+tMAaA
 4ttB/bWQMba68lcbEI/OjCdJIhwB2utL4armwJ2c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/10] chardev/char: qemu_char_open(): add return value
Date: Thu, 15 Jan 2026 17:46:04 +0300
Message-ID: <20260115144606.233252-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115144606.233252-1-vsementsov@yandex-team.ru>
References: <20260115144606.233252-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Accordingly with recommendations in include/qapi/error.h accompany
errp by boolean return value and get rid of error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index ef0cdffd3f..5bda43c6e7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -246,7 +246,7 @@ int qemu_chr_add_client(Chardev *s, int fd)
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
-static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
+static bool qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
@@ -262,13 +262,15 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         }
         chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
         if (chr->logfd < 0) {
-            return;
+            return false;
         }
     }
 
-    if (cc->chr_open) {
-        cc->chr_open(chr, backend, errp);
+    if (!cc->chr_open) {
+        return true;
     }
+
+    return cc->chr_open(chr, backend, errp);
 }
 
 static void char_init(Object *obj)
@@ -1006,7 +1008,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    Error *local_err = NULL;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1017,9 +1018,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
     chr->label = g_strdup(id);
     chr->gcontext = gcontext;
 
-    qemu_char_open(chr, backend, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!qemu_char_open(chr, backend, errp)) {
         object_unref(obj);
         return NULL;
     }
-- 
2.52.0


