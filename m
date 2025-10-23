Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0007CCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuJb-0004Px-4B; Thu, 23 Oct 2025 08:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG2-000198-3k
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFx-0006Pe-6y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5BHPc007423;
 Thu, 23 Oct 2025 12:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=H+48uAYpotk2iY/Lw
 YGGOzuF9C4Vf0vGq+/I+DRjh38=; b=CXHiR3fol2XeMcv1fISzqXSXNdmL+YdMq
 ytiVAIZchDN13w0asLwFCe1WmdbJj0TEhEd1DX5/OkjNiGnJrXS3epEiWhMO6/6j
 R1D3jT1Y7xjgQz0Y/UMdxcPbSh9S4HVtzjr+baKnaWhoPGaTc7IyuX6q79xctAqQ
 nsrbAbTXkaxrIl0laBoSIwmKzowc7KvYZl5KAKL3FkJl32e+a+mSiL49KLS7i+2u
 VcwTUXtAwcX8YySEJ8UnnYqeek3huNUSZ6Ukb4mQI7GZb+OAFSR3vtv5Wknmo9Wt
 ZoOuZJoarTyYJc6gmmi8Hvxl9nDZmM8Ff70L9hXD/sROcM/H6gk5A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrgfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8VAFV014663;
 Thu, 23 Oct 2025 12:17:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdttb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHHWl52167032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 302A720043;
 Thu, 23 Oct 2025 12:17:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E71720040;
 Thu, 23 Oct 2025 12:17:16 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:16 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 12/32] ppc/amigaone: Free allocated struct
Date: Thu, 23 Oct 2025 17:46:31 +0530
Message-ID: <20251023121653.3686015-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx2ARMewCPeLs
 avY0LFRWGDuE844tRbPh8mVba6TY4CWLf2bgPe28yohGEj0k2cjdFxmHAl2Ojr5OmvaDUEOwB/6
 BTVuUcUY6rJszYCEkQQQqe2n3zyVRRGerQg5BGvVTo5u89N3xWVKO5juO37BlVBrWk10icKX0lJ
 onDTvQmMYb/gbQZyuaERSyEn2o8XN0ov3VkgsCPO5rBSnShi8aJJCQZ8rgOmhbQXDh7I0icgFLC
 cWs+l0H4HxU3LBufIUv2//EuOn7sBbNWa7Im5ioPZCdmQXVZCmnxyCFccBvLLvu1XfEOtx+HDpd
 qdjql6E7ucvsv3wS/GUfcl3hXzmkGFOlFzpAnkS2OinblxIDxPOcSS9jQgJkc2yV5YvldnQX0dp
 E8ZuRYP2lADh6wl/GcAYl1tzqqFthw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1cd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=F02M0vMrOoqODbYQAHQA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: tkAaiFNnzVUEmKANeL1DfY-RgLXaG7un
X-Proofpoint-ORIG-GUID: tkAaiFNnzVUEmKANeL1DfY-RgLXaG7un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

In create_bd_info function a bd_info struct is allocated but never
freed. Mark it g_autofree to avoid leaking it.

Fixes: 34f053d86b (ppc/amigaone: Add kernel and initrd support)
Resolves: Coverity CID 1641398
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251022211649.9A09E5972E5@zero.eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/amigaone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 12279f42bc..47fb016b4a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -221,7 +221,7 @@ struct bd_info {
 
 static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
 {
-    struct bd_info *bd = g_new0(struct bd_info, 1);
+    g_autofree struct bd_info *bd = g_new0(struct bd_info, 1);
 
     bd->bi_memsize =    cpu_to_be32(ram_size);
     bd->bi_flashstart = cpu_to_be32(PROM_ADDR);
-- 
2.43.5


