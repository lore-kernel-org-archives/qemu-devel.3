Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1AACCD18E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IlK-0006dg-LT; Mon, 13 Oct 2025 09:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlI-0006dA-Kg
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8IlC-0006aj-Iu
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:38:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 55F5D80867;
 Mon, 13 Oct 2025 16:38:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a50::1:2a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ccOm1D2F0Cg0-JHwB3Czw; Mon, 13 Oct 2025 16:38:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760362722;
 bh=FgcMsYI1bn9hUGlF235jK8ao8kgyOs3Gy+xNQW4udsE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LuqU+FZdMGKVyNHA9SVRnxoxnWjoT4yqUANodlWIcKqt+j5glJ5t4Ikit1tAayWMd
 cKFiniDH6YdXbGc+VEbUGkzdMRDiOfkpQwJOgxZOLToQZx/9zcLjil5DvSS5EwOoFX
 HERAFgS2AiJjryipwR5LlAhGAxHVecKiRVqIprp4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 4/7] chardev/char: move filename and be_opened handling to
 qemu_char_open()
Date: Mon, 13 Oct 2025 16:38:33 +0300
Message-ID: <20251013133836.852018-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013133836.852018-1-vsementsov@yandex-team.ru>
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
---
 chardev/char.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 64ec60c0f2..6498d53daa 100644
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
     Object *obj;
     Chardev *chr = NULL;
     Error *local_err = NULL;
-    bool be_opened = true;
 
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
@@ -1036,17 +1044,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
         goto fail;
     }
 
-    if (!qemu_char_open(chr, backend, &be_opened, &local_err)) {
+    if (!qemu_char_open(chr, backend, typename + 8, &local_err)) {
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


