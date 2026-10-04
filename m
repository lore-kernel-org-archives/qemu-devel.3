Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733D3CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKco-00042S-Th; Sun, 04 Oct 2026 07:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcn-00041P-8O
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:25 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcl-00023r-NK
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9DC4444EE;
 Sun,  4 Oct 2026 11:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6A01F000FF;
 Sun,  4 Oct 2026 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114202;
 bh=CGBMXo8TFz546fbBUTd+H8dFpmWiiml5P8nyirhFrLI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C6TYlSTN6IqanevclQfi3CvHCWB0+YeDuHwU+uebz8nqGMxFiugQB+MUZYqyTq+mZ
 TXhItHah59KazhYzJl9yePBVDGhGjTPbPPTykYjONav9Fp8ZNqco16PGWKsSb9Tztg
 W19l1K4rjENbfynVsv6E7anTHOwtMkEyJxKtwYEL0cWDiCXJ3xHmo1tTQUExxpZlhW
 HTGrDDWNCMREO9LdP9IjSwkjghHNnbdJNA2QhfT41XrxcM6bFKmJHRLJLv+C6cMlyy
 AAz+sdcsnMXwa/N5+u+XwaUOBilrzu2vI9FjB7PSP2i2XfFJxBdxgTlp3O1egZNz5w
 M1ss+4PygNQgQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/5] target/mips: fix Loongson-3A4000 definition to have
 abs2008 and nan2008
Date: Sun,  4 Oct 2026 13:43:09 +0200
Message-ID: <20261004114311.3874-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
References: <20261004114311.3874-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Alex Rønne Petersen <alex@alexrp.com>

Checked on a Loongson 3B4000; this uarch operates in 2008 mode.

Signed-off-by: Alex Rønne Petersen <alex@alexrp.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/mips/cpu-defs.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index cc1916232f..b2ddfa1e82 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -941,8 +941,8 @@ const mips_def_t mips_defs[] =
                     (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
         .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
                     (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
-                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
-        .CP1_fcr31 = 0,
+                    (0x1 << FCR0_D) | (0x1 << FCR0_S) | (0x1 << FCR0_HAS2008),
+        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .MSAIR = (0x01 << MSAIR_ProcID) | (0x40 << MSAIR_Rev),
         .lcsr_cpucfg1 = (1 << CPUCFG1_FP) | (2 << CPUCFG1_FPREV) |
-- 
2.54.0


