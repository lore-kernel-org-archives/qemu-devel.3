Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C2CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98vl-0004Xc-Q7; Wed, 15 Oct 2025 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98vk-0004WD-3b
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:21:08 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v98vd-0001zU-PT
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:21:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8149388438;
 Thu, 16 Oct 2025 00:20:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rKYpxt3F20U0-vjjJ7dYS; Thu, 16 Oct 2025 00:20:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760563258;
 bh=mAcgyU8pWURnH1Cci2ISyWqlwVQRNioOv0+KYPy8xKQ=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=dDv2NcWtq8FYgVbl9YgqsxwdZI1LfVkt6cDi6thgJKMqsU9X9qrMFCRmyZbkAMV1l
 CwqB43CFVy4Bfb0FHXdoupv3Mfswzf5H6abXQcsiH+qJ3aqQkoYfkdkcg7QJbxjnza
 Zxl7LexQjzsTHdfYZWFgX4FHLijP9w35LcnvX8ME=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, raphael@enfabrica.net,
 armbru@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v4 4/7] chardev/char: move filename and be_opened handling to
 qemu_char_open()
Date: Thu, 16 Oct 2025 00:20:48 +0300
Message-ID: <20251015212051.1156334-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
References: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
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

Absent filename and necessity to send CHR_EVENT_OPENED are artifacts
of .open(). Handle them in qemu_char_open().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index c874a2d31e..27290e26fb 100644
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


