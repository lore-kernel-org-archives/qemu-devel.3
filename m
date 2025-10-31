Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C29CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErXd-0007B8-8z; Fri, 31 Oct 2025 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXS-00077z-9w
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vErXG-0005zp-3H
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:59:40 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BC149806C1;
 Fri, 31 Oct 2025 18:59:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fxip9o0FqiE0-YPIAS6Mu; Fri, 31 Oct 2025 18:59:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761926362;
 bh=vY0OE5QMEqzOyQE29iXX8SgUTFf8mtXdoyKSkyX34oo=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=MiJI5MtN+5sLgcvaYur4m//+guUtiklooZ3wwWsWYaqwUrUWbkSh85MeadhvMJX7Z
 KGzzgyIyNBk6PqVHT8FSpnotaYjv+J8k94lrd0kWuE7/VnNMG9mL22uCQrz1pu6++T
 tK6xZoCTqqShHvio2CQqAAXt+mBOmxpNoeKEypks=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v5 4/7] chardev/char: move filename and be_opened handling to
 qemu_char_open()
Date: Fri, 31 Oct 2025 18:59:11 +0300
Message-ID: <20251031155914.189112-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155914.189112-1-vsementsov@yandex-team.ru>
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Absent filename and necessity to send CHR_EVENT_OPENED are artifacts
of .open(). Handle them in qemu_char_open().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3e9a274d7d..7a029b0eb9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -247,18 +247,27 @@ int qemu_chr_add_client(Chardev *s, int fd)
 }
 
 static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
-                           bool *be_opened, Error **errp)
+                           const char *default_filename, Error **errp)
 {
     ERRP_GUARD();
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    bool be_opened = true;
 
     if (cc->open) {
-        cc->open(chr, backend, be_opened, errp);
+        cc->open(chr, backend, &be_opened, errp);
         if (*errp) {
             return false;
         }
     }
 
+    if (!chr->filename) {
+        chr->filename = g_strdup(default_filename);
+    }
+
+    if (be_opened) {
+        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    }
+
     return true;
 }
 
@@ -1021,7 +1030,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
 {
     Object *obj;
     Chardev *chr = NULL;
-    bool be_opened = true;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1036,17 +1044,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    if (!qemu_char_open(chr, backend, &be_opened, errp)) {
+    if (!qemu_char_open(chr, backend, typename + 8, errp)) {
         goto fail;
     }
 
-    if (!chr->filename) {
-        chr->filename = g_strdup(typename + 8);
-    }
-    if (be_opened) {
-        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-    }
-
     return chr;
 
 fail:
-- 
2.48.1


