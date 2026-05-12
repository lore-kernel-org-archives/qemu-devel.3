Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B7DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuDR-0006BZ-9l; Tue, 12 May 2026 17:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCn-00037o-S0; Tue, 12 May 2026 16:59:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCl-0005Dn-KT; Tue, 12 May 2026 16:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=KOc/DiAKjrRpadbwE3U+gOpNg38f5fy9LqaRl7wyL5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IZW2D//cqzpBbzNli/ugWD/4xIp1jus+n/w6E0RBxi9+yAvxEqg7HFS377VvY2bCd
 Cu2SYp1MR8olrRSxw0/BBMNl8u6XE3Wtkvmeha4xSjWIhXfn0euHdya2/cRClLNEoH
 r3fc+Ik8y4tEsTl5/4pGv8H7GjbUnqJJeVyb+5O0HxuXXU/BqQ3ftVYkZYGmN7IweP
 NwxACxtUbsUPodhdPQmwq4UtaIzM1Ktd4SvxZtpacwSdwxAGR1luMzI+7gjsflQOrm
 mPRGxuDSe3QbL0HtmOsNxBCZsqpbAdyD5qhhozK8gDeianTgZHydMkejB1W/YNQAqD
 HJQggRlWAT7Lg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8DE081AA2FF;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 991FC3ABC70;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 051/107] util/readline: Fix out-of-bounds access in
 readline_insert_char().
Date: Tue, 12 May 2026 23:53:38 +0300
Message-ID: <20260512205437.360850-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Currently, the readline_insert_char() function is guarded by the cursor
position (cmd_buf_index) rather than the actual buffer fill level(cmd_buf_size).
The current check is:
	if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)

This logic is flawed because if the command buffer is full and a user moves the
cursor backward (e.g. by sending left arrow key), cmd_buf_index can be
decreased without descreasing of buffer size.
This allow subsequent insertions to increase cmd_buf_size past its maximum
limit of rs->cmd_buf.

Because in the ReadLineState struct, cmd_buf[READLINE_CMD_BUF_SIZE + 1] is
immediately followed by the cmd_buf_index integer, once the buffer size is
sufficiently inflated, the memmove() operation inside readline_insert_char()
can write past the end of cmd_buf[] and overwrites cmd_buf_index itself.

The subsequent line:
	rs->cmd_buf[rs->cmd_buf_index] = ch;

then writes the input character to an address determined by the now-corrupted
index.

By providing a specifically crafted input sequence via HMP, this flaw can be
used to redirect the write operation to overwrite any field within the
ReadLineState structure, which can lead to unpredictable behavior or
application crashes.

Fix this by adding the guard to check for buffer fullness.

Cc: qemu-stable@nongnu.org
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Message-id: 20260406050454.284873-2-phind.uet@gmail.com
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4e4832dd72db59cf9348a5cb787fe65b738d7601)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/readline.c b/util/readline.c
index 0f19674f52..e2664e48ca 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -84,7 +84,9 @@ static void readline_update(ReadLineState *rs)
 
 static void readline_insert_char(ReadLineState *rs, int ch)
 {
-    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
+    assert(rs->cmd_buf_index <= rs->cmd_buf_size);
+
+    if (rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
         memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
                 rs->cmd_buf + rs->cmd_buf_index,
                 rs->cmd_buf_size - rs->cmd_buf_index);
-- 
2.47.3


