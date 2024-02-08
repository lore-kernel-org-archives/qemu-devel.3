Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A1CC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 15:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6dr-0000Oj-7K; Thu, 08 Feb 2024 10:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby825@126.com>)
 id 1rY6dm-0000OQ-V4; Thu, 08 Feb 2024 10:48:43 -0500
Received: from m16.mail.126.com ([220.197.31.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bobby825@126.com>)
 id 1rY6dk-0005uV-KM; Thu, 08 Feb 2024 10:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=sVHV6PYUwN23rSqvWgebqgUt2SID3QbNVQEPg+8em8A=;
 b=R3gz6aS62NiDoNt2oBXdj8jL5u6fctQ3GZAau7F6rV9v4uP7ZlkEZXoHi3iOJ/
 +ik8OrmDcCJG63hL1G3sbU50EsOcPxb4u1JorQ7VovJq/M+Jccjvd8XSIVoF+DUL
 6YbxgSEyl5LRKsva7vug/BDKOW+yXe2xMmatEJP0KjphA=
Received: from localhost.localdomain (unknown [183.192.131.113])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnD4bH98RlvabfAQ--.0S2;
 Thu, 08 Feb 2024 23:48:26 +0800 (CST)
From: Tianlan Zhou <bobby825@126.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Tianlan Zhou <bobby825@126.com>
Subject: [PATCH v2] ui/console: Fix console resize with placeholder surface
Date: Thu,  8 Feb 2024 23:47:06 +0800
Message-Id: <20240208154705.1896-1-bobby825@126.com>
X-Mailer: git-send-email 2.38.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnD4bH98RlvabfAQ--.0S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4kuF4DKrWrWF1DCrWruFg_yoW8Gr1xpF
 nxJF95Jrn8WryFvr9xtw4SgFWxu3909F4j9FWYkw17Zw1DJrWSv34xtw15u3yavw1ktas0
 kFWUKFs8AF17Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieMK_UUUUU=
X-Originating-IP: [183.192.131.113]
X-CM-SenderInfo: xereu5qysvqiyswou0bp/1tbiOg1+UmVEuzSHswAAsB
Received-SPF: pass client-ip=220.197.31.6; envelope-from=bobby825@126.com;
 helo=m16.mail.126.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In `qemu_console_resize()`, the old surface of the console is kept if
the new console size is the same as the old one. If the old surface is a
placeholder, and the new size of console is the same as the placeholder
surface (640*480), it won't be replaced.
In this situation, the surface's `QEMU_PLACEHOLDER_FLAG` flag is still
set, so the console won't be displayed in SDL display mode.
This patch fixes this problem by forcing a new surface if the old one is
a placeholder.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Tianlan Zhou <bobby825@126.com>

---

v2:
- Slightly modify the commit message
- Add Reviewed-by: Marc-André Lureau

v1:
- Initial patch

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


