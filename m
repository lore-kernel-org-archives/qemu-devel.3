Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A790C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplP-0006R6-Ke; Fri, 28 Aug 2026 02:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplO-0006QW-L5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplM-0000vm-A8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S225bJ596414
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bKx0K4jsVo8HX3FmE
 0B4SUBkH8Rh8Kx0qcblgW+B3r0=; b=ryfClFDvdqWvnZd2aV65cAY8E9K0OYG53
 IAH54PlqbjtnX3RXQAIgklvIB9qfev9WCz/LRFCl6jBpaz6S10RqZMJyznruHPFW
 dzgbB109y2wEfFZgkSB8p0ePYPS4nG9mbBX3ebfVDm0lkCOVcNkA+UfloRXYwnkH
 9a6JBO3nS1sYFpcwNwCc2ODIESLlXCqOV3n6qOvYn+OXqzWJ5S5juURz8GLr0UF6
 DHbqQskEG2E7hpJWFefDIZKjI/qMejcOGfxirnLA0fpnbkKrAn2dix3qlANPKTad
 PtUIfM5rtVcKdBo2OI80XDR8Pb0WmvTFsFhqBvjIM5Fjl3VqcMQgA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uITV019166
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kcm98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Lxj40436034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E2C720043;
 Fri, 28 Aug 2026 06:08:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1150820040;
 Fri, 28 Aug 2026 06:08:19 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:18 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 21/41] target/ppc: Move wait instruction to decodetree
Date: Fri, 28 Aug 2026 11:36:56 +0530
Message-ID: <20260828060716.91672-22-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Um8bpVHBAzoHuOonu9ziNeAwY-fPYtiD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX+o1eULvalUyi
 6vIB6MKgb21dnEioUaRy5KmwgMuq/weW9+AvaRnaZK2+WkgJ4AlyIwA1kJ3wnPar8Omx+CL4OlG
 w6U+ON7T8Tehv6wXU87I7JuhHvURF76SvtF3+XQ8cWkLUZA6/aRak5CgbJTBf1XJ+koLlfrrZD3
 QB9rjFLD9PSyT8NHlgV17+irjggf8PBzpM3dGJIpGbisY0iT5MdEZlV3T+fOjEma7ec6JyplkzM
 7J8S4+k/SorcCrGckMt0EYMFdboxFlThgP2Qk5oJee4X8UZE3X2qvuPQMhQbI+3oy5lMLJUAOgu
 LqwVkg+Kpmh6k/2c321suAiwxA+KVnPMHXCWpxKMx76/GwPA9zDi+qKt6JHVIcc/euWNKtFC9aQ
 pzEgwi4KS8k21ug4d/fXAeHmTtmnTwYtBjsLp1BSNj/5AOWxnTJCVDfJgXNftgzxeimI6/4XkPl
 ikjI+mN83yyfFJhPRlQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uB9JOsh-sYL72gAx4UQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXzLUq5v/fXxST
 rsi9ew9lJtz4vW9ofOuB+xxYXgVPXDs4fTbe9AjDQxc/lsmVTRuYIzv6GNCnFSIJrRIg4Y9qWTa
 XhmAKpeKwDRUvdLjmPlj398wxHxNexI=
X-Proofpoint-ORIG-GUID: Um8bpVHBAzoHuOonu9ziNeAwY-fPYtiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Implement wait instruction using decodetree with
proper handling of WC and PL fields across different ISA
versions. Since the opcode changed between ISA 2.x and 3.x
we have defined 2 different decodetree instructions that
are handled by the same helper.

The changes have been tested by comparing the tcg generated
before and after the change for wait instruction. The test
was repeated for 2 types of machines:

Power10 - which should use the newer wait implementation
e500mc - which should use older PPC_WAIT implementation

Both generated the same tcg ops with and without the change.
Further, with the changes we were able to boot into Fedora
distro as well.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-18-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                     | 15 +++
 target/ppc/translate.c                       | 91 ------------------
 target/ppc/translate/storage-ctrl-impl.c.inc | 99 ++++++++++++++++++++
 3 files changed, 114 insertions(+), 91 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e7cc36bd6c..da32ac1d28 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1478,6 +1478,21 @@ ISYNC           010011 ----- ----- ----- 0010010110 -
 @XL_bfa         ...... bf:3 .. bfa:3 .. ..... ..... ..... .
 MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
 
