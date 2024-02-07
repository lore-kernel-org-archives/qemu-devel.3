Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85177C4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmnL-0000T8-Ll; Wed, 07 Feb 2024 13:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby825@126.com>) id 1rXleX-0001sS-Le
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 12:24:05 -0500
Received: from m16.mail.126.com ([220.197.31.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bobby825@126.com>) id 1rXleV-0006SP-Bu
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 12:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=At/vQ
 S/IiNbcY/YL8bRCfI4EX/uYYWgWOhkgxUFUX9M=; b=HTCy9V/9hoAY7NX5LU1Bg
 Rbu6jkx9MJ/f2aPubL18d9B9ysvrm8NYewQ9eNHo9yvmbt1MkZpOUoPqFsgJYzLD
 HycvdzBqky2YprmEb36zqqK0EvGMbJV7Cjsmfc0X0eFL5jypIs23VBH/tLCME/Ae
 k70b4TVRigUHh97B+sDji8=
Received: from localhost.localdomain (unknown [101.88.177.236])
 by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wB3OoGkvMNllK2bAQ--.77S2;
 Thu, 08 Feb 2024 01:23:49 +0800 (CST)
From: Tianlan Zhou <bobby825@126.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tianlan Zhou <bobby825@126.com>
Subject: [PATCH] ui/console: Fix console resize with placeholder surface
Date: Thu,  8 Feb 2024 01:20:25 +0800
Message-Id: <20240207172024.8-1-bobby825@126.com>
X-Mailer: git-send-email 2.38.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3OoGkvMNllK2bAQ--.77S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1rXF1UXFyrZw4xGFWDXFb_yoWkurb_Aa
 4UZayUAw1rZr9xXa4DKFZ5CF4Sg3s3Crn3uFn7tF13tw1UWFsFqF4UtrySg3ZFyw4Iqr92
 9r18C347CrnxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRitkuDUUUUU==
X-Originating-IP: [101.88.177.236]
X-CM-SenderInfo: xereu5qysvqiyswou0bp/1tbiHBl9UmV20Oj7cAAAsK
Received-SPF: pass client-ip=220.197.31.6; envelope-from=bobby825@126.com;
 helo=m16.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Feb 2024 13:37:14 -0500
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

In `qemu_console_resize()`, the old surface of the console is keeped if the new
console size is the same as the old one. If the old surface is a placeholder,
and the new size of console is the same as the placeholder surface (640*480),
the surface won't be replace.
In this situation, the surface's `QEMU_PLACEHOLDER_FLAG` flag is still set, so
the console won't be displayed in SDL display mode.
This patch fixes this problem by forcing a new surface if the old one is a
placeholder.

Signed-off-by: Tianlan Zhou <bobby825@126.com>
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index 7db921e3b7..832055675c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1577,7 +1577,7 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && surface->flags & QEMU_ALLOCATED_FLAG)) &&
+         (surface && !is_buffer_shared(surface) && !is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
-- 
2.38.1.windows.1


