Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FD60A6F7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S+WeUZyI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vV-0003Lw-A1; Thu, 19 Nov 2026 15:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v5-0003Ap-2l
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007IP-73
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:46 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJTvXl1112077
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tKl/qEFEO+y
 +kWGHTZjrwg54bY2zAfu7YfpJia+KXyw=; b=S+WeUZyIrRQT+N0BQppDDBpZsOa
 mOTQt4La0NDuPtnifWu3PGSRlHCTgD6WI9ytagCyh78ekOBBYF1ATeivdn0fUj3T
 fFoE+GfepVTHz02WWg59TTa7loVM8Ntlfdcs+CS2ut58CTb5K3/p9NiajskPvqPr
 em6NXyCRhGIiO4dxbAjkCRf8saB66b4q9wq5wallhPyhWRMKtMuX4joztp3yEuI8
 yKIzrvfbK1RlpKPf3kmhMU5svdjs0O6OTs5vJwFjafo//3GxM4cHM6ciMJSle3N5
 QCs7KHnMx4p/b5SQcq+ZXDnvmKZwquCrDZEOQpNdmod/NJZmVdtUTtIL2Eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au0awn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgNZ1670342; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJKdfvU1670303
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 8E9EE25785; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 08/13] target/hexagon: preserve inactive BADVA registers
Date: Thu, 19 Nov 2026 12:39:36 -0800
Message-ID: <20261119203941.899748-9-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX48tzbS6DEYcf
 F978m5ZpsorjvQOL6isirJiVZRousaBBZavXQZ0lkzIgEgeXCjS4uhjKqPNWsTSpfVfMoH7jDIQ
 OalRwg0jbTIkkyZdoGudQ++FQ27qkusmUpcP5taZC1chju15RDJcY0sc4VznhpoNRc6LGuwhi7e
 KyOhD0iDwafg/t1vjwr6a561ptH6w5hL/qDchJTrTpF7xr5k9zqd5x2jQ9U3Wd3IUmsY30NvlC+
 VfFYt9P81wRwy0B63f0wK599+m4SWrklpEu3w8u19aj0lx9LcDPP07uYInAmIYju1mIn/cInL2c
 ZYwTO5ghH3/v75OOAYABFbL0wqxHDGXsFmwOblEsypiGd/4zfJpPB8+tx4SBqvFsnMiNqS4J3Xk
 tMCIBabkW0rXTWIS6svX4UdvmNT8uyn2Ck3plUFXRLYUAFqociQOrHoKg7v30leriiKON033DwA
 IB5vEAM+hlxPXJaS1oA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX3A0IiMse7bDr
 GhPW4vmwqUrLtgT9TlStq33ysD0H9vTos4J5nXVz20sIds0sbKjezj1uH8vObt8fg9J/Y2TCPDX
 X2OgX+arMJPopVHMgKeJ3DZxjuZDjVo=
X-Proofpoint-ORIG-GUID: zPyyJ1VSP3rlGk6q-zpZzll0ZjUJtp-h
X-Proofpoint-GUID: zPyyJ1VSP3rlGk6q-zpZzll0ZjUJtp-h
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=Stv3M7lcxomkFMvdv2cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
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


