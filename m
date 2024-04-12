Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBYT-0000iv-Na; Fri, 12 Apr 2024 03:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBYQ-0000ib-Un; Fri, 12 Apr 2024 03:42:34 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBYO-00008x-CZ; Fri, 12 Apr 2024 03:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712907745; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=HN6DhZ1YDyjygjYarsnv77wizJM6gixFAR0kv+mDYD8=;
 b=HECwdnN5XD6mDtqQwYEHk7amfQOX4gPXPx9A0Iu/DWZz1c/asR1IJZMCy41SRnyY8Wkp6DHrFpilOdL+B/L3uF/sbWUxUhtAwY5oRdOvkvyMefKrzXozGSGjhhhYGhtWcCYOIQe6mXslKzoWNassuR7P6OoGScoNYFYEsKQnenA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NQA-S_1712907742; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NQA-S_1712907742) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:42:23 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 02/65] target/riscv: Reuse th_csr.c to add user-mode csrs
Date: Fri, 12 Apr 2024 15:36:32 +0800
Message-ID: <20240412073735.76413-3-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

The former patch added th_csr.c to add th.sxstatus csr for XTheadMaee.
However, it can only support system-mode vendor csrs.
In this patch, I change the way of compiling th_csr.c and calling the
function th_register_custom_csrs, using '#if !defined(CONFIG_USER_ONLY)' in
th_csr.c to support both user-mode and system-mode vendor csrs.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/cpu.c       |  2 +-
 target/riscv/meson.build |  2 +-
 target/riscv/th_csr.c    | 21 +++++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 46a66cdbbb..3f21c976ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -545,8 +545,8 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
 #endif
+    th_register_custom_csrs(cpu);
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.pmp = true;
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..b01a6cfb23 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -12,6 +12,7 @@ riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
+  'th_csr.c',
   'fpu_helper.c',
   'gdbstub.c',
   'op_helper.c',
@@ -33,7 +34,6 @@ riscv_system_ss.add(files(
   'monitor.c',
   'machine.c',
   'pmu.c',
-  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 66d260cabd..dc087b1ffa 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -33,6 +33,15 @@ typedef struct {
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
+static int test_thead_mvendorid(RISCVCPU *cpu)
+{
+    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
+        return -1;
+    }
+    return 0;
+}
+
+#if !defined(CONFIG_USER_ONLY)
 static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
 {
     if (env->debugger)
@@ -44,13 +53,6 @@ static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
-{
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID)
-        return -1;
-    return 0;
-}
-
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
@@ -58,13 +60,16 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
     *val = TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
     return RISCV_EXCP_NONE;
 }
+#endif
 
 static riscv_csr th_csr_list[] = {
+#if !defined(CONFIG_USER_ONLY)
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", s_mode_csr, read_th_sxstatus }
-    }
+    },
+#endif
 };
 
 void th_register_custom_csrs(RISCVCPU *cpu)
-- 
2.44.0


