Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9006510F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYV4-0002Xs-81; Wed, 08 Apr 2026 15:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1wAY4y-0006ek-OX; Wed, 08 Apr 2026 14:56:44 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>)
 id 1wAPBA-0000Lv-AV; Wed, 08 Apr 2026 05:26:34 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id DCFF21C31BA; Wed, 08 Apr 2026 11:15:05 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH] qemu-keymap: fix altgr modifier lookup for newer
 xkeyboard-config
Date: Wed,  8 Apr 2026 11:14:59 +0200
Message-ID: <20260408091459.4001711-1-dietmar@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

xkeyboard-config 2.37 removed the "AltGr" virtual modifier in favor
of mapping upper groups directly to Mod5. Since then,
xkb_keymap_mod_get_index(map, "AltGr") returns XKB_MOD_INVALID, so
AltGr-based keysyms were never generated.

See: https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/473f9bc32f9ba869829cc0d06a75cd1f2560aa60

Try "AltGr" first, and fall back to "Mod5" for compatibility with
both old and new xkeyboard-config versions.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 qemu-keymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 1c081db287..d4dccf456e 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -230,6 +230,9 @@ int main(int argc, char *argv[])
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


