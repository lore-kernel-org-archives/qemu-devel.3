Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A81C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180b-0000Jq-8h; Mon, 31 Aug 2026 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180Z-0000In-NE; Mon, 31 Aug 2026 15:49:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180X-0002bK-5U; Mon, 31 Aug 2026 15:49:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVkRK1979921; Mon, 31 Aug 2026 19:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Va2UZzJBThLAqKBv3
 qTn9iNBAvZqDKPJCkqsAr+o7Uo=; b=qS1lmaReVv/Tz9SD2r6LGQmmPvdKeKRUb
 pLN9i2htkEVvp9dcTvAXmfhvUZHK+VnkoMWINQPtKSyvAIqNgp/tcPzs3SG1+r5g
 D+yEeQiBatukwVf3loCy4oSnkKEeYHtlDCVL72h7gaKgyi2qcS4yDJpBayw9b/Z1
 YHq2T9jwerUTKuDzTaIvHmDm+Fx4JY56RQ8sWCjaD/hytYhkLDs6h+DRhxSK59Mn
 Bie+iOjcVOfANjNqSYvSCRQDPpzXu0VueWxIYRIS4irUZR95r0jCvwD7U6fCnFEL
 WXeqM/TW0yaLfRYIrqQ4lQbONqqNF2+VWIjDS2qzVeAdtiiTBi7Uw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudkfss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfMEF011384;
 Mon, 31 Aug 2026 19:49:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq7xjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnOxT57213244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D502558052;
 Mon, 31 Aug 2026 19:49:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EBAC58056;
 Mon, 31 Aug 2026 19:49:24 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:24 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v3 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block lengths
Date: Mon, 31 Aug 2026 15:49:13 -0400
Message-ID: <20260831194919.3830270-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lk1k4v1o-M8Wg202tnN4QIioa3tY4dsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX0sPVYp+Li3Vh
 c5pqEUqTXF52cXUVEvoCnL1JKH3VysDqyQh0q5/AoghqIXM5F1BzxTvnfaM0JqTeaDPMTrh51J6
 XktIQiZUtADXK+RnJVtt19HNLQLpOHS18Occ35PL4JtNjskWKCfIxGqxCGHdqAZB+Lp7GIRlU8N
 z+ZtoP3Ok5StbLurjkz4CAr2PBipO0FsZvurZIKagQoF1wWDCmtWoe3XzrZnIG5zdCUnr/L1+h4
 Jl8VUUq2yp77VQVW8atkWpMw84J3Mxs+Hgsu0/ANgSk4nxyohuQAVeoCch3UDNpcsIrebczJi+5
 vRTyu3nACiHiOD8pR/4t3oUaT329lGRKU/pYd6DfVuowqNsMf/XudMX2jYKak56JsLHEF7F2Qtj
 sIt6ZTKxSAKllvDv4TvY9BOEN7H60pnUbV/yRP5no+yu2d1axLGZgRfeQZlIfyUB058R1Ast7Wm
 2YGxdJMflnaPyIgRBgw==
X-Proofpoint-ORIG-GUID: Lk1k4v1o-M8Wg202tnN4QIioa3tY4dsw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX65J4RnswFQd5
 5AFJ3NF3s6zrY1yyZvEyQ05m/3Tir8DCuwPgQfEdCWmQTKKelvyTHMcOT+SBLrNtqk4ymMahCu4
 hxUk64TjZo8IVX98NpIwdcFpZ3dlK9Q=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95dac7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=oWrvFdo7ebCuo4saDU8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310169
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

The length of the PCI IPLB is calculated by size of the IplBlockPci struct
plus the number of bytes used for common IPLB fields.

Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
while we are at it.

Cc: qemu-stable@nongnu.org
Fixes: 395116781df5 ("s390x: Build IPLB for virtio-pci devices")
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c              | 2 ++
 include/hw/s390x/ipl/qipl.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d59ed36c78..ba69ee89bb 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -615,6 +615,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_PCI;
             iplb->pci.fid = cpu_to_be32(pbdev->fid);
             break;
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 3fa9649112..69b0023ea3 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -39,7 +39,7 @@ typedef enum S390IplType S390IplType;
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
-#define S390_IPLB_MIN_PCI_LEN 376
+#define S390_IPLB_MIN_PCI_LEN (offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci))
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 #define S390_IPLB_MAX_LEN 4096
 
-- 
2.54.0


