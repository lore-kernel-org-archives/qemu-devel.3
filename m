Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C273ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMeD-0006Hz-NB; Wed, 07 Oct 2026 04:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEGVl-0004HC-Pc; Tue, 06 Oct 2026 21:32:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEGVe-0007Du-6b; Tue, 06 Oct 2026 21:31:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6HZd3415793; Tue, 6 Oct 2026 10:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hhSJzag4tbHMQkFMW
 Xp3ZkxvrerWPtAwfQCsmMUkOGY=; b=bN2EwCUkuM4eG5KZYpo1v/hJ6+EXaTtjN
 Sbvg+PGaWfCIewCwAxYsJS3Wvr3Ue5vxHDoM2ZVFDZvo4sF+cyvotKgeWiWncUoI
 R4blyZnBIBAphzwW2ydMOB8wv+BZaBRMUhe5VUg83cMuEX4EiIWpIN7FOK2lR184
 WZBO67MGhyefe91lRCn6Wk1W96Xmze+TeqVRImjGhCWNVb8C3qRRrxjBJbCl1i1s
 Zb+kt3x5WuZEAMZModoxdOM5NGfcQQTLxMJqUnFROtXaM+JQ4gUHmjxD/6xSiaLr
 iCqQZpHkxxRwVj/q4RFiww0PjFetyFmPVnE0xdye9lrQ4Xd9BOThw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv6hjk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6JOH3066182; Tue, 6 Oct 2026 10:57:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g9d41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvF3p48759288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61E362004B;
 Tue,  6 Oct 2026 10:57:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BC9520040;
 Tue,  6 Oct 2026 10:57:13 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:13 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 3/8] target/ppc: Implement DMR getter/setter and some DMF
 insns.
Date: Tue,  6 Oct 2026 16:26:14 +0530
Message-ID: <20261006105650.189752-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lStoAY2R8UCZmPydc_9EScKNbNaqQGFM
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4d417 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=nVAKW73EA9BuGoQ3LgAA:9
X-Proofpoint-GUID: XKJW2yDjwOzSnNh4Z_YtnG4pMiXVJccv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXxGjdNhqi9vg2
 lWPowAk7nB+4cn/zz5NWsFrey4vHEnz57CMWqcSv/3g95SSMFPJJgI4qlm2ZRkLPeNdqTKWgo+j
 5Isg3LKgpHdZ4NrTP2EJ1TYIBy+9P+uw8uaHZEowo91nNmItEEsIE19A8VmvKgq9LjasV/GeG0X
 q0XmRFdWJa6ZBZcQbelUTQnmNByzlcFIIbmoRy45588Wl4LVjctDiLsIMs8HfKgcL0ZIVKF8fM7
 eyLkWYuH2FDwImxS2s73u9ZrZcT8GmnMbj/6UI7SImenKBk+kTZFOEg1naDfM8ind0Pqcxbzh4O
 bPJbMZUqMUPEGGHzZO2sAwW9hwN+O1OJD2oL1yOJ7S7ZXCaWPlfB6TUgx476yb1xKB2ku6mZVcK
 IscuPXPjR3IirUoELIklY2qsejmHhGE5eMiZZjjbXst+dqZbaZA48/T58T6L70VfDV3NGCqyWt/
 LvOwtqoo+qcfdiNndew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXzCOXbHhG2223
 KMkNBK54W5wgUHL9/0Nk78yBCWlZirxxx6snVBVxtQS6PqQkwhAQG5AUJ0VdHzm3cBZf6uejTQX
 yVRcRr9k5//gBvQkYsj2knpwtbh8fB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From RFC 02653 for Power ISA 3.2 :
Implement the getter and setter for DMRs with row level granularity.

Implement the following DMF instructions :

	DMSETDMRZ		: X-form
	DMXX{EXTF,INST}DMR256	: XX2-form
	DMXX{EXTF,INST}DMR512	: XX3-form

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h                    |  5 ++
 target/ppc/insn32.decode            | 18 +++++++
 target/ppc/translate.c              | 11 ++++
 target/ppc/translate/dmf-impl.c.inc | 80 +++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 target/ppc/translate/dmf-impl.c.inc

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1cd379810a..7221868793 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3055,6 +3055,11 @@ static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
     return (ppc_avr_t *)((uintptr_t)env + avr_full_offset(i));
 }
 
