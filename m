Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEE606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A9hogDsF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYgs-0000vN-MH; Mon, 09 Nov 2026 18:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgR-0000jl-9y
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgL-0000NY-Jc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:48 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9uAF2018001
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QQ3EIShBYoX
 wKEi5zvKVixIEIPkTwKD90vth00Rz6BE=; b=A9hogDsFCII8ajFu3OdeVGxYu7A
 myQOoJzcYCERzdb/Q9omXvExXty4+fE0uBiNrO3GUkNq2Ew6ZmCxUpLzUezx574E
 tYCb5Xop8bnvRe88KL1drJ79Kxn3CBRuY2gy2s9+pzhZReaRhXAa77wT3puBb2tK
 lgInCHqR71YJdBKRxw930Ne3x4PWISFsyHBG7rs6YkZ6Y0o8GLH501OrdRQMh+sr
 QW37bRHCfbQCiqiioQxovHxolBPFNYJxUVEM+ZGNPDSTqKF/OsOFdqCGqsaREDbt
 i/NweVsFVAi0aLOs/mUiLSAEyCmBXmXSCU0ElqA1uUgd2X0n2ldVFJz2PqA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg0nt1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:21:44 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NLhAf2661045; Mon, 9 Nov 2026 23:21:43 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A9NLhC52661031
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id D6F3720E50; Mon,  9 Nov 2026 15:21:42 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 1/3] target/hexagon: preserve guest event fault and CFI
 state
Date: Mon,  9 Nov 2026 15:21:40 -0800
Message-ID: <20261109232142.4081792-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX+IhC14NNcKvH
 LVNTuy3COgW8ykRi0n+zyWUZK4q53yKcHWcSAB/KIsQHD7v96vy7+aWyAFO2pWGhZv7XsjP4+M1
 w1gRD1FuDtXRTZmEF0DzigS1PTykvaTVSUwYC7cwiZRiEdZq3cAYQuK3ULdtys3Mygvuj8PVCRY
 dQZFuDP39yOuMy0K6iaR4TyVJ/D05IiQUj8aB6rVVZlYzRNS7BLsezUfcqZHiulNdG2W+hROa25
 bQlei0/Oov1kXpkEhBw6UZaMel6w9jWXshQKEgydVA1G/KRL47azS/CdFkM8pd3rCT/7H3Ntw9Y
 RAdzHyuO4vwQk0AbX3Hvt1XKVzRPpwSZAyygoh29AWlVvb1IlDwDy6SAR8J8pqCjtMsMYoqskPp
 mR7PM1I76T6fLOBmtj/AvK51Bzdky1fg+slEgrjJ5spdGOjZY4XXJ8PACIRWBm3EpDjApLLNMYA
 WSgtC/M+XHvY8xuvAtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX/MZFQLc1KggH
 XWT94cUfRURG7pSD0vFttGjwRU1GZo1qlrge7r2CvxGoj2lINn895LR6t5ADxKvjGhMoyLuV1cN
 PE5cqE6ZEHVwgDlpEHsMpJmNLwrf+IE=
X-Proofpoint-GUID: wlfEwVd1pl6xXG6nLEtqpVyP0pS0RGYh
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af25588 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=MTNzgN7s884OyKAPA0UA:9
X-Proofpoint-ORIG-GUID: wlfEwVd1pl6xXG6nLEtqpVyP0pS0RGYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090093
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

Guest event entry must select BADVA0 or BADVA1 through SSR.BVS
instead of copying the stale BADVA array slot. It must also save
SSR.CFI into GSR.CFI so guest return can restore the interrupted
CFI state.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/hexswi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 663d9fe49ea..f22d4a77516 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -809,6 +809,9 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
     gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
                     reg_field_info[GSR_IE].width,
                     GET_FIELD(CCR_GIE, env->t_sreg[HEX_SREG_CCR]));
+    gsr = deposit32(gsr, reg_field_info[GSR_CFI].offset,
+                    reg_field_info[GSR_CFI].width,
+                    GET_FIELD(SSR_CFI, old_ssr));
     env->greg[HEX_GREG_GSR] = gsr;
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS, 0);
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM, 1);
@@ -816,7 +819,8 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
     SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
     env->greg[HEX_GREG_GELR] = event_pc;
     if (set_gbadva) {
-        env->greg[HEX_GREG_GBADVA] = env->t_sreg[HEX_SREG_BADVA];
+        env->greg[HEX_GREG_GBADVA] = env->t_sreg[
+            GET_FIELD(SSR_BVS, old_ssr) ? HEX_SREG_BADVA1 : HEX_SREG_BADVA0];
     }
     env->gpr[HEX_REG_PC] = gevb + vec_offset;
 }
-- 
2.43.0


