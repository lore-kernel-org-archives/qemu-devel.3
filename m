Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E3FD116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 13:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLFh-0005Pk-E6; Sat, 29 Nov 2025 08:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFZ-0005OH-Ix
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:34 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vPLFW-0002Yj-UN
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 08:44:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9FD9E80880;
 Sat, 29 Nov 2025 16:44:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:891::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Iigm2k0FK8c0-aURnXYtc; Sat, 29 Nov 2025 16:44:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764423869;
 bh=LDJBwEe0WyOZ3uhZLQNadmppxccnqU6Wlab8d4muJ8U=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=v51XC/VbvtYaVKcvZY26DUPp2aj2LPJGt7xWliPFkqUF6FmLFDp4VCNA3lA7K6jTx
 d3zEz/s6h+wjKJNpGjIt6oHyJcLAmyGaVpiTU0ZZTjG1yME8dkN+/6k80qIK/glfyY
 Hl3uRT3NK/gZcKRZNKfyaNLIuVOCK+BpJrrWamMs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 8/8] chardev/char: qemu_char_open(): add return value
Date: Sat, 29 Nov 2025 16:43:48 +0300
Message-ID: <20251129134350.487839-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129134350.487839-1-vsementsov@yandex-team.ru>
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
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

Accordingly with recommendations in include/qapi/error.h accompany
errp by boolean return value and get rid of error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index bdd907f015..fadbda5907 100644
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
+    if (cc->chr_open && !cc->chr_open(chr, backend, errp)) {
+        return false;
     }
+
+    return true;
 }
 
 static void char_init(Object *obj)
@@ -1007,7 +1009,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    Error *local_err = NULL;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1018,9 +1019,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
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
2.48.1


