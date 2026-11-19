Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70575606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlW0C1xv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9n-0003Bl-LP; Thu, 19 Nov 2026 16:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9l-0003A2-Ju
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9h-0006Zc-46
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Ow13814584
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p1RVaOWbtfQ
 bYQjs/GfhBdK5/KroMVgCk9blW8QDqzY=; b=ZlW0C1xvtpBBowB168pj9g0kG1w
 AR+RNgDZjpflsAkI21twMx2pTfzSxh1U8vQlJcztNwNcpaohZj4rvBMgr1WaVv9C
 dgSm3S0Yn+xnGARBp/vy/RVoorG3mCgm6aOZD7biX4/wIZxygIwZ8su3s3oFAekT
 63PeY3qgYD3Ei7CnNl/HX0d0rNRuZ6jmpflZyvsvLjOCHpnMFuqsheH4IDSt6fnm
 yAZUdAbnpzAGJV2rze+ig//ir0+fgPBIi1Ztust4s/z27rdolw+oWpd6nlyZk9UW
 h87XcT5lx+cJT5xg2/ijzEj9GV9xvAbnfIdtN6eAN3fRSKufysaa22tNJ1g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6uj1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwr8o1783825
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJLwrlu1783803
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 398CA23D1B; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 01/15] target/hexagon: read the old predicate value through
 C4
Date: Thu, 19 Nov 2026 13:58:39 -0800
Message-ID: <20261119215853.987158-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=YG9VzMu1pjctpm2pRaQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX/fqVQjRj+xus
 MtURuY1nmMRUkFgqgEaZX+usMHQfFgxkpWkI5pw6TYW7/9h22h3oVdAe3vpHAIlAm71KhmHaSVC
 pOf+JXXLJ2zTaiHcEd5CXiHwgh1055uJGzOo49SzDd8SS4B13fOUBCbIxcHY6OdkYEVUu4DLIDs
 GdC8kNKNwYX1TwGUMHqE8lhchfudD50vfcXqEHZ0sYRn/W3EyM43+CSKU9KmWiW8kwRbMtQH9g3
 3MsuDEc8G+mkIxvAIOy675XmLtrb6Vm9Zn+yqJUaEAlJYdn39OiIO7l1DXLFdkNHzRiXfQcprEo
 DTmTHTq7L4VI0BlEbBLIo8pyU/jP7nxjg599l+g1lmQnuD6757QvptZCpVobaszDS72BK+/v2eJ
 ApGsoeSgA9azxBvC+ScAiS/HzStVikg9sgVnF88/fqeIb9fQ+/qVeWueYNgf8Areb0r7lChofvS
 EkrW/UhI7nNRKNiJ9Pg==
X-Proofpoint-ORIG-GUID: XDumqyoFA633GRC03okVSSyfVXnix_tM
X-Proofpoint-GUID: XDumqyoFA633GRC03okVSSyfVXnix_tM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX8raQCRorkFbR
 5qGVw7McJiqjE9JzmWptDgkwas31SoO4TzrgCq1CO3aDUfXSK0EvzBs5VcF+6A7C7wD7pbbHjr2
 ho9Y1AWbXTqiysfJwibD8pMAzBr0J4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
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


