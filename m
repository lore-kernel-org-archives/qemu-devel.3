Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229D606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TmOzmpkR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9n-0003C7-R7; Thu, 19 Nov 2026 16:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9j-00038t-Uu
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Zh-R6
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:59 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1UIe1936335
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tKl/qEFEO+y
 +kWGHTZjrwg54bY2zAfu7YfpJia+KXyw=; b=TmOzmpkRx2h3mn5YywKMnGEMw2z
 XhMor6FEhvwYdKZ63XcKjygozCrEUp3lEqzeYVoinSAhA/Ojd/g8ZJ0WIwg7KNn5
 ndjNQo89CZl4kdiM2EZfNLewDEH3uooXPxnHOt8jCv4oxBYyGRY/11T6JD7ef04U
 cjNAOy3QthJwTa41hD+3BqAztd3kcJM1/p84m6zK0rObQ665odhxFfOlczpeA8Xa
 ifexLfwzsW/oHGta6OLs+bt6yLIfTd2SgW1j7BHLqZxObhcE8J7vmgijVpPtrHAA
 zaXaNEX5GWzKU2z3gF+kYX3UHwlQZEt4QDfV85A9HuYAXbvqod+WN0dKF0w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugt9j6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLws0i3684705; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJLwsXS3684676
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 658172578E; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 10/15] target/hexagon: preserve inactive BADVA registers
Date: Thu, 19 Nov 2026 13:58:48 -0800
Message-ID: <20261119215853.987158-11-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 8O6OhMQ8mvPLxDueXyYWdBr97gvNKqsC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX76scZeFY0kkb
 dVMGXsynxo1FW0VimFqt547zfqQIFCEkHxe/YQ5kqZys/y9vluvXHh8s2aqVwcU/zYDppgr2HRD
 tmIpLBg1cI8NYprep+Djxrk9qh4mUhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX2Pk3q1idRkCG
 A8HdyrN3HGVNXxVtTHZNo8oQyvjMPyUStVYDqzBj3Om+ecT9C01gUMnVfRSpKbHUpq70nWKFoCa
 BczrVHJclbNDNSWCuRc4c319PuBBu3ssxVyThibkDP+xYybYUA6Cjs/G4kW54KeS+xVXRg4ZcBG
 6y97A3xw7iurHpcgbfXoN1dOif4o6HnZQ8Jjn4eCWBZKVx/gbcaUqayWpuEw+R5GowR0jpk0v9d
 gmsqCvb4Fh2e65Pp0g09OyLmpzSriT0IT17kOw9Ju9yJ8U74uUOHWPyo8C3rIR41eKHfVso5HCI
 9FUUWIrpDkuPRKp3FsUGiljC1TCvjdSUQxquLyMLAQ/6UnDSvYCCFdzht6c7lfk0tnwNeBiMO0b
 u+2FB3mUfvNb3zX9dmAoV4MaUsLb6LlUvHEyCUIfDMD/Wj4YtMHTb4NyTnCE5dYeeLlqQTiXG7L
 DeBw8RyBphP/f8SAtdQ==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=Stv3M7lcxomkFMvdv2cA:9
X-Proofpoint-ORIG-GUID: 8O6OhMQ8mvPLxDueXyYWdBr97gvNKqsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
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

Clear the validity bit without overwriting the inactive slot address.
Fault handlers can retain BADVA values across exceptions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 34f80d6671..5ebe67d024 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -752,8 +752,6 @@ static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 }
 
 
-#define INVALID_BADVA 0xbadabada
-
 static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
                            MMUAccessType access_type)
 {
@@ -765,8 +763,6 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
             if (valid & (1U << i)) {
                 env->t_sreg[HEX_SREG_BADVA0 + i] =
                     i == slot ? VA : env->mem_access_va[i];
-            } else {
-                env->t_sreg[HEX_SREG_BADVA0 + i] = INVALID_BADVA;
             }
         }
         SET_SSR_FIELD(env, SSR_V0, valid & 1);
@@ -777,12 +773,10 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
 
     if (access_type == MMU_INST_FETCH || slot == 0) {
         env->t_sreg[HEX_SREG_BADVA0] = VA;
-        env->t_sreg[HEX_SREG_BADVA1] = INVALID_BADVA;
         SET_SSR_FIELD(env, SSR_V0, 1);
         SET_SSR_FIELD(env, SSR_V1, 0);
         SET_SSR_FIELD(env, SSR_BVS, 0);
     } else if (slot == 1) {
-        env->t_sreg[HEX_SREG_BADVA0] = INVALID_BADVA;
         env->t_sreg[HEX_SREG_BADVA1] = VA;
         SET_SSR_FIELD(env, SSR_V0, 0);
         SET_SSR_FIELD(env, SSR_V1, 1);
-- 
2.43.0


