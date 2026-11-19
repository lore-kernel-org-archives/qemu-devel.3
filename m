Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96819606B74C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cddWjgn6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8w2-0003QC-M5; Thu, 19 Nov 2026 15:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vE-0003BL-KH
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vC-0007LP-9n
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:55 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXx03367478
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H7snRXnsDEQ
 o2A4oQdNti29KXhzPkxkFULbOHBbGRDM=; b=cddWjgn6ZpocEJk0c7DEFNb7C+6
 JvAbx8aMiyWn8cJymF48nvyqYxN7dOYANysUnisAqNT/x8zYmk/txI8+YkQvE/7O
 fiHE2GEewau4kzY9dxI+oIq7RgDba8D8Ottgfotq5Mukq76cBnfMGj1b1jU0EMo8
 EwfsolzbAjrl1riZCU5LhgBvY/xir6WpxhNLHVDEYnCWp5rq44yF75Kcyc1wjKTp
 6LbUh7v5GlJYg9dNjIhmEAAQDnFP8tipiwhYbwhLUepau/oVqRMyI92xcEJC/rC6
 7uXqqF0dGlxgkN03DN5S7FM/b1RIyLATPL+W6w7ac9QROeMbRwhCTMD1Pyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5ra7p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdfrM1670316; Thu, 19 Nov 2026 20:39:41 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJKdfhR1670297
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 7B9602575D; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 04/13] target/hexagon: commit coprocessor results before
 context changes
Date: Thu, 19 Nov 2026 12:39:32 -0800
Message-ID: <20261119203941.899748-5-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX011x7u1ro6BI
 PpzDPWzWf+mCg/iEBlIil/4w9wGbG7FgVsVZri7z5TDSK1yhoV1y85b9qfs6bPyyU5XFQrviyCr
 6cUOjCM0m6w559hSzsol5GQcmTwopd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfXy/+DlTYgK7go
 iDV5pfS0ifVxCujDrzlqZCZGa/wFMvnJv/MRpd32dMRt1G6gWaqIC/MXPW224wuBrnuTcMOlmbA
 suuJmqf39VvPQoN7fIWkXiNcIg1yGWrtIR1M8dBJkY0D6mQrfQepP3i1M+1uOtpsIDGuoFi/Wn5
 kV/Ygbsy5j1Z0jRyWXdrGeorh4I+uieDkfzE9n2OeSaUgZGIObmhDPXyCUAAGn79sxvUd42ny1D
 08fEo+S2fyb4PNU/V6iwHy7+H4+LuSspN1bvL5c1T5QfsOh6PZHhXQywtxCUG6xxvz+iH4qWioZ
 mBqm/FGH7Tgw5AW46+B/yb4f+yb4GPHu+tgnYh6p3xedZtbf7t57+Og0Pa2RayWvwMlyKMF/kQQ
 WxDyW0oYamUY18B990ShqhAWS5kqi1pL+A3AzI/qkKxioQgXWfuzFmnLEoHYY2lYbYIXMuEFFNl
 n3qU9wR58mVVSEjaDfA==
X-Proofpoint-GUID: OTf3hM9jcbiXpUTDlLW8lTNnwH70kaKn
X-Proofpoint-ORIG-GUID: OTf3hM9jcbiXpUTDlLW8lTNnwH70kaKn
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff5e8f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=2ZaAnrbsLTiuA5g7MksA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190082
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


