Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C00CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTl8-0005ZA-Cb; Wed, 24 Jun 2026 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTl2-0005XR-A5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTl0-00084e-QB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:36 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEVFdp2562352; Wed, 24 Jun 2026 19:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=mnJjVbHWDRE7lon15/r7YUtGbzFZo
 Mohrf1wfktidIQ=; b=RrF6Yj92CqmTxFVanLHDDIxNQdS3En6eAeiZoqpZ27mtz
 gWKCMh9s2405sZ4f25lkJelrE4KfSH/7FdCENAGxkPOmNFMF3bE4hnZJuCw+gZet
 qO1obpEuMGEmB7kau5EobgZfkSmjNRRwCi1pFtznVNnl8++hk23yJ7zx3OqQAQlO
 4IyZbTo2pCmGSM8z0/ejZl1aAE+J40V25OW4mYo3WBIkrsdqXTs5FU9JL3drBjdW
 zXFTqSQiUW6Pl/0D9AVhiZLOmu2q+k6+nu23EkPZn3z2omY26A+VQzsYvOpycdOH
 SRu8fsiAZu9AT9tux/B0UQ8j/18CBF6L1dbHI63qA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfue1vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65OJwbDX008967; Wed, 24 Jun 2026 19:59:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas3kx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65OJuO8C004335;
 Wed, 24 Jun 2026 19:59:26 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhas3kwx-1; Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 0/4] amd_iommu: Fix Coverity and endianness issues
Date: Wed, 24 Jun 2026 19:59:21 +0000
Message-ID: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=603 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240167
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX/lBnWeO2scrK
 Yle2N6Eo+N6UcPxJmcOoNC+4azADiiZzFWgSBwNqez1BlpDpYjIxdFsGvwDz4C1pII+SdeYwACv
 xugKjubyEIGg5MCSJnGUbdGsebQpuK4Svuxx9TxTO3VEHO9vVHxh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfXzWPXJWrSMfM+
 YSmNXdTlSWxf7W4FfGFwRZROypHWtNH+oWqxwAmXtFRazTfJ+1nGL+SESvM2B0Le+BmTSLpn5yD
 hYTNQsSDW83NLwcu+C5+UG46K97s7uU2Z44YTuyZ7KUwKaGrO9ciN1AEbcUhsPFHCEJP5u58VqJ
 lVeoRIP7ejifyQIJrprUlTjoNVgjnCsUzCGhewQ+zUNCctuAedwkkP8wOT4shkA/6Et9dcf8qq4
 Pvh89jjEG5T+5nzMqHvql48t0DM+UjSsrzoApeQJuhZLBAK5UjawOe+RQda82w6aDDfL62nVbUM
 0xD0kHJY6RGtImoSVEO+sWl63XHuSQwBTkxJau0szo7/iYP4V0RYIFkGR1QDNWSWFEa2ozNxmg4
 /ZLPiVtsIMMFKetjXBHI93CnDZvmjqFBLfP+BdQdUbwfLTlV3ik=
X-Proofpoint-ORIG-GUID: GRYCitEm9vWc0oSLrXfocwRangouxklf
X-Proofpoint-GUID: GRYCitEm9vWc0oSLrXfocwRangouxklf
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3c371f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ZDHTvDlGPrLvpomD27cA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

This series fixes the AMD vIOMMU issues reported from the 11.1 pull request
Coverity scan, plus follow-up review comments pointing out bitfield usage and
big-endian hosts compatibility concerns.

Although patches 3 and 4 fix correctness issues in big-endian hosts, these are
longstanding portability bugs rather than recent regressions, so I have not CC'd
qemu-stable on them.

Thank you,
Alejandro

Changes since v1:
https://lore.kernel.org/all/20260623005813.984238-1-alejandro.j.jimenez@oracle.com/
- Added Peter's Reviewed-by to patch 1.
- Dropped the standalone "Fully initialize XT interrupt message state" patch.
  Patch 2 now fixes CID 1660056 and removes the XT bitfield union.
- Added two patches to remove IRTE bitfield decoding and fix command buffer
  endianness handling.

Alejandro Jimenez (4):
  amd_iommu: Return int from page walk status helpers
  amd_iommu: Decode XT interrupt control register without bitfields
  amd_iommu: Decode IRTEs without bitfields
  amd_iommu: Fix endianness handling for command buffer entries

 hw/i386/amd_iommu.c | 164 +++++++++++++++++++++++++++++++-------------
 hw/i386/amd_iommu.h |  63 -----------------
 2 files changed, 118 insertions(+), 109 deletions(-)


base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
-- 
2.47.3


