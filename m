Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FEFCAC5BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3e-00034W-J1; Sun, 28 Sep 2025 15:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3P-0002uT-Cr
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3F-00047P-SB
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S3TCIv005829
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RBhrO2lKUkGFES6TD
 II4rcIjBHGWNLUSU0r3LZTcFtY=; b=HyDhUi7lp34XJSklxJOTvCtB0ldRBwfCs
 kiA6ZiMASlgEcVc4uXRcHrmoY5nL+fuQU8F6SLnyo4EZiulKhdKKLOAJSEx+7Mew
 1AOC/lCaitfnjl9hkzWy5GxnhdneXqS4NQdvpC6ehM1DsQzUXtq7gTB4/oRN9AAV
 tlFgNMBow1VpCSrBDJdBj8B8WMB7LQUdjVVO7ZYMjA9WaSnumtw4LywMwuRaRmcK
 6WLEdZvNUfFMsK4fFxKkBlImXa+oRnb2qO8pj9lTBisArG04Vp0wPYOgIYrBBOFf
 pk86zYOY3BiC6NwtrbhR4xX7C7LoBkwhwmQx5ZzODT8jg7mG8lzGQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6xpej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SJDHbL001569
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfhtmq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJR7IK30540226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888D520040;
 Sun, 28 Sep 2025 19:27:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 559F820049;
 Sun, 28 Sep 2025 19:27:06 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:06 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 20/27] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
Date: Mon, 29 Sep 2025 00:56:22 +0530
Message-ID: <20250928192629.139822-21-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KL5sU38Q6V0rRR4O6JI-sEW-vR4dM2Wy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX3HAHNQNjHEHf
 boE3kAhW0r4iXoSNCIwfmF6PKkZR/9d0zIb4AU5Rsr5kxBj7aW4a01t2MAXnw6HH2LE4yBLXQfI
 X6lDT8rmG/zaRxJkVpYQHrWggzZSlZBRX/yty8YouP4J1osU5ZQXW5A4qxLAwZetpE8xI8pG0L9
 EG9Oj/aeOy2XInZt1vx5Tx0LHivEk5JEvHUTPHaCVIOumE5ytItZVVOEbv5Tnxr/NCgmpUmXvco
 LlB+omv6FZLF4b5pxcDo43/QIpb1ejt/P01ModsDRdYSJS3px3BRi3mVbY7SvFt5/7tmJ8ERzYk
 GZkbpEu/HXk4waHh0KXE9I+k8mpdgrXvFlhBrEGcLWHkx3HgnOP/QN81mRwJAoY5LGamn9WB03F
 8TI53K+/sQesPNcGbXGRod81BuyKIQ==
X-Proofpoint-GUID: KL5sU38Q6V0rRR4O6JI-sEW-vR4dM2Wy
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68d98c10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oGpWkBbS-i_JAY9sGPEA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gautam Menghani <gautam@linux.ibm.com>

Coverity reported an integer overflow warning in xive2_redistribute()
where the code does a left shift operation "0xffffffff << crowd". Fix the
warning by using a 64 byte integer type. Also refactor the calculation
into dedicated routines.

Resolves: Coverity CID 1612608
Fixes: 555e446019f5 ("ppc/xive2: Support redistribution of group interrupts")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250811074912.162774-1-gautam@linux.ibm.com
Message-ID: <20250811074912.162774-1-gautam@linux.ibm.com>
---
 hw/intc/xive2.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ee5fa26178..fbb3b7975e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -95,6 +95,35 @@ static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
     }
 }
 
+static uint32_t xive2_nvgc_get_idx(uint32_t nvp_idx, uint8_t group)
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
+static uint8_t xive2_nvgc_get_blk(uint8_t nvp_blk, uint8_t crowd)
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
2.43.5


