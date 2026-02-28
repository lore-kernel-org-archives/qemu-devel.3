Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D45FD0045
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9k-0004Ce-SR; Sat, 28 Feb 2026 16:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9e-0004Ar-Pf
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from qs-2005c-snip4-7.eps.apple.com ([57.103.86.158]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9c-0002U2-Q5
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 6956218000BF; Sat, 28 Feb 2026 21:47:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315235; x=1774907235;
 bh=yu7x8lpmTBFPKXdTa9gwDbLuLb/7CfSjIGSs46mmW0w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X2AHMeb6Vb9+JWgI0xb6Zjv93I6eTULpq2IG0j3DA1wLjhZ7xCDZPFi+sKiivAQlDbJU8+6QsS/oeiDN0ukXXM8CVW3SmiwgFtxR3Suolo6X6QSCYe3o42LW1DV3QCxjGA4N09tAP9/qxxbd0YnOYrv4zDeOOSsBskjmOC7OKi8Zt9rWnOIxcLjoPgZduZdCvPugQx78D9VyY6ldBgg3ngR1VV3GSLiHdNSX2PF5KoZe2IjhlhNxvru2detNf/Loc3lVWVeIGcuxQ+WZ6b9u2QR0F10Yn7k0KB0vnGAWtpI1i94gT0feaYilJckULajZy5t5jCNd6mZvYJm7Loc8Qg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 D8991180018D; Sat, 28 Feb 2026 21:47:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 5/8] target/i386: emulate: more 64-bit register handling
Date: Sat, 28 Feb 2026 22:47:01 +0100
Message-ID: <20260228214704.19048-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9Dv67PjySwdX18J6pWoM2kfNhC5syaH7
X-Authority-Info-Out: v=2.4 cv=YsgChoYX c=1 sm=1 tr=0 ts=69a36263
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=_1DnBmLJiPlmecJZ0XgA:9
X-Proofpoint-ORIG-GUID: 9Dv67PjySwdX18J6pWoM2kfNhC5syaH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfX+8noJ1JPCWUn
 +eQk4gmnBum/ivrBGylICeg/P7kSHeILWF6JD6j++xJF23vPbvc+PZJjqs9dcNwU7Jvpoj5dzbm
 OQl22TxSh9RitJ4mpF0R1qbboo2PPTSvfuFmK8waeM+WNwIyOccBqTlRY11KdFRbgT6eypqPBux
 EWR487KPdNtVUkRfcrHLk4UWnu5ML5QnwWLvIplATUK9EmLfxHmVNvbw1TQRnNwjjxhiRUpfFBA
 PMFSaCLCmm7qVdv8CRMMsT2pIRCRQljEPwNH3QjUv0KOcDOB339pydvB49CwRNtudZvZFQWhdZL
 9PCFHwSgNwVgWsu5aqbnNdrQTCNr4da3omNvoOD9AVLqIqXMtInYukWhBvDI6A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1030 spamscore=0 phishscore=0 mlxlogscore=766
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABcs2/G4p28nM8yXxNFvzcFScr0/vpL9S0EHkXY3qlyUeeThwX8nFiing3mNF5C75tMmIH6kMuKy3pCPuOO4wnVwhnvDPgwDxebijCqSfLfBoIea3LFmNRc/jBts6CKRuytxHOLKWBBeJeuYZOpYR/xR/zOhqqGugJ2E6ktjHl1GK7VdtcZmUyRHpWP5LDhM0896tRED4Mr30PMFZBIZGrB8Zjp/5d0JGiXA+mADdkSBtWU9M+Ws742ThhY7PrkVtWTOHvefgmmRic8tgRfMPShq+deEC2LWn1lOTF40Ac76tSCLM2Z9AMnLToq09rcQx3244gicT8S/ikvnezIAUXBJ0bHHyscsttO1zZrS6dhHkSQcswmKhmVpAqQUQRJbYFvWsA2LyEW4FF6zRhrXI9UYfNVGDeJSHB1T/PW15BVuq0p+VLxQcYTSUkcT0GarbLbCKsMhj3ZbDIsGg484Ns2ZAoB2KJtFqS4my2/YRPTbs3ylGAfA/+Oh4DIYoiAYcuaNn8B35oGTqpqh4kIEzzR6k4/c9sTRexXNeNEw19qIGvB6xCUnTqz/pOsRVRwBHq5Ql0Ae+/xFyd6dtS+hm9rErrjDcR1e8+KxylN/tX0dzh92ZKWYiICTbYuJpB0C+DpPzk6vuUSuTtZ05UrsgNJvTuz8AhhvKIHUSZ
Received-SPF: pass client-ip=57.103.86.158;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c   | 17 ++++++++++++
 target/i386/emulate/x86_flags.c | 47 +++++++++++++++++++++++++++++++++
 target/i386/emulate/x86_flags.h | 20 ++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 8d35f3338c..6c4ccc4538 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -45,6 +45,22 @@
 #include "x86_mmu.h"
 
 
