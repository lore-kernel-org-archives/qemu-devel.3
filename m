Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E2CC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnfjm-0001J1-1r; Thu, 27 Feb 2025 10:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6M-0001sg-RM; Thu, 27 Feb 2025 09:43:03 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saveliy.motov@syntacore.com>)
 id 1tnf6J-0008Tc-N0; Thu, 27 Feb 2025 09:43:02 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id 81077B41D0C;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=m; bh=adUAeS8Pv7eqKYl3hGXwcB8
 AWI6qvWNM+DnwBPIEL1s=; b=RiM2mQHdQvZXjwAHdiYLJvsQLp/wRk2HuZFqIR6
 l+S/8v9RVuMv0z18ASV8jBclHvdXgmixrLejOBSMKYK8ll5qLgUhVioS2fqJaBg2
 HiUZDY9QiM6CMdDZm5ZRQrw2aU8LPLiW8SDPt8VVoBOZGaofpqTZkC08GOkKE8Bg
 u2kzELxwS6WaK4SmrGS6fRe9oaujkicklGBuHyWdaLlxZDe1cDvGHAD8JbriZwWM
 vzXQaHHAcKow0klechYEj/OXCntAMeGY/w8RKaBEyIx6jhFGtEHsTjT/+LUmN0iD
 Hi/REDzGkSihMLUqzWY2bwXTRr2ZcSv1CcqZVBEilv2enEg==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id 6C76EB41D05;
 Thu, 27 Feb 2025 17:42:50 +0300 (MSK)
Received: from le14u.yadro.com (172.17.5.46) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 17:41:40 +0300
From: Saveliy Motov <saveliy.motov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Saveliy Motov
 <saveliy.motov@syntacore.com>
Subject: [PATCH 1/2] target/riscv/csr.c: Fix first Zkr CSR reading
Date: Thu, 27 Feb 2025 17:41:59 +0300
Message-ID: <20250227144200.69270-2-saveliy.motov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227144200.69270-1-saveliy.motov@syntacore.com>
References: <20250227144200.69270-1-saveliy.motov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.5.46]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=saveliy.motov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Feb 2025 10:23:37 -0500
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

According to RISC-V Cryptography Extensions Volume I. Version 1.0.1 Chapter 4.1
BIST alarm must be latched until polled at least once to enable software to
record its occurrence.

Signed-off-by: Saveliy Motov <saveliy.motov@syntacore.com>
---
 target/riscv/cpu.c | 3 +++
 target/riscv/cpu.h | 4 ++++
 target/riscv/csr.c | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cca24b9f1f..a5724b2fca 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1046,6 +1046,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj, type);
     }
+
+    env->zkr_csr_is_read = false;
+
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cb..7fc36ae7ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -250,6 +250,10 @@ struct CPUArchState {
     target_ulong excp_uw2;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
+
+    /* ZKR state */
+    bool zkr_csr_is_read;
+
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f07..3af4f69698 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5152,10 +5152,15 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
 {
     target_ulong rval;
 
-    rval = riscv_new_csr_seed(new_value, write_mask);
+    if (env->zkr_csr_is_read) {
+        rval = riscv_new_csr_seed(new_value, write_mask);
+    } else {
+        rval = SEED_OPST_BIST;
+    }
 
     if (ret_value) {
         *ret_value = rval;
+        env->zkr_csr_is_read = true;
     }
 
     return RISCV_EXCP_NONE;
-- 
2.34.1



