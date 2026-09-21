Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB1C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kK6-0005w3-ED; Mon, 21 Sep 2026 16:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJt-0005mm-Cr; Mon, 21 Sep 2026 16:08:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJq-0005P6-EE; Mon, 21 Sep 2026 16:08:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Ewp4193462; Mon, 21 Sep 2026 20:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZOITuEInNY2RZ+hG0
 3fPrZlU9dBVEsWBaMd5vkXquTc=; b=iawaiepJEaJDkjChZpvOR6MJUFjfv+MW5
 w1vtFycjkIrN4Z4duySizEf08BdkTfZU7oHcjlet9tNButHHAuhmGeijhyinZPzD
 d+LE3ItELDyQN4dQP8zGhgmfTRyud4u+JRuWdWiU7iMaitjUOhKeaZlUIuWSH1BZ
 NOnHSPYT8BbSOL688jIg5a8rqznHZ/pYhdimmPsn9d61pA3+cI8r3Vb1MtuCD4l4
 FogDRjPqtpvcJmwlT4Fu0MmWCkF7jPbvu7/mRkcWfhD1LLwGEXw6bDE6yGkwAx4f
 Qx4J3xm+uAYn5wL1Gjqb05P2oeK2lSuqPI8+KOzlfvYGa5h96oaoA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1jh6x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJIMrF1489425; Mon, 21 Sep 2026 20:08:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq71u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8mHe13042220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E2D358059;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 903A55805D;
 Mon, 21 Sep 2026 20:08:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:47 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 27/33] s390x/ipl: Add PCI and bus fields to IplBlockQemuScsi
Date: Mon, 21 Sep 2026 16:08:24 -0400
Message-ID: <20260921200830.1302919-28-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mm5EPjJlN8guTglS9Wrvk5xtk9JeqIUw
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab18ed1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=omE_1ZJ1-raI6ZwwQhYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXz6O21X6F7Tjo
 ha69NtnZ7uqQi1skB8hIAmtN9rN/KXLosSu3Cpail5DRCQw9kZ8R6LebA89ro15glqDobsEFW2t
 5qSnSQrxDoLewNrtaXVK3/kfN6PGpOg=
X-Proofpoint-GUID: mm5EPjJlN8guTglS9Wrvk5xtk9JeqIUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX9pxpFRbNtgjF
 B74TCmmF9bGNuVOLdK6GmTMJ4sTYRNvXKVefL9wMDg/+RmTEvZimv/diO3nDgc+yt2Wqz2Fa+Qu
 1aI6TG2zCR13f7jqy97Sj4/Wj2fIu0NhCOZQg5tfkUvOcEWU61sZjTYsplMKfqizf1mzzs3R6Zp
 dXlIX9rzHE2ZvMoqqDaHddNbKJWyMGe6R31HZai2CKywUXfPiZZl6Bo7NUXW0iwbygIjhFkJtp4
 cu5jGSqK6lfRO0yy9WlD7JVRq5Jy5RWHhCBXMfgJb58M9Nz05biXDULNX6CA+K3g48gyvztZfH6
 PsFSxBtDfE2x5zTbvBHvZCE/r1T8vpeubzgJF9KtsNW4QVHG3OMBg3/0u3+5bInmaMGWFl8P8n5
 AVEJZeNrKGzXj3IpYU4wCDsAjItppTpZ9xbApp52F9Nwi/6PPAm+jxJ14jRP8aBP52NxCGpKBPY
 NLXbakfsBQmI7cfxGcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-5-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.c              |  1 +
 hw/s390x/ipl.h              |  2 ++
 include/hw/s390x/ipl/qipl.h | 13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b2b87beefd..4fa8124f92 100644
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
2.55.0


