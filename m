Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FB606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=SMHDQdgO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMadj-0004Yc-QS; Thu, 29 Oct 2026 20:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadZ-0004WJ-Ry
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadW-0003ci-6k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLYNiC1913021; Fri, 30 Oct 2026 00:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=O7UOL
 G7qLDkhqiUSc32Mb+g0QQ9McU5BeJZscq4zAds=; b=SMHDQdgOHQY1JsDrE3sjb
 8kZ6JXwMVx8w5cY4m3KauMCRmdHmAs9O3RG2T7nc39wHRlo+mOunyaRAwSRkiKMw
 jxVMJNxp7DHqdPKTvx3hnmlWYyROdAim8UBaPYe0Qy4G8zRVivWtkHY3wP0cowxk
 8As2kdI+DTtzwnaW41ZwmcQk2hFR4cl92NboQ+6WCJEWb3fQaghfEd3ObIyHlCCF
 xCsx5DggbfmeVv9jpovOgoy69m+xIy+g5CNLh5YTxNEMc4l6Ormru//w8vHsz8TK
 mufAe2n4etCin6bwdE8KOpHOL7MPasupKv6138DrKr/395PWKSOVjF5mNt6IFmOA
 A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme5mr4ch-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNg6vS2004177; Fri, 30 Oct 2026 00:38:19 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-2; Fri, 30 Oct 2026 00:38:18 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 1/5] amd_iommu: Do not create duplicate MSI capability
Date: Fri, 30 Oct 2026 00:38:13 +0000
Message-ID: <20261030003817.3521476-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
References: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610300001
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX7jIFYUgijWWY
 aGD7zbtm+7nE73cxqes7JuS+v+EY7vIAtvNeTpQwsbIXV7EANKwEomwkj7dct54/wC2/uFthIoF
 NoA6qyS8LxE0jkgM2lvR++rn2VT52H5Av0rvV57dnJQjhBRzgzAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX83kzk0hle8ZT
 9P5lz7YxkHiv/fUPLDQW8zPw/Tj/qONMruBBE3wjwNSvJLTijwDcf+dvr4dyps7zVtzckIiGE1X
 0ckfV6lhEFI7+UHu4tlJ4mZAPqZuOixL44y2Ibu2og+VMOtiZ7HRPRjhnmxgiOzOT32CPZ4so/r
 IduQpb+YSZW3HelgC1dOKZ3gs9UgY82V2fTmeDHcfWkkT+ApEXHWhaKqsHlpJ6IxgARtPL0S1r9
 buhsNpbZUvfITjhGhfkrU47qSW/QKktKjW0ruCYlgIxXUWjudggbkcfEeIINCb4L915l5o1riqO
 Hae2PhwHB2PQ8AqebV1j7YgDyxeV6oWRruXahAUrj2VC2x7hM5shjpY5p6i7pqptHzTf9DdYmk9
 d9JdDRPVrVpoKKhKDtdrFJjKWPpcY6gn2jYtdvc/v8b+A3hxYT3aVt23zfygRvSOiG9++cmsNKa
 Le0PQBeWomOzy0AEpsA==
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ae3e6fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=w9z83O1xWNOsbQloCHQA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: SsZARSDI27OQ9_UI11KWv2WGxAfsXXaB
X-Proofpoint-ORIG-GUID: SsZARSDI27OQ9_UI11KWv2WGxAfsXXaB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dongli Zhang <dongli.zhang@oracle.com>

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
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2d5c7b5cdf..fa590c9223 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2576,11 +2576,6 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
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
2.47.3


