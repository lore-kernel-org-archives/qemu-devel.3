Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F59CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOypk-0005VZ-73; Mon, 18 May 2026 10:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOyph-0005Ux-Vw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:20:38 -0400
Received: from mta212a-ord.mtasv.net ([104.245.209.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pm_bounces@pm.mtasv.net>)
 id 1wOype-0002nE-V0
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:20:37 -0400
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoicWVtdS1kZXZlbEBub25nbnUub3JnIn0=
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806;
 c=relaxed/relaxed; 
 bh=0JbQeoOqTiL1eqXMetxQ2DhpxGAfdHIVjrJbrCsoHY4=;
 h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
 t=1779114034; x=1779718834;
 b=To0ZluqRgGUopZgLdnSnHT2cr80c/ew3+6bbZMusyEcqQxwNQn/QEo8L2a5YXLmWWRjHojsvU
 tCRxrBwWYlU3TXdcQCICrZlOCU/hI54emwmjM48TeQ8Zb/UAky048kTbLUaV761jZVOOfbkoNfu
 4Mbz5MxH8FTIz8ROa18stXl1uwOTG4NnNhhAzpcu8wsVD7aF4b+MapA7Z2vP8GWY6PMAWpJPNEh
 dKUK1RH8iF58w2brO9bvhnlOQq/MD0cs89Ee425QA0lyhSbrt1Trq2SBv+ZgpLuzpaSflg2o495
 bfZwYJTjOmS3cJo5xd7DimqCXm9eFd/XzGd/5wVfsKdg==;
Received: from ip-172-26-31-179.us-east-2.compute.internal (172.26.31.179)
 by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.244) 
 with ESMTP id bba500ec52c411f189d40209af5131b9 for <qemu-devel@nongnu.org>;
 Mon, 18 May 2026 14:20:34 +0000
From: SignKirigami <prcups@krgm.moe>
Date: Mon, 18 May 2026 14:20:33 +0000
Subject: [PATCH 1/4] target/loongarch: add LVZ CPU state and CSR metadata
Message-Id: <734d561d-4a8c-4235-b55d-1387020f8a62@mtasv.net>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518142155.5086-1-prcups@krgm.moe>
References: <20260518142155.5086-1-prcups@krgm.moe>
Feedback-ID: s9655927-_:s9655927:a251693:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 251693_9655927
X-PM-Message-Id: 734d561d-4a8c-4235-b55d-1387020f8a62
X-PM-RCPT: |bTF8MjUxNjkzfDk2NTU5Mjd8cWVtdS1kZXZlbEBub25nbnUub3Jn|
X-PM-Message-Options: v1;
 1.HYukbPqv0CbgfxKifMdslw.jNyanRNK2y_WzBqWy5Sv1TmjbHhRLKS26QTP9p2xjmLPfrUvstRGH79kSZxz8719n_I-Dr2IrTT9ZmZ3JFN6bb5TexWLjXbQOBlR1xIONnhU5yIJL6jpA_qDEGEOTnQ8xr-BmGggKGpIEpUWnfABQHfGMEuehp5Ghenh5jSWyEUVkcfDxpsdyu_hdamDWRsP
X-virtual-MTA: ord-104-245-209-212
X-PM-MTA-Pool: transactional-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=104.245.209.212;
 envelope-from=pm_bounces@pm.mtasv.net; helo=mta212a-ord.mtasv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Reply-To: prcups@krgm.moe
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-csr.h |  42 +++++++
 target/loongarch/cpu.h     | 125 ++++++++++++++++++-
 target/loongarch/csr.c     | 122 ++++++++++++++++++
 target/loongarch/csr.h     |   3 +
 target/loongarch/machine.c | 249 +++++++++++++++++++++++++------------
 5 files changed, 457 insertions(+), 84 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..4b0bb4d2e5 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -180,11 +180,13 @@ FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
