Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC8E784A4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 06:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYew9-00065E-Iq; Thu, 25 Dec 2025 01:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1vYew7-00064l-8F
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:34:59 -0500
Received: from smtp-pop-umt-1.cecloud.com ([1.203.97.246]
 helo=smtp.cecloud.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>) id 1vYew4-0003N0-3U
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 01:34:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id 1D9027C0119;
 Thu, 25 Dec 2025 14:34:38 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.69.245])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P3424602T281460011430256S1766644474672507_; 
 Thu, 25 Dec 2025 14:34:37 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-devel@nongnu.org
X-RCPT-COUNT: 4
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.69.245
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <a8d4961367a6a2c489eb9d93cd0fc674>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] chardev/pty: fix incorrect return value in char_pty_chr_write
Date: Thu, 25 Dec 2025 14:34:12 +0800
Message-ID: <20251225063412.572-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.45.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=1.203.97.246; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

In char_pty_chr_write(), when the PTY is not connected (s->connected ==
false), the function attempts a non-blocking poll to check if the fd is 
writable. However, even if the fd is not writable or if io_channel_send()
fails the function unconditionally returns 'len', falsely indicating that
all data was successfully written.

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 chardev/char-pty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 652b0bd9e7..37a20d5f4b 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -124,11 +124,15 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
     pfd.revents = 0;
     rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
     g_assert(rc >= 0);
+    if ((pfd.revents & G_IO_HUP) || !(pfd.revents & G_IO_OUT)) {
+        return 0;
+    }
     if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
         return io_channel_send(s->ioc, buf, len);
     }
 
-    return len;
+    int ret = io_channel_send(s->ioc, buf, len);
+    return ret;
 }
 
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
-- 
2.45.1.windows.1




