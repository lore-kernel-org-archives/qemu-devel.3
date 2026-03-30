Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1947B1061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7KA3-0007vD-M0; Mon, 30 Mar 2026 17:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9u-0007tY-Lw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w7K9t-0006FG-43
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:28:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDE6mO2688944; Mon, 30 Mar 2026 21:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=OoS4kr3LWWHZmmMk91qsAoRO55rJk
 Whon8rF5413HTk=; b=VpHv6s6z71FbGtlu0LvjgrPvXJlGlx66XPyB10wg7qFDf
 t44j6Oxam+Bua9Rk1GSQEED9mnULcpcEsjoz2jL7fvKl3tvZE6P4sZkNk0BuNv2H
 zRe5UymBp2lb9hac5QoECAPBqTkjmH4eQ49rUSl+G6n3aZS9et0DikqzaUHFx6uv
 vs6zQmGiJvPHPJ33LOr5GBwbeTPuAgrW+NX7eUriwHWY7VCxFRZsAJlDmSXw286l
 7WeeZA6yuzaCgfNinBDPK9P7VY4mWlEtkShT5EJdCp9F8AQXXQ7VJ9PJey4PXixs
 GvqRHzDsSazY6Kug3g2WsBNQ6ZvGauOn4ad+vBbtw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66v5k3em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UK8467036391; Mon, 30 Mar 2026 21:28:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65efn53v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 21:28:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62ULSISv018888;
 Mon, 30 Mar 2026 21:28:18 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4d65efn53s-1; Mon, 30 Mar 2026 21:28:18 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, sarunkod@amd.com, qemu@demindiro.com, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH for-11.0 0/2] amd_iommu fixes for 11.0-rc2
Date: Mon, 30 Mar 2026 21:28:15 +0000
Message-ID: <20260330212817.992673-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=692
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300182
X-Proofpoint-GUID: HJZ2QkOc0RhSvuvDz69LyH8K0_7M_TDA
X-Authority-Analysis: v=2.4 cv=G7cR0tk5 c=1 sm=1 tr=0 ts=69caeaf3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=RWxpEp7VAAAA:8 a=p0WdMEafAAAA:8
 a=NEAV23lmAAAA:8 a=te4cm0NsdgC6RsF14IMA:9 a=3unh6Pbajv6CBnL1DxgC:22 cc=ntf
 awl=host:12276
X-Proofpoint-ORIG-GUID: HJZ2QkOc0RhSvuvDz69LyH8K0_7M_TDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE4MiBTYWx0ZWRfX6GIcpxJGHXoH
 I4+lC62XPc+TLr1hE26w+1ou8Hgut/VdHPBP4p/YN2huXeFFWwaU6vk5vs/0nkcJx+w3h+I71fm
 Uc4d+qYTGl7teuYBwKHLowu1di+38FSFYfFhchwcPkr1S7OEfqVkskIeAP6EBqxtsZe6lsui/RB
 AyrqT3x8cmfICeabsoLDOgOAMl32n/TZf0rzfGLtosrZP1KmpA6wjEpDYhw9dr51U/4aoVqDTYy
 OzqqV6vFOvjkfqLjrYoyO9HuZmXnnK2kTJtJYlKV3n1HQ0WRpM196OIdZMDo/8OoAAauyIId132
 BFosdaxgLreTxwXBYZpwvJIzP7eAm6tY9eY1fJwXughjMPas5AtTgbHTAKARbW68WcLTGz987jO
 H8zMrI1H3oaYPUfyHi140QSApk2KJ7S+KCgLoKuOO8LhqhGhndPLHRMHOI2O8D/KgmeWZsgcJ54
 FYm1f39BUm7n6N8/GSyoK2MMjtovzAeldMY6WDH0=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Please consider these AMD vIOMMU fixes for 11.0-rc2.

This series fixes a bug in the current page walker implementation.
When triggered, the issue leads to extremely slow boot or hangs and missing
devices in the guest, as reported in:

https://lore.kernel.org/qemu-devel/20260225145831.28275-3-qemu@demindiro.com/

Thank you,
Alejandro

---
Also available on github:

The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)

are available in the Git repository at:

  https://github.com/aljimenezb/qemu.git tags/amdvi-11.0-rc2-fixes-20260330

for you to fetch changes up to 9728f609a871606b272fc37226f5af30df7ac51a:

  amd_iommu: Reject non-decreasing NextLevel in fetch_pte() (2026-03-30 17:23:54 +0000)

----------------------------------------------------------------
amd_iommu fixes for 11.0-rc2

- Fix hugepage mappings being reported as 4K pages during page walks
- Reject non-decreasing NextLevel values to avoid invalid page-walk loops
- Both patches should be picked when porting to stable release

----------------------------------------------------------------

Alejandro Jimenez (2):
  amd_iommu: Follow root pointer before page walk and use 1-based levels
  amd_iommu: Reject non-decreasing NextLevel in fetch_pte()

 hw/i386/amd_iommu.c | 136 +++++++++++++++++++++++++++++++-------------
 hw/i386/amd_iommu.h |  11 ++--
 2 files changed, 101 insertions(+), 46 deletions(-)


base-commit: dd3ee9c63d96b223c8d41bf5d65392eb898be626
-- 
2.47.3


