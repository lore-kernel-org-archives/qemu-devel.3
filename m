Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0B9CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wReKX-0005nd-DR; Mon, 25 May 2026 19:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wReKU-0005nA-89
 for qemu-devel@nongnu.org; Mon, 25 May 2026 19:03:26 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wReKS-0000iV-GY
 for qemu-devel@nongnu.org; Mon, 25 May 2026 19:03:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D4CD60018;
 Mon, 25 May 2026 23:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3451F000E9;
 Mon, 25 May 2026 23:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779750194;
 bh=fJqVDKluOa4/c1wsTNSYyeCKQDQVsUHjJqM4MzpAVvQ=;
 h=From:To:Cc:Subject:Date;
 b=fhZvAI7MiClqr6pEspdGwpv2dly2J9y+jGdjyU6UucwT/puxyqSlVVT8SywmHfoUR
 feDZwjPUXDUJZgurHuknpBBrUD3y4cQ9ZHO+bffsaG3qNYoqvc7e93J9gYx43ogc67
 IjT4o8WH4gF9GuLroKEQZ4OsP7B0OhaHmQ8ytot+k0B/l8TSVEAoHPF1tkuX0Ga3zc
 NGP+jHuM7w/zmSUDp0tSFLzmujxAs64Lh7tP76kvbA3yGy0OENOVCfDfmmy4vgFAnr
 EYdzWRdRAupJcYpFoYLqbI5wuHh0ovVg/F2bykc2ygp2Y6q23ZHLl1N0zmvawcLhJy
 n/krRZv1WdMMw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH] linux-user: Fix loading static ARM cortex-m55 binaries
Date: Tue, 26 May 2026 01:03:08 +0200
Message-ID: <20260525230308.137009-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Static built ARM binaries for Cortex-m55 may have been linked to have
their load address at address 0. When qemu-user is running as non-root
user and thus will try to mmap() a host address which is smaller than
mmap_min_addr (/proc/sys/vm/mmap_min_addr), it will fail with EPERM and
as such loading those guest programs will fail.

Avoid this EPERM failure by automatically choosing a valid starting
guest_base address which has to be higher than mmap_min_addr.

Signed-off-by: Helge Deller <deller@gmx.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e757787d2..152c122a23 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1033,8 +1033,9 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    /* Try the identity map first. */
-    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
+    /* Try the identity map first if guest_loadaddr is above mmap_min_addr. */
+    if (guest_loaddr >= mmap_min_addr &&
+        pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
         if (pgb_try_mmap_set(&ga, 0, brk)) {
             guest_base = 0;
-- 
2.54.0