+static inline int dmr_row_offset(int reg, int row)
+{
+    return offsetof(CPUPPCState, dmr[reg].row[row]);
+}
+
 static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 {
     /* We can test whether the SPR is defined by checking for a valid name */
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6563dc4f64..2a9733d6fd 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -274,12 +274,20 @@
 &MMIRR_XX3      xa xb xt pmsk xmsk ymsk
 %xx_at          23:3
 %xx_xa_pair     2:1 17:4 !function=times_2
+%xx_xb_pair     1:1 12:4 !function=times_2
 @XX3_at         ...... ... .. ..... ..... ........ ...          &MMIRR_XX3 xt=%xx_at xb=%xx_xb \
                                                                 pmsk=255 xmsk=15 ymsk=15
 
 &XX3_dm         xt xa xb dm
 @XX3_dm         ...... ..... ..... ..... . dm:2 ..... ...       &XX3_dm xt=%xx_xt xa=%xx_xa xb=%xx_xb
 
+&XX3_abp_as_p   xap xbp as p
+@XX3_abp_as_p   ...... as:3 .. .... p:1 .... . ........ ...     &XX3_abp_as_p xap=%xx_xa_pair xbp=%xx_xb_pair
+
+%p0p1           16:1 11:1
+&XX2_bp_as_p    xbp as p
+@XX2_bp_as_p    ...... as:3 ...... . .... . ......... ..        &XX2_bp_as_p xbp=%xx_xb_pair p=%p0p1
+
 &XX4            xt xa xb xc
 @XX4            ...... ..... ..... ..... ..... .. ....          &XX4 xt=%xx_xt xa=%xx_xa xb=%xx_xb xc=%xx_xc
 
@@ -1534,6 +1542,16 @@ VMODUD          000100 ..... ..... ..... 11011001011    @VX
 VMODSQ          000100 ..... ..... ..... 11100001011    @VX
 VMODUQ          000100 ..... ..... ..... 11000001011    @VX
 
+## DMF Instructions
+
+DMSETDMRZ       011111 ... -- 00010 ----- 0010110001 -      @X_a
+
+DMXXEXTFDMR512  111100 ... -- .... . .... - 11100010 ..-    @XX3_abp_as_p
+DMXXINSTDMR512  111100 ... -- .... . .... - 11101010 ..-    @XX3_abp_as_p
+
+DMXXEXTFDMR256  111100 ... ------ . .... . 111100100 .-     @XX2_bp_as_p
+DMXXINSTDMR256  111100 ... ------ . .... . 111100101 .-     @XX2_bp_as_p
+
 ## SLB Management Instructions
 
 SLBIE           011111 ----- ----- ..... 0110110010 -   @X_rb
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 48e5903214..c714ed665a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3992,6 +3992,15 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
         }                                               \
     } while (0)
 
+#define REQUIRE_DM(CTX)                                 \
+    do {                                                \
+        if (unlikely(!(CTX)->dm_enabled)) {             \
+            gen_exception_err((CTX), POWERPC_EXCP_FU,   \
+                               FSCR_IC_DM);             \
+            return true;                                \
+        }                                               \
+    } while (0)
+
 #define REQUIRE_FPU(ctx)                                \
     do {                                                \
         if (unlikely(!(ctx)->fpu_enabled)) {            \
@@ -4384,6 +4393,8 @@ static bool trans_ICBIEP(DisasContext *ctx, arg_X_ea *a)
 
 #include "translate/vsx-impl.c.inc"
 
+#include "translate/dmf-impl.c.inc"
+
 #include "translate/dfp-impl.c.inc"
 
 #include "translate/spe-impl.c.inc"
diff --git a/target/ppc/translate/dmf-impl.c.inc b/target/ppc/translate/dmf-impl.c.inc
new file mode 100644
index 0000000000..5409ba8836
--- /dev/null
+++ b/target/ppc/translate/dmf-impl.c.inc
@@ -0,0 +1,80 @@
+/***                           DMF extension                               ***/
+
+static inline void set_dmr_row(int reg, int row, TCGv_i128 src)
+{
+    tcg_gen_st_i128(src, tcg_env, dmr_row_offset(reg, row));
+}
+
+static inline void get_dmr_row(TCGv_i128 dst, int reg, int row)
+{
+    tcg_gen_ld_i128(dst, tcg_env, dmr_row_offset(reg, row));
+}
+
+static bool trans_DMSETDMRZ(DisasContext *ctx, arg_DMSETDMRZ *a)
+{
+    TCGv_i128 zero;
+    TCGv_i64 hi, lo;
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+
+    zero = tcg_temp_new_i128();
+    hi = tcg_constant_i64(0);
+    lo = tcg_constant_i64(0);
+
+    tcg_gen_concat_i64_i128(zero, lo, hi);
+    for (int row = 0; row < 8; row++) {
+        set_dmr_row(a->ra, row, zero);
+    }
+    return true;
+}
+
+static bool do_ext_inst_512(DisasContext *ctx, arg_XX3_abp_as_p *a, bool ext)
+{
+    TCGv_i128 temp;
+
+    REQUIRE_DM(ctx);
+    REQUIRE_VSX(ctx);
+
+    temp = tcg_temp_new_i128();
+    int start_row = (a->p > 0) ? 4 : 0;
+
+    for (int i = 0; i < 4; i++) {
+        int vsr_reg = (i < 2) ? a->xap : a->xbp;
+        if (ext) {
+            get_dmr_row(temp, a->as, start_row + i);
+            set_vsr_full(vsr_reg + (i % 2), temp);
+        } else {
+            get_vsr_full(temp, vsr_reg + (i % 2));
+            set_dmr_row(a->as, start_row + i, temp);
+        }
+    }
+    return true;
+}
+
+static bool do_ext_inst_256(DisasContext *ctx, arg_XX2_bp_as_p *a, bool ext)
+{
+    TCGv_i128 temp;
+
+    REQUIRE_DM(ctx);
+    REQUIRE_VSX(ctx);
+
+    temp = tcg_temp_new_i128();
+    int start_row = 2 * a->p;
+
+    for (int i = 0; i < 2; i++) {
+        if (ext) {
+            get_dmr_row(temp, a->as, start_row + i);
+            set_vsr_full(a->xbp + i, temp);
+        } else {
+            get_vsr_full(temp, a->xbp + i);
+            set_dmr_row(start_row, a->xbp + i, temp);
+        }
+    }
+    return true;
+}
+
+TRANS_FLAGS2(ISA320, DMXXEXTFDMR512, do_ext_inst_512, true)
+TRANS_FLAGS2(ISA320, DMXXINSTDMR512, do_ext_inst_512, false)
+TRANS_FLAGS2(ISA320, DMXXEXTFDMR256, do_ext_inst_256, true)
+TRANS_FLAGS2(ISA320, DMXXINSTDMR256, do_ext_inst_256, false)
-- 
2.55.0


