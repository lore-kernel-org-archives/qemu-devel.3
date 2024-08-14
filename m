Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF25EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9bL-0006uM-RE; Wed, 14 Aug 2024 04:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9bJ-0006g3-J8; Wed, 14 Aug 2024 04:43:25 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9bG-0005wd-99; Wed, 14 Aug 2024 04:43:25 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E4gOKe023234;
 Wed, 14 Aug 2024 03:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=MaLEtMq/pIJzfGG6cS8WjmovSKbvm3aRu7TcVO7kh/A=; b=
 SIZ0g4eyI3tgBSGICKYgnnoLuPRgBXWc/q4BSZmBEzqhIjBEhLJX4qci5X//LxSQ
 aXIvHq3Jv3CVJadF9kJA3+oEfRjQJAobFjg3Q/kflp2j9LvzoBULu43kiExsy+DQ
 I0SFFApHKnIdeLe8QJZuJ73hlUq10aONpDPXlDf8Fxt0x6CYGYwheXoRM8bs+/KB
 cAhHZwJL5oCrppiIMIGtt4lUHn+4p5yJskr7dYyyGmA/HSqI+Ajm64JODUUyshvc
 ZWZuZpUxY3DErpFV0D5tqvDnu9mepHyyjXNE+ySHnboLXkxOUiEzfZU9iCSqVym3
 ZomTLwpVkGgTjs5tAn+dDA==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhmb8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:43:14 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:43:14 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:43:12 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 07/11] target/riscv: Update CSR xnxti in CLIC mode
Date: Wed, 14 Aug 2024 09:27:37 +0100
Message-ID: <20240814083836.12256-14-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EkTh0I53R6-dp5uI0VXoqDLJcRb3l1uk
X-Proofpoint-GUID: EkTh0I53R6-dp5uI0VXoqDLJcRb3l1uk
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.152.168;
 envelope-from=prvs=5956f96c7e=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ian Brockbank <ian.brockbank@cirrus.com>

The CSR can be used by software to service the next horizontal interrupt
when it has greater level than the saved interrupt context
(held in xcause`.pil`) and greater level than the interrupt threshold of
the corresponding privilege mode,

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
---
 target/riscv/cpu_bits.h |  25 +++++++++
 target/riscv/csr.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 279a6f889b..3744b34504 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -166,6 +166,7 @@
 #define CSR_MCAUSE          0x342
 #define CSR_MTVAL           0x343
 #define CSR_MIP             0x344
+#define CSR_MNXTI           0x345 /* clic-spec-draft */
 #define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */
 #define CSR_MINTTHRESH      0x347 /* clic-spec-draft */

@@ -210,6 +211,7 @@
 #define CSR_SCAUSE          0x142
 #define CSR_STVAL           0x143
 #define CSR_SIP             0x144
+#define CSR_SNXTI           0x145 /* clic-spec-draft */
 #define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */
 #define CSR_SINTTHRESH      0x147 /* clic-spec-draft */

@@ -561,6 +563,8 @@
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL

+#define MSTATUS_WRITE_MASK  0x0000001f
+
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL

