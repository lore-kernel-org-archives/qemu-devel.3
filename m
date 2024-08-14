Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D19C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9Zj-0006uY-Ks; Wed, 14 Aug 2024 04:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9Zh-0006lb-8h; Wed, 14 Aug 2024 04:41:45 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1se9Zf-0005pf-A8; Wed, 14 Aug 2024 04:41:44 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E7SSRd029781;
 Wed, 14 Aug 2024 03:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=8+MWTdLJRX6DJEFL6fYcpdlaMSw1KJielO7I/ehLkJc=; b=
 MMUdgCCaBQmUhq0KW+ep/eh3mAMcnV6cJh2s8KiQ229QUXDKlkhnodqeLiFzEpdu
 E2ZwFQTAzviFZ5A6IEyqfFv1gSdotpk/XX/PcoHolWqVbHk+7tdm2/a1ov4U3pJD
 ygGbvM2ZFzBuJ+9Y55qcR/Osgs0aDqGtSS060Khu7t11LVkywzG4VIGogHRB8Ojx
 azNFnGKTkUaTBcc2sjT477t/KrpSUdXFBMsn1345EAvGEKDvmL2bsVfM+HdZa75K
 Cio7GQtPtnXhfvOuMQobjhIj5sGZLBRpKUm8bAJBxGvQMCngq9clFpUdbJ6FcnFt
 Kbjw/bShmSSvWtNSfozmvw==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhmb7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 03:41:35 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 03:41:35 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 03:41:33 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH 02/11] target/riscv: Update CSR xintthresh in CLIC mode
Date: Wed, 14 Aug 2024 09:27:29 +0100
Message-ID: <20240814083836.12256-6-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wZS3Z0bjyaBknXA2mHPli4Zigkp-ctlp
X-Proofpoint-GUID: wZS3Z0bjyaBknXA2mHPli4Zigkp-ctlp
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

The interrupt-level threshold (xintthresh) CSR holds an 8-bit field
for the threshold level of the associated privilege mode.

For horizontal interrupts, only the ones with higher interrupt levels
than the threshold level are allowed to preempt.

Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 95303f50d3..9b5f36ad0a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -260,6 +260,7 @@ struct CPUArchState {

     uint64_t miclaim;
     uint64_t mintstatus; /* clic-spec */
+    target_ulong mintthresh; /* clic-spec */

     uint64_t mie;
     uint64_t mideleg;
@@ -283,6 +284,7 @@ struct CPUArchState {
     target_ulong stvec;
     target_ulong sepc;
     target_ulong scause;
+    target_ulong sintthresh; /* clic-spec */

     target_ulong mtvec;
     target_ulong mepc;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2e65495b54..ad45402370 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -166,6 +166,7 @@
 #define CSR_MTVAL           0x343
 #define CSR_MIP             0x344
 #define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */
+#define CSR_MINTTHRESH      0x347 /* clic-spec-draft */

 /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_MISELECT        0x350
@@ -208,6 +209,7 @@
 #define CSR_STVAL           0x143
 #define CSR_SIP             0x144
 #define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */
+#define CSR_SINTTHRESH      0x147 /* clic-spec-draft */

 /* Sstc supervisor CSRs */
 #define CSR_STIMECMP        0x14D
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f9ed7b9079..9c824c0d8f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2903,6 +2903,18 @@ static int read_mintstatus(CPURISCVState *env, int c=
srno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }

+static int read_mintthresh(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    *val =3D env->mintthresh;
+    return 0;
+}
+
+static int write_mintthresh(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    env->mintthresh =3D val;
+    return 0;
+}
+
 /* Supervisor Trap Setup */
 static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
                                         Int128 *val)
@@ -3322,6 +3334,18 @@ static int read_sintstatus(CPURISCVState *env, int c=
srno, target_ulong *val)
     return RISCV_EXCP_NONE;
 }

+static int read_sintthresh(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    *val =3D env->sintthresh;
+    return 0;
+}
+
+static int write_sintthresh(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    env->sintthresh =3D val;
+    return 0;
+}
+
 /* Supervisor Protection and Translation */
 static RISCVException read_satp(CPURISCVState *env, int csrno,
                                 target_ulong *val)
@@ -5621,9 +5645,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {

     /* Machine Mode Core Level Interrupt Controller */
     [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus       =
},
+    [CSR_MINTTHRESH]     =3D { "mintthresh", clic,  read_mintthresh,
+                             write_mintthresh },

     /* Supervisor Mode Core Level Interrupt Controller */
     [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus       =
},
+    [CSR_SINTTHRESH]     =3D { "sintthresh", clic,  read_sintthresh,
+                             write_sintthresh },

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