+# Wait Instructions
+
+# We can use the same X_wait argument set for both WAIT and older ISA2.x
+# compliant WAIT_2_x. Depending on the version, we may or may not use the
+# arguments. For more information, check do_wait() helper.
+
+&X_wait         wc pl
+@X_wait         ...... ..- wc:2 --- pl:2 ----- .......... -  &X_wait
+
+# According to ISA v3.1, bit 6 and 7 are implementation dependent and "unless
+# the intention is to use the implementation-dependent field, these bits must be
+# coded zero". Hence, we code them to 0.
+WAIT            011111 00-.. ---.. ----- 0000011110 -  @X_wait
+WAIT_ISA_2_X    011111 ---.. ---.. ----- 0000111110 -  @X_wait
+
 # Branch History Rolling Buffer (BHRB) Instructions
 
 &XFX_bhrbe      rt bhrbe
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 322870dc0d..e5ed4d2cc4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2727,95 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
 #endif
 
-/* wait */
-static void gen_wait(DisasContext *ctx)
-{
-    uint32_t wc;
-
-    if (ctx->insns_flags & PPC_WAIT) {
-        /* v2.03-v2.07 define an older incompatible 'wait' encoding. */
-
-        if (ctx->insns_flags2 & PPC2_PM_ISA206) {
-            /* v2.06 introduced the WC field. WC > 0 may be treated as no-op. */
-            wc = WC(ctx->opcode);
-        } else {
-            wc = 0;
-        }
-
-    } else if (ctx->insns_flags2 & PPC2_ISA300) {
-        /* v3.0 defines a new 'wait' encoding. */
-        wc = WC(ctx->opcode);
-        if (ctx->insns_flags2 & PPC2_ISA310) {
-            uint32_t pl = PL(ctx->opcode);
-
-            /* WC 1,2 may be treated as no-op. WC 3 is reserved. */
-            if (wc == 3) {
-                gen_invalid(ctx);
-                return;
-            }
-
-            /* PL 1-3 are reserved. If WC=2 then the insn is treated as noop. */
-            if (pl > 0 && wc != 2) {
-                gen_invalid(ctx);
-                return;
-            }
-
-        } else { /* ISA300 */
-            /* WC 1-3 are reserved */
-            if (wc > 0) {
-                gen_invalid(ctx);
-                return;
-            }
-        }
-
-    } else {
-        warn_report("wait instruction decoded with wrong ISA flags.");
-        gen_invalid(ctx);
-        return;
-    }
-
-    /*
-     * wait without WC field or with WC=0 waits for an exception / interrupt
-     * to occur.
-     */
-    if (wc == 0) {
-        TCGv_i32 t0 = tcg_constant_i32(1);
-        tcg_gen_st_i32(t0, tcg_env,
-                       -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
-        /* Stop translation, as the CPU is supposed to sleep from now */
-        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-    }
-
-    /*
-     * Other wait types must not just wait until an exception occurs because
-     * ignoring their other wake-up conditions could cause a hang.
-     *
-     * For v2.06 and 2.07, wc=1,2,3 are architected but may be implemented as
-     * no-ops.
-     *
-     * wc=1 and wc=3 explicitly allow the instruction to be treated as a no-op.
-     *
-     * wc=2 waits for an implementation-specific condition, such could be
-     * always true, so it can be implemented as a no-op.
-     *
-     * For v3.1, wc=1,2 are architected but may be implemented as no-ops.
-     *
-     * wc=1 (waitrsv) waits for an exception or a reservation to be lost.
-     * Reservation-loss may have implementation-specific conditions, so it
-     * can be implemented as a no-op.
-     *
-     * wc=2 waits for an exception or an amount of time to pass. This
-     * amount is implementation-specific so it can be implemented as a
-     * no-op.
-     *
-     * ISA v3.1 allows for execution to resume "in the rare case of
-     * an implementation-dependent event", so in any case software must
-     * not depend on the architected resumption condition to become
-     * true, so no-op implementations should be architecturally correct
-     * (if suboptimal).
-     */
-}
-
 #if defined(TARGET_PPC64)
 static void gen_doze(DisasContext *ctx)
 {
@@ -5184,8 +5095,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
-GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
-GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index 943229c438..d4d6ab765a 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -270,3 +270,102 @@ static bool do_tlbie(DisasContext *ctx, arg_X_tlbie *a, bool local)
 
 TRANS_FLAGS(MEM_TLBIE, TLBIE, do_tlbie, false)
 TRANS_FLAGS(MEM_TLBIE, TLBIEL, do_tlbie, true)
+
+/*
+ * Decodetree populates a->wc and a->pl based on ISA v3.1, however they may
+ * or may not be used based on the ISA:
+ *   For ISA < 2.06 - both wc and pl are ignored
+ *   For ISA == 2.06, 2.07, 3.0 - wc is used and pl is ignored
+ *   For ISA 3.1 - both wc and pl are used
+ */
+static bool do_wait(DisasContext *ctx, arg_X_wait *a)
+{
+    uint32_t wc;
+
+    if (ctx->insns_flags & PPC_WAIT) {
+        /* v2.03-v2.07 define an older incompatible 'wait' encoding. */
+
+        if (ctx->insns_flags2 & PPC2_PM_ISA206) {
+            /* v2.06 introduced the WC field. WC > 0 may be treated as no-op. */
+            wc = a->wc;
+        } else {
+            wc = 0;
+        }
+
+    } else if (ctx->insns_flags2 & PPC2_ISA300) {
+        /* v3.0 defines a new 'wait' encoding. */
+        wc = a->wc;
+        if (ctx->insns_flags2 & PPC2_ISA310) {
+            uint32_t pl = a->pl;
+
+            /* WC 1,2 may be treated as no-op. WC 3 is reserved. */
+            if (wc == 3) {
+                gen_invalid(ctx);
+                return true;
+            }
+
+            /* PL 1-3 are reserved. If WC=2 then the insn is treated as noop. */
+            if (pl > 0 && wc != 2) {
+                gen_invalid(ctx);
+                return true;
+            }
+
+        } else { /* ISA300 */
+            /* WC 1-3 are reserved */
+            if (wc > 0) {
+                gen_invalid(ctx);
+                return true;
+            }
+        }
+
+    } else {
+        warn_report("wait instruction decoded with wrong ISA flags.");
+        gen_invalid(ctx);
+        return true;
+    }
+
+    /*
+     * wait without WC field or with WC=0 waits for an exception / interrupt
+     * to occur.
+     */
+    if (wc == 0) {
+        TCGv_i32 t0 = tcg_constant_i32(1);
+        tcg_gen_st_i32(t0, tcg_env,
+                       -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+        /* Stop translation, as the CPU is supposed to sleep from now */
+        gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
+    }
+
+    /*
+     * Other wait types must not just wait until an exception occurs because
+     * ignoring their other wake-up conditions could cause a hang.
+     *
+     * For v2.06 and 2.07, wc=1,2,3 are architected but may be implemented as
+     * no-ops.
+     *
+     * wc=1 and wc=3 explicitly allow the instruction to be treated as a no-op.
+     *
+     * wc=2 waits for an implementation-specific condition, such could be
+     * always true, so it can be implemented as a no-op.
+     *
+     * For v3.1, wc=1,2 are architected but may be implemented as no-ops.
+     *
+     * wc=1 (waitrsv) waits for an exception or a reservation to be lost.
+     * Reservation-loss may have implementation-specific conditions, so it
+     * can be implemented as a no-op.
+     *
+     * wc=2 waits for an exception or an amount of time to pass. This
+     * amount is implementation-specific so it can be implemented as a
+     * no-op.
+     *
+     * ISA v3.1 allows for execution to resume "in the rare case of
+     * an implementation-dependent event", so in any case software must
+     * not depend on the architected resumption condition to become
+     * true, so no-op implementations should be architecturally correct
+     * (if suboptimal).
+     */
+    return true;
+}
+
+TRANS_FLAGS(WAIT, WAIT_ISA_2_X, do_wait)
+TRANS_FLAGS2(ISA300, WAIT, do_wait)
-- 
2.52.0


