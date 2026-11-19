Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63F6074339
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe5g1MQ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vk-0003N2-I5; Thu, 19 Nov 2026 15:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vA-0003B9-1X
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007IY-Ol
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:49 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1L8Q373665
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WfEpdar0kA2
 13KLzSJxLmMtq23Gd5/8FW4eBSEmojFc=; b=Oe5g1MQ3XEIaGiMaHmKTJsbgQAW
 UuwaQV7kxWY3RYsKJDjv8BOzZmPiL8nAbSMryu9WGDMSPhCtyKjmuwZP9ES+STkl
 W8e0BnVYkguH50mEDDGYF/a5THJwL4xOAOHVykFpg/sI6XgZ6pGpDZl8PlfmjKnj
 vpN8ZQDX1HV2KfoVMIgT5hQSs7Y4W7KiuNU9PTy1MqW54U3ZKWbXquNFcd4XX+48
 x7XzNeLlClVYcuZH93YbK/o352KdQic/x8TraBYbrLPSSn81QKKelHWe/o5S3MDD
 Qnd5WIy76QpcDB8B85ViI6Dzw6zQkP4s8n4ubRYwvVNSJvnSJUAJvrnG5yA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymjyjk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgbH3657757; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AJKdfar3657747
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 802B82577C; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 05/13] target/hexagon: distinguish packet-page instruction
 TLB misses
Date: Thu, 19 Nov 2026 12:39:33 -0800
Message-ID: <20261119203941.899748-6-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfXwPuh/+7/mplK
 lbTaHBqG169hd+e+O2lKegP4E+VDLnQLVcAF77sWNncyIG2NFQtJQnZjwFTs7NNRwRQ/8jx7Pca
 pbiwFylGtpMe5r8UAmAov+Z/7AXuf8E=
X-Proofpoint-GUID: PXM9o92oY7H7KjdL41vravgtvUQSe29I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX30gVJ/XPd7Lv
 CnUsNvcHs+CJOF3OWKkWMPmBrc9Y8qw7Xfg3LKFQyOvFG0bOUsFpXhOLHTnAKTPwQ5sxqehw8UW
 +DYH0p2JqQVb9bS89D5r970u9oLUMN6gZYMT3bmAV0jKxQP8EPRR22R/VAS5mmJKEPIlCSEDLnY
 HawoPOywuoG24v87r5Qz+slo979DvQEwMFw933Mt/+aM9siV6nnYxOsHegWg3HCNVID/VYq8Oma
 CaHYtogOqtIKS0mfa8taDnhKNgrkXG5zxfHMIPmJsmFMLEyqv9ZIn9/vYTMpzt8kjrbmeKivLAA
 +df4PlRgUtHKyOM1Vxa4JuImMYVrhuol9SFj/muxpVLAKBKjfHVP7wjIEBmsJHFta17TuznDgVD
 m7MfDthtX1l9AS+WchqKgr/bj/u/NaC4E2DwbX9b45qdGveusdD/ztBtTsNUM8XDfC9wHf1mQOT
 sW4Ein9xO8mhszXmG2w==
X-Proofpoint-ORIG-GUID: PXM9o92oY7H7KjdL41vravgtvUQSe29I
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=y542WfLQcSmRoA_04BIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
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

A page-aligned fault address does not imply a straddling packet.
Compare its page with the packet PC page to select cause 0x60 or 0x61.

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


