Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC29C48292
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 05:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWVHI-0002Cq-DV; Sun, 04 Feb 2024 00:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rWVHE-0002CB-Mo; Sun, 04 Feb 2024 00:42:48 -0500
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rWVHC-0007h9-Gf; Sun, 04 Feb 2024 00:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1707025359; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=xDYD+IGKD2fXCKy7qnheHnSq4iihbUK1cj+sAgP9Ha8=;
 b=NpERZbz8WsKU3ddJvNeA3ROC8j3p9cC9EKRgpWU+Xey20SSsc43mp+pcfaiWuwnOv2a+P4t8blovMAogP2+X2uFBqOnfmbKt6YaKLL1mHYpuaiGwNrPoPMZ/J4Sj6NtK6oiP74bjxsSYORCDtCB0qNG/P8S7ZMCViXYFMT+GVVs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W0.iu5X_1707025350; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W0.iu5X_1707025350) by smtp.aliyun-inc.com;
 Sun, 04 Feb 2024 13:42:37 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, bjorn@kernel.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 1/2] target/riscv: Register vendors CSR
Date: Sun,  4 Feb 2024 13:42:27 +0800
Message-Id: <20240204054228.651-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
References: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

riscv specification allows custom CSRs in decode area. So we should
register all vendor CSRs in cpu realize stage.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
1) Use int index to quiet the  Werror for "i < 0".
---
 target/riscv/cpu.c         |  3 +++
 target/riscv/tcg/tcg-cpu.c | 18 ++++++++++++++++++
 target/riscv/tcg/tcg-cpu.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cbfc7e781..2dcbc9ff32 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1113,6 +1113,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (tcg_enabled()) {
+        riscv_tcg_cpu_register_vendor_csr(cpu);
+    }
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 994ca1cdf9..559bf373f3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -871,6 +871,24 @@ static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
     }
 }
 
+void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
+{
+    static const struct {
+        bool (*guard_func)(const RISCVCPUConfig *);
+        riscv_csr_operations *csr_ops;
+    } vendors[] = {
+    };
+    for (int i = 0; i < ARRAY_SIZE(vendors); ++i) {
+        if (!vendors[i].guard_func(&cpu->cfg)) {
+            continue;
+        }
+        for (size_t j = 0; j < CSR_TABLE_SIZE &&
+                           vendors[i].csr_ops[j].name; j++) {
+            csr_ops[j] = vendors[i].csr_ops[j];
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
index f7b32417f8..3daaebf4fb 100644
--- a/target/riscv/tcg/tcg-cpu.h
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -25,5 +25,6 @@
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
+void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu);
 
 #endif
-- 
2.25.1


