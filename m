Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB187CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuEj-0007fs-0n; Tue, 12 May 2026 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCw-0003vL-B1; Tue, 12 May 2026 17:00:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCu-0005bw-5J; Tue, 12 May 2026 17:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=zvja2Ly8MOB+3TR7eyI+pbxqWtBhp+V27gwsfOW3bHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aCz5XHIs0SGyeaePO2bVEdfllga643qBrF4P1zb9ip0iS+r80x7amM/2pGg+dZGOl
 I4kBtjST4Dq9mp8nPiUsW5kAnsI9uv1/8zmysVOZwd1Rkgw+By0WGWJliV15Kec87F
 Nt1FwXq9p6xhc+ymv3D4uFJjpWw4YOAH0Vi9RccrB4QJ6CVgsMLk/GxHKd7dYhkzE2
 kCQMOCyFe7yZ9N5gKLsnqPkeJ70mN7vKxkOU034NgMB8kFAWuYL9Smu9XphL4Irn6p
 mQ2ljk0NWPmwn/HigD13I5Hctfv0cKHvNamG0X0FNFhQew2tpR9JEE4rBBGSGBKmJI
 8sUgvPgh2WscQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C84CD1AA302;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CA8323ABC73;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dietmar Maurer <dietmar@proxmox.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 054/107] qemu-keymap: fix altgr modifier lookup for
 newer xkeyboard-config
Date: Tue, 12 May 2026 23:53:41 +0300
Message-ID: <20260512205437.360850-54-mjt@tls.msk.ru>
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

From: Dietmar Maurer <dietmar@proxmox.com>

xkeyboard-config 2.37 removed the "AltGr" virtual modifier in favor
of mapping upper groups directly to Mod5. Since then,
xkb_keymap_mod_get_index(map, "AltGr") returns XKB_MOD_INVALID, so
AltGr-based keysyms were never generated.

See: https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/473f9bc32f9ba869829cc0d06a75cd1f2560aa60

Try "AltGr" first, and fall back to "Mod5" for compatibility with
both old and new xkeyboard-config versions.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260408091459.4001711-1-dietmar@proxmox.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 4e6fb62fb0f33c815b089d0b59e1313b768c55d0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 6707067fea..402815139a 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -231,6 +231,9 @@ int main(int argc, char *argv[])
     shift = get_mod(map, "Shift");
     ctrl = get_mod(map, "Control");
     altgr = get_mod(map, "AltGr");
+    if (!altgr) {
+        altgr = get_mod(map, "Mod5");
+    }
     numlock = get_mod(map, "NumLock");
 
     state = xkb_state_new(map);
-- 
2.47.3


