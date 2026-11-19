Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213A606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jc5+WIBx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9s-0003ES-KU; Thu, 19 Nov 2026 16:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9l-00039p-7T
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Zw-SS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Rea1671581
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5dva35PM0dn
 hdrmFSBWAu6N7kmor4hMyiOzEwZtKI80=; b=Jc5+WIBxXLuQMRk47h3G0mzlkzX
 vJHVQmlOlUlU+/9+yXEa6gNtg6Qfu3D7c4sBEdsumKwe9qhcDaoebtYiSuzRzofu
 GIU+JfFVtcOfRLPjE0aNrxn3q5nZ2iCZ/cQw6Lirk2/LIrPaelVO/k91Pz2NiRYK
 fMi9m3KaxlNtUIeDkRLkM93BuUFD5xQd6mGejmzxu9OhWdaRgsRTuhHAEuJFrAK7
 o3XcdSJD/u0gH5IHGpPBY97lTJjzgvndnNqALw7wG3/6IIdkzRXb9Ebj2rOMM8uq
 cHlTSE/gjqbYpnjaUxxNIaYYbdEB/APJD350PGRtCOekA8AyS4IdSAicYAw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x70bpuh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwsma3770712; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AJLwsJn3770699
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 563BE250C6; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 07/15] target/hexagon: bound packet lookahead to the
 current page
Date: Thu, 19 Nov 2026 13:58:45 -0800
Message-ID: <20261119215853.987158-8-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 8CJ6db55jh6Yzh0kww-kTJKWxbw4csff
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6aff711f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=2ZaAnrbsLTiuA5g7MksA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX1kd8vlSdDf4P
 wcfMtMVCrBWWLKYKfrvT5FlIOMGBo1+YNrxPVSvocCE3dPg+ARQaGBXJSab8rDla/+HpfpS0u6O
 7tZ4fMMuTCLWz1ceojDNl6kWuTbeZRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX6LuN87E1ty4V
 JsEtHSQj03JUWw2fS8NbRQ7D6/ddgosvioFsMSVHGlZE8Kdh2+hdqk/A9tIqSiBmMuXrs/n96uT
 vvvt3tOaD1nBw048lkI3acjiZETYZBQnC207ZUnCTrYgyXZAbWRN9C0NZAb8tTyIh6ZGR6EAVRR
 DfCILljDBHrT+H17rhI2QPM9fDSljcwOpmqwjQz8HJY/g7TlrTMRsMorUnLoQu1l/l+a+EO0X9J
 2OnNADxekiR/eTYgoA3oiONA0YqVzIdZoi76wm+BktMTFHj/E8HVMdi7xpHd+WenBL2lMtwmT85
 DZXNZh5Ypp0Ziz2555CC3ejkszQTORsj7+wdfPC6rS4tI0yJ2wraRCypifK6KePEHs/ritBKGpq
 2pB8z7sKiu76nHkgXkeQ4pOfv+V8jlSlvP0vv3vaHNWSdqclde8lmg/XbmoHJ6nKDJnfxN31tmN
 lkftqVvCzHTx0e8CD3g==
X-Proofpoint-GUID: 8CJ6db55jh6Yzh0kww-kTJKWxbw4csff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190088
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

Do not fetch an unmapped page while deciding where to end a TB.
This lets complete packets retire before a straddling packet faults,
and preserves the correct packet restart address.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 220328147f..73676f6346 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1653,6 +1653,11 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
+        /* Look ahead only on this page; a fault must not discard this TB. */
+        if (ctx->base.pc_next + nwords * sizeof(uint32_t) - page_start >=
+            TARGET_PAGE_SIZE) {
+            return true;
+        }
         uint32_t word = translator_ldl_end(env, &ctx->base,
                                            ctx->base.pc_next
                                            + nwords * sizeof(uint32_t),
-- 
2.43.0


