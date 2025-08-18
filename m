Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7eU-0001wW-Le; Mon, 18 Aug 2025 17:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eK-0001pp-1A; Mon, 18 Aug 2025 17:44:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7eF-0003n8-VP; Mon, 18 Aug 2025 17:44:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IKJO8h016893;
 Mon, 18 Aug 2025 21:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OSwEtJZh8CYe1LcRJ
 y6nbo08IOE1vIPc++nQlIVs2+0=; b=K8p+Dvg9X74K3FAV7R8r1xx64wd5cEPWH
 8CC98eJ7n6IuEsE3trPzFHlyEc8cCtBgpmyRN5hxyt7GLn6XqyUkQSYjcOx/Sj6s
 zZhtO0k2dWO+bWofBx8XrGJfXi2KnTuxCFnrBqeJuH4+0Guaagy/k5hpJWfPvwcB
 b4mM9J6aknDPSZoaqBDDY4/wVzV7WQvtesbRoLxXrUVz7U1391KDQMiqTq3VRmyd
 cDogtjrkCTzCLZm1Hiu2fxUHGDRq+HFKYI69LenzXWzR+mdmZ8xXcf/3Q8Y6mpZZ
 4AQvYsgq8oJysKAGTh4Z8KojdfzWGicaKfSWn4OWw147x2RbbROPQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g0cp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IKJKmC002381;
 Mon, 18 Aug 2025 21:43:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k712y9wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhijw26346172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C22158057;
 Mon, 18 Aug 2025 21:43:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9513A58058;
 Mon, 18 Aug 2025 21:43:43 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:43 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 16/29] hw/s390x/ipl: Set iplb->len to maximum length of IPL
 Parameter Block
Date: Mon, 18 Aug 2025 17:43:09 -0400
Message-ID: <20250818214323.529501-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: grXQFdALiC0zAXrpTamYmItBV9AQu4R4
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a39e92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=MJvGgyB-O-neVO77w_cA:9
X-Proofpoint-GUID: grXQFdALiC0zAXrpTamYmItBV9AQu4R4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX1rgXcWkdTOao
 4n7L225PT4FhOAYb+nyiFItbz6PY3axtaiz3QjzSfqwODmgpBrOMUeD95sbz1xjpNWgI3WjTdfm
 1u/GmJ2meX4fZsX/VJA8Kt/JjDkugcJ0vLjHMDKPsTEi4msXrYh9J3Kz7nbhYMHRT6V3tcyLYSM
 eKYz/Et/EeRqw01hcJ+TZbYnkONWb2iEbKxoba023i3Pr9MTyZd2tRD3hiqZ9BzHO37DORBNCL1
 YXm/svpuYAAYpzdaMU9uzqVPld8PkyfNZcd9pZi9rJTNDbLKlikGWcUe0JJy5UgKcBA4OlgWJvX
 hMmPCx3IxsTKqPon7vJYuAn4HVfuCoKPD2vU6wipJR7FEpB9HTJirlgkxH8fsEubpAzkm1EQmSk
 ydhMNujJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.50.1


