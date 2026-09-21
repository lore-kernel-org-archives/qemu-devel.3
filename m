Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16473C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKO-0006bf-S4; Mon, 21 Sep 2026 16:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKJ-0006ME-9a; Mon, 21 Sep 2026 16:09:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKH-0005Oy-JX; Mon, 21 Sep 2026 16:09:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8TSV1903178; Mon, 21 Sep 2026 20:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tug2xrafeNLvl2Zt6
 S+y8PyY7tv16UHANxLi69pQyck=; b=JueFpaimayLqcq4ExZA15QH1aecVOmC7H
 l/J53TaL00HKc17DlzCjiW0jOwmaxSbJ7KpCtIhIU9sPBWrgpqB8eEOWMRTHq58e
 RidTaAYBCjVLqGNUNrYwzYKeAY/J8nTd+xsKxavZDLzplLIMQyoNNHKEe3VmxUMH
 hT9rcb5F9M09klVICSUPa4R2TYg5WV3sDMFrANfBZSiXRn9+Apx+IvVP8dQ+XujU
 NCT6cF6jVP1SQrnYal6KPbuc5Rv9dN6M2ASKsjjPeBzWNdqQAtb5X3MUFru+vw3D
 ECiE8+0Ht07CYAfDpUhJJguRxosJen9F1qseMD/l02l7hDNI94cbA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv2be0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJET9G1489468; Mon, 21 Sep 2026 20:08:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq71u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8kkj64881064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D82A158059;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54AAC58055;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 25/33] hw/s390x/ipl: Fix incorrect PCI IPL block lengths
Date: Mon, 21 Sep 2026 16:08:22 -0400
Message-ID: <20260921200830.1302919-26-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OISg6mIS0LHnL4gZLCn2GJqbbQWQfYOp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX03jqlJEw8cn4
 W6tzhh5BfdpL0H7C0/JMW/zHNIxVh0aJMqThdwQ6HtMKZeIrNG2hSZ6nehaOleZAWrLVlP6Q0+K
 LVRVuRVbMKROS5tqKdSX/EzsvwXuq6o=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab18ed1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=oWrvFdo7ebCuo4saDU8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: OISg6mIS0LHnL4gZLCn2GJqbbQWQfYOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXzHN79tLj10VX
 hPMqWnvC5DjIEoCgBPStrNwJZh45cD+FMorahkfe2DJqrb3kxH82z3hBOA5cYVXOyNgv4Qf+Sh/
 J3UmRnqjKdyMmZkWUWYqxaGFZONxfnQtCe6BJjl1qDA3jAx0qvYZoRpiMHcItx3E8Wvyw0lEf5s
 o+h+d1pTmu0Wpb0QFB7UP0QR0jNF2s0X5hsD3mQuz+AmPTFEgTdXemYTrToCJRRJKxydoX1UEVU
 kc4mO6oO59DJIlHLdIdLE5SW0VkYFGBUmeT1XGoF0lkxc7c9Wpgux1VUIPiXlisRYfHeh/AS1S3
 3fJ8IAZkyYndLYg5HCA3tk+apGp9YPNMg4t1PnXK2XirLvBT55RoTn0zYgn+Do42ePlHNyitQ4v
 e039zqHHkr87BH/QEcChsRIHyAgHP0vjAaH+aXIe8+5hcQqcJQvKcwJlScvruVl8kgeZt6rpuIV
 EW9MjFao2rl0NRVZWfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-3-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.c              | 2 ++
 include/hw/s390x/ipl/qipl.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b0da3cbb27..b2b87beefd 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -610,6 +610,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
2.55.0