+FIELD(CSR_TLBRPRMD, PGM, 3, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
=20
 /* Machine Error CSRs */
 #define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
 FIELD(CSR_MERRCTL, ISMERR, 0, 1)
+FIELD(CSR_MERRCTL, PGM, 5, 1)
 #define LOONGARCH_CSR_MERRINFO1      0x91
 #define LOONGARCH_CSR_MERRINFO2      0x92
 #define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
@@ -224,4 +226,44 @@ FIELD(CSR_DBG, ECODE, 16, 6)
 #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
 #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
=20
+/* LVZ (LoongArch Virtualization) CSRs */
+#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
+FIELD(CSR_GSTAT, VM, 0, 1)
+FIELD(CSR_GSTAT, PVM, 1, 1)
+FIELD(CSR_GSTAT, GIDBIT, 4, 6)
+FIELD(CSR_GSTAT, GID, 16, 8)
+
+#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
+FIELD(CSR_GCFG, MATP, 0, 4)
+FIELD(CSR_GCFG, MATC, 4, 2)
+FIELD(CSR_GCFG, TOPIP, 6, 1)
+FIELD(CSR_GCFG, TOPI, 7, 1)
+FIELD(CSR_GCFG, TOTIP, 8, 1)
+FIELD(CSR_GCFG, TOTI, 9, 1)
+FIELD(CSR_GCFG, TOEP, 10, 1)
+FIELD(CSR_GCFG, TOE, 11, 1)
+FIELD(CSR_GCFG, TOPP, 12, 1)
+FIELD(CSR_GCFG, TOP, 13, 1)
+FIELD(CSR_GCFG, TOHUP, 14, 1)
+FIELD(CSR_GCFG, TOHU, 15, 1)
+FIELD(CSR_GCFG, TOCIP, 16, 4)
+FIELD(CSR_GCFG, TOCI, 20, 2)
+FIELD(CSR_GCFG, GPMP, 23, 1)
+FIELD(CSR_GCFG, GPMNUM, 24, 3)
+
+#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
+FIELD(CSR_GINTC, HWIS, 0, 8)
+FIELD(CSR_GINTC, HWIP, 8, 8)
+FIELD(CSR_GINTC, HWIC, 16, 8)
+
+#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
+
+#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
+FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
+FIELD(CSR_GTLBC, USETGID, 12, 1)
+FIELD(CSR_GTLBC, TOTI, 13, 1)
+FIELD(CSR_GTLBC, TGID, 16, 8)
+
+#define LOONGARCH_CSR_TRGP           0x16 /* Trapped guest physical addres=
s */
+
 #endif /* LOONGARCH_CPU_CSR_H */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 096d778928..8d3cae59fa 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -20,6 +20,20 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
=20
+#define GET_CSR_IF(guest_mode, csr_name) \
+    ((guest_mode) ? (env->GCSR_##csr_name) : (env->CSR_##csr_name))
+
+#define SET_CSR_IF(guest_mode, csr_name, value) \
+    do {                                        \
+        if (guest_mode) {                       \
+            env->GCSR_##csr_name =3D (value);     \
+        } else {                                \
+            env->CSR_##csr_name =3D (value);      \
+        }                                       \
+    } while (0)
+
+#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
+
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
@@ -93,6 +107,10 @@ FIELD(FCSR0, CAUSE, 24, 5)
 #define  EXCCODE_WPEM                EXCODE(19, 1)
 #define  EXCCODE_BTD                 EXCODE(20, 0)
 #define  EXCCODE_BTE                 EXCODE(21, 0)
+#define  EXCCODE_GSPR                EXCODE(22, 0)
+#define  EXCCODE_HVC                 EXCODE(23, 0)
+#define  EXCCODE_GCSC                EXCODE(24, 0)
+#define  EXCCODE_GCHC                EXCODE(25, 0)
 #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode use=
d for debug */
=20
 /* cpucfg[0] bits */
@@ -255,6 +273,7 @@ FIELD(TLB_MISC, E, 0, 1)
 FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
+FIELD(TLB_MISC, GID, 54, 8)
=20
 /*Msg interrupt registers */
 #define N_MSGIS                4
@@ -389,6 +408,79 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+
+    /* LVZ (LoongArch Virtualization) CSRs */
+    uint64_t CSR_GSTAT;
+    uint64_t CSR_GCFG;
+    uint64_t CSR_GINTC;
+    uint64_t CSR_GCNTC;
+    uint64_t CSR_GTLBC;
+    uint64_t CSR_TRGP;
+
+    /* Guest CSR registers (GCSR) */
+    uint64_t GCSR_CRMD;
+    uint64_t GCSR_PRMD;
+    uint64_t GCSR_EUEN;
+    uint64_t GCSR_MISC;
+    uint64_t GCSR_ECFG;
+    uint64_t GCSR_ESTAT;
+    uint64_t GCSR_ERA;
+    uint64_t GCSR_BADV;
+    uint64_t GCSR_BADI;
+    uint64_t GCSR_EENTRY;
+    uint64_t GCSR_TLBIDX;
+    uint64_t GCSR_TLBEHI;
+    uint64_t GCSR_TLBELO0;
+    uint64_t GCSR_TLBELO1;
+    uint64_t GCSR_ASID;
+    uint64_t GCSR_PGDL;
+    uint64_t GCSR_PGDH;
+    uint64_t GCSR_PGD;
+    uint64_t GCSR_PWCL;
+    uint64_t GCSR_PWCH;
+    uint64_t GCSR_STLBPS;
+    uint64_t GCSR_RVACFG;
+    uint64_t GCSR_CPUID;
+    uint64_t GCSR_PRCFG1;
+    uint64_t GCSR_PRCFG2;
+    uint64_t GCSR_PRCFG3;
+    uint64_t GCSR_SAVE[16];
+    uint64_t GCSR_TID;
+    uint64_t GCSR_TCFG;
+    uint64_t GCSR_TVAL;
+    uint64_t GCSR_CNTC;
+    uint64_t GCSR_TICLR;
+    uint64_t GCSR_LLBCTL;
+    uint64_t GCSR_IMPCTL1;
+    uint64_t GCSR_IMPCTL2;
+    uint64_t GCSR_TLBRENTRY;
+    uint64_t GCSR_TLBRBADV;
+    uint64_t GCSR_TLBRERA;
+    uint64_t GCSR_TLBRSAVE;
+    uint64_t GCSR_TLBRELO0;
+    uint64_t GCSR_TLBRELO1;
+    uint64_t GCSR_TLBREHI;
+    uint64_t GCSR_TLBRPRMD;
+    uint64_t GCSR_MERRCTL;
+    uint64_t GCSR_MERRINFO1;
+    uint64_t GCSR_MERRINFO2;
+    uint64_t GCSR_MERRENTRY;
+    uint64_t GCSR_MERRERA;
+    uint64_t GCSR_MERRSAVE;
+    uint64_t GCSR_CTAG;
+    uint64_t GCSR_DMW[4];
+    uint64_t GCSR_DBG;
+    uint64_t GCSR_DERA;
+    uint64_t GCSR_DSAVE;
+    uint64_t GCSR_GSTAT;
+    uint64_t GCSR_GCFG;
+    uint64_t GCSR_GINTC;
+    uint64_t GCSR_GCNTC;
+    uint64_t GCSR_GTLBC;
+    uint64_t GCSR_TRGP;
+
+    bool guest;
+    bool vm_exit;
     /* Msg interrupt registers */
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
@@ -410,6 +502,7 @@ typedef struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
+    LoongArchTLB gtlb[LOONGARCH_TLB_MAX];
 #endif
=20
     AddressSpace *address_space_iocsr;
@@ -434,9 +527,11 @@ struct ArchCPU {
=20
     CPULoongArchState env;
     QEMUTimer timer;
+    QEMUTimer guest_timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
+    OnOffAuto lvz;
     OnOffAuto ptw;
     OnOffAuto lsx;
     OnOffAuto lasx;
@@ -480,6 +575,24 @@ struct LoongArchCPUClass {
 #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
+#define MMU_GUEST_IDX    5
+#define MMU_GUEST_DA_IDX 9
+
+static inline bool is_guest_mmu_idx(int mmu_idx)
+{
+    return mmu_idx >=3D MMU_GUEST_IDX;
+}
+
+static inline int mmu_idx_to_plv(int mmu_idx)
+{
+    if (mmu_idx =3D=3D MMU_DA_IDX || mmu_idx =3D=3D MMU_GUEST_DA_IDX) {
+        return 0;
+    }
+    if (is_guest_mmu_idx(mmu_idx)) {
+        return mmu_idx - MMU_GUEST_IDX;
+    }
+    return mmu_idx;
+}
=20
 static inline bool is_la64(CPULoongArchState *env)
 {
@@ -490,8 +603,9 @@ static inline bool is_va32(CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 =3D !is_la64(env);
-    uint64_t plv =3D FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >=3D 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << p=
lv))) {
+    uint64_t plv =3D FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PL=
V);
+    if (plv >=3D 1 &&
+        (FIELD_EX64(GET_CSR_IF(env->guest, MISC), CSR_MISC, VA32) & BIT(pl=
v))) {
         va32 =3D true;
     }
     return va32;
@@ -515,6 +629,13 @@ static inline void set_pc(CPULoongArchState *env, uint=
64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
+#define HW_FLAGS_GUEST_MODE 0x80
+
+bool has_lvz_capability(CPULoongArchState *env);
+bool will_return_to_guest(CPULoongArchState *env);
+uint8_t get_gid(CPULoongArchState *env);
+uint8_t get_tgid(CPULoongArchState *env);
+void trigger_vm_exit(CPULoongArchState *env);
=20
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
=20
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index fff2312f87..1c4505536d 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -20,8 +20,27 @@
         .flags =3D 0, .readfn =3D NULL, .writefn =3D NULL           \
     }
=20
+#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                              \
+    [LOONGARCH_CSR_##                                                 \
+        NAME] =3D { .name =3D (stringify(GCSR_##NAME)),                   =
\
+                  .offset =3D offsetof(CPULoongArchState, GCSR_##NAME), \
+                  .flags =3D FL,                                        \
+                  .readfn =3D RD,                                       \
+                  .writefn =3D WR }
+
+#define GCSR_OFF_ARRAY(NAME, N)                                         \
+    [LOONGARCH_CSR_##NAME(N)] =3D { .name =3D (stringify(GCSR_##NAME##N)),=
  \
+                                  .offset =3D offsetof(CPULoongArchState, =
\
+                                                     GCSR_##NAME[N]),   \
+                                  .flags =3D 0,                           =
\
+                                  .readfn =3D NULL,                       =
\
+                                  .writefn =3D NULL }
+
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, 0)
+#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
+#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, 0)
+#define GCSR_GSPR(NAME) GCSR_OFF_FUNCS(NAME, CSRFL_GSPR, NULL, NULL)
=20
 static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -35,6 +54,8 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
     CSR_OFF(EENTRY),
     CSR_OFF(TLBIDX),
+    CSR_OFF(GTLBC),
+    CSR_OFF(TRGP),
     CSR_OFF(TLBEHI),
     CSR_OFF(TLBELO0),
     CSR_OFF(TLBELO1),
@@ -71,6 +92,10 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
     CSR_OFF(CNTC),
     CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF(GSTAT),
+    CSR_OFF(GCFG),
+    CSR_OFF_FLAGS(GINTC, CSRFL_IO),
+    CSR_OFF(GCNTC),
     CSR_OFF(LLBCTL),
     CSR_OFF(IMPCTL1),
     CSR_OFF(IMPCTL2),
@@ -135,6 +160,87 @@ static CSRInfo csr_info[] =3D {
     CSR_OFF(MSGIR),
 };
=20
+static CSRInfo gcsr_info[] =3D {
+    GCSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
+    GCSR_OFF(PRMD),
+    GCSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
+    GCSR_OFF_FLAGS(MISC, CSRFL_GUEST_READONLY),
+    GCSR_OFF(ECFG),
+    GCSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
+    GCSR_OFF(ERA),
+    GCSR_OFF(BADV),
+    GCSR_OFF_FLAGS(BADI, CSRFL_GUEST_READONLY),
+    GCSR_OFF(EENTRY),
+    GCSR_OFF(TLBIDX),
+    GCSR_GSPR(GTLBC),
+    GCSR_GSPR(TRGP),
+    GCSR_OFF(TLBEHI),
+    GCSR_OFF(TLBELO0),
+    GCSR_OFF(TLBELO1),
+    GCSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
+    GCSR_OFF(PGDL),
+    GCSR_OFF(PGDH),
+    GCSR_OFF_FLAGS(PGD, CSRFL_GUEST_READONLY),
+    GCSR_OFF(PWCL),
+    GCSR_OFF(PWCH),
+    GCSR_OFF(STLBPS),
+    GCSR_OFF(RVACFG),
+    GCSR_OFF_FLAGS(CPUID, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG1, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG2, CSRFL_GUEST_READONLY),
+    GCSR_OFF_FLAGS(PRCFG3, CSRFL_GUEST_READONLY),
+    GCSR_OFF_ARRAY(SAVE, 0),
+    GCSR_OFF_ARRAY(SAVE, 1),
+    GCSR_OFF_ARRAY(SAVE, 2),
+    GCSR_OFF_ARRAY(SAVE, 3),
+    GCSR_OFF_ARRAY(SAVE, 4),
+    GCSR_OFF_ARRAY(SAVE, 5),
+    GCSR_OFF_ARRAY(SAVE, 6),
+    GCSR_OFF_ARRAY(SAVE, 7),
+    GCSR_OFF_ARRAY(SAVE, 8),
+    GCSR_OFF_ARRAY(SAVE, 9),
+    GCSR_OFF_ARRAY(SAVE, 10),
+    GCSR_OFF_ARRAY(SAVE, 11),
+    GCSR_OFF_ARRAY(SAVE, 12),
+    GCSR_OFF_ARRAY(SAVE, 13),
+    GCSR_OFF_ARRAY(SAVE, 14),
+    GCSR_OFF_ARRAY(SAVE, 15),
+    GCSR_OFF(TID),
+    GCSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    GCSR_OFF_FLAGS(TVAL, CSRFL_GUEST_READONLY | CSRFL_IO),
+    GCSR_OFF(CNTC),
+    GCSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    GCSR_GSPR(GSTAT),
+    GCSR_GSPR(GCFG),
+    GCSR_GSPR(GINTC),
+    GCSR_GSPR(GCNTC),
+    GCSR_OFF(LLBCTL),
+    GCSR_GSPR(IMPCTL1),
+    GCSR_GSPR(IMPCTL2),
+    GCSR_OFF(TLBRENTRY),
+    GCSR_OFF(TLBRBADV),
+    GCSR_OFF(TLBRERA),
+    GCSR_OFF(TLBRSAVE),
+    GCSR_OFF(TLBRELO0),
+    GCSR_OFF(TLBRELO1),
+    GCSR_OFF(TLBREHI),
+    GCSR_OFF(TLBRPRMD),
+    GCSR_GSPR(MERRCTL),
+    GCSR_GSPR(MERRINFO1),
+    GCSR_GSPR(MERRINFO2),
+    GCSR_GSPR(MERRENTRY),
+    GCSR_GSPR(MERRERA),
+    GCSR_GSPR(MERRSAVE),
+    GCSR_GSPR(CTAG),
+    GCSR_OFF_ARRAY(DMW, 0),
+    GCSR_OFF_ARRAY(DMW, 1),
+    GCSR_OFF_ARRAY(DMW, 2),
+    GCSR_OFF_ARRAY(DMW, 3),
+    GCSR_GSPR(DBG),
+    GCSR_GSPR(DERA),
+    GCSR_GSPR(DSAVE),
+};
+
 CSRInfo *get_csr(unsigned int csr_num)
 {
     CSRInfo *csr;
@@ -151,6 +257,22 @@ CSRInfo *get_csr(unsigned int csr_num)
     return csr;
 }
=20
+CSRInfo *get_gcsr(unsigned int csr_num)
+{
+    CSRInfo *csr;
+
+    if (csr_num >=3D ARRAY_SIZE(gcsr_info)) {
+        return NULL;
+    }
+
+    csr =3D &gcsr_info[csr_num];
+    if (csr->offset =3D=3D 0) {
+        return NULL;
+    }
+
+    return csr;
+}
+
 bool set_csr_flag(unsigned int csr_num, int flag)
 {
     CSRInfo *csr;
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 81a656baae..a0846353de 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -14,6 +14,8 @@ enum {
     CSRFL_EXITTB   =3D (1 << 1),
     CSRFL_IO       =3D (1 << 2),
     CSRFL_UNUSED   =3D (1 << 3),
+    CSRFL_GUEST_READONLY =3D (1 << 4),
+    CSRFL_GSPR     =3D (1 << 5),
 };
=20
 typedef struct {
@@ -25,5 +27,6 @@ typedef struct {
 } CSRInfo;
=20
 CSRInfo *get_csr(unsigned int csr_num);
+CSRInfo *get_gcsr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4db53fec26..df7a7c9075 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -197,11 +197,101 @@ static const VMStateDescription vmstate_tlb =3D {
     .version_id =3D 0,
     .minimum_version_id =3D 0,
     .needed =3D tlb_needed,
-    .fields =3D (const VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
-                             0, vmstate_tlb_entry, LoongArchTLB),
-        VMSTATE_END_OF_LIST()
-    }
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,=
 0,
+                                 vmstate_tlb_entry, LoongArchTLB),
+            VMSTATE_END_OF_LIST() }
+};
+
+static bool lvz_needed(void *opaque)
+{
+    LoongArchCPU *cpu =3D opaque;
+
+    return FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LVZ);
+}
+
+static const VMStateDescription vmstate_lvz =3D {
+    .name =3D "cpu/lvz",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D lvz_needed,
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_UINT64(env.CSR_GSTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GINTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GCNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_GTLBC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TRGP, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_CRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_EUEN, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MISC, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ECFG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ESTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_BADV, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_BADI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_EENTRY, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_TLBIDX, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBEHI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_ASID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGDL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGDH, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PGD, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PWCL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PWCH, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_STLBPS, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_RVACFG, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_CPUID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG2, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_PRCFG3, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.GCSR_SAVE, LoongArchCPU, 16),
+
+            VMSTATE_UINT64(env.GCSR_TID, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TVAL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_CNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TICLR, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_LLBCTL, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_IMPCTL1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_IMPCTL2, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_TLBRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRBADV, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBREHI, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_TLBRPRMD, LoongArchCPU),
+
+            VMSTATE_UINT64(env.GCSR_MERRCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRINFO1, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRINFO2, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_MERRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_CTAG, LoongArchCPU),
+
+            VMSTATE_UINT64_ARRAY(env.GCSR_DMW, LoongArchCPU, 4),
+
+            VMSTATE_UINT64(env.GCSR_DBG, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_DERA, LoongArchCPU),
+            VMSTATE_UINT64(env.GCSR_DSAVE, LoongArchCPU),
+
+            VMSTATE_BOOL(env.guest, LoongArchCPU),
+            VMSTATE_STRUCT_ARRAY(env.gtlb, LoongArchCPU, LOONGARCH_TLB_MAX=
, 0,
+                                 vmstate_tlb_entry, LoongArchTLB),
+            VMSTATE_END_OF_LIST() },
 };
 #endif
=20
@@ -210,83 +300,78 @@ const VMStateDescription vmstate_loongarch_cpu =3D {
     .name =3D "cpu",
     .version_id =3D 4,
     .minimum_version_id =3D 4,
-    .fields =3D (const VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
-        VMSTATE_UINT64(env.pc, LoongArchCPU),
-
-        /* Remaining CSRs */
-        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
-        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
-
-        /* Debug CSRs */
-        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
-
-        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
-        /* PV steal time */
-        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
-
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections =3D (const VMStateDescription * const []) {
-        &vmstate_fpu,
-        &vmstate_lsx,
-        &vmstate_lasx,
+    .fields =3D
+        (const VMStateField[]){
+            VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
+            VMSTATE_UINT64(env.pc, LoongArchCPU),
+
+            /* Remaining CSRs */
+            VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
+            VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
+            VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
+
+            /* Debug CSRs */
+            VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
+            VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+
+            VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+            /* PV steal time */
+            VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
+
+            VMSTATE_END_OF_LIST() },
+    .subsections =3D
+        (const VMStateDescription *const[]) {
+            &vmstate_fpu, &vmstate_lsx, &vmstate_lasx,
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-        &vmstate_tlb,
+            &vmstate_tlb, &vmstate_lvz,
 #endif
-        &vmstate_lbt,
-        &vmstate_msgint,
-        &vmstate_pmu,
-        NULL
-    }
+            &vmstate_lbt, &vmstate_msgint, &vmstate_pmu, NULL }
 };
--=20
2.52.0

