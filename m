Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818AEDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtmK-0005Eo-EZ; Fri, 13 Feb 2026 09:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vqmpI-0003zm-VP; Fri, 13 Feb 2026 01:38:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vqmpG-0000eI-Kq; Fri, 13 Feb 2026 01:38:52 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CFw5r33988415; Fri, 13 Feb 2026 06:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=o01AsjMHpxCKCALaZ
 yjCRawxTKW1zed51+u1M3zBDsc=; b=k6frwr3xT5CKPNoRba/PJAYU2W25O+6Pq
 hSsfp01xvY3zTL3HflDbjidhs3u1HTVX0KUBm6OFgb52BGJgFrM3eV01rc7tDdpy
 wQiPxMSosQbJc7CkwSa1qFQ8V6hligx+TVpoUSc+m1Z+EApNOoytLJGRLClBBBo1
 +G9UOPfdWnrDxm1kGT40Iw5nr/tmbZiAnB6TLdUqvtP086bPQvvPC7/QVHvXldRr
 YqHLcWFwq7nYpAsYQGwtE9qzOLWSHva8iXNe6k+rXUgYRABfjIPVyQgCZ+MOEPnT
 ZHYpD+3VJqmDzYeVFn4T3u5ca849skaKoIrH2rYDz2bxCccXX6riA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696whqpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:38:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61D44p0J001815;
 Fri, 13 Feb 2026 06:38:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je2dg73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:38:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61D6cfoH61341970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Feb 2026 06:38:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA19320076;
 Fri, 13 Feb 2026 06:38:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD21120075;
 Fri, 13 Feb 2026 06:38:40 +0000 (GMT)
Received: from B02-B02RHL5-RH94-0370-9-114-17-225.pok.stglabs.ibm.com (unknown
 [9.114.17.225]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Feb 2026 06:38:40 +0000 (GMT)
From: Aby Sam Ross <abysamross@ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Aby Sam Ross <abysamross@ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v3] s390x/pci: prevent null pointer dereference during zpci
 hot unplug
Date: Fri, 13 Feb 2026 01:34:43 -0500
Message-ID: <b45cefc3147c2c8446772dab0f53d030fb92406a.1770963150.git.abysamross@ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212202515.3ffa2a80.pasic@linux.ibm.com>
References: <20260212202515.3ffa2a80.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698ec6f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=oz4qGxXyewAE73xyycUA:9
X-Proofpoint-GUID: SYK-FA5aTa05ryjLsBAlw_aivzE8YB1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0NiBTYWx0ZWRfX0C2FzqeCOhvv
 JuecbfQ7zWU+jnYeM1zKWoNLis8q1eHhY9xGARQ9iAEZsCITmGdfsSymyimTJVQ8qdF7nPgt2cI
 atG818QjqWHJaWwqb5nF/TLsca8UGuVIqG+CRx3iLn3rewwFJ27wqd43iRgtaA8Qk8Zoup376LQ
 8IeTEBNui7rJvEvZZHEgeFkGCWse+vnqkuKl6oWGYpGQc+/FeXQvj8GVJ+JesFIYFLPRc2zzBpr
 qiDSFGr74MoRrHD0MWZoWKKhRCvf7wH1U4tupRPJXc/9vNgRK+R+slS5VBNCvicfB0JYHAZyCvL
 ZPAlvVdH17mz9XoHhyMrcqTUm6uysDxO9dVvbhFEvjNiuyqXPH+LcZBjkAksJreb0xiBAsPq1qy
 SOZYwHvzzUtUVQIOFZn0RcTxyfAWKHWJ5YRNB+wBZKvQ4z2osHsrNZGa9Fz8jL5g/TLg1H+cj3y
 G/x1P5/QMHo6M26NgRw==
X-Proofpoint-ORIG-GUID: SYK-FA5aTa05ryjLsBAlw_aivzE8YB1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=abysamross@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Feb 2026 09:04:14 -0500
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

All other uses of zpci iommu without null check happens after both the zpci and
hostdev(pci) devices are plugged and are safe from null dereference.

Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")

Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Suggested-by: Halil Pasic <pasic@linux.ibm.com> 
---
Thank you, Eric, Matthew & Farhan for looking into this.

v2:
Added subsystem name to the commit message.
Updated the `Fixes` tag to include the reference commit's message.

v3:
Added a note about other uses of zpci iommu without null check in the
description as suggested by Halil.
Matthew verified the zpci iommu uses during v1 review.
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


