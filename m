Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F6BC4829B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xl-0006Ak-8M; Sun, 11 Feb 2024 07:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xk-0006A0-7A
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:36 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xi-0006Gy-Gj
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2EDBBCE0D8B;
 Sun, 11 Feb 2024 12:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC4FC433C7;
 Sun, 11 Feb 2024 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654571;
 bh=WnjkRHA+PxnhJ2hwB5R3kLTKfKDbD/nEu0xgZtuTRoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mo2SxgeiIonE6/LMG/P99TzmyuqH4hvTUqhgqELCyW/X9yL2WNC4uFqQ3BDhcY2CP
 K6acADc5jMka1kIU8jxSSkHNFqbhhFdreD9DbcJVhnob0ELIr2OvoSkcvLrNFg/dff
 taqZ+AlioetNrEgURLvU+aO4JhNd9gZ8qZ184nRfkQct2x3eT+p6fX3fnQ0mDuW2zk
 AHfy+erq+uI5+UCemvvyvHA/Fwo7h8lToSq4y34tGnKY1N7cxwpPhBNRaarRNIHB3r
 jACHalMBdp6fMMXP4q4BHzfKY9/2cf0ocCY5nbgs2ejFPXF0zbLgcckmbeujLkNrge
 LTA2e9y6+dOIw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/12] hw/net/tulip: add chip status register values
Date: Sun, 11 Feb 2024 13:29:07 +0100
Message-ID: <20240211122909.5807-11-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Sven Schnelle <svens@stackframe.org>

Netbsd isn't able to detect a link on the emulated tulip card. That's
because netbsd reads the Chip Status Register of the Phy (address
0x14). The default phy data in the qemu tulip driver is all zero,
which means no link is established and autonegotation isn't complete.

Therefore set the register to 0x3b40, which means:

Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
speed.

Also clear the mask because this register is read only.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/tulip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 6d4fb06dad..1f2ef20977 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -421,7 +421,7 @@ static uint16_t tulip_mdi_default[] = {
     /* MDI Registers 8 - 15 */
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     /* MDI Registers 16 - 31 */
-    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+    0x0003, 0x0000, 0x0001, 0x0000, 0x3b40, 0x0000, 0x0000, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
@@ -429,7 +429,7 @@ static uint16_t tulip_mdi_default[] = {
 static const uint16_t tulip_mdi_mask[] = {
     0x0000, 0xffff, 0xffff, 0xffff, 0xc01f, 0xffff, 0xffff, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-    0x0fff, 0x0000, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff,
+    0x0fff, 0x0000, 0xffff, 0xffff, 0x0000, 0xffff, 0xffff, 0xffff,
     0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
-- 
2.43.0


