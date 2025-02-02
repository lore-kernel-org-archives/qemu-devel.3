Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6888C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 22:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teium-00070P-Gf; Sun, 02 Feb 2025 17:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1teiul-00070H-Kk
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 17:58:07 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1teiuj-0000ri-Q0
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 17:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1738537079; bh=NVLosc1GQ3qSx4iEokPE1IuLFLjWGIOzeCeuzK2JvUs=;
 h=From:Date:Subject:To:Cc:From;
 b=st/f3ezXSgdTeNFBtTAdfVo+SdNXfTTcsvgq8guUBsX+D4Tcv+lGxMbXPLHwyEHYQ
 GONQ9PtP1MWAszpN8kxVGwPgN4i9qlIxFBoq1NwwscO5FGHAonzNfBQmmHgUE4hqZb
 rfX/lJ66W9qohwBrMiOysn53jAfNH2wpSh5Tk+hY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 02 Feb 2025 23:57:58 +0100
Subject: [PATCH] linux-user/riscv: Disable unsupported SA_RESTORER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAHX4n2cC/x2MMQqAMAwAvyKZDdSKFP2KOBSbapYqiRSh9O8Wl
 4Mb7gooCZPC0hUQyqx8pSZD38F++nQQcmgO1tjJNKCw7hnVo5A+l5AghTCG6J2bTYTW3UKR3/+
 5brV+6rQcWGMAAAA=
X-Change-ID: 20250202-riscv-sa-restorer-edd3dfa7790f
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738537078; l=956;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=NVLosc1GQ3qSx4iEokPE1IuLFLjWGIOzeCeuzK2JvUs=;
 b=qE03iSz7dN7yz/AIknG0ta1UzR6GsT+6/ax97QLqV6VyTRdf13qNUH9/DhVrj4qF593XEM/Uw
 UGZF7I3wX9ACxsbDR7n+l8KVs6JucWEBbkwLTssCpfdeC/W7FqOsyu8
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Linux on riscv does not support SA_RESTORER.
Currently QEMU thinks there is a field 'sa_restorer' in the middle of
'struct sigaction' which does not actually exist.
This leads to corrupted data and out-of-bounds accesses.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 linux-user/riscv/target_signal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
index 6c0470f0bc82c6330ce50cb662f2039cf1fab288..258945770b674c0b6b66a94659d9c93fbabffdfb 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -4,5 +4,6 @@
 #include "../generic/signal.h"
 
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
+#undef TARGET_SA_RESTORER
 
 #endif /* RISCV_TARGET_SIGNAL_H */

---
base-commit: 6fccaa2fba391815308a746d68f7fa197bc93586
change-id: 20250202-riscv-sa-restorer-edd3dfa7790f

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


