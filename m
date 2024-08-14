Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A8DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9bk-0000ez-KI; Wed, 14 Aug 2024 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9bh-0000NT-6v; Wed, 14 Aug 2024 04:43:49 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9bf-0005zY-8F; Wed, 14 Aug 2024 04:43:48 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E4gOKg023234;
 Wed, 14 Aug 2024 03:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=BpG6B539a4OdKFkJyo/rvorQIsMi6L/7XRdL6Y07Hh4=; b=
 KfGsboNnHwMBUlW2RBcDnbk+3M3rzVnrRe5zbJ60W+Vsbp5HLtbyoxwFU7MXJKc9
 uPTxOkuCvW9O7s26vW4l8+hTloXV8r4IFdEr/lG+9DZBpsnMNnDHbn7q3XldRaR7
 3TLT8fZerF2Vxl7a+Gft3R3Fk0hkwf/lh/yHAzFxNXUiABR0c5CuoRqx7JR6pVZU
 g9azXzRV/vGx85oWYNcfHcVCVWVP1jQAIq7zKlgysA7F8yKDO2tClUxIwWJf2dRX
 T4dm3R/4sqeATI7U7/o3CTOSdAynC0m8pJDmn0SaE+k2aoUfu71lGe0catFECT28
 mZjCADTDGNal75l0CxQHZQ==
Received: from ausex02.ad.cirrus.com ([141.131.3.21])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhmb8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:43:39 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex02.ad.cirrus.com
 (141.131.37.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:43:38 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:43:36 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 06/11] target/riscv: Update CSR xtvec in CLIC mode
Date: Wed, 14 Aug 2024 09:27:39 +0100
Message-ID: <20240814083836.12256-16-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mc0j2OrmnRKsZRZFDUxxX5E83bhixuvI
X-Proofpoint-GUID: mc0j2OrmnRKsZRZFDUxxX5E83bhixuvI
X-Proofpoint-Spam-Reason: safe
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

The new CLIC interrupt-handling mode is encoded as a new state in the
existing WARL xtvec register, where the low two bits of are 11.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
---
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 63 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12aa8cf6b1..05a014db03 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -283,11 +283,13 @@ struct CPUArchState {
     target_ulong medeleg;

     target_ulong stvec;
+    target_ulong stvt; /* clic-spec */
     target_ulong sepc;
     target_ulong scause;
     target_ulong sintthresh; /* clic-spec */

     target_ulong mtvec;
+    target_ulong mtvt; /* clic-spec */
     target_ulong mepc;
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 0ed44ec0a8..279a6f889b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -153,6 +153,7 @@
 #define CSR_MIE             0x304
 #define CSR_MTVEC           0x305
 #define CSR_MCOUNTEREN      0x306
+#define CSR_MTVT            0x307 /* clic-spec-draft */

 /* 32-bit only */
 #define CSR_MSTATUSH        0x310
@@ -192,6 +193,7 @@
 #define CSR_SIE             0x104
 #define CSR_STVEC           0x105
 #define CSR_SCOUNTEREN      0x106
+#define CSR_STVT            0x107 /* clic-spec-draft */

 /* Supervisor Configuration CSRs */
 #define CSR_SENVCFG         0x10A
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 276ef7856e..be0071fd25 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2170,9 +2170,23 @@ static RISCVException read_mtvec(CPURISCVState *env,=
 int csrno,
 static RISCVException write_mtvec(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
-    if ((val & 3) < 2) {
+    /*
+     * bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 3 =3D CLIC,
+     * others reserved
+     */
+    target_ulong mode =3D get_field(val, XTVEC_MODE);
+    target_ulong fullmode =3D val & XTVEC_FULL_MODE;
+    if (mode <=3D XTVEC_CLINT_VECTORED) {
         env->mtvec =3D val;
+    } else if (XTVEC_CLIC =3D=3D fullmode && env->clic) {
+        /*
+         * CLIC mode hardwires xtvec bits 2-5 to zero.
+         * Layout:
+         *   XLEN-1:6   base (WARL)
+         *   5:2        submode (WARL)  - 0000 for CLIC
+         *   1:0        mode (WARL)     - 11 for CLIC
+         */
+        env->mtvec =3D (val & XTVEC_NBASE) | XTVEC_CLIC;
     } else {
         qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: reserved mode not supported\n=
");
     }
@@ -2271,6 +2285,18 @@ static RISCVException write_mcounteren(CPURISCVState=
 *env, int csrno,
     return RISCV_EXCP_NONE;
 }

+static int read_mtvt(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mtvt;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mtvt(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mtvt =3D val & XTVEC_NBASE;
+    return RISCV_EXCP_NONE;
+}
+
 /* Machine Trap Handling */
 static RISCVException read_mscratch_i128(CPURISCVState *env, int csrno,
                                          Int128 *val)
@@ -3122,9 +3148,24 @@ static RISCVException read_stvec(CPURISCVState *env,=
 int csrno,
 static RISCVException write_stvec(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
-    if ((val & 3) < 2) {
+    /*
+     * bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 3 =3D CLIC,
+     * others reserved
+     */
+    target_ulong mode =3D val & XTVEC_MODE;
+    target_ulong fullmode =3D val & XTVEC_FULL_MODE;
+    if (mode <=3D XTVEC_CLINT_VECTORED) {
         env->stvec =3D val;
+    } else if (XTVEC_CLIC =3D=3D fullmode && env->clic) {
+        /*
+         * If only CLIC mode is supported, writes to bit 1 are also ignore=
d and
+         * it is always set to one. CLIC mode hardwires xtvec bits 2-5 to =
zero.
+         * Layout:
+         *   XLEN-1:6   base (WARL)
+         *   5:2        submode (WARL)  - 0000 for CLIC
+         *   1:0        mode (WARL)     - 11 for CLIC
+         */
+        env->stvec =3D (val & XTVEC_NBASE) | XTVEC_CLIC;
     } else {
         qemu_log_mask(LOG_UNIMP, "CSR_STVEC: reserved mode not supported\n=
");
     }
@@ -3149,6 +3190,18 @@ static RISCVException write_scounteren(CPURISCVState=
 *env, int csrno,
     return RISCV_EXCP_NONE;
 }

+static int read_stvt(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->stvt;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_stvt(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->stvt =3D val & XTVEC_NBASE;
+    return RISCV_EXCP_NONE;
+}
+
 /* Supervisor Trap Handling */
 static RISCVException read_sscratch_i128(CPURISCVState *env, int csrno,
                                          Int128 *val)
@@ -5666,11 +5719,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
                              write_mhpmcounterh                         },

     /* Machine Mode Core Level Interrupt Controller */
+    [CSR_MTVT]           =3D { "mtvt",       clic,  read_mtvt, write_mtvt =
},
     [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus       =
},
     [CSR_MINTTHRESH]     =3D { "mintthresh", clic,  read_mintthresh,
                              write_mintthresh },

     /* Supervisor Mode Core Level Interrupt Controller */
+    [CSR_STVT]           =3D { "stvt",       clic,  read_stvt, write_stvt =
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

