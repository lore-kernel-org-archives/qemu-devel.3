Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC923C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7n-0002uI-8b; Wed, 04 Jun 2025 17:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7K-0002ox-4P; Wed, 04 Jun 2025 17:57:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7H-000715-5u; Wed, 04 Jun 2025 17:57:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Kow9s027916;
 Wed, 4 Jun 2025 21:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CbFIG+ZCIc+yXNuj3
 ++h0AVdoaBTr0L8zpOg6Tun6ys=; b=kZkb0uurEuF5O7tbIojDE2z5CqIROP59o
 qV/YxUoA99inzn/Swi8y161q3hH0sBjG4UaTqKJN1OM5I/kQUuY0Yv9QIOrYWcUf
 L/uwWEbMNqT/NuQJ+wLkI5NSKfp4vdHMe/wjF7PAiAEUzptvje/d4tJUCWxX1VGO
 v7iycr7jI5igYH2uDDMlpm7R4w5kElaJkxDRN4/DKnE6/ckDN4YhY2/SnNjZ/twc
 hfsYM1Dc4msmsIlXiO64A2qt2wS+t7jQDC33tYbrsYrTpByNaaLOvfL4nwaFz0DV
 ISCWv83iXi1+lf8je0oHSm9hipBwLVScyFYLpDoq8HcBgg1hvRyGg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyddpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554Imubb019898;
 Wed, 4 Jun 2025 21:57:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1us9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvfcI57475574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BFD58050;
 Wed,  4 Jun 2025 21:57:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB98758045;
 Wed,  4 Jun 2025 21:57:39 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 16/28] hw/s390x/ipl: Set iplb->len to maximum length of IPL
 Parameter Block
Date: Wed,  4 Jun 2025 17:56:44 -0400
Message-ID: <20250604215657.528142-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6840c158 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=MJvGgyB-O-neVO77w_cA:9
X-Proofpoint-GUID: xxGwsiO1OmRDdU8iaExspYvceVoVFOXE
X-Proofpoint-ORIG-GUID: xxGwsiO1OmRDdU8iaExspYvceVoVFOXE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX/nTsvk9ziHDo
 mSfgveDq3nbmc0XFehadgp5fPr3V/caTA3DLDAp0/dG05ADISODrU/scLpCA0wwpLoa8xxYs1oD
 O/Ym1zy8Fm6DacmTDheD8C8k/kk8pY5kG4ZdKrLThgpTPQBI05dTTGy+mNIWt+psupdAKMvthVU
 FkoXVyqIS9t9dj792RI/CDc+a3F/kBrVGZf9sJqV+ZhJGbQOZlcAQ9KppakeEFmrzOODpAVKMZ5
 M7VDg1A3f8nAFjOHNpa//rEdaDbKwm1DnZbNn586xyaE8KMJ1lqWKL9Zvy/+J5+zphqiZjPD3XU
 U171apK5Fqg/8Npk+56MugwQn/JiWN7M0DwVtdoB26oT+lNTUawMZt2AQJ8ZOaIrYoXwW+QVBCd
 39FRsAHWQytwtr8Tasjp7CiaJ8DkLFc8aooDEQK2s3xQGynIWV02niYqv5oI7BaFSYm1MuIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=809 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The IPL Information Report Block (IIRB) immediately follows the IPL
Parameter Block (IPLB).

The IPLB struct is allocated 4KB in memory, and iplb->len indicates
the amount of memory currently used by the IPLB.

To ensure proper alignment of the IIRB and prevent overlap, set
iplb->len to the maximum length of the IPLB, allowing alignment
constraints to be determined based on its size.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 6 +++---
 hw/s390x/ipl.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8ac0cee73d..d1a972ac8d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -459,7 +459,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             if (scsi_lp && strlen(scsi_lp) > 0) {
                 lp = scsi_lp;
             }
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
@@ -470,14 +470,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->pbt = S390_IPL_TYPE_CCW;
             iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
         case CCW_DEVTYPE_VIRTIO:
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_CCW;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 3b8cc5474e..01922d80c4 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -100,6 +100,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
+#define S390_IPLB_MAX_LEN 4096
 
 static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
 {
-- 
2.49.0


