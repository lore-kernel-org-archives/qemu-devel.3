Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051A1C79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbD-0001Bo-Rh; Fri, 04 Sep 2026 00:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kmj-0004S5-0X; Thu, 03 Sep 2026 23:40:13 -0400
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kmh-000387-2x; Thu, 03 Sep 2026 23:40:12 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c7fb79dd;
 Fri, 4 Sep 2026 11:30:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable@nongnu.org,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] chardev/baum: unregister the brlapi fd handler on finalize
Date: Fri,  4 Sep 2026 11:30:55 +0800
Message-ID: <20260904033055.413-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a78272203a1kunm1f59f1f324014
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkMYVkkeH0hPSB1OTU8fHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=GMdFjmalRyx7HRFVgxAzMwv05ylIPDxU8oNqY4pRX+zgU8VD0Ye2jDPQ+PRyQXZtPLDJgtvpFn5x4ObNPWAd017HS8RtqvF2J2yMnjuqrMUOOZWlFKp3g+YzJy2KFwHYSQZ4+cAQe2fXZCdmRFGd7nIfpg9GpPmmYnvcqNNqNNc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=i4UF+zUntchigIYSg8PqU5rjlNCTdMQXlfUMw2DUtqY=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.254.49.197; envelope-from=getshell@seu.edu.cn;
 helo=mail-m49197.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

baum_chr_open() registers baum->brlapi_fd with the main loop through a
raw qemu_set_fd_handler() call.  The chardev base class does not know
about this handler, and char_braille_finalize() only closes the brlapi
connection and frees the handle; it never removes the fd handler.

When the chardev is removed at runtime (QMP chardev-remove /
object_unparent), BaumChardev is finalized and freed while the main loop
still holds an fd handler whose opaque points to the freed object.  The
next time brlapi_fd becomes readable (or the connection drops) the loop
calls baum_chr_read() with a dangling opaque, dereferencing freed
memory -> host use-after-free.

Unregister the handler in char_braille_finalize() before tearing the
connection down, using the same descriptor that baum_chr_open()
registered, and NULL the handle afterwards as a belt-and-braces guard.
Only do so while baum->brlapi is valid: baum_chr_open() sets
baum->brlapi_fd from brlapi__openConnection(), which is
BRLAPI_INVALID_FILE_DESCRIPTOR on failure, and that error path already
g_free()s the handle and returns before any handler is installed.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 chardev/baum.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/chardev/baum.c b/chardev/baum.c
index ac1e535ba8..6d9df70c7e 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -671,8 +671,16 @@ static void char_braille_finalize(Object *obj)
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
+        /*
+         * baum_chr_open() registered brlapi_fd with the main loop via
+         * qemu_set_fd_handler(); unregister it before tearing the
+         * connection down so a later chardev-remove cannot dispatch
+         * baum_chr_read() with a dangling opaque.
+         */
+        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
+        baum->brlapi = NULL;
     }
 }
 
-- 
2.50.1.windows.1


