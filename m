Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFABFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg51N-0005F7-QS; Mon, 19 Aug 2024 12:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg51L-0004yy-B3; Mon, 19 Aug 2024 12:14:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]
 helo=mx0b-001ae601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg51G-0007hC-Ln; Mon, 19 Aug 2024 12:14:15 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JF6kgG004018;
 Mon, 19 Aug 2024 11:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=B8DLQvKLhrx+ODVEVv6MS/qGMzbh77KzgX40R1FVarM=; b=
 XG8Sgq8rkZvxqxTPS5X8OxhJVhO/fevPSewpocEifG4V8Uy/yPohJ0RQiuflZ9By
 U3isF3ubE2LmZYPlfMFU764YWic/Cso5Gr7ok9v1AmhESqOJ/mngG0PDawh+s6jf
 AOuN2JIakYmy8x8CGFIGXy297zs0uHOBCu1yNJFeZCtoW/gzkC/uyWMUmKeVWktw
 Mg0BmC88vZLDpuZMuS9lMIPoSamrQjIRC3sLFdahhZXV2TGKcfor6xlVoETj/wfK
 rRKQ6iwy2D1Pn7s5bH/yQFIEkjkn649origGfwgL93JF4W8+KoXABUFtOR08PGqR
 FBKUQ67d0zL0f1G63jwcwg==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 412s8x1xbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 11:11:35 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 11:11:34 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 19 Aug 2024 11:11:32 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 08/11 v2] target/riscv: Update interrupt handling in CLIC mode
Date: Mon, 19 Aug 2024 17:02:19 +0100
Message-ID: <20240819160742.27586-12-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: prNILGHpb-fk1DJ5VRtaFFAaByPb5zvy
X-Proofpoint-GUID: prNILGHpb-fk1DJ5VRtaFFAaByPb5zvy
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.149.25;
 envelope-from=prvs=5961d01319=ian.brockbank@cirrus.com;
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

Decode CLIC interrupt information from exccode, includes interrupt
privilege mode, interrupt level, and irq number.

Then update CSRs xcause, xstatus, xepc, xintstatus and jump to
correct PC according to the CLIC specification.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
---
 target/riscv/cpu_helper.c | 129 +++++++++++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..944afb68d2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -24,6 +24,7 @@
 #include "internals.h"
 #include "pmu.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/page-protection.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
@@ -33,6 +34,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "hw/intc/riscv_clic.h"

 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -428,6 +430,20 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
 }

+static int riscv_cpu_local_irq_mode_enabled(CPURISCVState *env, int mode)
+{
+    switch (mode) {
+    case PRV_M:
+        return env->priv < PRV_M ||
+            (env->priv =3D=3D PRV_M && get_field(env->mstatus, MSTATUS_MIE=
));
+    case PRV_S:
+        return env->priv < PRV_S ||
+            (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATUS_SIE=
));
+    default:
+        return false;
+    }
+}
+
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     uint64_t irqs, pending, mie, hsie, vsie, irqs_f, irqs_f_vs;
@@ -506,6 +522,18 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interr=
upt_request)
             return true;
         }
     }
+    if (interrupt_request & CPU_INTERRUPT_CLIC) {
+        RISCVCPU *cpu =3D RISCV_CPU(cs);
+        CPURISCVState *env =3D &cpu->env;
+        int mode =3D get_field(env->exccode, RISCV_EXCP_CLIC_MODE);
+        int enabled =3D riscv_cpu_local_irq_mode_enabled(env, mode);
+        if (enabled) {
+            cs->exception_index =3D RISCV_EXCP_CLIC | env->exccode;
+            cs->interrupt_request =3D cs->interrupt_request & ~CPU_INTERRU=
PT_CLIC;
+            riscv_cpu_do_interrupt(cs);
+            return true;
+        }
+    }
     return false;
 }

@@ -1641,6 +1669,60 @@ static target_ulong riscv_transformed_insn(CPURISCVS=
tate *env,
     return xinsn;
 }

