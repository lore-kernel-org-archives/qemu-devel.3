Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D94DCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAj-0008So-Md; Wed, 30 Sep 2026 11:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAh-0008PP-O5; Wed, 30 Sep 2026 11:24:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAf-00023q-Te; Wed, 30 Sep 2026 11:24:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE64HB1337364; Wed, 30 Sep 2026 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=59PE50OUkZ7LnaCIa
 s2XOlMzSs9lg0pOQ9hAOdm/Zbw=; b=D9nVpSUC/e925yTKOhsRhldz+vsqaj/aQ
 UlsalF0C5UjWGlCvxJs2ol7k/lmRNUTSH9cZ9w1r2o0fGHw6p17tD+eokY5FyIEv
 5ohGs9NA5k7Lq91eEQvUh4z0OBnpD8mYRnmbxHBzbThB26cG2kZrTykr2KMsnuPt
 5NfzXWhmjYIXRxs/MaoIVPWutZeyaH2RTg26xjdKhxibPOdyTGewzuq1rqIQ1tXD
 HQCAMW+M9yRt+gCpAUronSWMVxtMX4Ikl0Fo8HSmoPNEe5np+JiBNt7C1QlYdT4k
 jCCG6WjP996isG44BkWtuSpo/WkbZCOJ7qTRHgRzxZZBdfCgGvm3A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrdtwq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34Ct3541449; Wed, 30 Sep 2026 15:24:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcetm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOXOQ31326974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99CD458060;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 257D65805A;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 20/23] s390x/pci: Fix frame stepping in rpcit_service_call()
Date: Wed, 30 Sep 2026 11:24:17 -0400
Message-ID: <20260930152420.1956230-21-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXzL4Q+7P28VUQ
 0Vt1rs1S4rFCVNe//bFHkQwiFeeVXXL1lUpnkoYoKTbLQbdzYvQy3O4PjPr8UDHmfwWqwFw4TfZ
 +QNb4EmxHJIxookIilT3utsekxS9WUGbgku7oafe7DEOrTDbK3RLudW5bTZZTBKy+rC37R/2j5z
 hu0UFScksQ7IQrFPfhh4gpBszXeeUHvFCC9kISJH2hgBCnl2TK616IsNbSaPDEtYNxFL+nF/d/H
 QZaccATNEctjU38JxL+Iju438YYLeQjttSgJz9bWbrgfRryBwQ9o9/JBblyn100LgiCFOkIOHQy
 81OHB7C+tvt8L+Hzf5zQd3LhjRQFWIQnQcAmNqXYNYpVgh6jzrw6mHr6g30AbhF1PpqJlHAW87y
 1Z9sK031XFNRgPiuKeXFL7XejNkBwALckF7t7cjvhJjNl6BNge/iBGJ5S5F0z1fu8tqkC2yfUBg
 4kHl0S7OdHvG9lcPZ1Q==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd29b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=MMuBV-PD9cgeK7xIxbcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: pSpXFLrjQAP_F_v-Ee1D7Vu3jPWJCtsz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX94513+F8kx3M
 vdxZ9TFb8LWFmBOkNZTPnT42YABIbOReCMXgmy5bSa7CmBkT02nFc+ZLogokRgUu3N01M1gqen5
 QtyYi0IFzSzyRhEYtHtZHPmU3/h2QwQ=
X-Proofpoint-GUID: pSpXFLrjQAP_F_v-Ee1D7Vu3jPWJCtsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

When walking the guest IO address table, an invalid segment or region
entry causes table_translate() to return entry.len equal to the frame
size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
entry.len directly to start only advances to the correct next frame
boundary if start is already frame-aligned at that level -- which is
true for a well-behaved Linux guest but not a general requirement.

Add logic to advance start to the next frame boundary rather than
simply adding entry.len.  For a frame-aligned start (the typical,
well-behaved case) the result is identical.

Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-2-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 652e1712ec..bac813fb6a 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
             coalesce = 0;
         }
 
-        start += entry.len;
+        /* Advance to next frame boundary if start was not frame-aligned */
+        start = QEMU_ALIGN_UP(start + 1, entry.len);
         while (entry.iova < start && entry.iova < end) {
             if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
                 dma_avail = s390_pci_update_iotlb(iommu, &entry);
-- 
2.55.0


