Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6E7C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJt2X-00043m-LL; Tue, 27 May 2025 08:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uJt24-0003lQ-GJ; Tue, 27 May 2025 08:03:50 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uJt1z-00058i-F2; Tue, 27 May 2025 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G7xMA/pAQ1KrAyhQNxLPVgWOWyjEHeR5P5B+3oY4j+s=; b=Y1W6W+mAV9THhwQmPkFvRqLnV3
 kNFME4F3XD/EngIEcAU82AX3m6WOzb7IxpQcBzbUD/UYf/mkgYTvJQbreKiyxdHxTOu9Q8LcspdgY
 bkV8jI8NTGu59yEasmCErPjsHMVuQwAe2FDL2N+x6Piz/5XDGv+bpqdIyO69wLxqM+2RTj9NOdy4H
 Px++UBMZCWCsmg1/Rpb4BkFMHUUVPZo89gCn9WUFZlAYIGnqjjDPZh+JnSUEqv4n1QQQPDslLhds0
 CiwK5bYLhcvyh4JyuwfbRSk538IgYlouAA2cDMZuj+2SCEGbpcclKo6R09FpqXl80O8dzoANonxb5
 sRb05RBQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uJsQ9-002w7Z-MJ; Tue, 27 May 2025 12:24:38 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uJsQA-00000001DqI-19pS;
 Tue, 27 May 2025 12:24:38 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: ben.dooks@codethink.co.uk,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] target/riscv: add cva6 core type
Date: Tue, 27 May 2025 12:24:36 +0100
Message-Id: <20250527112437.291445-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add TYPE_RISCV_CPU_CVA6 for the CVA6 core

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..3daf75568c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -34,6 +34,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
+#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
 #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
 #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..fca45dc9d9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU,
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV39,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .cfg.pmp = true,
+        .cfg.mmu = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
-- 
2.37.2.352.g3c44437643