+static target_ulong riscv_intr_pc(CPURISCVState *env, target_ulong tvec,
+                                  target_ulong tvt, bool async,
+                                  int cause, int mode)
+{
+    int mode1 =3D tvec & XTVEC_MODE;
+    int mode2 =3D tvec & XTVEC_FULL_MODE;
+
+    if (!async) {
+        return tvec & XTVEC_OBASE;
+    }
+    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
+    switch (mode1) {
+    case XTVEC_CLINT_DIRECT:
+        return tvec & XTVEC_OBASE;
+    case XTVEC_CLINT_VECTORED:
+        return (tvec & XTVEC_OBASE) + cause * 4;
+    default:
+        if (env->clic && (mode2 =3D=3D XTVEC_CLIC)) {
+            /* Non-vectored, clicintattr[i].shv =3D 0 || cliccfg.nvbits =
=3D 0 */
+            if (!riscv_clic_shv_interrupt(env->clic, cause)) {
+                /* NBASE =3D mtvec[XLEN-1:6]<<6 */
+                return tvec & XTVEC_NBASE;
+            } else {
+                /*
+                 * pc :=3D M[TBASE + XLEN/8 * exccode)] & ~1,
+                 * TBASE =3D mtvt[XLEN-1:6]<<6
+                 */
+                int size =3D TARGET_LONG_BITS / 8;
+                target_ulong tbase =3D (tvt & XTVEC_NBASE) + size * cause;
+                void *host =3D tlb_vaddr_to_host(env, tbase, MMU_DATA_LOAD=
, mode);
+                if (host !=3D NULL) {
+                    target_ulong new_pc =3D tbase;
+                    if (!riscv_clic_use_jump_table(env->clic)) {
+                        /*
+                         * Standard CLIC: the vector entry is a function p=
ointer
+                         * so look up the destination.
+                         */
+                        new_pc =3D ldn_p(host, size);
+                        host =3D tlb_vaddr_to_host(env, new_pc,
+                                                 MMU_INST_FETCH, mode);
+                    }
+                    if (host) {
+                        return new_pc;
+                    }
+                }
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "CLIC: load trap handler error!\n");
+                exit(1);
+            }
+        }
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Handle Traps
  *
@@ -1654,12 +1736,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool virt =3D env->virt_enabled;
     bool write_gva =3D false;
     uint64_t s;
+    int mode, level, irq;

     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
      */
-    bool async =3D !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
+    bool clic =3D !!(cs->exception_index & RISCV_EXCP_CLIC);
+    bool async =3D !!(cs->exception_index & RISCV_EXCP_INT_FLAG) || clic;
     target_ulong cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
     uint64_t deleg =3D async ? env->mideleg : env->medeleg;
     bool s_injected =3D env->mvip & (1 << cause) & env->mvien &&
@@ -1746,6 +1830,28 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }

+    if (clic) {
+        riscv_clic_decode_exccode(cause, &mode, &level, &irq);
+        cause =3D irq | get_field(env->mstatus, MSTATUS_MPP) << XCAUSE_XPP=
_SHIFT;
+        switch (mode) {
+        case PRV_M:
+            cause |=3D get_field(env->mintstatus, MINTSTATUS_MIL)
+                     << XCAUSE_XPIL_SHIFT;
+            cause |=3D get_field(env->mstatus, MSTATUS_MIE) << XCAUSE_XPIE=
_SHIFT;
+            env->mintstatus =3D set_field(env->mintstatus, MINTSTATUS_MIL,=
 level);
+            break;
+        case PRV_S:
+            cause |=3D get_field(env->mintstatus, MINTSTATUS_SIL)
+                     << XCAUSE_XPIL_SHIFT;
+            cause |=3D get_field(env->mstatus, MSTATUS_SPIE) << XCAUSE_XPI=
E_SHIFT;
+            env->mintstatus =3D set_field(env->mintstatus, MINTSTATUS_SIL,=
 level);
+            break;
+        }
+    } else {
+        mode =3D env->priv <=3D PRV_S && cause < 64 &&
+            ((deleg >> cause) & 1 || s_injected || vs_injected) ? PRV_S : =
PRV_M;
+    }
+
     trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
                      riscv_cpu_get_trap_name(cause, async));

@@ -1755,8 +1861,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));

-    if (env->priv <=3D PRV_S && cause < 64 &&
-        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
+    if (PRV_S =3D=3D mode) {
         /* handle the trap in S-mode */
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
@@ -1765,7 +1870,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 (((hdeleg >> cause) & 1) || vs_injected)) {
                 /* Trap to VS mode */
                 /*
-                 * See if we need to adjust cause. Yes if its VS mode inte=
rrupt
+                 * See if we need to adjust cause. Yes if it's VS mode int=
errupt
                  * no if hypervisor has delegated one of hs mode's interru=
pt
                  */
                 if (async && (cause =3D=3D IRQ_VS_TIMER || cause =3D=3D IR=
Q_VS_SOFT ||
@@ -1796,13 +1901,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s =3D set_field(s, MSTATUS_SPP, env->priv);
         s =3D set_field(s, MSTATUS_SIE, 0);
         env->mstatus =3D s;
-        env->scause =3D cause | ((target_ulong)async << (TARGET_LONG_BITS =
- 1));
+        if (async) {
+            env->scause =3D cause | SCAUSE_INT;
+        }
         env->sepc =3D env->pc;
         env->stval =3D tval;
         env->htval =3D htval;
         env->htinst =3D tinst;
-        env->pc =3D (env->stvec >> 2 << 2) +
-                  ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : 0);
+        env->pc =3D riscv_intr_pc(env, env->stvec, env->stvt, async,
+                                cause & SCAUSE_EXCCODE, PRV_S);
         riscv_cpu_set_mode(env, PRV_S, virt);
     } else {
         /* handle the trap in M-mode */
@@ -1827,13 +1934,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s =3D set_field(s, MSTATUS_MPP, env->priv);
         s =3D set_field(s, MSTATUS_MIE, 0);
         env->mstatus =3D s;
-        env->mcause =3D cause | ~(((target_ulong)-1) >> async);
+        if (async) {
+            env->mcause =3D cause | MCAUSE_INT;
+        }
         env->mepc =3D env->pc;
         env->mtval =3D tval;
         env->mtval2 =3D mtval2;
         env->mtinst =3D tinst;
-        env->pc =3D (env->mtvec >> 2 << 2) +
-                  ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0);
+        env->pc =3D riscv_intr_pc(env, env->mtvec, env->mtvt, async,
+                                cause & MCAUSE_EXCCODE, PRV_M);
         riscv_cpu_set_mode(env, PRV_M, virt);
     }

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

