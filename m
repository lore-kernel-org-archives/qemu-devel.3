Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2355CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUdc-0003OH-98; Sat, 13 Jun 2026 16:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUcM-0001fJ-Vz; Sat, 13 Jun 2026 16:06:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUcK-0000bH-Mz; Sat, 13 Jun 2026 16:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381068; bh=DJZuAd6uoTybgvHP17Px/QZ+fzo7XTUkf9sXHlZo+24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tffcVPVdOIqYv1CY8KA9FmPUt3J+XOxdB28H1PomO8frHNIqOGs1RQprLBORkPiuY
 mQs+V8+xyrHfeY0NmoGRomzZCkq/bJGN4907Pos003WOr9mOaPvgYO7SJ8YRnaIGwb
 4ySahaEvFsWgWAZy6nPJLbLmDZi7mxf88FpbzBPMV4lXEdGP1DMxDFk994sm97kzEW
 Tras/cqDBlLAxFHZoNvMUu0nOHsxPHqrt91ah1IOjLZquF4JW+UYjskDP0GblW+DVW
 wAtqmhZhSxS/meR3meJemuBrC/pcolBhhQS/zf5SylO3VZ3y/r6N31SLDgwafKzOHd
 Ox9NlEtuUXnzQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35D841B6E7B;
 Sat, 13 Jun 2026 23:04:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8FC773CE8DE;
 Sat, 13 Jun 2026 23:04:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Heechan Kang <gganji11@naver.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 20/61] ui: fix validation of VNC extended clipboard
 data length
Date: Sat, 13 Jun 2026 23:03:03 +0300
Message-ID: <20260613200411.1808021-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Heechan Kang <gganji11@naver.com>

QEMU's VNC extended clipboard handler inflates a client-controlled
compressed clipboard payload. The code checks the declared text size
against the total inflated buffer size:

    if (tsize < size)

but then copies from:

    tbuf = buf + 4;
    qemu_clipboard_set_data(..., tsize, tbuf, true);

The correct bound is the remaining data length after the 4-byte length
field, not the total inflated buffer length.

As a result, a VNC client can make QEMU copy up to 3 bytes past the end
of the inflated heap buffer. With a second VNC client, those copied
bytes are observable through the normal VNC extended clipboard PROVIDE
path.

Fixes: CVE-2026-8343
Reported-by: Heechan Kang <gganji11@naver.com>
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Heechan Kang <gganji11@naver.com>
[DB: added #include and 'return' statements]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260512095543.459949-1-berrange@redhat.com>
(cherry picked from commit e56b4bbff1df260487b80abe1f967f687fa115d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 124b6fbd9c..fa05d86f42 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
 
@@ -282,10 +283,16 @@ void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t
             buf && size >= 4) {
             uint32_t tsize = read_u32(buf, 0);
             uint8_t *tbuf = buf + 4;
-            if (tsize < size) {
+            if (tsize <= size - 4) {
                 qemu_clipboard_set_data(&vs->cbpeer, vs->cbinfo,
                                         QEMU_CLIPBOARD_TYPE_TEXT,
                                         tsize, tbuf, true);
+            } else {
+                error_report("vnc: malformed extended clipboard payload "
+                             "with text length %u exceeding available %u",
+                             tsize, size - 4);
+                vnc_client_error(vs);
+                return;
             }
         }
     }
-- 
2.47.3


