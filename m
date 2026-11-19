Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261B606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SZ2QLRgl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9m-0003AV-7i; Thu, 19 Nov 2026 16:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9l-00039o-50
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Zz-TD
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1SnV095109
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XdS6IUwy5hj
 yxzXWpJVR89i6bqQBuQHFOPwe/SLcuNY=; b=SZ2QLRgl9sHZ+XN4YNCHEVgD+0D
 3rKf5wR0KHSP7gNwarwwyMaW0Rjf/lPmW2FFGKNMEzEgzCXiqkzDxrwiSc6QwLfu
 iNrXDx/SnCA3rj/qKVLcofZ015rqs0el94PWnj9HGuduW/JFXCu1JAfEuCKw5IXY
 8wsBu70XMQG/dVjXhTHCAcnMiXjiDquEfKKovfS3xx5IP98+br8We7Fv5EjytLPq
 DqIGCq1/3uLL1L8qSoOMUjXB2w/bsc+rDiJm/eRG8x5RQuQy7qQhUX4hTfbT9yOB
 1BMy9VTQIh9lRjQgtO4PXmEMBNSy66ER/aMvbnxLbhMgTrB3ObT3eAbTtaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1bf71-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLrv773805686
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJLwsGh3812750
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 4B4662577C; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 05/15] target/hexagon: commit coprocessor results before
 context changes
Date: Thu, 19 Nov 2026 13:58:43 -0800
Message-ID: <20261119215853.987158-6-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff711f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=2ZaAnrbsLTiuA5g7MksA:9
X-Proofpoint-ORIG-GUID: DodZNidkbRCegq_7juUoMSwFC_pycukx
X-Proofpoint-GUID: DodZNidkbRCegq_7juUoMSwFC_pycukx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXxdcDNkMPkAWw
 qlubrV5KUarPWpAvDEBsVVKwr+vG3+bJqlI+IsqsGXyuMqgWgGFiJu4Wi1SpjARNDiMnN6Gud33
 m3DVLzxqa+2ENTatw+S59TgZ8m8V8/f3bFXqr7FzO1OxdsIRZu4azBCyD89YcICn+lXepcQqkv4
 NNY0crHMdE1ic355fg3VlbxRdM0mBJlIb5gizx1Krto0z3hpwD3LMRXU8FfHy8nwegR75oYzzr/
 vmHAPUqDKJo41Nxdb5LcKxRvR0lGCp7pQP58dKDTLO8Ovkn1FxA45sncK4DvK4cCI7E9zbEk6ro
 Pce8Z6x5qgpop3GAMxUKrHVjgOkq225WQLuWQcH9JRty4PQvhRfqdaVrKaIlFp5+jda+G7kadft
 /yMs53Sswh654NGZjYZqkXuWwZtLqjd88PLSI46ePCHw/ROEbtquW9FwdTEeosCBML1dgOq3DA1
 N4dCceneGjVUemsZU1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX8PdJ8HF+cirU
 yDdpqNxHINR9Rms3i1nC9B/NVQOPWPlF9W6+93DdrjdQ+sdFgU2Uh+ga+KJo4/+hJXPuizS5RVH
 z9NogoeY3qVZPXNaxCVm1ef96seV1xY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
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

A CCR write can detach the HLX context. Commit packet results to the
old context before applying system register writes, so clearing XE3
does not abort the emulator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 3601c4e9f3..220328147f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1482,7 +1482,6 @@ static void gen_commit_packet(DisasContext *ctx)
     gen_reg_writes(ctx);
 #ifndef CONFIG_USER_ONLY
     gen_greg_writes(ctx);
-    gen_sreg_writes(ctx);
 #endif
     gen_pred_writes(ctx);
     if (ctx->pkt.pkt_has_hvx) {
@@ -1494,6 +1493,10 @@ static void gen_commit_packet(DisasContext *ctx)
     if (ctx->pkt.pkt_has_hmx) {
         gen_commit_hmx(ctx);
     }
+#ifndef CONFIG_USER_ONLY
+    /* Context changes must follow writes to the packet's old context. */
+    gen_sreg_writes(ctx);
+#endif
     update_exec_counters(ctx);
 
     if (ctx->pkt.vhist_insn != NULL) {
-- 
2.43.0


