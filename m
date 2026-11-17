Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aUS8bsHr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3A-0001J4-1Q; Tue, 17 Nov 2026 13:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2n-0001F2-Ft
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000oz-6z
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQi8g534674
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qMyqWaKfcib
 9GuVHdYfqq3EK916hHGDOF8W8sYCgA04=; b=aUS8bsHrbZr6lFp/lhlX3zmgV+Q
 dtMrE4pzfoUCCTjCf36zykqFUQcSl0ruSz+q/YfGBgDhmpb00EZ8rIDl66L1ajco
 ZKuZOceUySlr+ie4x8xw3a/VZoQCx/bjKvwovXGwOrcubhOhfA1xGffnaa6sKJkE
 s1Wkoir4ws5WbttX3idB3yYTbIjtjJFSbjcl2nRh8ii3iEB6sQyD/kH9CD6pPjME
 IMssZOuFwt4PoOgJz3k+feRHuORYts3W8k+Uge/sKISKmYSmYa5MaU8sLXgoPhYV
 icYY0BLURaL38bfbU+5FpSR0Nnv0hwyksFj1G1C3zyEr8ArLNWWtaCiy0JQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr39nt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUX13041141; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AHIaUcX3041110
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 9FC3B25480; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 05/14] target/hexagon: commit coprocessor results before
 context changes
Date: Tue, 17 Nov 2026 10:36:20 -0800
Message-ID: <20261117183629.2002840-6-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=2ZaAnrbsLTiuA5g7MksA:9
X-Proofpoint-GUID: -eSHf4A2ArSNSSz6Cx8S6odSzuroVtee
X-Proofpoint-ORIG-GUID: -eSHf4A2ArSNSSz6Cx8S6odSzuroVtee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX07oiK0TaIlkR
 zgJ2ZD5h3d9t9jUmIzHi+BQXS0+Jid9TzFf90cV8Ue8F+OEMzPMvaPRx3M47QPIOvCXX3wZ1kl1
 V7ofprPIcS4nv/mitXnsKSUEQpQsi8xU9OkREznipKHI6UGI8SM/5UqdJcgpGYivCkFAdCfR6T+
 NYDgJ8HtyAY+78YJHT5H15yBBhdfbzd3sRo/bro17fsALRhRHgs7zk5e8uL8ic2rD0MVnTKLA0t
 MVjQU8dSML29SaclVWlLMWTl9tE+wQEEgr7n3M7qxWKsoDvSo05sNP7PzyLIyKjU9N9A9xMYATr
 1i7VgpJj1BbJ+ZQBA5JJEz4cbTxAE1g2z8EJM50hjCuwmGsgyD9xh4C4ZeU4s7TAWNCAxZMel4K
 TJNgqi/YnMJgzsmMdhmsLegaAcft83wXdjU8EjPh8HWU7MB5lWhid9CmhnQ+NR+eciR8tqY6X4+
 dI4U24oWCXtzf36PX2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX4ETpK+yZ/v4r
 u+j4yyzWQrp2kryuqtJJMDT/3/3iTnqFVeSDGgmdcUp5LcBtXwsK0aOfE0aRTZyp+H/ua//0Vl2
 zaJcnlXZKxonFBrf7V5DWqKHRlzEj44=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170074
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

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index de5baf9f6e..590d50fc16 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1469,7 +1469,6 @@ static void gen_commit_packet(DisasContext *ctx)
     gen_reg_writes(ctx);
 #ifndef CONFIG_USER_ONLY
     gen_greg_writes(ctx);
-    gen_sreg_writes(ctx);
 #endif
     gen_pred_writes(ctx);
     if (ctx->pkt.pkt_has_hvx) {
@@ -1481,6 +1480,10 @@ static void gen_commit_packet(DisasContext *ctx)
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


