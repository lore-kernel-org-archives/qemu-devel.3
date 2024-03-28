Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D631CD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvMp-0000xB-3P; Thu, 28 Mar 2024 15:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rpvMn-0000wG-H5; Thu, 28 Mar 2024 15:24:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rpvMl-0001Rr-Ih; Thu, 28 Mar 2024 15:24:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SIeuDU025262; Thu, 28 Mar 2024 19:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RIb9jPTRKPhhYur4GjRbwz1VZFP+CXDe02Qi3AUij3Q=;
 b=L6MurnF+3EACV47gyZLfYeodw0SNVwbd2cQI7RTV45ez3wmOCee9GIaSv4E1ohMdkrEh
 sF68vyia0BsdW5XBYeX2iHS3w24kc2h94/MEz2Js2ig44sbLsoBVM7PHES/By1MmB7jy
 LwQzxrXc2K1C2t1oO0hPso+db76AOn+jbLpjqrYVuERbPCjnyL4Lo1EElf/RWS29wQs7
 7BqqYGdGwRcUnA2Oyjr7i5uYAbpmUuDi4eya+Wy/9VusxO1GnSUq9jviYnAR98mqd8VT
 W4D8ElFTAM7QXv9yBoM3oZWmB6H4XiKrvaKDgIZAjKPI4H9lkeBle/+krp85hKJiB+TD Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5dsjg475-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:40 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SJOd3g027167;
 Thu, 28 Mar 2024 19:24:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5dsjg473-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:39 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SIW3XZ011243; Thu, 28 Mar 2024 19:24:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmf50b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42SJOar217498642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 19:24:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2527558045;
 Thu, 28 Mar 2024 19:24:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A04A58056;
 Thu, 28 Mar 2024 19:24:35 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 28 Mar 2024 19:24:35 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 3/4] target/ppc: Add clrbhrb and mfbhrbe instructions
Date: Thu, 28 Mar 2024 14:23:55 -0500
Message-Id: <20240328192356.2144086-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.8
In-Reply-To: <20240328192356.2144086-1-milesg@linux.vnet.ibm.com>
References: <20240328192356.2144086-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tK8WMj3Y6vRbKcYpyYmgP3yp2NXMA6oh
X-Proofpoint-GUID: -OkRbrWPz45uD4ZOSJDjJezZyniRhdO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=673 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403280136
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add support for the clrbhrb and mfbhrbe instructions.

Since neither instruction is believed to be critical to
performance, both instructions were implemented using helper
functions.

Access to both instructions is controlled by bits in the
HFSCR (for privileged state) and MMCR0 (for problem state).
A new function, helper_mmcr0_facility_check, was added for
checking MMCR0[BHRBA] and raising a facility_unavailable exception
if required.

NOTE: For P8 and P9, due to a performance issue, branch history will
not be kept, but the instructions will be allowed to execute
as normal with the exception that the mfbhrbe instruction will
always return a zero value.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---

Changes from v3:
  - Rebased on latest master branch
  - Fixed compile errors for non ppc64-softmmu targets

 target/ppc/cpu.h                     |  2 ++
 target/ppc/helper.h                  |  7 ++++
 target/ppc/insn32.decode             |  8 +++++
 target/ppc/misc_helper.c             | 50 ++++++++++++++++++++++++++++
 target/ppc/translate.c               |  2 ++
 target/ppc/translate/bhrb-impl.c.inc | 43 ++++++++++++++++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7a62a82d03..76e896fdda 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -537,6 +537,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
 #define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
 #define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
+#define MMCR0_BHRBA_NR PPC_BIT_NR(42)    /* BHRB Available */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -636,6 +637,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3df360efe9..8cdb322ed6 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -820,3 +820,10 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+DEF_HELPER_1(clrbhrb, void, env)
+DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+#endif
+#endif
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index eada59f59f..a343621cdd 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -998,3 +998,11 @@ MSGSND          011111 ----- ----- ..... 0011001110 -   @X_rb
 MSGCLRP         011111 ----- ----- ..... 0010101110 -   @X_rb
 MSGSNDP         011111 ----- ----- ..... 0010001110 -   @X_rb
 MSGSYNC         011111 ----- ----- ----- 1101110110 -
+
+# Branch History Rolling Buffer (BHRB) Instructions
+
+&XFX_bhrbe      rt bhrbe
+@XFX_bhrbe      ...... rt:5 bhrbe:10 .......... -       &XFX_bhrbe
+
+MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
+CLRBHRB         011111 ----- ----- ----- 0110101110 -
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 58e808dc96..6f419c9346 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -150,6 +150,17 @@ void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
 
 #if !defined(CONFIG_USER_ONLY)
 
+#ifdef TARGET_PPC64
+static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
+                                 uint32_t sprn, uint32_t cause)
+{
+    if (FIELD_EX64(env->msr, MSR, PR) &&
+        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
+        raise_fu_exception(env, bit, sprn, cause, GETPC());
+    }
+}
+#endif
+
 void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_SDR1] != val) {
@@ -363,3 +374,42 @@ void helper_fixup_thrm(CPUPPCState *env)
         env->spr[i] = v;
     }
 }
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+void helper_clrbhrb(CPUPPCState *env)
+{
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
+{
+    unsigned int index;
+
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (!(env->flags & POWERPC_FLAG_BHRB) ||
+         (bhrbe >= env->bhrb_num_entries) ||
+         (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        return 0;
+    }
+
+    /*
+     * Note: bhrb_offset is the byte offset for writing the
+     * next entry (over the oldest entry), which is why we
+     * must offset bhrbe by 1 to get to the 0th entry.
+     */
+    index = ((env->bhrb_offset / sizeof(uint64_t)) - (bhrbe + 1)) %
+            env->bhrb_num_entries;
+    return env->bhrb[index];
+}
+#endif
+#endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5de82abf7d..42446f7d05 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6450,6 +6450,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/storage-ctrl-impl.c.inc"
 
+#include "translate/bhrb-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/bhrb-impl.c.inc b/target/ppc/translate/bhrb-impl.c.inc
new file mode 100644
index 0000000000..3a19bc4555
--- /dev/null
+++ b/target/ppc/translate/bhrb-impl.c.inc
@@ -0,0 +1,43 @@
+/*
+ * Power ISA Decode For BHRB Instructions
+ *
+ *  Copyright IBM Corp. 2023
+ *
+ * Authors:
+ *  Glenn Miles      <milesg@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    TCGv_i32 bhrbe = tcg_constant_i32(arg->bhrbe);
+    gen_helper_mfbhrbe(cpu_gpr[arg->rt], tcg_env, bhrbe);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    gen_helper_clrbhrb(tcg_env);
+    return true;
+}
+
+#else
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+#endif
-- 
2.31.8


