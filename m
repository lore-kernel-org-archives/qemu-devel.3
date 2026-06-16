Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D73ACD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhu-0002F2-Qu; Tue, 16 Jun 2026 06:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhs-0001v0-4p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhp-0003UI-Rh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c0aa420401so31922985ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604460; x=1782209260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFbtHTpTbPnfYlm9OrTcuscTEdQcUcd5xh026t7kduI=;
 b=iGGW29PZsXfPHi9R9Ne3UFiN4C+FA4DvKZvhs4DU4jVuyV7KSNjrgsT4ZmuuY7Sjun
 ADJSzZ3PsBRQ1Z2vOfNSPIl9rosoqUYIa28SreCR/N0EcJdZrooXNjq4TEbf7M8/xleq
 isGYdxODCm2cY6ayWkFnANC1gQsy9j/dwybbNYmSy7LooKjnz+l75u+kjIHJBK1yaC5F
 YhGNtvMEM9LArfIUJyTnRL3E84qcaxwnZ2tl+QYI9pVVniJWiwLVUIBdt5cfT6AAnFyJ
 rbm8nbwub4RemQFix+amLxIRqt25ZrWUjZa+lX04NQYV5Mw7Zpe2KjkEQmRCiuRkc2Hw
 ZmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604460; x=1782209260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFbtHTpTbPnfYlm9OrTcuscTEdQcUcd5xh026t7kduI=;
 b=s9TLALkdmfO1I/C5fcUdVEDejUxkri3JG0JHTsDrxrZHxH84Y1cjWG7w823shBaR1m
 wiOKrAR+WJcSPo8KX1CQNeV/+3sqGsHRX9ceHUSG4z6ASVQDgwVpyf2WqyzqbFKH+FW7
 K1vlNiUCw6jIbNM97vheteIo8i2RDIssrPst2M0APGR6PpqmyZh6KiHpRibdbzuMCUlL
 Ij+zeJ0+WTIP5TUsk1s+MiNQ09pIiey7dl9uUpVwBrejqoLNrklWZ0+W9AsD7O3gRdxV
 otQgqePHCExOtqi1mT1+elnT40v8dBko45VTnjn1KPcwKDSGd37ry1wseUj6FW5i6N2Z
 CGlQ==
X-Gm-Message-State: AOJu0YwTkXegs2NamyztAFLXlas2CtydNQR9SfmhSGunxcyoUpYnsURO
 YjAyKsK7CLu5CxH+m/dc3XzlynxGAa26aFtl70urnqg0E6bUz/RA+OqhUxY78ZWU
X-Gm-Gg: Acq92OHkZn67Fb6H63xkV2caFLofN79y4Z+Zsx4+IsI636H5IYd312fwnTMvZf5Wc9h
 3FenjIkLZ2YfL4wuk1kxVpKivBcYDXSGkh24zSjwfi//VG2c3aFpt46qQ0ub1f3Cj2OFVPgRjHM
 rpe1eUa+N3kIZ7xPTk2qp67gzFODhaYd94f6NyxBL0HvXkTwrlJBHpB5URabs6ekncZRFYCWfpc
 vjEtYjAYCUEQKeOoAQRJXyHY1TNDIYiQbkgXE8RvBjwZMgXWF0XPVpQfFDUrdtyMnnHgEQlh83b
 9kw/cmu6f1LNwF/+6j9h/2YuIOFf8+iX2DLc1PS9XFV/RJJ40DxZ2OPnOU4u8YLTbd1ZSR3FHxh
 qPxtQUsVERD7YgEj3dhf4GZocCCOB+hYz78tjOfAbicaswYFITksZdYRJwqLpcpzyOwVTppaJZt
 rHuF0yZwX+KljtoE1lelMCm8KlXEqLo/O/GEN6KxVy
X-Received: by 2002:a17:903:4587:b0:2c2:8659:da3a with SMTP id
 d9443c01a7336-2c4132039cbmr202766105ad.31.1781604460392; 
 Tue, 16 Jun 2026 03:07:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/83] target/riscv: Make pmp.h target_ulong agnostic
Date: Tue, 16 Jun 2026 20:04:39 +1000
Message-ID: <20260616100527.1939565-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson <anjo@rev.ng>

The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
CPUArchState.  CSR declarations are only used in target/ and are moved to
csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
parameter is fixed to 8 bits, similar to previous commits.

Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
migration from older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-26-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.h     | 12 ++++++++++++
 target/riscv/pmp.h     | 19 +++++--------------
 target/riscv/machine.c | 10 +++++-----
 target/riscv/pmp.c     | 10 ++++++----
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 4cca3a000a..c791260f83 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -87,4 +87,16 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
 
+/* PMP CSRs, defined in pmp.c */
+void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
+                      target_ulong val);
+target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
+uint64_t mseccfg_csr_read(CPURISCVState *env);
+
+void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
+                       target_ulong val);
+target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
+
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 91130289d8..eae305ac6f 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,7 +22,6 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
-#include "exec/target_long.h"
 #include "cpu.h"
 
 typedef enum {
@@ -52,7 +51,7 @@ typedef enum {
 } mseccfg_field_t;
 
 typedef struct {
-    target_ulong addr_reg;
+    uint64_t addr_reg;
     uint8_t  cfg_reg;
 } pmp_entry_t;
 
@@ -67,21 +66,13 @@ typedef struct {
     uint32_t num_rules;
 } pmp_table_t;
 
-void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-                      target_ulong val);
-target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+typedef struct CPUArchState CPURISCVState;
 
-void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
-uint64_t mseccfg_csr_read(CPURISCVState *env);
-
-void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
-                       target_ulong val);
-target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
+                        int size, pmp_priv_t privs,
                         pmp_priv_t *allowed_privs,
-                        target_ulong mode);
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
+                        privilege_mode_t mode);
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index dad45f10c3..6e70b145a5 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -49,10 +49,10 @@ static int pmp_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_pmp_entry = {
     .name = "cpu/pmp/entry",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(addr_reg, pmp_entry_t),
+        VMSTATE_UINT64(addr_reg, pmp_entry_t),
         VMSTATE_UINT8(cfg_reg, pmp_entry_t),
         VMSTATE_END_OF_LIST()
     }
@@ -60,8 +60,8 @@ static const VMStateDescription vmstate_pmp_entry = {
 
 static const VMStateDescription vmstate_pmp = {
     .name = "cpu/pmp",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmp_needed,
     .post_load = pmp_post_load,
     .fields = (const VMStateField[]) {
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 211f5b3862..d93563c36b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
@@ -317,7 +318,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index, hwaddr addr)
  */
 static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
                                        pmp_priv_t *allowed_privs,
-                                       target_ulong mode)
+                                       privilege_mode_t mode)
 {
     bool ret;
 
@@ -380,8 +381,9 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
  * have no functional impact in QEMU emulation.
  */
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
-                        pmp_priv_t *allowed_privs, target_ulong mode)
+                        int size, pmp_priv_t privs,
+                        pmp_priv_t *allowed_privs,
+                        privilege_mode_t mode)
 {
     int i = 0;
     int pmp_size = 0;
@@ -732,7 +734,7 @@ uint64_t mseccfg_csr_read(CPURISCVState *env)
  * To avoid this we return a size of 1 (which means no caching) if the PMP
  * region only covers partial of the TLB page.
  */
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
 {
     hwaddr pmp_sa;
     hwaddr pmp_ea;
-- 
2.54.0


