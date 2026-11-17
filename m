Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCB606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=odiQ5krA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO2r-0001Fs-4s; Tue, 17 Nov 2026 13:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2m-0001EB-0i
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:36 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2i-0000p1-PU
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:35 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIETLS1033075
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q9uCzgA4D2O
 O1aaRB7WKswGt7+ZK5/+EQM6yKgLnhKs=; b=odiQ5krAfjEIgNHEmYLPYEfStU1
 U8+Z03zUsSvKrPLdrnsYUdcLCRAiJ+gc31OWBX1mnSqQkXLmkIZRcJeJDJbRKIPh
 nQ/yxT84ehgWVavZqY/iFcSjL8tLNUVkN+H5d0qJI9oaMsQPFT/eZskTz4HMAAVM
 Qgshbg4y6L46OQI+ZnYlXXAoW4mAX9ye7Kfyj4R52svbyLQFD47H8fZFU8GUWL9W
 7b/9BOQWo58KPG03l2O9m5U4AM5wJBCPRwBsZmxYg1bVzkG0Opoq6Mg+g8yT+663
 hz6IFJQP3wnTsxdaySC7TqzsSaaJOUa4v5e2fdY18L3A9Zh5NfzzupzlMYw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0v1fg34h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUkX3167782; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AHIaUBt3167743
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id BE22F2551A; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 12/14] target/hexagon: check packet alignment before TLB probes
Date: Tue, 17 Nov 2026 10:36:27 -0800
Message-ID: <20261117183629.2002840-13-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: bLayfHliWIKX0reJyCOefhg5H1uIFZoj
X-Proofpoint-GUID: bLayfHliWIKX0reJyCOefhg5H1uIFZoj
X-Authority-Analysis: v=2.4 cv=IbgSymqa c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=szOULfNCbFcSyid-6x4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX3vzxGVOIAWML
 Hg9epnAxfNGVNl3Zixf16j8Ook2midy2uJk+/l1ernZYAPFWTzfIx3eQNNqouCkB0AeGyBCtq0Y
 EIW/JNiXW9F8JgS6QYtxbYUB/eabnb/sHIMV0Q2aHyUpzqJhNcK3wjziKP0ubJdwl8lLj+JDKq/
 Rng73d+1Msje4pDzw3Hv1lufC7kH5kdqCaK9wRyF0sLhMBCriSpNSFlis53fieLh79PhlvGv0E8
 n/a0Hv4+OfLx3YCfcghCqzHqubB/sbfh3FW2VAbbZqaXoqap2Qe8Su2PRGbDN/1ZBThLjP8U6tV
 0ldDionlkLUpWKKCeU9GKqESLkfKn+63CCtK8QxzMJYiwMrX15yumhWnxFLZ8l2V5/OJP5mKBIG
 y2AjoIYlYo/AgiGxPkX/FthBKw0CPYlUnCrtWxxOA4RUhC688vyiNWTOvswO5sjXiO8v7eEz9eW
 i04GQJGY+V58qF2TdLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8cvTtwSJbzGH
 eD1VwveTrKA0TOzSk87yeefool1jQag8nUBtm73qgpXQOLfIG3w154Bjqc5FK27kedO5TkxvNQJ
 sqzK4iHlRPVD/JfXXjON2gP+n5MnqdU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Check active scalar addresses for alignment before translating either
slot. An alignment error must not trigger a recoverable TLB miss first.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c       | 12 ++++++++++++
 target/hexagon/cpu.h       |  6 ++++++
 target/hexagon/op_helper.c | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 77fd8156ed..bc8e51ee61 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -833,6 +833,18 @@ static void raise_misaligned_exception(CPUState *cs, uint32_t VA, int slot,
     env->cause_code = excp;
 }
 
+void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
+                             unsigned size, int slot,
+                             MMUAccessType access_type, uintptr_t retaddr)
+{
+    if (va & (size - 1)) {
+        CPUState *cs = env_cpu(env);
+        raise_misaligned_exception(cs, va, slot, access_type);
+        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
+                           retaddr);
+    }
+}
+
 static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
                                            "MMU_INST_FETCH" };
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 092462cb6c..e7ecbb1d59 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -233,6 +233,12 @@ typedef struct CPUArchState {
     HmxState *hmx_state;
 } CPUHexagonState;
 
+#ifndef CONFIG_USER_ONLY
+void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
+                             unsigned size, int slot,
+                             MMUAccessType access_type, uintptr_t retaddr);
+#endif
+
 typedef struct HexagonCPUClass {
     CPUClass parent_class;
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0814a32fa3..7afd13c996 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -70,6 +70,15 @@ void HELPER(probe_packet_mem)(CPUHexagonState *env, uint32_t mmu_idx)
 {
     uintptr_t ra = GETPC();
 
+    /* Alignment errors have priority over address translation faults. */
+    for (int slot = 1; slot >= 0; slot--) {
+        if (env->mem_access_valid & (1U << slot)) {
+            hexagon_check_alignment(env, env->mem_access_va[slot],
+                                    env->mem_access_size[slot], slot,
+                                    env->mem_access_store[slot] ?
+                                    MMU_DATA_STORE : MMU_DATA_LOAD, ra);
+        }
+    }
     for (int slot = 1; slot >= 0; slot--) {
         if (env->mem_access_valid & (1U << slot)) {
             env->mem_slot = slot;
@@ -507,6 +516,7 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
     uintptr_t retaddr = GETPC();
 #ifndef CONFIG_USER_ONLY
     env->mem_slot = 0;
+    hexagon_check_alignment(env, va, size, 0, MMU_DATA_LOAD, retaddr);
 #endif
     probe_read(env, va, size, mmu_idx, retaddr);
 }
-- 
2.43.0


