Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78581606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PaAm8cPv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9o-0003CB-3L; Thu, 19 Nov 2026 16:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9l-0003A9-NY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9h-0006Zg-82
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1DId3594959
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=obaYNB5+EMm
 2OLpXASkG5Fo78WwbSU4KyHhou3DNGqo=; b=PaAm8cPvDOB9PReNKfpbqJQlbJY
 y0UvdWikLci5/67VoBJ4atwijLhWBNrcAb/a22jwjgvVCmyw35QhTpLOVEFzX2Vp
 jH1XzNg7uPt1u9gEiSNTCuGKJvV9hhwpTTsVK73VqV306+wCxGYfAzipSzByVsB2
 KKKRmh0BWYKX9L+ayd+a6tqRoMMvwaFvbxJ3OlU7Nv3HjcRtIBt0L8/4f1c49K85
 WfBeHblx7RmwMmNgoTBlt86U8voy5DKBEEa+bmfRwbjksgAcQu4JZH458dQO82VM
 3Mx9f5ct+8+HC1ief+xay7cHXfnjxiP1fS59EadhkvEo3tirlVARELocwbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255whhgv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwsNF3684702; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJLwsDM3684675
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 6A0062578F; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 11/15] target/hexagon: probe scalar packet memory in slot
 priority order
Date: Thu, 19 Nov 2026 13:58:49 -0800
Message-ID: <20261119215853.987158-12-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX60NwcQdZKpw0
 ciL1phsVFv31buVb7gwd+GUPZKWDEw1wGZUYyHE35u7me2b2wlKkQV2Z7aXgeiAKoQebm7w8eMd
 BZScEfgevuJb2bKxCTB4gcYGOFGsG3Q=
X-Proofpoint-GUID: YfN2aTDZvwMf8Dg00C94kQh2YPuWcvjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX2W2xFWZcdzYL
 9Tym+oBDIXOpGskkPPcr/NRHDJ7dVIDLG1ikETGK6aeJ7rsPkqQqECS1169lLxSI/Aavr8pGaeq
 MUK98qfPKSIp5rrt5630c9QH7ST7h40OsZESbGiOm+LD9uWRkZwiwR03eBrcsga/ZEMk/IVE5a1
 sRWrAJ3cB5OfPj9Lp4Cf8vRpkC+tWBk9nAlv9Ez8OsxuFoDZ0gCK0VicmQMZMHC2V6etWvoRQFK
 ygaLptBi/b6AMBJVbxICljOLOefoFJEr/gr7PLvJxLWca12dfD8xWa9BL2osZ7AMJvzOD8gK1uO
 H4gVLccXEkh9sB4IQGzDbaIcJqTrHWYtbvRHcoJEWzKc1oxsFuMgvhzR68mVXsQLQmsFMQdle3T
 tz81aI1Y+mR9PRFa52urCIz1zef9dTGMPQV5vXEhZHj9AbhG4r2u52KKvdKwsmAPlBydlQp2J7C
 FwEDm70BNQTMHKdKYew==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=dMN3z6l-B7iZEtH36-MA:9
X-Proofpoint-ORIG-GUID: YfN2aTDZvwMf8Dg00C94kQh2YPuWcvjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190088
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

Probe slot 1 before slot 0 without committing either access. A slot 1
store miss must win over a slot 0 load miss in a mem_noshuf packet.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index be5ce7d89c..f22353302b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -459,6 +459,12 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
 {
     uintptr_t retaddr = GETPC();
 #ifndef CONFIG_USER_ONLY
+    /* The slot 1 store fault must precede the slot 0 load fault. */
+    if (env->mem_access_valid & (1U << 1)) {
+        env->mem_slot = 1;
+        probe_write(env, env->mem_access_va[1],
+                    env->mem_log_stores[1].width, mmu_idx, retaddr);
+    }
     env->mem_slot = 0;
 #endif
     probe_read(env, va, size, mmu_idx, retaddr);
@@ -555,6 +561,10 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
 {
     if (slot == 0 && pkt_has_scalar_store_s1 &&
         ((env->slot_cancelled & (1 << 1)) == 0)) {
+#ifndef CONFIG_USER_ONLY
+        probe_store(env, 1, MMU_USER_IDX, false, ra);
+        env->mem_slot = 0;
+#endif
         probe_read(env, vaddr, size, MMU_USER_IDX, ra);
         commit_store(env, 1, ra);
     }
-- 
2.43.0


