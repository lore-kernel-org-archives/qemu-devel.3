Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8353C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180d-0000Lw-5l; Mon, 31 Aug 2026 15:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180b-0000KE-Ru; Mon, 31 Aug 2026 15:49:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180a-0002cf-49; Mon, 31 Aug 2026 15:49:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVldh3108193; Mon, 31 Aug 2026 19:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=w7fFMiPAlJgF2NauW
 3RN6HQ4hoRl3Il3UO0MTyTfzNU=; b=WnRP4jWJH1TqnQg3bcf2pOUm73EJvqm47
 g86nOg+qqFP5qaCIfnoDs31jgfrWHmd1WBct8JDZE+laDvJ5JPsrSal5IERZ+9kG
 0YqLRbVteIZObE1ImzP2EbRQ61VmFhGJVyUIPwClHDF0yK9xvPFZ4a18kVj+uIyV
 dUx7h3srZBF/EIuADPvSq/gPd77lt3o/kFXBSCUD+jV8FkgbU87Xvcmd1IEqjH5s
 F8OT8BPmqLVT3/gkbDUDv2ZHJUexMc6oCl/PGsaswjCVo3n+vzp7NYB/YR5+vKJ9
 gNsECUUehQQxnmpAscKJEXkuLerLWVtEWz3FKLb+npvC+zz6Mz/sA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54kgu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfK94014187;
 Mon, 31 Aug 2026 19:49:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7pxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnRcv34734806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A89CA58056;
 Mon, 31 Aug 2026 19:49:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2289D58052;
 Mon, 31 Aug 2026 19:49:27 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:27 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 4/8] s390x/ipl: Add PCI and bus fields to IplBlockQemuScsi
Date: Mon, 31 Aug 2026 15:49:15 -0400
Message-ID: <20260831194919.3830270-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfXyBSiimvZWhCy
 LHqvkCMZH1eYurHUjMcLoLcavbF0pzLoaPcjXqFVFez9DlY2J6JTmAlTr0lZrIYMX2E+0q3JQkx
 2yUkdJ5JUXUjpsu6XHrPaKMHKZVVX7QOLcC1mg9d9A4Xp6uTZ+WLF7jCE2KDMBra1PhDvhvoACf
 azgPg76GZoe1bhIUnurLFs1EsKJxoogBNUvv9DlIRaBjIA6Se7b75dPGf2GQxRP4Rz84fIpBt2h
 P0HNs2zIySb9zX1ytkkCH5ZscLH3NIrOyhynVE1KNAeg4/t/Mwoem5QIZPvG2aTZYPKUfBJvBHe
 uL2RaDODg5TkVb3rTMJzMf4WCTYJV2BDyk0IUzIdEx0OzcDolhT3w4n6nG5OWGXTMfOlVNsGudU
 w8aev7XGS9WdXeQq/KOGDdzFqtRE7dLLtm+59l7ILFcgq261aUyZMJ5zSWVtIQY+qLwOEnnF5/5
 uw67c77S0HRXOG9PGXQ==
X-Proofpoint-ORIG-GUID: spv5-OzN2HzRR2esB3V7YL5O3TBVOOVG
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95daca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-QlUfH9WTwOXCv0RR1sA:9
X-Proofpoint-GUID: spv5-OzN2HzRR2esB3V7YL5O3TBVOOVG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfXwzSHvmD4Ku2N
 3GOMwmyy2mjHqfYDNkI/phH6W5Lzid2FrcSXLy6r9Mz0QXlCDZYUnflvhg+9APf5rbFDLnshnlX
 WfxwbFD8Lzzis7sytUMGYuVDl9060Sc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Rather than add a second non-architected IPLB type for scsi-pci devices,
let's add the relevant fields to the existing struct so that it can handle
both PCI and CCW scsi controllers.

The PCI and CCW fields of the IplBlockQemuScsi are aligned with same
offsets as the corresponding fields in IplBlockPci and IplBlockCcw for
potential union access.

Add comments for PCI/CCW specifics and also denote that the S390IplType
enum values must fit in uint8_t.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c              |  1 +
 hw/s390x/ipl.h              |  2 ++
 include/hw/s390x/ipl/qipl.h | 13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ba69ee89bb..6969e11b27 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -563,6 +563,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->scsi.lun = cpu_to_be32(sd->lun);
             iplb->scsi.target = cpu_to_be16(sd->id);
             iplb->scsi.channel = cpu_to_be16(sd->channel);
+            iplb->scsi.bus = S390_IPL_TYPE_CCW;
             iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 772566bb11..580f42aa4a 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -86,6 +86,8 @@ struct S390IPLState {
     uint16_t devno;
 };
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
+QEMU_BUILD_BUG_MSG(offsetof(IplBlockQemuScsi, fid) != offsetof(IplBlockPci, fid),
+                   "iplb fields misaligned across bus types");
 
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
 {
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 69b0023ea3..e733c6ce31 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -29,7 +29,7 @@ enum S390IplType {
     S390_IPL_TYPE_CCW = 0x02,
     S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
-    S390_IPL_TYPE_QEMU_SCSI = 0xff
+    S390_IPL_TYPE_QEMU_SCSI = 0xff /* Max value, must fit in uint8_t */
 };
 typedef enum S390IplType S390IplType;
 
@@ -123,9 +123,14 @@ struct IplBlockQemuScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
-    uint8_t  reserved0[77];
-    uint8_t  ssid;
-    uint16_t devno;
+    uint8_t  bus;
+    uint8_t  reserved0[76];
+    uint8_t  ssid;              /* CCW only */
+    uint16_t devno;             /* CCW only */
+    uint8_t  reserved1[216];
+    uint8_t  opt;               /* PCI only */
+    uint8_t  reserved2[3];
+    uint32_t fid;               /* PCI only */
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
-- 
2.54.0


