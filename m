Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D0C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulNI9-0004Zl-Lp; Mon, 11 Aug 2025 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ulNI4-0004Wb-3n; Mon, 11 Aug 2025 03:49:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1ulNHq-0001TI-W9; Mon, 11 Aug 2025 03:49:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANMQ2c009288;
 Mon, 11 Aug 2025 07:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+Mxb2L4BWHpt3YmM5OUzWtGuCi64HkvbBfoMl/To5
 vQ=; b=cO9S1m11QQRjRdHBdB51HuD9ak/GzA5bXyRhpHX4/lW83gdcygxqy+USl
 uom6cwOK76kpVUISFR5JG55slA8v88oiCApbP1kLgmfl5yUgJkFPXoMXg/PGrgSy
 YTknQd8OvUIwwtRCxElwVnJ6/pvwtgsZ3Rjv8MBhu2n/LNon6Oqxf4y5sog7nSWA
 0BTRCaxomPzIkYFvC3qGiT3ooYeFTfL8M98fTai9piDsPQ83zzaLws+ulalBrdyd
 bdsJ/NSkqsqQaXS6zxanASUGyjXCVXdG6I1BNeCqdWGLZgc7OQb9l1c09wZH96F9
 RzCvnlKvZKr0dbJxIqRu7DxqTfCLQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14839b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:49:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B7cee5018959;
 Mon, 11 Aug 2025 07:49:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx148398-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:49:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B62jaf028674;
 Mon, 11 Aug 2025 07:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5mvspa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:49:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57B7nOD516449896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 07:49:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E0202004D;
 Mon, 11 Aug 2025 07:49:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7632020043;
 Mon, 11 Aug 2025 07:49:21 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown
 [9.39.30.61]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Aug 2025 07:49:21 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: milesg@linux.ibm.com, kowal@linux.ibm.com, ganeshgr@linux.ibm.com,
 clg@kaod.org, harshpb@linux.ibm.com, npiggin@gmail.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] ppc/xive2: Fix integer overflow warning in
 xive2_redistribute()
Date: Mon, 11 Aug 2025 13:19:11 +0530
Message-ID: <20250811074912.162774-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ksAxpKdVTalDbGVCpFHtvlcOlySjlYMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA0OCBTYWx0ZWRfXxfWkY3IdXC41
 +udTzEd3SwlRpg8iS1E4N9ILQUh5M+PtNj7J+8MxuoELUjtbMhmHSRUSI9/JBHRdRDtlGUSucXo
 t/N+B9XypWSuqm6weHL/5Jmsz40BIsQjEadKayNf8Khp5O4TGm/kE0OE9mollbhEkY7YFimvlaw
 xrlAHAZ6JmxMUGT6HvPu1uWy+rJ5JW1xr+CPCDkmAj3DRvn2UUzC4J+zCivBVkI/DKyIouqbcsC
 6GfH7j1ybZJiCQ7d8BOwetk860W7c8eUwWB2rj7jBiquYdTLjvH9W1HPQSdovvM07QfvWqpyGO1
 YeXRPjagmO2T/je+BGpxQoT7Vikl72nAPc8FzAZYLEjgAN/Y0n3S869EwvwGJ3xigd0+IrdPqxa
 9Kc8bJLNu/GOO7vswD3c/5hwum7A1HMfXwZ8b3soGcMY2myjuNIY//A3hI+AeDhG7O2qoEpF
X-Proofpoint-GUID: 96QSvNCrbLM6k8V6OE7mJmRvBeL66B8i
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=6899a08b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=oGpWkBbS-i_JAY9sGPEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Remove inline keyword from the function definition (Glenn)

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
2.50.1


