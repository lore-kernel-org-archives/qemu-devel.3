Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6764CCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzila-00066p-Vg; Fri, 19 Sep 2025 17:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilW-000669-Kh
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilT-0002UC-9g
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:38 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu68Z015671;
 Fri, 19 Sep 2025 21:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=cqMJu
 dA3K5i8GrXqZJbEflLo7iiZ3q7DOUER9/x1Zmk=; b=dZ7VCbHYrrVULbeiYAF8a
 z2bRODjkN+C0qRXcDmwy0ATa9W27g1xyi7WLsqJzKNXwvqMg34eiz+6paasLKAaI
 5iJyLexKNLpqFZK3T5WzyRTTHaH1SiDi4aj4ifxaFhO+3Yu/gSQkG37lK3VEzEPw
 3oT1cPzdPCjBDx7lerunyb2QCMgF6tUMazM49PRpubOtqgkWjp1UplV9barFdDRr
 f7wyQTJkzjJvoNBfeI/mDrQ5S3/ShuUAn49JifojoZbiL4lUjhPS96w9wjeCYPyY
 itZ8XdTTi/ySPZNpqmIT4D+DZbKhFnSprksoFzRbOlZUt2yjXwBxaffUHvaxj47p
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbxdpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JItLGj033730; Fri, 19 Sep 2025 21:35:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm01004301;
 Fri, 19 Sep 2025 21:35:23 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-3; Fri, 19 Sep 2025 21:35:23 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 02/22] amd_iommu: Document '-device amd-iommu' common
 options
Date: Fri, 19 Sep 2025 21:34:55 +0000
Message-ID: <20250919213515.917111-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy4eGtg/kwtsM
 25wDE9Bd93Tw3O8SR2txN9z2mMWLn2/VYlJ+cDX2YJQxO+BueKzdM21fWv7FwPjcjqiHVwIw4oE
 NG4dQV7Xlo8PAHlTpnZ7xjlWS9CabZEoUh5tN+ueviOPMI98z/If365o3mbCvJoZpuKyfezdSdC
 fLY8evGhwl1R+XSBIrnv6hX24dLE9DRoA4/ksfl7cHKi/eqMPpwmUE7qg7/kzIQ/AdTAKPUcnpX
 SvfbYJisOVOPvAPf9qJhiG52fdwurervG2rVDkaSaZDktsbLW3eIZYPDurF6rV5ck+hD/MI9Scb
 5u+K79ipl6AYwdwuDLv8CLlLHaolzRlHe/O3DcsriSX7Wlbrcf5zS312pZiYv27Z6xwN3t7FRgv
 AFQJZLes
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cdcc9c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=gipPy096A3ZiGWeMGKsA:9
X-Proofpoint-GUID: D9uyZoKDAS_fRcPB7OcuSomlGV9iR_ZO
X-Proofpoint-ORIG-GUID: D9uyZoKDAS_fRcPB7OcuSomlGV9iR_ZO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Document the common parameters used when emulating AMD vIOMMU.
Besides the two amd-iommu specific options: 'xtsup' and 'dma-remap', the
the generic x86 IOMMU option 'intremap' is also included, since it is
typically specified in QEMU command line examples and mailing list threads.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 qemu-options.hx | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3e67..6615123e6a11a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1238,6 +1238,29 @@ SRST
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
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


