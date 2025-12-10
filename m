Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD6D3E77E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDJ-0004hB-GM; Wed, 10 Dec 2025 15:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDG-0004dH-8R; Wed, 10 Dec 2025 15:55:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDD-0000Wb-Rs; Wed, 10 Dec 2025 15:55:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAESjMW020535;
 Wed, 10 Dec 2025 20:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YdYfyN1blE3v8Gwcb
 cHjd5IQBKrbchD4XH2brVuaq4g=; b=qVRRUagD+pWSkz4xrcw/Xpgt+h+If6clD
 vw8i6ZfjP8OchH/FLHkTINNTK34JgRJVMNflwj2YLMz2RwghnbVtLp1cwHvBjmfg
 lc3fTz3PlgOIHS9ECIZcKMILS1YMQxBvlGbZ4CoIfwaeg5BWFN98/PBY6hM4XQHU
 HTCsPbCSMUIvRpAezwcDXJOrCiv+3dy2Vy50mUlQT2cV02QmOctSwOW4TRG56d58
 XXwpkJI0NzrJBtx9Y8up1BdNdIEnB7RdgP6VuTA+xLzQkrDP+J2OTjnWAsTjITSv
 +fsCSHC8TdzYf6UhjMQysRC/bJW+FQJ5qrhtnaFwIDg6PrEsCHU1A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61mjdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJamil012432;
 Wed, 10 Dec 2025 20:55:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ak2r1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:01 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKsxvx38994558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:54:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4964058056;
 Wed, 10 Dec 2025 20:54:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ADD658052;
 Wed, 10 Dec 2025 20:54:58 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:54:58 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 04/10] include/hw/s390x: Move CLP definitions for easier BIOS
 access
Date: Wed, 10 Dec 2025 15:54:43 -0500
Message-ID: <20251210205449.2783111-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1sPJCzRoNLSV
 Dg9V4Al4VdKq/6NfpBm3L60f0YTTJoeIuOqdnrlhiJGsG0llKlEfmoGqELarHYz6nkbn2/isdXQ
 Yt+2zmpRv8G+VA4duSJ7DDOoeL+2bQnFLFzo2/6JLWpPqY8oI/ZuXzciRPKQyP3cWqwv5KXKLs6
 OMmHxbmHAk94My2r9NFChfBxaS7dqy8BLDzJfGfF3HBc4qTsycyhHCQgDGwbkfBDmTufhTVAraJ
 I6iiNHXUNhTNf2FNfximz5RVJZAzbTeuCFMfp151+cYkCfjXFJrUl0cJxkw8YeQbKQo1d2MwAkg
 63jfga2/42BNsZ795+XlAp8iaI6Zp6KbrHrLLpoBFT0DDlAKXwqPiLUPyv6QvBfnRa82lAFisFw
 6q34fjdcTsPzzht+7jCVSi/IWAZ0Dg==
X-Proofpoint-GUID: DufOk4dB8I8l_Su8axjQu45ROhI--oLP
X-Proofpoint-ORIG-GUID: DufOk4dB8I8l_Su8axjQu45ROhI--oLP
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=6939de26 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ywRehXNDCqtWCsHy2Z0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Jared Rossi <jrossi@linux.ibm.com>

Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
to the s390-bios.  This allows the bios to reuse the architected definitions and
prevents code duplication.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
 include/hw/s390x/s390-pci-bus.h           | 2 +-
 hw/s390x/s390-pci-vfio.c                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)

diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/ipl/s390-pci-clp.h
similarity index 100%
rename from include/hw/s390x/s390-pci-clp.h
rename to include/hw/s390x/ipl/s390-pci-clp.h
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..f643e13057 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -19,7 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "qom/object.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 9e31029d7a..8ce44dbecc 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -17,7 +17,7 @@
 
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
-- 
2.49.0


