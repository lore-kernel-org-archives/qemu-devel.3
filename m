Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE4E6F09F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4fM-0000HG-7f; Tue, 23 Dec 2025 10:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4fB-00008D-GL
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:05 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4f6-0005Ta-Ad
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E06A43C30;
 Tue, 23 Dec 2025 15:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8276FC113D0;
 Tue, 23 Dec 2025 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505059;
 bh=CfUuSdb/wHb4Teg1yVC5iVuinJ5jN2VElcPx4w8WaD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FuJk7dOkPXOuN8k0m0TX8TtOGhttoB2zueiFODbjDbjfc67HqWdm8vC/DoS4T12BJ
 A0fJm/cyQZUZPkX/qACmdi8oFA7fyvVKAlbmLiQFpNqu67dgVgHR1V67Pfmj5NceI3
 hoW+0HLn1Bea8lJVqpO+DVHMaoc+xZLA8Ux5SqXg25YTR1UUiF3D/bOXd1j5fv8Njz
 iTtIKJH96NzIC6DWUjrjZJ9+JxpwvcugBu+0NPjooNWiQKClyh9DopantSFJPGpLKA
 1AXWPQG16PjBVpRClWHh6zLxaW7XOAMisxuFo7AW8tJ5pZN3OVC1cqfd6PE5kNVWiV
 SqY0NdU0MBG1Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 10/12] scsi: ncr710: Fix DSA register
Date: Tue, 23 Dec 2025 16:50:29 +0100
Message-ID: <20251223155031.7110-11-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Implement bytewise write handling for DSA register instead of using
the macro, as NetBSD driver accesses it byte by byte.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index dd453991e0..0ea1fc43a3 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2078,7 +2078,21 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         /* Linux writes to these readonly registers on startup */
         return;
 
-    CASE_SET_REG32(dsa, NCR710_DSA_REG)
+    case NCR710_DSA_REG:
+        s->dsa &= 0xffffff00;
+        s->dsa |= val;
+        break;
+    case NCR710_DSA_REG + 1:
+        s->dsa &= 0xffff00ff;
+        s->dsa |= val << 8;
+        break;
+    case NCR710_DSA_REG + 2:
+        s->dsa &= 0xff00ffff;
+        s->dsa |= val << 16;
+        break;
+    case NCR710_DSA_REG + 3:
+        s->dsa &= 0x00ffffff;
+        s->dsa |= val << 24;
         break;
 
     case NCR710_CTEST0_REG: /* CTEST0 */
-- 
2.52.0


