Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE74C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv6-0005a6-9c; Wed, 15 Jul 2026 09:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv2-0005XM-Gh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:00 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv0-0007tj-CC
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=l7DDRAg
 VAgLl7fMyxNP68NFRW45Vg/87JXuhs43rF+M6YrXv34Q7k19PNGdIsliIFN1yARsIMTXWO
 REOM0gYsa6DvbbjEOHfe4jUZu7v2Br4u+8kylUe+SgiTRnM2h+GcjayJlh8fQGj5s7JN7z
 2bTXMAqTXW8cD+2gyMY7/3/TI6ym0Sd6Ng0d1dyiz0CoQ+Uu4qM1V1Rm2oI9I9OnwLNG86
 waLha8n4K41WMNnqHO8WU7iYq32u4VBpRTT1D8bQcVoP9mIvA0RYhju7ouzy5D33l+H8J5
 atcuxE3ll9XJnTchN9gNQei6iNzkL98IBnkF7n7U6JV1KgVjK+72HMg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=5
 unVjui2VqYQAOoR8Cz3h7Wz8eYsYZYctNPB/KH5TKQ=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=v7UbFguvfz6y8cBVVj1neOEYYcKt7eExNAHiALyWfFK1XurOfmbSh50doHnumzK+Zks/
 2yLVaomPjU0zyX77XfTXYn8mQ5K/z02XeVQI6xTn4u4Y3kpcSj9REmXnGCs++Di4TMNy62
 69h9POqs+W0JgzpTgaKMKzrb3AuXrI3nfDnBu45L3sfN8+HcRzui6VX8Ns4+7B3/aFBWXR
 B39DNiQ/v8licnUH2D/BfpUqTNzvGICT5kYF60NiJYEbn9g4tfvdsQ5SD3uruOiH5w2jY/
 miHQgCERuRChWqARSluzVC8soFbzuyoKU5zSpg3lqmgL5uSf+eHMbDrY+uJ+ugDA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=zkJ5SZo1; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=3vR+7kuv;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=5unVjui2
 VqYQAOoR8Cz3h7Wz8eYsYZYctNPB/KH5TKQ=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=zkJ5SZo1l7pSrJx8BcQZocfcSkh2cV8Izz5
 v8nN86AJbzKtVeb3UnCg0AdkT6LKZUtL95EFPzV+UmIgmU/UzSffJABRrV+3R/CKQZ64AK
 a15maoe1ZdCQXaN1IUNkL3cy16V2BHvBJ1mzdSY7BpqC/nHhjPGL3Qn3KY+iIndm5omo9z
 EJbu/XyIiBod4d4ql07WF8grVl5tCE61xe4zY19c6ZEXT0PnrKX7vtzZbkUlvapqE9WV36
 svoUtgikbUXC30mltuQsveV7psUSDbZWxgJJpFnqYkXC5fGrR4Mt0HmSevfSwBW151KGkj
 ZQYcRyOY790s+wUb4uk+3sNRDaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=5unVjui2VqYQAOoR8Cz3h7Wz8eYsYZYctNPB/KH5TKQ=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=3vR+7kuvgCDwM3Fv9m
 DkQYBX+d7W600GqhwRzK7KKPUUHs5dHH8EIs1SOib+eHOUKBO3pnIMmcmSyUwpvUB0Cg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id fe0d8c33
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:51 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 694c9095;
 Wed, 15 Jul 2026 15:44:49 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 05/25] target/mips: add Octeon CN73xx CPU model
Date: Wed, 15 Jul 2026 15:43:51 +0200
Message-ID: <20260715134447.56007-6-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


