Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A9C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfwx-0003rn-7H; Thu, 01 May 2025 22:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwu-0003qm-In
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwr-0007PX-H1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNbi022593;
 Fri, 2 May 2025 02:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=RA2Lt
 f0EyegmdJBGDkE2+w28gEQf1v1EpWMa7OVBVO8=; b=Aspxikh894Dtub/p+Ypfc
 ZrGhip7ZWBB82s8+5ywOkoWjFT/rx89aUvwyX7iiuhIUVF0obPNTTjGQDveYezOK
 +LUZSAb+gIoHP7m5OYsUREs3LwRiUMZSRLv7oeg71EfaLrwKdCQZ3uB3lZnxiKtS
 A+vwmy2o53kpzIWvZ7eND4L0MM64m+lzWvJKRveu28WEgdfrw5YpImP6sx2WafGf
 j+8MddYcbv3iV7ItSdp29PHnTrQLqWOq+HfvzomKYugK+07dkGXR2yVt5Sa1kmiU
 NLY2kD70k1hclJB1GyPtQwiBweztQfGM0x8W0ZJOOFuX4JulT4VKhHe9eDOPrYoP
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uumday-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54206o0X023906; Fri, 2 May 2025 02:16:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkgywr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FErs011525;
 Fri, 2 May 2025 02:16:07 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-3; Fri, 02 May 2025 02:16:07 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 02/20] amd_iommu: Document '-device amd-iommu' common
 options
Date: Fri,  2 May 2025 02:15:47 +0000
Message-ID: <20250502021605.1795985-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX/J2xd5SSJMKN
 0CV+/ByARSzuU8Z0WLY/rpLPj7oTu9+sM3a1G5DJT1UfInG9+iBeA7FKjHtKyPgoK47PIK3vRIn
 1NOK3+0U4im1BA2E+y/hQGIKn1ygVPWg6xvnGV1L9xDpk03sXhton1md87gIcq7D6AOPgmcK6hK
 7COuasZHt96rB1DfUkiptVc/gcHtPog1Mf1HEJuQmFY4EjXVBXk/i+lchruGYV8E5gGlyUdlJuH
 nn9XJt99K8OJqRbZfFLeYoPXjwlYZTLcHz4aLq4lbFDyaI0Zsjm4lx4KYDIX4+aBgKyn1vqT5Nv
 Ver4PmbmXe8XDE2fsLNc8qzwFm043BbKDIUq+kGPicWwGfd9WAaqFnRbA1RdYuTo7iOmMYJW3fO
 teVv/x2df9dOLS0k64E4ti7RxLwllvsIbwYr0lFrnbQ8K4CJeaWAMzzv2NI2f96w6hM9s+NW
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=68142aea b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=gipPy096A3ZiGWeMGKsA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: q2IKr-g9EvtfMtp-AX1KE4bVvVsr7d0I
X-Proofpoint-GUID: q2IKr-g9EvtfMtp-AX1KE4bVvVsr7d0I
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document the common parameters used when emulating AMD vIOMMU.
Besides the two amd-iommu specific options: 'xtsup' and 'dma-remap', the
the generic x86 IOMMU option 'intremap' is also included, since it is
typically specified in QEMU command line examples and mailing list threads.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 qemu-options.hx | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a30a..198acab48e8e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1226,6 +1226,29 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
+``-device amd-iommu[,option=...]``
+    Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
+    Only available with ``-machine q35``, it supports the following options:
+
+    ``dma-remap=on|off`` (default: off)
+        Support for DMA address translation and access permission checking for
+        guests attaching passthrough devices to paging domains, using the AMD v1
+        I/O Page Table format. This enables ``-device vfio-pci,...`` to work
+        correctly with a guest using the DMA remapping feature of the vIOMMU.
+
+    ``intremap=on|off`` (default: auto)
+        Generic x86 IOMMU functionality implemented by ``amd-iommu`` device.
+        Enables interrupt remapping feature in guests, which is also required to
+        enable x2apic support.
+        Currently only available with ``kernel-irqchip=off|split``, it is
+        automatically enabled when either of those modes is in use, and disabled
+        with ``kernel-irqchip=on``.
+
+    ``xtsup=on|off`` (default: off)
+        Interrupt remapping table supports x2apic mode, enabling the use of
+        128-bit IRTE format with 32-bit destination field by the guest. Required
+        to support routing interrupts to vCPUs with APIC IDs larger than 0xff.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.43.5


