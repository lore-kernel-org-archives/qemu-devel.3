Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1424C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 18:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQX4-0007Hp-U2; Mon, 15 Jul 2024 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX3-0007A2-0I; Mon, 15 Jul 2024 14:34:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX0-0007GP-9W; Mon, 15 Jul 2024 14:34:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FHwDgO025365;
 Mon, 15 Jul 2024 18:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=edm0oEWjdHxvh
 UacSEuwD++TTwrmTg8J7AiBBFpDQac=; b=BANCSdhMtfCmeS08614YMyM0f93mh
 jQ51ODjv72OwOh8p7TtggV6FOd+cw8n12Ym6BMplhQpGrSgqQFUs0ETXMlAKalCn
 aQa2YhU5wenKNOztON3JwKh29vl62BbMuFQ/NpYhEe8ijwbfPoKhUKIjpuE0nvLl
 +Y1roYN4RUVp+WQ4YkGhPbcUCGa0jXXtl8g6zUEV/uAQfeBfXjDfNFo7ZmoBwreS
 J9CgjdGTvMd2KbljKC6kd5FYvLROTTFhHfIQdLuxnsSWKmBoMjPEM1t5shV56w2a
 aB0X015dd7TIKLWO6Q5uC9y3hKa7gTSsW1WelNlt1CCjpR6lCqMigR77w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86s83s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYSH0014008;
 Mon, 15 Jul 2024 18:34:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86s83s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FFnZXK018103; Mon, 15 Jul 2024 18:34:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c3wtrhr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYNUY53346642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D45920043;
 Mon, 15 Jul 2024 18:34:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B6EC20040;
 Mon, 15 Jul 2024 18:34:22 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:22 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 2/9] pnv/xive2: Structure/define alignment changes
Date: Mon, 15 Jul 2024 13:33:25 -0500
Message-Id: <20240715183332.27287-3-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VUTy9s4k6SZv1nqPF5pxcvmixJp5RImP
X-Proofpoint-GUID: qfjqXITbyH3ZL9U0k33nMnn84-Lgxuvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=802 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150143
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Made changes to some structure and define elements to ease review in
next patchset.

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index f6a735cca5..5b075a220c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -45,16 +45,16 @@ typedef struct XiveVstInfo {
 
 static const XiveVstInfo vst_infos[] = {
 
-    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),  16 },
-    [VST_ESB]  = { "ESB",  1,                  16 },
-    [VST_END]  = { "ENDT", sizeof(Xive2End),  16 },
+    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),     16 },
+    [VST_ESB]  = { "ESB",  1,                    16 },
+    [VST_END]  = { "ENDT", sizeof(Xive2End),     16 },
 
-    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),  16 },
-    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc), 16 },
-    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc), 16 },
+    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),     16 },
+    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc),    16 },
+    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
 
-    [VST_IC]  =  { "IC",   1 /* ? */         , 16 }, /* Topology # */
-    [VST_SYNC] = { "SYNC", 1 /* ? */         , 16 }, /* Topology # */
+    [VST_IC]  =  { "IC",   1, /* ? */            16 }, /* Topology # */
+    [VST_SYNC] = { "SYNC", 1, /* ? */            16 }, /* Topology # */
 
     /*
      * This table contains the backing store pages for the interrupt
@@ -1722,13 +1722,13 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
 /*
  * Sync MMIO page (write only)
  */
-#define PNV_XIVE2_SYNC_IPI      0x000
-#define PNV_XIVE2_SYNC_HW       0x080
-#define PNV_XIVE2_SYNC_NxC      0x100
-#define PNV_XIVE2_SYNC_INT      0x180
-#define PNV_XIVE2_SYNC_OS_ESC   0x200
-#define PNV_XIVE2_SYNC_POOL_ESC 0x280
-#define PNV_XIVE2_SYNC_HARD_ESC 0x300
+#define PNV_XIVE2_SYNC_IPI              0x000
+#define PNV_XIVE2_SYNC_HW               0x080
+#define PNV_XIVE2_SYNC_NxC              0x100
+#define PNV_XIVE2_SYNC_INT              0x180
+#define PNV_XIVE2_SYNC_OS_ESC           0x200
+#define PNV_XIVE2_SYNC_POOL_ESC         0x280
+#define PNV_XIVE2_SYNC_HARD_ESC         0x300
 
 static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
                                        unsigned size)
-- 
2.43.0


