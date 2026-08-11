Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB1C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkY-0002UZ-NF; Tue, 11 Aug 2026 10:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkW-0002TX-Rh; Tue, 11 Aug 2026 10:46:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkV-0003fC-8Z; Tue, 11 Aug 2026 10:46:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDXAaI3634660; Tue, 11 Aug 2026 14:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=caT94ZbDmvieUba6j
 M19revu63rE5oJcPcfOLvQ2Uq8=; b=MB5X0lpejVIK6eBPwK3VVMAltlOaKRuOX
 0SOApdcZJp7SaTQ7DnFVB6wRfGxkoixPqgnow2B7tExddGA6LScSNzu/aJ0SYBnM
 +RM5eOgzNeRlcpuvom3lPSIHJ3TXech1gxhWrZ8N1bvVHX52PNheEVEbjCqExJ2Y
 /grTR5EYcVN4DxxRf1+6x2oN8rb9vwJmmcwO7wsIuTnNxZu9969QcAjHkbFTwddB
 4I7Fp0Qd/4uVgioFQgwqpko5IGpByW48DcPRCl9rCP6X1iHLzv9GHFp30NLgYiQY
 wI6e/bEARksM6gyZRTNTefKU/YqWFq/kriRKVc2lL6kSAulc+bkjA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23p621-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfE0Y002882;
 Tue, 11 Aug 2026 14:46:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g973d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkadP33292888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B91758059;
 Tue, 11 Aug 2026 14:46:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7435D5805D;
 Tue, 11 Aug 2026 14:46:35 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:35 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 3/8] s390x/ipl: Add PCI and bus fields to iplBlockQemuScsi
Date: Tue, 11 Aug 2026 10:46:24 -0400
Message-ID: <20260811144629.866641-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b35cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-QlUfH9WTwOXCv0RR1sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXw9jQpNBxUKWZ
 GicpvI1Jiqw3y1FyMUCzZo8L2RAkoVm+QuZEVKC2FNmMOq8icT8Dnvtr+UGpLT6AmpSpU7y3ekH
 0IC3q7LQcbi0GMOi9jCrrx36h8krNllU+McCC31NfYPlxCuBPsjt3o9rpMLD7PCmkyOUIWrrlzC
 QcMyPLN4K3R4CVvTB4nwWFAyuI4KyaMqEzyqOxm51lXgBnS0ZWI6WieJDVAYTO6tHtaUBJ+55SW
 tVDbBPl9DAFNQGN3oeb9wm2P1qOmwJmrgQMjcWX62kPpB8zD7zWTOxQFCxBm6AKgEWpsRxgQWIw
 3mjuMGyFm/3kCjbFP6ClXuvyKhYIYRKNVDt6tatwm5KDxPSMB5SbZNdw1BbJOdSe2WDtdRiyf6k
 NntDxwfVWAGP6lkWwYXtJkn6d6c69WMJ73SOcEYNTv6RR/PkQivNIvnsawC75OVUVG9MP1gsJbA
 uHWRT70VbCLi2S+hN7Q==
X-Proofpoint-ORIG-GUID: zzvE2pnE10K6VcE0zYFXaiBO3U_Fad6l
X-Proofpoint-GUID: zzvE2pnE10K6VcE0zYFXaiBO3U_Fad6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX+GBsnGBspWl+
 Tanh4tPwG5zEYjLMn58FZQyE7DtxI+veVdC/D8jMG912rGWfarqfGZxsLr3jApJ7+bQmmGhTg7t
 olODuHQjJ7JCc8pLHLb+B3S1HG5eoYM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c              |  1 +
 hw/s390x/ipl.h              |  2 ++
 include/hw/s390x/ipl/qipl.h | 13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fd6e9100f9..7e68be4c20 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -482,6 +482,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->scsi.lun = cpu_to_be32(sd->lun);
             iplb->scsi.target = cpu_to_be16(sd->id);
             iplb->scsi.channel = cpu_to_be16(sd->channel);
+            iplb->scsi.bus = S390_IPL_TYPE_CCW;
             iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b4d93054a7..0734d72117 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -86,6 +86,8 @@ struct S390IPLState {
     uint16_t devno;
 };
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
+QEMU_BUILD_BUG_MSG(offsetof(IplBlockQemuScsi, fid) != offsetof(IplBlockPci, fid),
+                   "iplb fields misaligned across bus types");
 
 #define DIAG_308_RC_OK              0x0001
 #define DIAG_308_RC_NO_CONF         0x0102
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 8d3c83a80b..8d3937376b 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -25,7 +25,7 @@ enum S390IplType {
     S390_IPL_TYPE_CCW = 0x02,
     S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
-    S390_IPL_TYPE_QEMU_SCSI = 0xff
+    S390_IPL_TYPE_QEMU_SCSI = 0xff /* Max value, must fit in uint8_t */
 };
 typedef enum S390IplType S390IplType;
 
@@ -103,9 +103,14 @@ struct IplBlockQemuScsi {
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


