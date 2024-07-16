Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81315C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToIQ-0004PK-3j; Tue, 16 Jul 2024 15:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIN-0004JZ-KJ; Tue, 16 Jul 2024 15:57:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIL-00068V-OL; Tue, 16 Jul 2024 15:57:07 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GIxIdR014289;
 Tue, 16 Jul 2024 19:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=3s9zklv1tTdzR
 PVfQIyUZyiA6z4dJEEsELSPcU3KrDA=; b=oY1kE3r53jKJWxABiUAzAfc3t0Nxf
 FhP+w/vBmIalX5/sYzVlrKNp+8EnAVnvFXeZWIVJQxNAIf/i+DoRVHpr4E1XKr/L
 Mexv7J5bVWtiTNqIxhTpz8yoy7tl6BWrFK40sJBp7NB9Ggb5H7NvC23gZxTr9HGh
 /3k1ltnompl14djS9kMiB7L4f/YpvfZrBXyzZwIOn1zX1XtEcHjmH1Dp4n6DNJiY
 4R0ixqBPQavnsfQhQmxLT5iCiJ6BYPl6UVs5ETTpegfMpJAxV6qpd8BKpnbnUg27
 88w4aLgrBotykKMI5u9O0CJj+vv4mLO2IEeJoDRT7DNAqEQk6uaUgb8vA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dxky03hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:56 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GJukTN027935;
 Tue, 16 Jul 2024 19:56:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dxky03hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GHnCmm006122; Tue, 16 Jul 2024 19:56:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkm8g9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GJunKW53150044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 19:56:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8A422004D;
 Tue, 16 Jul 2024 19:56:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96C8C2004B;
 Tue, 16 Jul 2024 19:56:48 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 19:56:48 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 2/9] pnv/xive2: Structure/define alignment changes
Date: Tue, 16 Jul 2024 14:56:26 -0500
Message-Id: <20240716195633.12679-3-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1NYGU4WOFdTn6GkOfRz1yo7IAIup5gCZ
X-Proofpoint-ORIG-GUID: yWddUbjyj5DH_wkxr3NYvCt-mlRhyY6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxlogscore=802 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160144
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
index af9ab68fc6..08b6da78fb 100644
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
@@ -1720,13 +1720,13 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
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


