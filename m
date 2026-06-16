Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED0CCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhH-0008Eb-3R; Tue, 16 Jun 2026 06:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhF-00081D-55
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:05 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhD-0003MD-05
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:04 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c88831f28f4so417194a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604422; x=1782209222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jxiXtNxHQeunKjhZBQ34EwCH1Q6dP1U0lZODDJfL4M=;
 b=H6cowK3mlbAb+2oHReYo6/L3jGX/wEIXxkP6mui+wKJ5jf+WH09oX3ckEEZlSrICUb
 Byq8umPGZzILNkwuRqfPFB8W1W9kVdH8DYY7d1n/Sk2aV6bKXwchyjiFLnS71XUniVKq
 j+MkyI1aQK8We0ow1CCOoicY/IiEa1v8P/BCTc7/FGBClrn4YDj9JeJ3NleUb2Y8v6ux
 6ie7Fu5J0aDBeqGZCQod3jAmzkuazwb6WUy9/b2iD9BJX0VFVOUx6J1G8M1CHCQE3D1b
 hwOS1QHQhMq6ToIWPlgyrLKO1Bh4IleeacZdbrkQW7fQlrYorab7U6rJGKBQ2SfpPiOF
 OEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604422; x=1782209222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jxiXtNxHQeunKjhZBQ34EwCH1Q6dP1U0lZODDJfL4M=;
 b=KEKBoxgxN5iwZX6G32Lx92kTsyDPURPhoDEE/1F/PX1bQ5DVcVZWrjzxlV1zDRX2nV
 M5zb32yfgKb6g2Z4+JJw0WEnV9jrdnZxLlucOsTfiuOSsjadRzkGKW5UOU8ti5GSMVJz
 m5g2y+idKR0Pedf/zJtAKsvRCVgiz2jdtZRdAh6h92bZEPO/u11AwpysxoJFvAmtfniA
 gmwi0sHDEm22I2KUWqeTgemdIhfkpFD61qosjlOS1/TTdmJx5zyMBl1zZM+Ap2iwaOw8
 R6Vla3hh8/GNRxJ3WoH5ITY5/6RPgdvlOHEjT5yjklOxYFZw/Buf5qCN3VcG1ZXe4qo/
 IkEQ==
X-Gm-Message-State: AOJu0Yxyz3Sru0lSsy8zTNBAaJJsID1BIGzFc9Qj9bmvPEIxhd5oivzI
 3tjptVIUt+bmFPQCzi4I2zdGGzw5oZ2Za5xsoWAHW9RIUQNbJaxVuX3LksDik0Qu
X-Gm-Gg: Acq92OGNa8bkilxyTq/Unb9XnV9CcCzmiSSQPVuNUgnRI5UcQMPOSTL7hMocmVFhEdY
 +LR1sTF4NWsRNimPmBgYzfM55dYtxBSy7jMYNiM+FRXvjHy0GtgIBmwJwYaNJFHBNfQ6OU7QjSc
 2UyyHI7yjwI198xFxrARUD7UcBzk2EvQ6HzzELt9U6PwDxfVYzCSewrsqGYkP4RGc6vScgFPo03
 bZzFuIyvCd1SN22WLsoLLWgzbPnA4/nFqCozsVRZTW7Gb6KrM/NYmQGOQzX1fg8YEJIQYOI2e0i
 z02lOUQ6GUXQo8qL5i6vZmDRwmDhCYztGCWZHpFq9Hw2+UPZUG00kTT/3DiBrVvho6Uy7+tymmL
 eMLB3CjdpTIjHejj9xSgb5udRejxe1/YnIGVWPWBAkrHef8GpPis/gEmLA/rbwnt4bB+uThnwRo
 EBMb0coAu5ooIrVcItIgn+Af0zcDwi3YLpXXLtYEpS
X-Received: by 2002:a05:6a20:d70a:b0:39c:5624:ee53 with SMTP id
 adf61e73a8af0-3b7e4ce6955mr3321483637.24.1781604421609; 
 Tue, 16 Jun 2026 03:07:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/83] target/riscv: Fix size of [m|s|vs]iselect fields
Date: Tue, 16 Jun 2026 20:04:28 +1000
Message-ID: <20260616100527.1939565-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

