Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44D8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEiG-0000Im-42; Mon, 13 Jul 2026 07:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi1-0008MM-EH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:26 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEhx-00080d-OD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ELfIxP2
 2Pd+XKTA763zWZ9LtlSupbog/cRQ5zCj5pyvMbmbN7mvqeo47WAhCiP88a69NK9RURwpKL
 TdYYA6cuzp/wW4zM9qp/wRqgESzdHaCt0EzxHpvJdULsDDzyG6Wcx+evTrVi6mJwoINqSb
 Ra5+GsIXlDjDshcYKYrKAWHgORzw2ePIXjsl5eAA+Whi2RviVAnoj/eENr5TN8J+QMtLp2
 PMtZIdbk3gs1ZYGxYSLTVMjIkv2HhsORgIm1liDV3n8IUOZ8Mx4szWQ/wxTYlu2gp1yxtE
 6n2whO+lulBhTaawxkf+RwUa5gbpXFQGF1GL4fgntLeXC/yWXmMUOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=7
 J2f9XYzkeb1DC/7GzPyKngK9FJeYiQ/Ftyiu+NCBDA=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Y5CHYXl5e8D6vrvHmyLHCCe6XoXvmW8KHF8s9PeYjNOk4rs4lK0xGUHDNgodCH268Lpr
 agTP3QFVziF7J/sVZPxFexskZk3qQOoUyejGFklNVIq9YvY4OF67g7C1BPtpCBaHS7+D57
 QhXjf6645wP7W4wK4RGOy+VlNXXdw8H8mkLKz/IIn5yR//Tp3/pqwAazbrZOixR7cWsgS5
 +4uYC+bXf9NcGjNQvaLgZ+W56oeUW+PIL9zv91M9DiFaIp6CZ2HPbBJITAnmJfX8sejKlr
 NumNZcw4WO87bedn2rHs73F78e8rcaNmIZ2uwEVOixJGAPcZ/Zj+77t939yyttGw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=hr5b0X7+; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=7gL/U7Wk;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=7J2f9XYz
 keb1DC/7GzPyKngK9FJeYiQ/Ftyiu+NCBDA=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=hr5b0X7+ROtpgXKOWcKQNUc0c7yAgNSid/S
 E2+PrZWyYehebHF4xtJ9V9QeimuwvQphlze13atth/cqkwevtXUgrqnHCwmRdVtJsZdkV4
 nxlGLZabxdhyyPDSiV9/3cXvFiYdR9hNJLytlyF+hcY2T2F9o80puPUoNTmi7oeXw4yhYt
 10OI6SKL1cgrxZ2hWNtg5pIPDlFpxwh7ZaWcAt0AYi9DS0Vf8cozqqc0CfUApFCLsnVngR
 xQXAHqizGy1QXEsrCX5FmgCZx88V5uwhKg1MZjpFAS1A3+W/b+kUnChZPkiF/CLzccnjLE
 4797k4EuK/cMRuFras4FXYbmVyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=7J2f9XYzkeb1DC/7GzPyKngK9FJeYiQ/Ftyiu+NCBDA=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=7gL/U7Wko4Yo3VCl0y
 YdY2ZkeYLLSt/KnXW5qfPHa0wk28PuZfRgkF3AyEUDgzJ1w+F2+LbQ/iJWHwVmUTJWAQ==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 2ac6f388
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:16 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 64a294db;
 Mon, 13 Jul 2026 13:20:14 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 6/9] target/mips: add Octeon CN73xx CPU model
Date: Mon, 13 Jul 2026 13:16:34 +0200
Message-ID: <20260713112004.4956-7-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add a CN73xx CPU definition for the Octeon III machine. The PRId, FPU
FIR, and L2 cache geometry come from EdgeRouter Infinity ER-8-XG data;
the remaining CP0 fields come from a Juniper SRX300 CN70xx/CN71xx dump.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/cpu-defs.c.inc | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index cc1916232f..ee638568db 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1023,6 +1023,48 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        /*
+         * Minimal Octeon CN73xx model for EBB7304 firmware. PRId, FPU FIR,
+         * and L2 cache geometry match a Ubiquiti EdgeRouter Infinity
+         * ER-8-XG; the remaining CP0 values are a placeholder Octeon III
+         * model derived from a Juniper SRX300 CN70xx/CN71xx dump.
+         */
+        .name = "OcteonCN73XX",
+        .CP0_PRid = 0x000D9702,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT) | (1 << CP0C0_VI),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (6 << CP0C1_IL) | (7 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (0 << CP0C1_DL) | (7 << CP0C1_DA) |
+                       (1 << CP0C1_C2) | (1 << CP0C1_PC) |
+                       (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (6 << CP0C2_SL) |
+                       (15 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
+                       (1 << CP0C3_VZ) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) |
+                       (0x3c << CP0C4_KScrExist),
+        .CP0_Config7 = 1 << CP0C7_WII,
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .SYNCI_Step = 32,
+        .CCRes = 1,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) |
+                    (0x97 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 42,
+        .PABITS = 49,
+        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
+        .mmu_type = MMU_TYPE_R4000,
+    },
 
 #endif
 };
-- 
2.54.0


