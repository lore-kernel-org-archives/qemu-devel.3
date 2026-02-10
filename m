Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07125EA3F26
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjHL-0001Wp-S7; Tue, 10 Feb 2026 03:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vphcT-0002n9-As; Tue, 10 Feb 2026 01:53:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abysamross@ibm.com>)
 id 1vphcR-0003s6-L1; Tue, 10 Feb 2026 01:53:09 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619G4jjD369791; Tue, 10 Feb 2026 06:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=R/UV6HMEDUMIb9Q8VJA7rKMQ/NPZzRnfxT72mO0kB
 wI=; b=IPM3YP8qHKUHuSZrA14Zva7XpKWd3qXKUZZp8a9Sg54L2hp3wjLq9sior
 Fbm3GIb7tzVwmuqO//SPKPpSASuEd632MYQw8KxH5wV5OkHF5F8AgafPBiUcDNaN
 1ExR973HABmoSPXScdSVNfvctZF9aOW6KssjjYAwwB/a/LvItMTeZkCVe3xCqpAB
 1rnmFUcuZShooWinmbEtCsUGJOnlcN1pHxugyJrIfcheH7DD7lq67RRlIYvzaLSO
 VWEb3kNPlc4gdI8NXhXuC4MsCscGVeC+JpgqdkpVJa97A4s/ky6rC3kb0vyX95r4
 T2KLrYUfjZsmI+VwnyLhAqZ8pX8Yg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ws0cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 06:53:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A6FXdp001815;
 Tue, 10 Feb 2026 06:53:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je1yxgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 06:53:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61A6qxAa24773060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 06:52:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F90420043;
 Tue, 10 Feb 2026 06:52:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B48C320040;
 Tue, 10 Feb 2026 06:52:58 +0000 (GMT)
Received: from B02-B02RHL5-RH94-0370-9-114-17-225.pok.stglabs.ibm.com (unknown
 [9.114.17.225]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 06:52:58 +0000 (GMT)
From: Aby Sam Ross <abysamross@ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Aby Sam Ross <abysamross@ibm.com>
Subject: [PATCH] prevent null pointer dereference during zpci hot unplug
Date: Tue, 10 Feb 2026 01:52:14 -0500
Message-ID: <20260210065214.2252464-1-abysamross@ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698ad5d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=_df3JAyxEGjRhYUhYmcA:9
X-Proofpoint-GUID: iPFhh6fadNUuXTSWJiEXjvI4qRjRADN6
X-Proofpoint-ORIG-GUID: iPFhh6fadNUuXTSWJiEXjvI4qRjRADN6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA1NSBTYWx0ZWRfXwTBUNrMA7p27
 9rAVEKOIPSUZELe1gtpjoSrlVHLCJ6stBxIBCZt3M/YxXQSY79Kxa36ZSczyvfJr4Ro6u09AnD4
 /WFwhIG562mKlwRacSpQPjLD7Dg8Fkton2qlThkTbG1TLVu6rckhyF/7tVsY/e7NWMMTwv/RmBC
 qpSIG35vVY9T3/LtrCDZhUUEaXNT4eibJ3VKEM7CoOdezwxTr9KGZ/4qE/da4AAQm06oLIgk41x
 Iv1IY0ZsV8UTVcpEAN/GRVfK9R0hmWogeYtPHCHWT/IsKXVcgxwR7yGOWJKXO04vb9EoDC0YyxK
 a9JPQKZETg6kEJRWRoZDTmTeBYzfD29KftMpVTQKGOtisLtq8NOnxo00FLRlPfLogudXAS47tpx
 WoZIxwI3K+moYvsc7xmPTxT1zglyn1AXvYiZpMZAdykYU8tnHetSSNCzFJpVhzwY5iKNhnMkq4Y
 SLYGBwHnd83riCKU3cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100055
Received-SPF: pass client-ip=148.163.158.5; envelope-from=abysamross@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Feb 2026 03:39:27 -0500
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

Fixes: 37fa32de7073
Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
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