[m|s|vs]iselect are defined in version 20250508 of the privileged
specification to be XLEN in size, however QEMU only ever uses at most
16 bits of these fields, so fix them to 16.  Update relevant function
arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-15-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  8 ++++----
 target/riscv/csr.c     | 32 ++++++++++++++++----------------
 target/riscv/machine.c |  6 +++---
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2a4b7378f3..c338df1598 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -344,8 +344,8 @@ struct CPUArchState {
     uint8_t siprio[64];
 
     /* AIA CSRs */
-    target_ulong miselect;
-    target_ulong siselect;
+    uint16_t miselect;
+    uint16_t siselect;
     uint64_t mvien;
     uint64_t mvip;
 
@@ -391,7 +391,7 @@ struct CPUArchState {
     uint64_t vsatp;
 
     /* AIA VS-mode CSRs */
-    target_ulong vsiselect;
+    uint16_t vsiselect;
 
     uint64_t mtval2;
     uint64_t mtinst;
@@ -794,7 +794,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 }
 #endif
 
-static inline int riscv_cpu_xlen(CPURISCVState *env)
+static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
 {
     return 16 << env->xl;
 }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0d0b2fca49..29db646589 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2440,7 +2440,7 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong *val, target_ulong new_val,
                                    target_ulong wr_mask)
 {
-    target_ulong *iselect;
+    uint16_t *iselect;
     int ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
@@ -2483,18 +2483,18 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static bool xiselect_aia_range(target_ulong isel)
+static bool xiselect_aia_range(uint16_t isel)
 {
     return (ISELECT_IPRIO0 <= isel && isel <= ISELECT_IPRIO15) ||
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
-static bool xiselect_cd_range(target_ulong isel)
+static bool xiselect_cd_range(uint16_t isel)
 {
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
-static bool xiselect_ctr_range(int csrno, target_ulong isel)
+static bool xiselect_ctr_range(int csrno, uint16_t isel)
 {
     /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
     return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
@@ -2502,7 +2502,7 @@ static bool xiselect_ctr_range(int csrno, target_ulong isel)
 }
 
 static int rmw_iprio(target_ulong xlen,
-                     target_ulong iselect, uint8_t *iprio,
+                     uint16_t iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
                      target_ulong wr_mask, int ext_irq_no)
 {
@@ -2546,7 +2546,7 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2585,7 +2585,7 @@ static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong *val,
                           target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2624,7 +2624,7 @@ static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
+static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     /*
@@ -2665,7 +2665,7 @@ static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
 }
 
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
-                         target_ulong isel, target_ulong *val,
+                         uint16_t isel, target_ulong *val,
                          target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = false, isel_reserved = false;
@@ -2746,12 +2746,12 @@ done:
 }
 
 static int rmw_xireg_cd(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    int ctr_index = isel - ISELECT_CD_FIRST;
-    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+    uint16_t ctr_index = isel - ISELECT_CD_FIRST;
+    uint16_t isel_hpm_start = ISELECT_CD_FIRST + 3;
 
     if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
         ret = RISCV_EXCP_ILLEGAL_INST;
@@ -2818,7 +2818,7 @@ done:
 }
 
 static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
-                        target_ulong isel, target_ulong *val,
+                        uint16_t isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
@@ -2846,7 +2846,7 @@ static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
  * extension using csrind should be implemented here.
  */
 static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
-                              target_ulong isel, target_ulong *val,
+                              uint16_t isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
     bool virt = csrno == CSR_VSIREG ? true : false;
@@ -2876,7 +2876,7 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
                       target_ulong new_val, target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
@@ -2907,7 +2907,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong wr_mask)
 {
     int ret = -EINVAL;
-    target_ulong isel;
+    uint16_t isel;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
     if (ret != RISCV_EXCP_NONE) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index eb57ab07dc..45fd39994e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -109,7 +109,7 @@ static const VMStateDescription vmstate_hyper = {
         VMSTATE_UINT64(env.vscause, RISCVCPU),
         VMSTATE_UINT64(env.vstval, RISCVCPU),
         VMSTATE_UINT64(env.vsatp, RISCVCPU),
-        VMSTATE_UINTTL(env.vsiselect, RISCVCPU),
+        VMSTATE_UINT16(env.vsiselect, RISCVCPU),
         VMSTATE_UINT64(env.vsie, RISCVCPU),
 
         VMSTATE_UINT64(env.mtval2, RISCVCPU),
@@ -487,8 +487,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.mepc, RISCVCPU),
         VMSTATE_UINT64(env.mcause, RISCVCPU),
         VMSTATE_UINT64(env.mtval, RISCVCPU),
-        VMSTATE_UINTTL(env.miselect, RISCVCPU),
-        VMSTATE_UINTTL(env.siselect, RISCVCPU),
+        VMSTATE_UINT16(env.miselect, RISCVCPU),
+        VMSTATE_UINT16(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
-- 
2.54.0


