Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F74C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 23:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUwrj-0006ym-Kf; Fri, 19 Jul 2024 19:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwri-0006u6-Cs; Fri, 19 Jul 2024 19:18:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwrg-0006RR-Nl; Fri, 19 Jul 2024 19:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721431093; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=mQk+HoZF2f0RtHDlald+dinWdqte5kUK2h4GqQ4FmQY=;
 b=I0vjNj3MBJ5/kMU8wTqquA+LsPpXXa/9WqZVewvH2Scz/6Kmo7oZ6UUJVQJzWCTXXaDipCeyBkFhv7pEYN9mFOv46MPO2GXzTgqUM5zpELvCzbz2DSrBpoa0UHEDJ/lsLjxsGZ0XJJ0/E0hWeulhIsdjkZq3TvpGfl7vvil4SZw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045046011;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0WAsnMN0_1721431091; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WAsnMN0_1721431091) by smtp.aliyun-inc.com;
 Sat, 20 Jul 2024 07:18:12 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: [PATCH v6 7/8] target/riscv: Add any32 and max32 CPU for RV64 QEMU
Date: Sat, 20 Jul 2024 07:11:48 +0800
Message-Id: <20240719231149.1364-8-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

We may need 32-bit max or 32-bit any CPU for RV64 QEMU. Thus we add
these two CPUs for RV64 QEMU.

The reason we don't expose them to RV32 QEMU is that we already have
max or any cpu with the same configuration. Another reason is that
we want to follow the RISC-V custom where addw instruction doesn't
exist in RV32 CPU.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  2 ++
 target/riscv/cpu.c     | 13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 3670cfe6d9..9f91743b78 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -31,6 +31,8 @@
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
+#define TYPE_RISCV_CPU_ANY32            RISCV_CPU_TYPE_NAME("any32")
+#define TYPE_RISCV_CPU_MAX32            RISCV_CPU_TYPE_NAME("max32")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0df145d90f..ab2512bb19 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -464,11 +464,9 @@ static void riscv_max_cpu_init(Object *obj)
 
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
-#ifdef TARGET_RISCV32
-    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
-#else
-    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
-#endif
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
@@ -2962,6 +2960,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
 #endif
 
+#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY32,     MXL_RV32,  riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+#endif
+
 #if defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
-- 
2.25.1


