Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BAEEE3684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWiV-0006uU-JG; Thu, 12 Feb 2026 08:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vqVDr-0006I6-J1; Thu, 12 Feb 2026 06:51:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vqVDp-0006Gc-Pu; Thu, 12 Feb 2026 06:51:03 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61C7Uew7475486; Thu, 12 Feb 2026 11:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8nV/RaCCqBkVJFMqR
 Vn/S3YeR1gK4OsO7citxM156dU=; b=iQGhiyFcUTYamqnq6CE2cYVH3iqQYBRT6
 Red3Om5XSH6ZVrM18l/kMFr4THonR+9dxiGGEWJ6b/M/GgPass+C8luxn3H5Sy4D
 /nreCViFrUpMA1od+vYM29DJC+YUevxURIyDENWzo98iVhsR58fbcRiQ5eIP93wx
 RSxGRQL6g3Z9+0WRRkb6CAzJKGh6bFOci9a/mX6TbKjMXFTjFjqufnbhOAi0x20z
 dSO6/DttAqFdFxuBZFfLdCCXcD6wbqlpnoikVHLk61H4McOrPqBd0FGAWrGceDug
 Odqx27ZV2x8tUBxOJJsk2q4Qwc7zadBvQdofDAqhGj4217ChAdfEw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vb5a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 11:50:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C7ZMDu002548;
 Thu, 12 Feb 2026 11:50:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqste0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 11:50:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CBorrY29688152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 11:50:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8FE220040;
 Thu, 12 Feb 2026 11:50:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 099712004B;
 Thu, 12 Feb 2026 11:50:53 +0000 (GMT)
Received: from B02-B02RHL5-RH94-0370-9-114-17-225.pok.stglabs.ibm.com (unknown
 [9.114.17.225]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 11:50:52 +0000 (GMT)
From: Aby Sam Ross <abysamross@ibm.com>
To: qemu-s390x@nongnu.org
Cc: Aby Sam Ross <abysamross@ibm.com>, qemu-devel@nongnu.org,
 farman@linux.ibm.com, alifm@linux.ibm.com,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2] s390x/pci: prevent null pointer dereference during zpci
 hot unplug
Date: Thu, 12 Feb 2026 06:47:36 -0500
Message-ID: <8e983aa64ebeaad9897496199ca80cfb7e0bf003.1770877629.git.abysamross@ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
References: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9A74SqLp9Vsa3Z8bWPgsvgxhuoyyyVsJ
X-Proofpoint-ORIG-GUID: 9A74SqLp9Vsa3Z8bWPgsvgxhuoyyyVsJ
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698dbea2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=o_ZA4PQYd8X2eSHSQvoA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4OCBTYWx0ZWRfX+e80GlPVpowf
 AKQaW5xb6Hx+832Xgdnbt4K3tZ6PtcnhVz9y6ngIJhjdHps23+K1d/0rNXOmCpKsJN5genChxE+
 BXxIjxXjqwqYBQlQpNup26mPEOCOriYRCpvOEA7bDT5MCWYyRUcheRKvE1/wsFznDkUKp+XbbPy
 YWktnqk3hs6Yoy3pPYjfBdZ7f512h2aQA46rr+fiSeoSrwUNavsK/HeeyRjecR5MVtQRBRjXeUb
 0NWkeMXmWr6yFOCDRNglSFvr6AQyfQJlZxkLyd6ZibIsTH4V1rortDAFYMOCu+PxGgHNNLsqroS
 QFyCDLnCAHuN0Si/59UuZMivf/lc8EzECzHdywRQbr81KoOmPknBPGQ7d2+OHIzWgujChw1ynwb
 JPANGii1kLeAt+o3IroZ88uCGgk/xKlkb8+dzLhmYF7XdPUrejmVj9iXMWzLxU0GrBQGRb3+TKt
 BS/MKOMU4xB2zkhDNxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=abysamross@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Feb 2026 08:26:44 -0500
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

vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
hostdev[/properties] addition doesn't reach the point where it could be
associated with previously added zpci device (in `s390_pcihost_plug()`).
As a result, zpci iommu pointer remains null. The zpci hot unplug following the
failed hostdev addition assumes zpci iommu pointer was assigned and tries to
make use of it to end the dma count resulting in a null pointer dereference.
In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
after hostdev addition failure and this issue is not encountered.

Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")

Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
---
Thank you, Eric, Matthew & Farhan for looking into this.

v2:
Added subsystem name to the commit message.
Updated the `Fixes` tag to include the reference commit's message.
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b438d63c44..3166b91c46 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1248,7 +1248,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        if (pbdev->iommu->dma_limit) {
+        if (pbdev->iommu && pbdev->iommu->dma_limit) {
             s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
         }
         qdev_unrealize(dev);
-- 
2.52.0


