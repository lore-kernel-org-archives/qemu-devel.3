Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EDCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1E2-00089E-5R; Mon, 03 Nov 2025 15:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Du-0007xd-Om
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dr-00007w-3j
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:18 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KOrmq032642;
 Mon, 3 Nov 2025 20:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=o+FT21PEX9VwS+vb
 0ndSz77Jyo0mmVsAGrYuEJKxtEk=; b=iYFYqwbcN2VBLcb+5irvzY4XkhMPoavn
 u3SB0YFxMB63eeJo52Fc8ZGMexJ0Pyhgs3szLKsHxnTwpvQJo6SaB4e6CF7LLHEz
 AVXTkwEZBjpAyDybBK2+JkldORfa8xLqO2wx6QQ5Q+GjG9vypy9BW747CwEUCF0c
 R5pJ7DzvNz/E3pMVuJygUV8oWdMirgCofcjINCNTIT5pO7gQl1nk1AMnG0N4Mn/9
 deRlj5J1po4VqRtH1WinnqCW7T046FBFz5GO/03axTbVo8rUFmtFn3GXVjnCuiYM
 F/aqeIp4qlClY0h6uwq3wDdCz/TvX48sAHxfukNS+pGtYMlxyllVSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73dag0gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3Io3bM009603; Mon, 3 Nov 2025 20:32:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nc6ea3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A3KSvRx040083;
 Mon, 3 Nov 2025 20:32:09 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4a58nc6e9h-1; Mon, 03 Nov 2025 20:32:09 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org, sarunkod@amd.com
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH 0/3] amd_iommu fixes for 10.2
Date: Mon,  3 Nov 2025 20:32:06 +0000
Message-ID: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=857 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030183
X-Authority-Analysis: v=2.4 cv=e7oLiKp/ c=1 sm=1 tr=0 ts=6909114a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=kKSIff3KyANLwr03tfUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: 1i5ZoyuY-nNj3xAKEjLkK2WOcRGYiAsO
X-Proofpoint-GUID: 1i5ZoyuY-nNj3xAKEjLkK2WOcRGYiAsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MSBTYWx0ZWRfX6i8bjbfC/jgH
 t+ScakZ6AtCyihXsAPyPKUlwsYacBwURz0dTAeXIv04J+rAj3PEaFrwAq18VEKu05OdkM0XUp6m
 mpZx90HVyRMp2BNfAM9c7kt6wYWzd4C9QVo0ysZYzZGv7Q89Ou7RuiE0G8dVRE9B7w85dq3ZKiW
 uHCqp1OKWF/MPYlQ2Zo+5F1DyaInqvzEqBKVfchw0mZO8JojXp0Sh537S3Gzt3WpaBzqfRzOb8K
 gfq1SZefgOAKyRnoLNS2eDiGPPUo+G9q3CMz7ty3ta7dYmxsTBzq9BL0GkEClORF6yBLPd1Qy+A
 ACzNYn9Nw1Jgyr6ABXEcnwUb9dYZOZjF85BNEc8NsS9MJlffKRXlE/JBQWs6UuY9E2RO/wfN2Jq
 0yO6cjxqozqo2hFex0wwXo3Mye0UUG0qsk0colKNU2MVBgcWB7U=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi,

Please queue these AMD vIOMMU fixes for 10.2, with the following changes:

- Devices now work correctly when placed on PCI bus id != 0
- Fixed IOTLB aliasing when using emulated devices and forcedac=1
- Updated maintainer entry

I edited the commit messages in Sairaj's series to correct minor issues in
addition to the ones you pointed out.

Thank you,
Alejandro

---
Also available on github:

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://github.com/aljimenezb/qemu.git tags/amdvi-10.2-110325

for you to fetch changes up to 6a242996080d8312855511600cb93cc84d495e4c:

  amd_iommu: Support 64-bit address for IOTLB lookup (2025-11-03 19:44:00 +0000)

Alejandro Jimenez (1):
  MAINTAINERS: Update entry for AMD-Vi Emulation

Sairaj Kodilkar (2):
  amd_iommu: Fix handling of devices on buses != 0
  amd_iommu: Support 64-bit address for IOTLB lookup

 MAINTAINERS         |   6 +-
 hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |   6 +-
 3 files changed, 117 insertions(+), 74 deletions(-)


base-commit: a8e63c013016f9ff981689189c5b063551d04559
-- 
2.43.5


