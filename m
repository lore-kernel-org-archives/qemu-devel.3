Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830EB606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e93VUx9M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3D-0001Jc-Dy; Tue, 17 Nov 2026 13:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2n-0001F0-8C
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000ox-6y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:36 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGYS2R2743270
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u+GIH82Uwks
 3bHJmDQTrDZnl71saKl/LHsrSdaOn2tU=; b=e93VUx9MQiuSVoNUmE4xZokl3Ec
 TW4xNEomPUYaLfkpGf/KmdFIx8qKQ+SrSVPFFiKIxoehp0WrzfCd+wso50XOWorf
 b+fJjkEhF6VHX+b2JlthbVvz8pifHG8P6fgQ87OEIF9557Jxphypfw9M40QD7sIt
 lgFVlgJb+GCZKv0P3GmNyElZIMHuYbWuo6T5AIMDvaIXnz8WP7Qn6cRDMIpA1Yed
 Z4kalveFqqxIuKbd5+LyLEl5gnjaSJ0bPEX/MTmJ0aRJ/svhGJWxN9HpSIIqsPbb
 NW2QdD+rI7a8gNmvrPUqS8TeiDsDwf5GJxNf6DYNHAoa5LTV5hsNh3tw2nA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tjm0kex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUQu3045983; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6AHIaUvQ3045969
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id B5CD32550F; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 10/14] target/hexagon: preserve inactive BADVA registers
Date: Tue, 17 Nov 2026 10:36:25 -0800
Message-ID: <20261117183629.2002840-11-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX5rgG+hFPoenP
 HlZGCFHp8bRknsa85dcsIsDJO9QiFU9dWuobxXUKDYaPMXf52S2bYTRgVCpR7ZDTAmfRerUi82V
 2ACmR4C2KsrjWVurpdJM1KRXu3sMopc2PUqnpjCIrdRlPZx/HC+2hOb8XT/zrDcBuw7L4ea+IpU
 wjQio0C0lErXHozOYLCYR4zY7g8ckOPNS9P/pIezHh6znAEM/MA4QTM6i1PllevXltae4CMR/YD
 omzOmoXHs3FGq2CzzEKsGF0cWjsJUeO6iQiLVLFWJkZxziRoMhbpvKZkR2uFvk6ma4bknPvXPSC
 nyut4oCPxpQMXu4g2DxKsPabIE+I6MhMwUN7CFxbFY1aTLkIF6QSv+bpOEQwsmElu9ce6CrZYCv
 MjipiE/X89+LihpY/XyNDcRygGR4Kl+896lErcVr7Aq5WlFAgLmr03a0zgIzrKVPrhwUSap3ewp
 bYWkS9ZikBOg7/552xw==
X-Proofpoint-ORIG-GUID: cU2MV1fSpjbu0huHK9x9xMsL2zFgQjg7
X-Proofpoint-GUID: cU2MV1fSpjbu0huHK9x9xMsL2zFgQjg7
X-Authority-Analysis: v=2.4 cv=Br8IUoX5 c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=Stv3M7lcxomkFMvdv2cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX2PZhyrdyFgla
 ipnZUgdZ8mu8MGpRvRF4yVPGfsHxkyY1qRzqTNML02h2NWr2pR5oSdA5UqMRtnBWw1W1z4iu/h/
 x0vZJKeST98PWxp+HfyWBluRZFN5FP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Clear the validity bit without overwriting the inactive slot address.
Fault handlers can retain BADVA values across exceptions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index af86dec7dd..77fd8156ed 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -750,8 +750,6 @@ static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 }
 
 
-#define INVALID_BADVA 0xbadabada
-
 static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
                            MMUAccessType access_type)
 {
@@ -763,8 +761,6 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
             if (valid & (1U << i)) {
                 env->t_sreg[HEX_SREG_BADVA0 + i] =
                     i == slot ? VA : env->mem_access_va[i];
-            } else {
-                env->t_sreg[HEX_SREG_BADVA0 + i] = INVALID_BADVA;
             }
         }
         SET_SSR_FIELD(env, SSR_V0, valid & 1);
@@ -775,12 +771,10 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
 
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


