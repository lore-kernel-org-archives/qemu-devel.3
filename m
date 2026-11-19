Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD7606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dl9O1SfF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9p-0003Cw-FL; Thu, 19 Nov 2026 16:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9m-0003Aa-76
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9h-0006aU-C0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Tkc095198
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d0kVke999ru
 r6drkLHFxztqnMjHAuMDK5K6ETJehnR0=; b=Dl9O1SfFbUXUrUQr6wxUGeAW1EF
 ecaTpN5ODs/nWuv6cLrRcJQdfQ2OTVoHzZbID5COeQzotcrrq1exDe5Tt6zx2b92
 E63/wkuZx1wqgtuAs+VUhHSjvAuD3USsuJJ4uuO6rEy4oS8qY3Cl7p/jh5hInXfD
 DG2GrFC1ru5batM2ISvMxNuYB19ZekCXLdZnWfoA5pc3o2qrhQW+Z62IZVQAqodM
 SdTEq0SviQ8xcWlpmQdzSGd1KuNSxuJ8kgRFy4wZfCX2/jpcv9lWrcDgxCYvqFiv
 HaTRjRP3N1k3yb5e0tmOI6vbrUQCH/VctAGgjneSOFhJ43D6euPqWfaoY2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1bf6w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLws8b3770711; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AJLwsEG3770698
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 504F62577E; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 06/15] target/hexagon: distinguish packet-page instruction
 TLB misses
Date: Thu, 19 Nov 2026 13:58:44 -0800
Message-ID: <20261119215853.987158-7-marco.liebel@oss.qualcomm.com>
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
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=fbzj6gRIl7KxkdMa5FcA:9
X-Proofpoint-ORIG-GUID: TesJ6rOp2f-QlxststvUjsBvsfI_XUFJ
X-Proofpoint-GUID: TesJ6rOp2f-QlxststvUjsBvsfI_XUFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXwFrOfYW2Pv4f
 7/MrwuCKTELcvhdfzVZse3WZs2ApzId5BPdC0T0xzClgsoVmpmTJbHAWlJPwy41nidgFGuaz9OF
 9j3MUcExBe5UF1tjfGGlRvEDQedC7BWQ1o3qvKHar02urCkD4EXQpFccKlu2FE5FkFJJPLqhdY5
 Q3KJXFQWUk/ozRmjnn8VoMT+7OXgPaP1+/UY9FySbymBfl4RwG4KKi9Nm9o1TvLgteH784hM9Pa
 ScJ4lmcXj2UFm4GBNZpuCu184UaeuGve3Cn6wOMgUuQV/etcArAJ104HNEeXrEGE8EKhwvp2JhW
 1Q+1B26ADMW1qCs4jc9uzhMWAwupboCZydY/DqC1Yojm/0e0WLaJjn9VUQz+k0FBk/QAwojC71E
 LJkqro7+AHW5G6aivgEmpTEElmX591jLO+BPvFwx3k3FK4xOmIKGLEPXXPhXicys87HUj7QySZF
 WpsESxBGsJF59iDYcdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX9OVb9dtEBmSJ
 sgHyWZ7bKqtIesO8c7hn7vVZYYu3py3K+OWCVfLpxnJLaKaIkkyMdYyucJIiocUEH90lbB3K4UK
 9kDtgRl+ol4K0CiCl6vvRswRAI9XeUs=
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

A page-aligned fault address does not imply a straddling packet.
Compare its page with the packet PC page to select cause 0x60 or 0x61.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index effa95534b..1159b0cac9 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -786,7 +786,8 @@ static void raise_tlbmiss_exception(CPUState *cs, uint32_t VA, int slot,
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = HEX_EVENT_TLB_MISS_X;
-        if ((VA & ~TARGET_PAGE_MASK) == 0) {
+        if ((VA & TARGET_PAGE_MASK) !=
+            (env->gpr[HEX_REG_PC] & TARGET_PAGE_MASK)) {
             env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE;
         } else {
             env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NORMAL;
-- 
2.43.0


