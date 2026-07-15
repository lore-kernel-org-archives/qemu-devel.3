Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7BAC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk128-0006lQ-RW; Wed, 15 Jul 2026 10:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11x-0006eS-32; Wed, 15 Jul 2026 10:56:14 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11m-00052u-CA; Wed, 15 Jul 2026 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784127347; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=HANcIgYWWT+envrnIre/BFVi6a1eYrS8eNzuN21S4Pw=;
 b=KRFhhUkbD2nyK+jHcvAevACRWQ7bWJhPZ0rQkGrtP+W35RmrnyWIb1PBk5VuY+7XnaG2nX9aeOe5ZDMgOLIB8Ul/X36Qx84XCACc2sihOPCHG7tCoZdsZ8tzmKObCIv5cJQUS2e1bwvU6vcZZDtHIBbK817HQpcQCHoHh0oIzrg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X79XjO4_1784127030; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X79XjO4_1784127030 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Jul 2026 22:50:31 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 02/11] target/riscv: Add smmpt-sdidlen property for the
 mmpt SDID field
Date: Wed, 15 Jul 2026 22:50:07 +0800
Message-Id: <20260715145016.17369-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The number of implemented SDID bits is UNSPECIFIED and may be zero. The
number of implemented SDID bits, termed SDIDLEN, may be determined by
writing one to every bit position in the SDID field, then reading back
the value in mmpt to see which bit positions in the SDID field hold a
one. The least-significant bits of SDID are implemented first: that is,
if SDIDLEN > 0, SDID[SDIDLEN-1:0] is writable. The maximal value of
SDIDLEN, termed SDIDMAX, is 6.

Model this by adding a configurable "smmpt-sdidlen" CPU property. The value
defaults to SDIDMAX (6) to preserve the current behaviour. The mmpt write
handler now keeps only the low SDIDLEN bits of the SDID field, making the
SDIDLEN discovery sequence work as specified.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c                | 45 +++++++++++++++++++++++++++++++
 target/riscv/cpu_bits.h           |  3 +++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/tcg/csr.c            | 11 ++++++--
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563b..0f96e487fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1434,6 +1434,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlenb = 128 >> 3;
     cpu->cfg.elen = 64;
+    cpu->cfg.sdidlen = MMPT_SDIDLEN_MAX;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
@@ -1939,6 +1940,48 @@ static const PropertyInfo prop_vlen = {
     .set = prop_vlen_set,
 };
 
+static void prop_sdidlen_set(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value > MMPT_SDIDLEN_MAX) {
+        error_setg(errp, "smmpt-sdidlen must be between 0 and %d",
+                   MMPT_SDIDLEN_MAX);
+        return;
+    }
+
+    if (value != cpu->cfg.sdidlen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.sdidlen);
+        return;
+    }
+
+    cpu_option_add_user_setting(cpu, name);
+    cpu->cfg.sdidlen = value;
+}
+
+static void prop_sdidlen_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t value = RISCV_CPU(obj)->cfg.sdidlen;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_sdidlen = {
+    .type = "uint8",
+    .description = "smmpt-sdidlen",
+    .get = prop_sdidlen_get,
+    .set = prop_sdidlen_set,
+};
+
 static void prop_elen_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -2853,6 +2896,8 @@ static const Property riscv_cpu_properties[] = {
     {.name = "vlen", .info = &prop_vlen},
     {.name = "elen", .info = &prop_elen},
 
+    {.name = "smmpt-sdidlen", .info = &prop_sdidlen},
+
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4ed4843e3d..642edf3369 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1171,6 +1171,9 @@ typedef enum CTRType {
 #define CSR_MMPT        0x382
 #define CSR_MSDCFG      0x74E
 
+/* Maximal number of implemented SDID bits (SDIDMAX) */
+#define MMPT_SDIDLEN_MAX    6
+
 /*
  * MMPT register layout for MXLEN=32:
  * MODE[31:30], 0[29:28], SDID[27:22], PPN[21:0]
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 6b616388be..4a8c9b9e21 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -174,6 +174,7 @@ TYPED_FIELD(uint64_t, mimpid, 0)
 TYPED_FIELD(uint32_t, pmu_mask, 0)
 TYPED_FIELD(uint16_t, vlenb, 0)
 TYPED_FIELD(uint16_t, elen, 0)
+TYPED_FIELD(uint8_t,  sdidlen, 0)
 TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 8ffe85caa9..8d38d7a972 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5608,6 +5608,11 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
     uint32_t mode_value = 0;
+    /*
+     * Only the least-significant SDIDLEN bits of the SDID field are
+     * writable; the remaining bits are WARL and read as zero.
+     */
+    uint64_t sdid_mask = MAKE_64BIT_MASK(0, riscv_cpu_cfg(env)->sdidlen);
     if (!riscv_cpu_cfg(env)->ext_smmpt) {
         goto set_remaining_fields_zero;
     }
@@ -5621,7 +5626,8 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
             /* Only write the legal value */
             env->mptmode = mode_value;
         }
-        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
+        env->sdid = ((val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32)
+                    & sdid_mask;
         env->mptppn = val & MMPT_PPN_MASK_32;
     } else if (riscv_cpu_xlen(env) == 64) {
         mode_value = (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
@@ -5632,7 +5638,8 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
             mode_value += SMMPT43 - SMMPT34;
             env->mptmode = mode_value;
         }
-        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
+        env->sdid = (((uint64_t)val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64)
+                    & sdid_mask;
         env->mptppn = val & MMPT_PPN_MASK_64;
         /* Smmpt64: root table PPN bits 2:0 must be zero (32KiB alignment) */
         if (env->mptmode == SMMPT64) {
-- 
2.43.0


