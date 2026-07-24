Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62D7C53219
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOT7-0001UA-Bu; Fri, 24 Jul 2026 18:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSm-0001RU-1P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSk-0001Gy-4y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJcgmc4076183; Fri, 24 Jul 2026 22:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=VoZAP
 +iiZMnn34+A+4dIefcWKD3m13aNSr8Jjqr7aw0=; b=CLEmYqz/Ru8mDyBLYA6Rh
 9Vd47HuMubVh4DQF+5mElDVei/gtsQUvns0SW+g9fCpC2MVgD4J3ISP641vjB+IE
 xMJkbvwe/5RSJlDem/3JIZgaAfIpYSXu/L6/bVGfn5XFb1Vhdv2YLncWQUkG31+V
 wJahFGkbKWIGfjr51jh2CZC2/8G3i0Du0iU/CYbVwjS6kdjP0s+NQIfFDhm3Kyu7
 44VZEHWnPWM1w7+QzdrREZ6uOy2o9CHd7S8gEgpuNk1uvirZnBsHn/uwMv4hZHuq
 GXEwTCIHWyAjSma9sVyUpZkyvMo3/mw0By1lRRgpyT9Da6O5oHIyOz4ICGNQECVH
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv98hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXZEW028331; Fri, 24 Jul 2026 22:33:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:46 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTO029565;
 Fri, 24 Jul 2026 22:33:45 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-2; Fri, 24 Jul 2026 22:33:45 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 1/5] amd_iommu: Do not create duplicate MSI capability
Date: Fri, 24 Jul 2026 15:31:27 -0700
Message-ID: <20260724223216.108667-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260724223216.108667-1-dongli.zhang@oracle.com>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607240203
X-Proofpoint-GUID: oU1e8Lej5tIbLBTen11qjibPFdVcm7-d
X-Proofpoint-ORIG-GUID: oU1e8Lej5tIbLBTen11qjibPFdVcm7-d
X-Authority-Analysis: v=2.4 cv=IsYutr/g c=1 sm=1 tr=0 ts=6a63e84a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=w9z83O1xWNOsbQloCHQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12114
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX8cL0IC0JZySC
 bNVJrKglaf2rnDkyLxj13vreNRho7sdDOiOL3mvRkmSkBOgEBO6B/UKbC/8YBdFA27FjibdZN8/
 pbDTTumvcvAu/Dp2Ai1kJWgX/bPziuA/HzY+2QAqMLOkakN4UpsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX9O+cCPGesHwm
 x75I4DQRB+lstw6L7q6FMwQ+bs2eWDXlWVr3HTNhheulpH6YGqNEPIb6t9td6cPwn/nzOBKggvm
 QQ/1OjlvV7jSTdfk9211iPiocr0n7Ecln9wFiE6e+ZjJtWk8610kyEPlT1fa2bUGGWyCcjeOGop
 z/1KJg4eQe9rgu0U9nSy/QzSPpmacLkO/In2kUs7LgAVhCYxZeBZg5NyRb39E+qDjZF3zgQSV2h
 OuI2p+eoMUS+lNXUQdDnbQjW+LNz5o+FW5AUDeNxhFB1P3Ad4gEjk2PRDm15KJ0Jrpo01bEPtyZ
 5GAgIUJl0Z30hCOxmgV5GtCSKlgqjOyq6LxjyN05ZK+O3Cc0aBLFpUqEQX++XzGTD6z4zyw43Bw
 zAwkUTnpUxXURkudk8UYFi/h8m2bEqdx/EJb6mApBcmRr25lCWo4b0amebVDdq2geU7CFi5Hgfq
 J4y7V/s3CR5Bl3tdrIW5SSrsZpyKI20uhpVHGK+E=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

amdvi_pci_realize() manually adds an MSI capability before calling
msi_init(). msi_init() creates the MSI capability itself, so the device
can expose duplicate MSI capabilities to the guest.

Drop the manual MSI capability and let msi_init() create the single MSI
capability used by QEMU.

Otherwise, there are duplicate MSI capabilities in guest VM lspci.

[root@vm ~]# lspci -vvv -s 00:02.0
00:02.0 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 10h-1fh) I/O Memory Management Unit
	Subsystem: Red Hat, Inc. Device 1100
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin ? routed to IRQ 24
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee02000  Data: 0021
	Capabilities: [5c] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=0 MastHost- DefDir-
		Link Control 0: CFlE- CST+ CFE- <LkFail- Init- EOC- TXO- <CRCErr=c
		Link Config 0: MLWI=16bit MLWO=8bit LWI=8bit LWO=8bit
		Link Control 1: CFlE- CST- CFE- <LkFail- Init- EOC- TXO- <CRCErr=0
		Link Config 1: MLWI=8bit MLWO=[6] LWI=[6] LWO=N/C
		Revision ID: 0.00
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00005808  Data: 5c05
	Capabilities: [40] Secure device <?>

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
---
v1->v2:
  - Add Fixes tag.

 hw/i386/amd_iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 90252c52af..a5682747ac 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2567,11 +2567,6 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
     }
     s->capab_offset = ret;
 
-    ret = pci_add_capability(pdev, PCI_CAP_ID_MSI, 0,
-                             AMDVI_CAPAB_REG_SIZE, errp);
-    if (ret < 0) {
-        return;
-    }
     ret = pci_add_capability(pdev, PCI_CAP_ID_HT, 0,
                              AMDVI_CAPAB_REG_SIZE, errp);
     if (ret < 0) {
-- 
2.39.3


