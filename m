Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C79C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2I-0000uS-A2; Fri, 11 Jul 2025 17:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1y-0000hQ-OY; Fri, 11 Jul 2025 17:11:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1x-0002wL-1h; Fri, 11 Jul 2025 17:11:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHTuUF010221;
 Fri, 11 Jul 2025 21:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CbFIG+ZCIc+yXNuj3
 ++h0AVdoaBTr0L8zpOg6Tun6ys=; b=nkrG0aSM3YvI2V4L55wWVcCh3rbgIupU1
 3jPH0wcJ3mRBgszYtXCxACY5cEZvN+C8rczpaNdU++ZQhj16Aq83o2iE1Gwpbnet
 I9DwhhJ7VVMVEKn8QfzjnYGEYG1T9qzvOflkiLBsba4OWFhHahVNrdeu9qZjKYZP
 tE4+jSxM9W5HvKJaAWgpjteMltEIs0HFk+Wqk45KOm3zhVfekqv4/Wcv7j1RRAjZ
 WZdy/54mlRrxH8d1f50G0BrJT1SCSTw1+XsILeiThXO4VWKfWYnknl0YtrOiTTZV
 XIX/o55LABH0bOkzDcoIzL65/Brce7sGS/jdwQeEr9UW7YFWJJ8SQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb2db1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BL7sDC024678;
 Fri, 11 Jul 2025 21:11:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32v9ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBaUi26083982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E7575805B;
 Fri, 11 Jul 2025 21:11:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD2E58059;
 Fri, 11 Jul 2025 21:11:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 16/28] hw/s390x/ipl: Set iplb->len to maximum length of IPL
 Parameter Block
Date: Fri, 11 Jul 2025 17:10:52 -0400
Message-ID: <20250711211105.439554-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfXxcfHp+8fFwrO
 UjQYDwbRqwwoPopOXlqql9tJGtqqKlvhWF3yowI1a2KW9s9GFCEFnX19aNO/GE9jdrEwvPEnJdQ
 nN7mebmBA35SAfl6jMoeJH+APKk9HOYqRHhN7grHtds9WibAPgw62wYcIgwk/lONapc0QR0KsH7
 8C8dkO++SiZ0/gV2G3TZuK9rtScxyBc4n7vEk+NPNsRuVp7OSwkFQkwgBRTS33PZpLP8J71nm6P
 Omn1GCytZjjNPFwCNgFGyV+pnwlyP4xed2xYnLuaLw0py/fSLtO+a7YAX6wkDGyhHQ6hT4Ca6bz
 AhO521BJUpE+H2uR+CUdBQN+hV9+j9XXGglew9r4ZOK7Y6nVwS+oY+tq8xpy0aEfqDYeS3EZ4/2
 On7npw8c8FLg4aIlv/3V9I5FeJq6goEmq2OCwC5k/GNelp5LgnUqdxQfvfPVCmmgJtaecJjP
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=68717e0b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MJvGgyB-O-neVO77w_cA:9
X-Proofpoint-ORIG-GUID: 8koqOd-cjzOrSV9UfJAANsybDIYLJxBl
X-Proofpoint-GUID: 8koqOd-cjzOrSV9UfJAANsybDIYLJxBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=800 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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