+#ifdef TARGET_X86_64
+#define EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res) \
+    case 8:                                        \
+    {                                               \
+        uint64_t v1 = (uint64_t)decode->op[0].val;  \
+        uint64_t v2 = (uint64_t)decode->op[1].val;  \
+        uint64_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            if (write_val_ext(env, &decode->op[0], diff, 8)) { return 1; } \
+        } \
+        FLAGS_FUNC##64(env, v1, v2, diff);          \
+        break;                                      \
+    }
+#else
+#define EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res)
+#endif
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
     if (fetch_operands(env, decode, 2, true, true, false))  {\
@@ -84,6 +100,7 @@
         FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
     }                                               \
+    EXEC_2OP_FLAGS_CMD_64(env, decode, cmd, FLAGS_FUNC, save_res) \
     default:                                        \
         VM_PANIC("bad size\n");                    \
     }                                                   \
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index 6592193b5e..3c4270a14c 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -82,6 +82,10 @@
     SET_FLAGS_OSZAPC_SIZE(16, carries, result)
 #define SET_FLAGS_OSZAPC_32(carries, result) \
     SET_FLAGS_OSZAPC_SIZE(32, carries, result)
+#ifdef TARGET_X86_64
+#define SET_FLAGS_OSZAPC_64(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(64, carries, result)
+#endif
 
 /* ******************* */
 /* OSZAP */
@@ -107,6 +111,10 @@
     SET_FLAGS_OSZAP_SIZE(16, carries, result)
 #define SET_FLAGS_OSZAP_32(carries, result) \
     SET_FLAGS_OSZAP_SIZE(32, carries, result)
+#ifdef TARGET_X86_64
+#define SET_FLAGS_OSZAP_64(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(64, carries, result)
+#endif
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
 {
@@ -115,6 +123,14 @@ void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
     env->cc_src ^= ((target_ulong)new_of << LF_BIT_PO);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(SUB_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -133,6 +149,14 @@ void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAPC_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(ADD_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -151,6 +175,14 @@ void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAPC_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAP_64(SUB_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -169,6 +201,14 @@ void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAP_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAP_64(ADD_COUT_VEC(v1, v2, diff), diff);
+}
+#endif
+
 void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
@@ -187,6 +227,13 @@ void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAP_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_LOGIC64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff)
+{
+    SET_FLAGS_OSZAPC_64(0, diff);
+}
+#endif
 
 void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
                               uint32_t diff)
diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index a395c837a0..7ffbbe5c12 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -33,6 +33,10 @@ void set_CF(CPUX86State *env, bool val);
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff);
 void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -40,6 +44,10 @@ void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                            uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                            uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff);
 void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -47,6 +55,10 @@ void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                            uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_SUB64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                           uint64_t diff);
+#endif
 void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                            uint32_t diff);
 void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -54,6 +66,10 @@ void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                           uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAP_ADD64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                           uint64_t diff);
+#endif
 void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                            uint32_t diff);
 void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
@@ -61,6 +77,10 @@ void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                           uint8_t diff);
 
+#ifdef TARGET_X86_64
+void SET_FLAGS_OSZAPC_LOGIC64(CPUX86State *env, uint64_t v1, uint64_t v2,
+                              uint64_t diff);
+#endif
 void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
                               uint32_t diff);
 void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
-- 
2.50.1 (Apple Git-155)


