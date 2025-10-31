Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796B4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 19:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEuP1-00017P-Nu; Fri, 31 Oct 2025 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuOz-00016y-CV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:09 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEuOp-0004Xd-8U
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:03:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3F3CCC0159;
 Fri, 31 Oct 2025 22:02:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id m2mTmi0FnuQ0-hANvvA5b; Fri, 31 Oct 2025 22:02:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761937371;
 bh=N+I1NJouYOnrrHASJrjD5TNHeMpicQO5xeT8Na9pxR0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BRpkslg6GtiLSS3tdVuxE0mR1XTTRjeerbYQQhOCP8yfEsJEoBBnT3LeqOisWklHB
 GpoyrzJH/Ivyq/5kbmsaRT00uvEaBI3179b1fSKUpTE9Yo2TNbki9gDsxGac5DvJ2T
 USCc5j7/OBpFHAGP2aWGIYFa2twW/o4JkKQQEgMM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v2 1/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Date: Fri, 31 Oct 2025 22:02:45 +0300
Message-ID: <20251031190246.257153-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031190246.257153-1-vsementsov@yandex-team.ru>
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
qemu_hexdump_line(). This leads to last line of the dump (when
length is not multiply of 16) has badly aligned ASCII part.

Let's calculate length the same way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 util/hexdump.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/util/hexdump.c b/util/hexdump.c
index f29ffceb74..7cfc547261 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -22,6 +22,19 @@ static inline char hexdump_nibble(unsigned x)
     return (x < 10 ? '0' : 'a' - 10) + x;
 }
 
+static size_t hexdump_line_length(size_t buf_len, size_t unit_len,
+                                  size_t block_len)
+{
+    size_t est = buf_len * 2;
+    if (unit_len) {
+        est += buf_len / unit_len;
+    }
+    if (block_len) {
+        est += buf_len / block_len;
+    }
+    return est;
+}
+
 GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
                            size_t unit_len, size_t block_len)
 {
@@ -30,14 +43,8 @@ GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
 
     if (str == NULL) {
         /* Estimate the length of the output to avoid reallocs. */
-        size_t est = len * 2;
-        if (unit_len) {
-            est += len / unit_len;
-        }
-        if (block_len) {
-            est += len / block_len;
-        }
-        str = g_string_sized_new(est + 1);
+        str = g_string_sized_new(hexdump_line_length(len, unit_len, block_len)
+                                 + 1);
     }
 
     for (u = 0, b = 0; len; u++, b++, len--, buf++) {
@@ -76,13 +83,16 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
 }
 
 #define QEMU_HEXDUMP_LINE_BYTES 16
-#define QEMU_HEXDUMP_LINE_WIDTH \
-    (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
+#define QEMU_HEXDUMP_UNIT 1
+#define QEMU_HEXDUMP_BLOCK 4
 
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
+    int width = hexdump_line_length(QEMU_HEXDUMP_LINE_BYTES,
+                                    QEMU_HEXDUMP_UNIT,
+                                    QEMU_HEXDUMP_BLOCK);
+    g_autoptr(GString) str = g_string_sized_new(width + 1);
     char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
     size_t b, len;
 
@@ -90,11 +100,11 @@ void qemu_hexdump(FILE *fp, const char *prefix,
         len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
 
         g_string_truncate(str, 0);
-        qemu_hexdump_line(str, bufptr + b, len, 1, 4);
+        qemu_hexdump_line(str, bufptr + b, len,
+                          QEMU_HEXDUMP_UNIT, QEMU_HEXDUMP_BLOCK);
         asciidump_line(ascii, bufptr + b, len);
 
-        fprintf(fp, "%s: %04zx: %-*s %s\n",
-                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
+        fprintf(fp, "%s: %04zx: %-*s %s\n", prefix, b, width, str->str, ascii);
     }
 
 }
-- 
2.48.1


