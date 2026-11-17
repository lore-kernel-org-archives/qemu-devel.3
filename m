Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE9606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YNObMOm9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO2z-0001H3-Cd; Tue, 17 Nov 2026 13:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2n-0001F4-Ov
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000oi-7x
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR0tB3503801
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=12mM4rQklFW
 4ke2O4qtotiCGgNpimdIJTgx6g3oFIdI=; b=YNObMOm982MiqvYbqYRafpCW31M
 FIRcSA4dAOg2ZCbj7bdFWOAkahR0eYXB794hl3U1xd5TYhbY+/HmDWdvIA1MF0cb
 PR3fAHMuS+SLiPng4BDHGEiKzFRMx96ol0COHJPzFq05QUF9wFdDNap1zBuoDqcY
 ll4jbPhF3wOzO0sSb2V0djWW5etJIvsGpXdKOJujdgploj66qhvx1o40sHDj9Iql
 NC06NtmmzKQElVLGbwaxBvQxsrGbKBjmkPP66mzgdB2ZTreLiHlUrUTYlYP5wend
 jnluhGzCQX90GyNxAxPVeDGORMY2aumPyXZYScrdlmWZnmaDgPeMgU4nFug==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv125ey-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUhB3129169; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AHIaTap3129157
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:29 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 8E78724C65; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 01/14] target/hexagon: read the old predicate value through C4
Date: Tue, 17 Nov 2026 10:36:16 -0800
Message-ID: <20261117183629.2002840-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: -w9r6E3BGjlgmJl4InzsKxUjopu2BmN_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXwnjyjHxpV6oh
 1qSutr9QP3xSdB9VO4JQ6+5kpNXWF18O8dG6lw9COqMwbkgoTzVcdzHIiLLWJCXMXCdT8IKTGAQ
 64ceUF+iD9ESuFkd/T0FLeWyl1P7t28=
X-Proofpoint-ORIG-GUID: -w9r6E3BGjlgmJl4InzsKxUjopu2BmN_
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc9eae cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=YG9VzMu1pjctpm2pRaQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXwG2lu+HNiijs
 xSTCyINU0VJ6gYdnz06+W9QAIwN/xtybHJTBZy/+qxwnRJSShj27sLX2/VpzWv1O+P6grVJoFUQ
 PXmHxSkLoyDEy7VNWVMhUhFbaLgBi/o5GpNTfPov5diljI+xGMU9vcWufOv7Ngj3l2ZU1cWN8FR
 nU++anXmmVPT8/+DYLEVbWfikNBk2CgRqW9A8X2mYibEhRneekgvAnHwYwN1rqxydCyG+PsAehy
 poioc++M/JweLtXAK/tKBimmlDukwXPWeTbczXtTaS0v0zblAU5JCYfPWMz1cETo6BCD64Tphb+
 Zh+IgRTVOkXxsAbxVdmInNMT4SVLQsHNBZKr5maQA+nLI7cmJNE5hpFHlmNKNn0DsIQeyYe5yTt
 YfoeUlI7rRVzND9UVIvdX5DdOAXxjxdrTyXCI+qS5ByYaOqim6S2/F28u7JNz90pzldvxF2ae26
 4gcImEGv21bf/yY4EEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Track C4 reads as reads of all four predicates. This prevents the
packet short circuit from exposing a predicate result to an old-value
control register read.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/translate.h      |  6 +++++-
 tests/tcg/hexagon/meson.build   |  1 +
 tests/tcg/hexagon/packet_user.c | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/hexagon/packet_user.c

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index bc3b49ab06..c988c85f33 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -248,7 +248,11 @@ static inline void ctx_log_reg_write_pair(DisasContext *ctx, int rnum,
 
 static inline void ctx_log_reg_read(DisasContext *ctx, int rnum)
 {
-    if (test_bit(rnum, ctx->regs_written)) {
+    if (rnum == HEX_REG_P3_0_ALIASED) {
+        for (int i = 0; i < NUM_PREGS; i++) {
+            ctx_log_pred_read(ctx, i);
+        }
+    } else if (test_bit(rnum, ctx->regs_written)) {
         ctx->read_after_write = true;
     }
 }
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 70f6475656..b3635be3fc 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -96,6 +96,7 @@ tests += {
   'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
   'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
   'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
+  'packet_user.c': {'cflags': [cflags, '-O2']},
   'preg_alias.c': {'cflags': cflags},
   'dual_stores.c': {'cflags': cflags},
   'framekey.c': {'cflags': cflags},
diff --git a/tests/tcg/hexagon/packet_user.c b/tests/tcg/hexagon/packet_user.c
new file mode 100644
index 0000000000..acc77202ef
--- /dev/null
+++ b/tests/tcg/hexagon/packet_user.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+static int err;
+
+#include "hex_test.h"
+
+static void test_predicate_read(void)
+{
+    unsigned old, new;
+
+    asm volatile(
+        "r0 = #0x12\n"
+        "p3:0 = r0\n"
+        "{\n"
+        "    p0 = cmp.eq(r0,r0)\n"
+        "    %[old] = p3:0\n"
+        "}\n"
+        "%[new] = p3:0\n"
+        : [old] "=r"(old), [new] "=r"(new)
+        : : "r0", "p0", "p1", "p2", "p3"
+    );
+    /* Packet reads old C4, then commits P0. */
+    check32(old, 0x12);
+    check32(new, 0xff);
+}
+
+int main(void)
+{
+    test_predicate_read();
+    puts(err ? "FAIL" : "PASS");
+    return err != 0;
+}
-- 
2.43.0


