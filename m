Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C58606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ih/vcAyw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYgV-0000kS-VB; Mon, 09 Nov 2026 18:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgO-0000iA-I8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgL-0000NW-G0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:47 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA2jW436034
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xCZeavMVa7d
 QmMQ+pvbcH3aXR/mR4Pu16uA67DLgOiU=; b=Ih/vcAywBFNzdbaTaJelwRCKEse
 4CWCgaGnz+rG4Khdijrj3R3+xIe4/u0qKSxrV+ePvAlDWOdtT1OUbMOFNDunIevf
 petAx4FsvzKjimZakmTT7x98GBek0N8JVFPAh2f/RT9hazGzpNl5XzukzUeWhswe
 AKz6G+GjHexj1uGlrMrEjbsj0Qjok6E1fqoVjJLeM54s9mMFWiFKHDRdj7KTamnh
 FcNeAicw45InEriQHjTGFPVY8b9hWae7y8G035HiRW6qSXNjNYKAmdYP5R855I0b
 f+E5Fi+YxeVKsu/37unkXHwbxmEv9CcFyxYgfPlcSPPTko0q6f666Q1wHDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjaekh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NLhIN2661046; Mon, 9 Nov 2026 23:21:43 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A9NLhQ42661032
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id E05DC25743; Mon,  9 Nov 2026 15:21:42 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 3/3] target/hexagon: leave stack exchange to virtual SPSWAP
Date: Mon,  9 Nov 2026 15:21:42 -0800
Message-ID: <20261109232142.4081792-4-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: hFKjK5pBg3SDuBkOa-gribl2YvrCF2T9
X-Proofpoint-ORIG-GUID: hFKjK5pBg3SDuBkOa-gribl2YvrCF2T9
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af25587 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=PqpY7W32g4bzf9rcTroA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX7nkEwJ7LAqzp
 O17zBfQ1n77R5KHKFg1pqOY/xzjKqgXpPYNB39LxSwS8ElWs8Jb3xKKwNoqHZEh1L6j97b1qS8C
 xuTyvXwbS3EubufF3gxcWs/keQGsSFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX9VaiPE6FdNi9
 ppz7BbzxT2WPDUJtUiLuee9GbKFST9LZT9DDSjKNalkmbhuilb5+DERUGyT5ZsZisiG3H2wxaaw
 8tl4nPgtsCK49O/tSjHxZ7c7qyDoZ4k9E7jDWHDmVdO+p5Y0DtibPyU4bBY98zd7Tpm2rrFZ7ry
 B+ait4CXJvAx1hdhPQrbU8p2yJMmk6RMnYavTTqiBtZvDGBRvctr7Z8c4nqQafiij3NLrtK4oRJ
 jugtGdZxV06rZX6IJVCNYjWiNKf2Sy+qzI9WGzm+4N41YFZlyuh3R1/siiLEG8V68gvENXqqAON
 n3PNVhwn6bQXARoER1VQBGfU3x2snfKgUELEY39lnnZay/Ooh9y99uAsaV5icgNG0VPAhTHE7Fp
 YaKl52ROWt3ra3nIcdPZgduN1USizIN4ioLTiOt1HYjnq6JYhr0HIr93TMNtB8kjNkrvzw/eCWw
 kVveIhbPb+eEHNw777Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090093
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

Virtual RTE must restore status and branch to GELR without swapping
SP and GOSP. An implicit swap undoes the explicit exit SPSWAP and
resumes guest user code on the kernel stack.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/hexswi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index f22d4a77516..acc68aa6c23 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -831,12 +831,6 @@ void hexagon_vmrte(CPUHexagonState *env)
     uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
     CPUState *cs = env_cpu(env);
 
-    if (GET_FIELD(GSR_UM, gsr)) {
-        uint32_t sp = env->gpr[HEX_REG_SP];
-
-        env->gpr[HEX_REG_SP] = env->greg[HEX_GREG_GOSP];
-        env->greg[HEX_GREG_GOSP] = sp;
-    }
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS,
                      GET_FIELD(GSR_SS, gsr));
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM,
-- 
2.43.0


