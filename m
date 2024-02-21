Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A9DC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcod6-0000dB-I0; Wed, 21 Feb 2024 10:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoZJ-0000S3-7u; Wed, 21 Feb 2024 10:31:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchvq-00038S-F5; Wed, 21 Feb 2024 03:26:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CEE2F4F3F7;
 Wed, 21 Feb 2024 11:21:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9AA1C860D6;
 Wed, 21 Feb 2024 11:21:02 +0300 (MSK)
Received: (nullmailer pid 2142162 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tianlan Zhou <bobby825@126.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 57/60] ui/console: Fix console resize with placeholder
 surface
Date: Wed, 21 Feb 2024 11:20:45 +0300
Message-Id: <20240221082058.2141850-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Tianlan Zhou <bobby825@126.com>

In `qemu_console_resize()`, the old surface of the console is keeped if the new
console size is the same as the old one. If the old surface is a placeholder,
and the new size of console is the same as the placeholder surface (640*480),
the surface won't be replace.
In this situation, the surface's `QEMU_PLACEHOLDER_FLAG` flag is still set, so
the console won't be displayed in SDL display mode.
This patch fixes this problem by forcing a new surface if the old one is a
placeholder.

Signed-off-by: Tianlan Zhou <bobby825@126.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240207172024.8-1-bobby825@126.com>
(cherry picked from commit 95b08fee8f68d284a5028d37fd28be7a70c8e92b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


