Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D5CD98C6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3PH-0008Nq-Jc; Tue, 09 Jun 2026 16:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PE-0008Mp-Mk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PB-0000M8-UI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659KBYGe3717964; Tue, 9 Jun 2026 20:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=nPnLf
 Hr2KR80pWu/JIM8AXkZrCIjJWLwygALaGisYmA=; b=fyjF4fhw0jbNIL6YABkA3
 MX806NlOICfQQqZFuVoiwLA0vCzhsFviYZ5FhF5LYPqDH1/xJEe7WxB7wC9nz1kp
 LfrEXPOXSA5KSxaOe1ZWnRq3xIcJZ7VbDUbYGgUZou02VZiollTK46ezV24YeFcN
 i0jWSLEpJ9fiTUVdMRsqqPr5M4qEnP5ODBCYWzqVTiX8HO8TXb9SXaLOr/4c1nh1
 qwQ41Jjl6KTXEKQmUTaafg0ftJzTGuWAOrTHHL0h75k1ak82DBE0GB9yJVjR7Y1B
 VrpB4P00LAmuLf7bMx7cbTcFoFDakitCYFMAahN/63ZEWPRSJPbUxAFra1LFNmtq
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emaf95arv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 659KmXa8023253; Tue, 9 Jun 2026 20:50:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ema0qn7m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:30 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659KoTpJ030607;
 Tue, 9 Jun 2026 20:50:30 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ema0qn7ju-2; Tue, 09 Jun 2026 20:50:30 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: [PATCH 1/4] amd_iommu: Do not create duplicate MSI capability
Date: Tue,  9 Jun 2026 13:43:32 -0700
Message-ID: <20260609204403.323149-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260609204403.323149-1-dongli.zhang@oracle.com>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090195
X-Proofpoint-GUID: wxtpizBBvt5a-2Hqhi0B7MTh1RN6K47g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE5NSBTYWx0ZWRfX6RJQTZGYaPp6
 p7eGqWi28WlzXE0oNKg5FMuKtuDDpD02EvlkRZsK677EDwayU5G9aDgJlhXbbOiIkYbYufPkJWS
 /vxugSzfKa9BXtQsn4o+aSZoGkB4Yrzx3xp1WXMWBgIvVbtN9IR+9i0BtE+VDojzxVtduU1kzxa
 xO9A87kbsTS0qeKWgoNVBQb7aDU5MtYmIECtKFH0LjH41UsXHtQ3GXtMITQIbpARpGJ6XbcQocz
 h92CFRN60JdAoCvbddaGeT/vi84CpvLZdGEkkSCXOSwqxk9TQkFl4aJTEt2mlmkh5Z2Hva+014E
 IfEzN3cj3jf8OrW0TtKJyvQU0bTgmVYKNRqMJVF6NSU4wOBWfJ6xUnifEVOFJ0jMuLa1Hr3oJjh
 WaeFkWS1nNG3PZUc8u2VOpvfCVpMhlU8b6jDfjt14KKSF2RCFIvpw+aEx+PA4m0bPk5WfcAKBmp
 gOG8t6y2qV762qThrswoObvjwNKhDO03Se9x2UKg=
X-Proofpoint-ORIG-GUID: wxtpizBBvt5a-2Hqhi0B7MTh1RN6K47g
X-Authority-Analysis: v=2.4 cv=OYeoyBTY c=1 sm=1 tr=0 ts=6a287c98 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=w9z83O1xWNOsbQloCHQA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2..997d02eab5 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2422,11 +2422,6 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
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
2.43.5


