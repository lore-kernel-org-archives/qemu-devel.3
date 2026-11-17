Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDfTOERv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3D-0001Jd-Ep; Tue, 17 Nov 2026 13:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2o-0001Fh-Fn
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000on-8L
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR4Gb3503943
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=L22Tp4UFbv7
 hX5xZUcefJiuVvjdXCP5dfdEOLDxH2Ig=; b=IDfTOERvGVIO3LuG6qS6RifDDTC
 pBnYhbQt7plQKbYjkeHTwCNDROQFx5ffXQzaqtpykG+GDTYjvSYyg7iy/HDTx9cv
 PpFzO05fww5d8wAHFtuYSQZut/pxjmDLm9BgKW+s2QWHxl1q01Pahi4Pv078sQjF
 mdN20o4joidVeVOdZI8m/gN1B9LEwltwHMx9HETyvgiKt2D3utlf/0kG40KDyZSj
 cDclYt8bRv1P8/mWc4gpoWKikIITs4UYWraLwLML02Txgks0b/LLTzPI21QmE2zf
 DxCuAyiySt7LUwQq7pixllm8lk9fYe2MnBXCb3B9qGagCcGCV91ncjK8Azg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv125f1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUCi3167783; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AHIaUnu3167744
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id A98BE254ED; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 07/14] target/hexagon: bound packet lookahead to the current
 page
Date: Tue, 17 Nov 2026 10:36:22 -0800
Message-ID: <20261117183629.2002840-8-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: Hglm_P1kQ03uUPnxIg8GmjcD2ByAfefW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX2lxn8YmEhjzI
 UaFhqy4ud44dAgrCDPIYMH24SRWS7dLxwDPACGULzK7EEaJiHk7lL8FKzzvdxplMPCgP5JOqUsZ
 HJ7K7fT2U8wZpmfEwIp/TcYv4AdMWM4=
X-Proofpoint-ORIG-GUID: Hglm_P1kQ03uUPnxIg8GmjcD2ByAfefW
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=2ZaAnrbsLTiuA5g7MksA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX6UPXHa8kqchC
 DhDXMN/pOeesgwv/APVE4bKGGK0gd6euZiNCYwpQczMcaZKMUQ8Dah/QRGCQVzfohcWF7tJsQxv
 jxTD3fdU+9eLaQO1cnF3inuyXdh1s8YB/ke5piCWpn4HZ258wndiQ0XR2PymugteY9r2vdnrhqj
 gJoI9KqH0k1s2OrZFk//jQsgLFSx8jUiEuQoB+bf1dl4qUyOhByQsjh/fNgjJm8xSi2pIHOrMig
 8XSzEtuIPSIV5d3HqEYoU2HPzzIoNfcuv5bOG3YrVFefO2OHBnUZv2338flqG1xxCZ5rGw5EQW2
 zfZwwoTe0aFOWdUYwla8JejQk+t3yyzv52R5pSBjeZN7Hy5NTMiNXRLZwOgXJEkTzbvbeydl4zj
 6p7aaT51veVfkqesIh/ywvcxY2i3O/InBPkdYZ4GDYup7PN2Sau04oD1VHNm8cS8hHw/u6FSBOL
 r8s0tLMGYfZRdCGtvTQ==
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

Do not fetch an unmapped page while deciding where to end a TB.
This lets complete packets retire before a straddling packet faults,
and preserves the correct packet restart address.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 590d50fc16..a1cb9da134 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1638,6 +1638,11 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
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


