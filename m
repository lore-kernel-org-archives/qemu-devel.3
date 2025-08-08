Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70B7C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukK2g-0001Xf-OO; Fri, 08 Aug 2025 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ukK2f-0001Vz-6u; Fri, 08 Aug 2025 06:09:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ukK2d-0006kv-7q; Fri, 08 Aug 2025 06:09:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786QMTM020992;
 Fri, 8 Aug 2025 10:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FbRxD0MUnWtQmCI2DMzs9Zef7L1rf+ezjFRNnz+dS
 Ss=; b=oE/5O9UHD6s+PdyY1KXgM4kNGI/mS1khuUQ2sU8olkGV8mU1wqzPDManZ
 tPzlWQMyh6YEJymRBESRmqh1a7IYos19nTYK+KYeieDVW4Jng+JJQ4631E9k2RUz
 /hL8FiO4j06hnEyG0o8of7RXjAnfj6B9ZlSn0646iYUdjaZP60P0frqu1edkKhX6
 C8iIbmsgmB5bRZr4oWrhYI3BZs4SSv/EqtpZ+xwq4z2q/JzFUx94fAOtwBbQXM1F
 dRGXO3S6iQTC/YRxkY7eNHffdq+uk3CjeFw2dXWus49PkvPB/U9PhgG4pOiRd+lo
 z1dfIymMsp3lD18XzT/kWb6VK6LoQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fcxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 10:09:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578A9Wvf030324;
 Fri, 8 Aug 2025 10:09:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fcxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 10:09:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5786GHU9022682;
 Fri, 8 Aug 2025 10:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqn60n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 10:09:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578A9Qb438404452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 10:09:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A00E20067;
 Fri,  8 Aug 2025 10:09:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E39520063;
 Fri,  8 Aug 2025 10:09:24 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown
 [9.204.207.58]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 10:09:24 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: clg@kaod.org, milesg@linux.ibm.com, npiggin@gmail.com, kowal@linux.ibm.com,
 ganeshgr@linux.ibm.com, harshpb@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
Date: Fri,  8 Aug 2025 15:39:15 +0530
Message-ID: <20250808100917.37006-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6895ccdd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=oGpWkBbS-i_JAY9sGPEA:9
X-Proofpoint-GUID: IxMeTY-7cXxvm9TRNJlwQi6YtkSX_cHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA4MCBTYWx0ZWRfX7gGMLUNxq0Ev
 h7w5H+WHDq13Dd5VPGXzGc05ZKBi8YPgKHSZMYPJcJ4SNvT44DtCfxYkOSQ/H+VMA3JaXq/E7wo
 dI1hRwaeMe8YZ1waAmUMd3mzAzFeqiNb7Dw0iqhMjdxrTheLeB83BNaH4DIXb6MR8Ni24+nO6dn
 6xyfCtAdcH3EKMDd86ijzN5853wYy4gAhuZmvM6bvpvqcOvIXP2IZfeJ8/L9j+/vv5L5PLj5YED
 Xdn/b4Jyr3r/F1HCZodGSVwjxhprrq16wMcYnDlnlySx7qLOhzASDPiWX0ic76cS21zNxetzBlG
 GEx8gW/pVgd//mzjygw9h1fWtZHIH2CwXP/mPUyMkFRtshdBswajqtX/z2fjSbnbijNwYIYsQlI
 0u1wN2JVKKbud/XjIQJ9yffFMsWNERaOEq3qKoBnJCNRGztHEpzWSm7Dd8qnm3ls2tjs9w9Y
X-Proofpoint-ORIG-GUID: tDhdzKhjdTpdhPOPMew2quC0E5o2rfnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Coverity reported an integer overflow warning in xive2_redistribute()
where the code does a left shift operation "0xffffffff << crowd". Fix the
warning by using a 64 byte integer type. Also refactor the calculation
into dedicated routines.

Resolves: Coverity CID 1612608
Fixes: 555e446019f5 ("ppc/xive2: Support redistribution of group interrupts")
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 hw/intc/xive2.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ee5fa26178..90fe9c883b 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -95,6 +95,35 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
     }
 }
 
+static inline uint32_t xive2_nvgc_get_idx(uint32_t nvp_idx, uint8_t group)
+{
+    uint32_t nvgc_idx;
+
+    if (group > 0) {
+        nvgc_idx = (nvp_idx & (0xffffffffULL << group)) |
+                   ((1 << (group - 1)) - 1);
+    } else {
+        nvgc_idx = nvp_idx;
+    }
+
+    return nvgc_idx;
+}
+
+static inline uint8_t xive2_nvgc_get_blk(uint8_t nvp_blk, uint8_t crowd)
+{
+    uint8_t nvgc_blk;
+
+    if (crowd > 0) {
+        crowd = (crowd == 3) ? 4 : crowd;
+        nvgc_blk = (nvp_blk & (0xffffffffULL << crowd)) |
+                   ((1 << (crowd - 1)) - 1);
+    } else {
+        nvgc_blk = nvp_blk;
+    }
+
+    return nvgc_blk;
+}
+
 uint64_t xive2_presenter_nvgc_backlog_op(XivePresenter *xptr,
                                          bool crowd,
                                          uint8_t blk, uint32_t idx,
@@ -638,20 +667,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 
     trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
-    if (group > 0) {
-        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
-                   ((1 << (group - 1)) - 1);
-    } else {
-        nvgc_idx = nvp_idx;
-    }
-
-    if (crowd > 0) {
-        crowd = (crowd == 3) ? 4 : crowd;
-        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
-                   ((1 << (crowd - 1)) - 1);
-    } else {
-        nvgc_blk = nvp_blk;
-    }
+    nvgc_idx = xive2_nvgc_get_idx(nvp_idx, group);
+    nvgc_blk = xive2_nvgc_get_blk(nvp_blk, crowd);
 
     /* Use blk/idx to retrieve the NVGC */
     if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
-- 
2.50.1


