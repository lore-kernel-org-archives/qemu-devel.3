Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FE606A915
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F9WTqKOg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNugG-0001Lf-1D; Mon, 02 Nov 2026 11:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug7-0001HS-Vn; Mon, 02 Nov 2026 11:14:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug6-0000fU-4y; Mon, 02 Nov 2026 11:14:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2G0fwA3330859; Mon, 2 Nov 2026 16:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2HgDY2
 BOSk4cdb72j3bTFv3Q2JhxR2bbMALyTtypYbg=; b=F9WTqKOghF1dzGgzuDQzCz
 bfxwtPmPDkYcw4LdNKETPE0G9+rQMapBagwxO4ZUEdZh5ZYBBT8t1lvHcWrh5Mbw
 zCasme/LNhkVfzcQjLBB/ahjEBGER92vz5rIfYUWTq2tPdhQLA+BB7RkjV8CoQxt
 8footn6ebUcRvlihyByoTUdixbo7A6XIK0F9ShtKPm8FUuzm3VhWpt3pI2kIOUMV
 IoE+yRD9CkTRVbEOULRIqgmzks96ezHtNsCQ35s/4K6lWxYnBQ3fK6qJ3LTrlRmq
 h7P7QPlifzQMrmIs4cHUHhnh3Csde4iE1RHNGGbwnjdRZT4HDzHC5hs0xx3Dqe6g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826hjgh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp8kP932243; Mon, 2 Nov 2026 16:14:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxq1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2GET3a22414064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 16:14:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82B6E58045;
 Mon,  2 Nov 2026 16:14:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B93258054;
 Mon,  2 Nov 2026 16:14:28 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8058-b2c04f424b34.ibm.com.com (unknown
 [9.61.98.239]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 16:14:28 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Omar Elghoul <oelghoul@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 2/2] s390x/pci: Change reset method from legacy to resettable
 exit
Date: Mon,  2 Nov 2026 11:14:24 -0500
Message-ID: <20261102161424.241623-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102161424.241623-1-farman@linux.ibm.com>
References: <20261102161424.241623-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 688EH7gTlboKcs38YGAx8omDrgHwuQ3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX0yuAH7U+q1Tj
 z9vDPJ9Omf120wSAQU3m5uP39IB1JygwEAIFhs4LBYFk5wmHrvKP+6WYY7BDoCI0VsoB8wAN0DE
 g+Jjl+YR01P4LzRwPPu7xQI2gVzePWqenCxKsPJM30RoK3Lc2MNFZm3HLY02uT+ab+3O2itBCmN
 fJKZ2bFndv+PSZqiminIv27dcFS79LchLxqj4VHLKlVluURoxxGWaRp6tNO/ZoAMzrrAAI4L5BU
 AMKsWwmwpjpviADgvTz5Yw0NGY/Haw/uMw+pmJJhcS5DW42dad5cIrieWDGXRBjm5TYCazLFaWX
 Kfc9zGPSL8sSXCDAfTP0E2PNm73g0CFmsuDprvx+SYE8DXfKNDbAMtoDy+ZKaFkavBAJN1aLx3q
 g1wTm+B8spKX/gRTb9LxR3xksQ/igjz4KwclHP4R2Io5s5hsQlWnqpKOT3Nfg0tnbXrbuRP5U/q
 pwOUyGe8wsJwyiQy8rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX57dg2hAzLNuV
 cm2Vf91kFyQ+oHFXrI2iAYeRqN6wbgld04vPc9H7uOZEnzz3/D8cy4wuDSFEs7CaEHJBVUSsJaT
 1w9yGR4GpinujdumV4L25l149BvOKuA=
X-Proofpoint-GUID: 688EH7gTlboKcs38YGAx8omDrgHwuQ3c
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8b6e7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=d1GJVicS2NaZ5qTk1R8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020064
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Farhan Ali <alifm@linux.ibm.com>

On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
devices are reset first via the legacy reset hook, IOMMU mappings are torn
down before the PCI device itself is reset. For a PCI passthrough device
this opens a window where the device may issue DMA to addresses that no
longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.

The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
should perform teardown in the resettable 'exit' phase, after all devices
have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
from the legacy reset hook to the resettable exit phase to close this
window.

Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261028224611.240515-2-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 32f78a1f21..69832e9cf1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1786,9 +1786,9 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
-static void s390_pci_device_reset(DeviceState *dev)
+static void s390_pci_device_reset_exit(Object *obj, ResetType type)
 {
-    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(obj);
 
     switch (pbdev->state) {
     case ZPCI_FS_RESERVED:
@@ -2019,10 +2019,11 @@ static const VMStateDescription s390_pci_device_vmstate = {
 static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "zpci device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_legacy_reset(dc, s390_pci_device_reset);
+    rc->phases.exit = s390_pci_device_reset_exit;
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     device_class_set_props(dc, s390_pci_device_properties);
-- 
2.56.0