@@ -754,6 +758,27 @@ typedef enum RISCVException {
 #define SINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
 #define SINTSTATUS_UIL                     0x000000ff /* uil[7:0] */

+/* mcause */
+#define MCAUSE_INT                         (1 << (TARGET_LONG_BITS - 1))
+#define MCAUSE_MINHV                       0x40000000 /* minhv */
+#define MCAUSE_MPP                         0x30000000 /* mpp[1:0] */
+#define MCAUSE_MPIE                        0x08000000 /* mpie */
+#define MCAUSE_MPIL                        0x00ff0000 /* mpil[7:0] */
+#define MCAUSE_EXCCODE                     0x00000fff /* exccode[11:0] */
+
+/* scause */
+#define SCAUSE_INT                         (1 << (TARGET_LONG_BITS - 1))
+#define SCAUSE_SINHV                       0x40000000 /* sinhv */
+#define SCAUSE_SPP                         0x10000000 /* spp */
+#define SCAUSE_SPIE                        0x08000000 /* spie */
+#define SCAUSE_SPIL                        0x00ff0000 /* spil[7:0] */
+#define SCAUSE_EXCCODE                     0x00000fff /* exccode[11:0] */
+
+/* mcause & scause */
+#define XCAUSE_XPP_SHIFT                   28
+#define XCAUSE_XPIE_SHIFT                  27
+#define XCAUSE_XPIL_SHIFT                  16
+
 /* mtvec & stvec */
 #define XTVEC_MODE                         0x03
 #define XTVEC_SUBMODE                      0x3c
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index be0071fd25..813a5b927f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -19,6 +19,7 @@

 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "tcg/tcg-cpu.h"
@@ -2936,6 +2937,77 @@ static RISCVException rmw_mviph(CPURISCVState *env, =
int csrno,
     return ret;
 }

+static bool get_xnxti_status(CPURISCVState *env)
+{
+    int clic_irq, clic_priv, clic_il, pil;
+
+    if (!env->exccode) { /* No interrupt */
+        return false;
+    }
+    /* The system is not in a CLIC mode */
+    if (!riscv_clic_is_clic_mode(env)) {
+        return false;
+    } else {
+        riscv_clic_decode_exccode(env->exccode, &clic_priv, &clic_il,
+                                  &clic_irq);
+
+        if (env->priv =3D=3D PRV_M) {
+            pil =3D MAX(get_field(env->mcause, MCAUSE_MPIL), env->mintthre=
sh);
+        } else if (env->priv =3D=3D PRV_S) {
+            pil =3D MAX(get_field(env->scause, SCAUSE_SPIL), env->sintthre=
sh);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "CSR: rmw xnxti with unsupported mode\n");
+            exit(1);
+        }
+
+        if ((clic_priv !=3D env->priv) || /* No horizontal interrupt */
+            (clic_il <=3D pil) || /* No higher level interrupt */
+            (riscv_clic_shv_interrupt(env->clic, clic_irq))) {
+            /* CLIC vector mode */
+            return false;
+        } else {
+            return true;
+        }
+    }
+}
+
+static int rmw_mnxti(CPURISCVState *env, int csrno, target_ulong *ret_valu=
e,
+                     target_ulong new_value, target_ulong write_mask)
+{
+    int clic_priv, clic_il, clic_irq;
+    bool ready;
+    if (write_mask) {
+        env->mstatus |=3D new_value & (write_mask & MSTATUS_WRITE_MASK);
+    }
+
+    BQL_LOCK_GUARD();
+
+    ready =3D get_xnxti_status(env);
+    if (ready) {
+        riscv_clic_decode_exccode(env->exccode, &clic_priv, &clic_il,
+                                  &clic_irq);
+        if (write_mask) {
+            bool edge =3D riscv_clic_edge_triggered(env->clic,  clic_irq);
+            if (edge) {
+                riscv_clic_clean_pending(env->clic, clic_irq);
+            }
+            env->mintstatus =3D set_field(env->mintstatus,
+                                        MINTSTATUS_MIL, clic_il);
+            env->mcause =3D set_field(env->mcause, MCAUSE_EXCCODE, clic_ir=
q);
+        }
+        if (ret_value) {
+            *ret_value =3D (env->mtvt & ~0x3f) + sizeof(target_ulong) * cl=
ic_irq;
+        }
+    } else {
+        if (ret_value) {
+            *ret_value =3D 0;
+        }
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static int read_mintstatus(CPURISCVState *env, int csrno, target_ulong *va=
l)
 {
     *val =3D env->mintstatus;
@@ -3401,6 +3473,43 @@ static RISCVException rmw_siph(CPURISCVState *env, i=
nt csrno,
     return ret;
 }

+static int rmw_snxti(CPURISCVState *env, int csrno, target_ulong *ret_valu=
e,
+                     target_ulong new_value, target_ulong write_mask)
+{
+    int clic_priv, clic_il, clic_irq;
+    bool ready;
+    if (write_mask) {
+        env->mstatus |=3D new_value & (write_mask & MSTATUS_WRITE_MASK);
+    }
+
+    BQL_LOCK_GUARD();
+
+    ready =3D get_xnxti_status(env);
+    if (ready) {
+        riscv_clic_decode_exccode(env->exccode, &clic_priv, &clic_il,
+                                  &clic_irq);
+        if (write_mask) {
+            bool edge =3D riscv_clic_edge_triggered(env->clic, clic_irq);
+            if (edge) {
+                riscv_clic_clean_pending(env->clic, clic_irq);
+            }
+            /* update the PRV_S parts of mintstatus */
+            env->mintstatus =3D set_field(env->mintstatus,
+                                        MINTSTATUS_SIL, clic_il);
+            env->scause =3D set_field(env->scause, SCAUSE_EXCCODE, clic_ir=
q);
+        }
+        if (ret_value) {
+            *ret_value =3D (env->stvt & ~0x3f) + sizeof(target_ulong) * cl=
ic_irq;
+        }
+    } else {
+        if (ret_value) {
+            *ret_value =3D 0;
+        }
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static int read_sintstatus(CPURISCVState *env, int csrno, target_ulong *va=
l)
 {
     /* sintstatus is a filtered view of mintstatus with the PRV_M removed =
*/
@@ -5720,12 +5829,14 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {

     /* Machine Mode Core Level Interrupt Controller */
     [CSR_MTVT]           =3D { "mtvt",       clic,  read_mtvt, write_mtvt =
},
+    [CSR_MNXTI]          =3D { "mnxti",      clic,  NULL, NULL, rmw_mnxti =
},
     [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus       =
},
     [CSR_MINTTHRESH]     =3D { "mintthresh", clic,  read_mintthresh,
                              write_mintthresh },

     /* Supervisor Mode Core Level Interrupt Controller */
     [CSR_STVT]           =3D { "stvt",       clic,  read_stvt, write_stvt =
},
+    [CSR_SNXTI]          =3D { "snxti",      clic,  NULL, NULL, rmw_snxti =
},
     [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus       =
},
     [CSR_SINTTHRESH]     =3D { "sintthresh", clic,  read_sintthresh,
                              write_sintthresh },
--
2.46.0.windows.1
This message and any attachments may contain privileged and confidential in=
formation that is intended solely for the person(s) to whom it is addressed=
. If you are not an intended recipient you must not: read; copy; distribute=
; discuss; take any action in or make any reliance upon the contents of thi=
s message; nor open or read any attachment. If you have received this messa=
ge in error, please notify us as soon as possible on the following telephon=
e number and destroy this message including any attachments. Thank you. Cir=
rus Logic International (UK) Ltd and Cirrus Logic International Semiconduct=
or Ltd are companies registered in Scotland, with registered numbers SC0898=
39 and SC495735 respectively. Our registered office is at 7B Nightingale Wa=
y, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cirru=
s.com

