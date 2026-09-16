Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA74FC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6li9-0001D9-Px; Wed, 16 Sep 2026 05:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li6-0001Bu-Bm; Wed, 16 Sep 2026 05:13:46 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li4-000886-CK; Wed, 16 Sep 2026 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FyJL20A39h2kKxhzQYeYC1sWQDptdRBUqh98p24QS7E=; b=bEm3Wj0TOoWs4oH
 QzzsoY/wCzY4NRwIS2jbhFUBF37qrpQZOSaTCJg0o9prHCHfN3+JY1CXzjv0BjG+cKewDnIYygpEt
 Jsh8JxHCL5tGamYqGHokA2aSM92Fm2ANDLxxF7jFEMNN2wisWAGWD5wR33Hy+emaX585ToNBeqJ5A
 Tk=;
Date: Wed, 16 Sep 2026 11:18:59 +0200
Subject: [PATCH v4 04/12] target/riscv: Widen riscv_new_csr_seed()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-4-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=1839;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=zb8F/1kBBmzlCQeVmQAig7W/OLnoGf4kzsddQpqDRUE=;
 b=78+monYOt9euuE+XY4LAeOmknCSekrG3lk93a2iZaEFDytoudB8jYy/22+6lWtjYscqJqTACb
 eBYe25ZdWvTAtKo87/zsRSrz+FUZgdbkAo70+CVtixZzi196Rmx4cLs
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the function is exposed through the cpu.h header, make sure it's
rv32/rv64 agnostic.  Note return type could be made uint32_t and arguments
dropped, but I chose to follow the existing CSR OP style of functions,
in case there are other plans for this one.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 4 ++--
 target/riscv/cpu.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a820ec2f6e..a5fb75b990 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -953,8 +953,8 @@ void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
+uint64_t riscv_new_csr_seed(uint64_t new_value,
+                            uint64_t write_mask);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 const char *priv_spec_to_str(int priv_version);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f58e91b62..3356ba61d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -546,13 +546,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 #endif
 
 /* Used by csr.c and the KVM driver */
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask)
+uint64_t riscv_new_csr_seed(uint64_t new_value,
+                            uint64_t write_mask)
 {
     uint16_t random_v;
     Error *random_e = NULL;
     int random_r;
-    target_ulong rval;
+    uint64_t rval;
 
     random_r = qemu_guest_getrandom(&random_v, 2, &random_e);
     if (unlikely(random_r < 0)) {

-- 
2.52.0


