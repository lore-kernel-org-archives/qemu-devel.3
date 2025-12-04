Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA32FD2A52D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 20:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFuq-0006gd-PE; Thu, 04 Dec 2025 15:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFup-0006fr-J5
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:03 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFum-0003FC-Fu
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0DED080894;
 Thu, 04 Dec 2025 23:26:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sQswCW0FbOs0-qzfAlpcd; Thu, 04 Dec 2025 23:26:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764880016;
 bh=IaYZUp7ZUL709VuIKvjMZA9R7NxLlzhM+rvt6Zd10cA=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=rZORRaZHqxXLIfm5RSKfu7vCFEdnBjchegSftyCwfI+4qtoT0cGbI/6zG3AvTLgSr
 Wy0xu0L5Yu/CUD1qrH4GxrqZBMXD2jDkg1bc+6xGG0p/7TY0/7DV1SO6CZJh3B8OKU
 yLRvtiey5oyuk0ie/FADoMcTrVoIbh2lNaERbasE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 1/3] char: qemu_chr_write_log() use qemu_write_full()
Date: Thu,  4 Dec 2025 23:26:46 +0300
Message-ID: <20251204202653.597319-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204202653.597319-1-vsementsov@yandex-team.ru>
References: <20251204202653.597319-1-vsementsov@yandex-team.ru>
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

logfd is blocking, so we don't need to care about EAGAIN.
Let's simply use qemu_write_full().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5..64006a3119 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -82,29 +82,17 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
 }
 
-/* Not reporting errors from writing to logfile, as logs are
- * defined to be "best effort" only */
 static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
 {
-    size_t done = 0;
-    ssize_t ret;
-
     if (s->logfd < 0) {
         return;
     }
 
-    while (done < len) {
-    retry:
-        ret = write(s->logfd, buf + done, len - done);
-        if (ret == -1 && errno == EAGAIN) {
-            g_usleep(100);
-            goto retry;
-        }
-
-        if (ret <= 0) {
-            return;
-        }
-        done += ret;
+    if (qemu_write_full(s->logfd, buf, len) < len) {
+        /*
+         * qemu_write_full() is defined with G_GNUC_WARN_UNUSED_RESULT,
+         * but logging is best‑effort, we do ignore errors.
+         */
     }
 }
 
-- 
2.48.1


