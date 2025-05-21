Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2B1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlnB-00045O-6F; Wed, 21 May 2025 11:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlmz-00043W-1m; Wed, 21 May 2025 11:55:29 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlmv-0008Ag-IT; Wed, 21 May 2025 11:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s3+CHHmXAYyrW55D/Y+I1Y7QpnQ4qrn51rNdFIxUd7I=; b=Qv+CEgSSzOXJdyWVJSTzJ9S0g+
 L9rci/Jcez9IGmbGdI1c2Mr/QVbwtCGcvpRYol5J/GlYfz8Mw65Y0pr/V2G0XVJmF46YEg5zGqYyX
 FlZUrMWyLu4pxQCXTOFSA5NHU0eE23s939m948YVnsaR6MIy93YDZqvgAG8RzYLBJIQ1qp/44rHjW
 ZhzFU9RElRuQnTpbpSSynkXKaSvXuTeqoYXkQywMlJfhQhIH0kS9Lh6IuZWpMf+v3R1zngQD6pQym
 xJaec55KakXhGngpKUm3pPDRhpo9yW0JDxi+Sp9EVn5NbkbqEyviBvKZf5maQiM2MK0UgpyeXZxAz
 64UwpyqA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uHlmZ-001dlq-B4; Wed, 21 May 2025 16:55:03 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uHlmZ-000000006KP-0Yky;
 Wed, 21 May 2025 16:55:03 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: ben.dooks@codethink.co.uk,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/riscv: add cva6 cpu type
Date: Wed, 21 May 2025 16:54:58 +0100
Message-Id: <20250521155458.24255-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250521155458.24255-1-ben.dooks@codethink.co.uk>
References: <20250521155458.24255-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
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

Add CVA6 CPU type, for the OpenHW CVA6 cores

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4cfdb74891..b5460771d7 100644
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
index d92874baa0..0ad6a7b616 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -496,6 +496,24 @@ static void rv64_base_cpu_init(Object *obj)
 #endif
 }
 
+static void rv64_cva6_cpu_init(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU);
+    env->priv_ver = PRIV_VERSION_1_12_0;
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
+#endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_zifencei = true;
+    cpu->cfg.ext_zicsr = true;
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
+}
+
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -3247,6 +3265,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
 #if defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_CVA6,       MXL_RV64,  rv64_cva6_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
-- 
2.37.2.352.g3c44437643


