Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A812C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9aC-0000YX-JF; Wed, 14 Aug 2024 04:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9aA-0000Nb-1R; Wed, 14 Aug 2024 04:42:14 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]
 helo=mx0b-001ae601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9a8-0005rg-0d; Wed, 14 Aug 2024 04:42:13 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E5pcFq028298;
 Wed, 14 Aug 2024 03:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=ncndYl91D3S6kjKskFlCOb7/iz5xBVK1N21SwFSv9gs=; b=
 iUGOhi5wb+XLHjZ9kj3K2LSwF1Rhnijol192/G/K+k8EU3NUWkbnA7sFpNrVuMmS
 t5Jq2aF8HuCgW1GauXL9rfnwPt7K/qzE57dnhzPiCwKLzRMdrRlbtMyj4kU/xBmy
 BRXloGqRqDamsCYILYLJXfrFCWkYDCg6DiAw9ciGGmvW6oCLupJTY1oO7c86B0a5
 o8gSn8mlGwwrcDoS4oJ1R0/5FpQLlNawab2NX5p279iIH9WWo+bl85XVgtDUr5tS
 iT+XWmH1px+lXUqASfHd0Qjmb/kIhifC/rCbO+mGBc3+NPKmdyaHa9VirlJbuj0b
 9CU2vt3S5R+6WHjEW5J2ZA==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwmadk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:42:02 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:42:00 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:41:59 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 01/11] target/riscv: Add CLIC CSR mintstatus
Date: Wed, 14 Aug 2024 09:27:31 +0100
Message-ID: <20240814083836.12256-8-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e4Yj6phMfVM674Ik10Ur5RNQpmyHvo-M
X-Proofpoint-GUID: e4Yj6phMfVM674Ik10Ur5RNQpmyHvo-M
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.149.25;
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

CSR mintstatus holds the active interrupt level for each supported
privilege mode. sintstatus, and user, uintstatus, provide restricted
views of mintstatus.

Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu.h      |  3 +++
 target/riscv/cpu_bits.h | 11 +++++++++++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..95303f50d3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -259,6 +259,7 @@ struct CPUArchState {
     bool software_seip;

     uint64_t miclaim;
+    uint64_t mintstatus; /* clic-spec */

     uint64_t mie;
     uint64_t mideleg;
@@ -461,6 +462,8 @@ struct CPUArchState {
     QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
     bool vstime_irq;

+    void *clic;       /* clic interrupt controller */
+
     hwaddr kernel_addr;
     hwaddr fdt_addr;

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 32b068f18a..2e65495b54 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -165,6 +165,7 @@
 #define CSR_MCAUSE          0x342
 #define CSR_MTVAL           0x343
 #define CSR_MIP             0x344
+#define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */

 /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_MISELECT        0x350
@@ -206,6 +207,7 @@
 #define CSR_SCAUSE          0x142
 #define CSR_STVAL           0x143
 #define CSR_SIP             0x144
+#define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */

 /* Sstc supervisor CSRs */
 #define CSR_STIMECMP        0x14D
@@ -733,6 +735,15 @@ typedef enum RISCVException {
 #define SIP_SEIP                           MIP_SEIP
 #define SIP_LCOFIP                         MIP_LCOFIP

+/* mintstatus */
+#define MINTSTATUS_MIL                     0xff000000 /* mil[31:24] */
+#define MINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
+#define MINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
+
+/* sintstatus */
+#define SINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
+#define SINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
+
 /* MIE masks */
 #define MIE_SEIE                           (1 << IRQ_S_EXT)
 #define MIE_UEIE                           (1 << IRQ_U_EXT)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..f9ed7b9079 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -578,6 +578,16 @@ static RISCVException debug(CPURISCVState *env, int cs=
rno)

     return RISCV_EXCP_ILLEGAL_INST;
 }
+
+static int clic(CPURISCVState *env, int csrno)
+{
+    if (env->clic) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
 #endif

 static RISCVException seed(CPURISCVState *env, int csrno)
@@ -2887,6 +2897,12 @@ static RISCVException rmw_mviph(CPURISCVState *env, =
int csrno,
     return ret;
 }

+static int read_mintstatus(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    *val =3D env->mintstatus;
+    return RISCV_EXCP_NONE;
+}
+
 /* Supervisor Trap Setup */
 static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
                                         Int128 *val)
@@ -3298,6 +3314,14 @@ static RISCVException rmw_siph(CPURISCVState *env, i=
nt csrno,
     return ret;
 }

+static int read_sintstatus(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    /* sintstatus is a filtered view of mintstatus with the PRV_M removed =
*/
+    target_ulong mask =3D SINTSTATUS_SIL | SINTSTATUS_UIL;
+    *val =3D env->mintstatus & mask;
+    return RISCV_EXCP_NONE;
+}
+
 /* Supervisor Protection and Translation */
 static RISCVException read_satp(CPURISCVState *env, int csrno,
                                 target_ulong *val)
@@ -5594,6 +5618,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
                              write_mhpmcounterh                         },
     [CSR_MHPMCOUNTER31H] =3D { "mhpmcounter31h", mctr32,  read_hpmcounterh=
,
                              write_mhpmcounterh                         },
+
+    /* Machine Mode Core Level Interrupt Controller */
+    [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus       =
},
+
+    /* Supervisor Mode Core Level Interrupt Controller */
+    [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus       =
},
+
     [CSR_SCOUNTOVF]      =3D { "scountovf", sscofpmf,  read_scountovf,
                              .min_priv_ver =3D PRIV_VERSION_1_12_0 },

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

