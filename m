Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E922CCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTlD-0005ap-ST; Wed, 24 Jun 2026 15:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTl0-0005XA-Nq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wcTky-00083j-1N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 15:59:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEVGEU2562366; Wed, 24 Jun 2026 19:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=IpaBH
 6rQs/JVSlvo2pJdyMQwFZskYQ/gRorcE+dtrDo=; b=A5e8gtDB+5Muzw9HPirrf
 ouykxjjhSaE8H2iPc641JA4I2v8L4vRCh6PZuvjulqUiUothtMwWtFvpLDhxW8jD
 rQCuRgzHlgGO49LolJiCjFtLnfdIGh8gyMfTGBjJmPRqnjSE2RITRsRpG1pzxNZf
 f9Zdq6Bj87KGKdXXttuHy7/BQfUGf/GLGFq4hyxNBWMOWxkxWv8bMDGyUENZXpAY
 CHojUtYHG2zuD8pAcBv5uQFoI9k3sWqmiAt7tjLAkahs1gPid2BTkRGVVGOQN//J
 ny5vgKfwcA1BWghb187lwunKE8wpxO54gWqKQkmhRxEdWBbvCnaXROYYgfbtDXgp
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfue1vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65OJwck4009044; Wed, 24 Jun 2026 19:59:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas3kx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65OJuO8E004335;
 Wed, 24 Jun 2026 19:59:26 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhas3kwx-2; Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 1/4] amd_iommu: Return int from page walk status helpers
Date: Wed, 24 Jun 2026 19:59:22 +0000
Message-ID: <20260624195925.1254462-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
References: <20260624195925.1254462-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240167
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX1oRu+IW4PD0P
 Z1apk0LR5qFn/zOWWVd8kx1E4tK5I7nAAPIUpe+qnKk0YpgN26p5cahpStDBBAjo4c09IBKv9F3
 nxo4aOHjv3EhQy+YShglw+n4r5gB2X2V7M8XTCgzr5KMelK/yEUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NyBTYWx0ZWRfX/KPnt16M+XrO
 0UqGQAFGJtYup95SE3/hFDjn8KSsjsLEybMuzy0LYAzRGF6LOvfvIokZ2v4IgRrqZqt5aV+diLj
 bPyN9O/2tSpzqT4np5GU+/7/16t2g4GfI0IyvxyWhTL4bZju+Er1NGdDPGaKXVcwmUvyYh2ttiX
 GFI3gzy0/s0OQe0IUNxprUYYRuQPpRmnnNYXo+Rs7Fa4fRVrE+YOCRF5E3JCMyV6bFyQZ8Ak29c
 qBkt+87Wo2PQ3KU4gXVhuxAftREwD2HzIRODrEyQmM1iuHwFInPb15NHNl1SSg5KI48C1Pw251E
 7tOj8tNl9VkaBhglvsVqcDtlgbil0hz1QwTVOcsblEx6m4TAl/3zcfgz/itcAvhE/NrE3emWkGB
 B5oVUWjIfj0Uu0cMvQtGXRm7r3ImeC7P43TMdnUMwfH/uTXgHwk=
X-Proofpoint-ORIG-GUID: YBvAnb2Wb4X14QIHAjm9LrREzmp9P2zN
X-Proofpoint-GUID: YBvAnb2Wb4X14QIHAjm9LrREzmp9P2zN
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3c371f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=CPMDAz_8QbydQVlharwA:9 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
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

fetch_pte() returns a status code 0 on success, and (small) negative values
on failure. The PTE value itself is returned via an output parameter.
amdvi_get_top_pt_level_and_perms() follows the same return convention.

Both functions currently return uint64_t, which means any negative error
values are returned as unsigned and then converted back to int by the
callers. This does not cause any issues in the current implementation, but
Coverity flags the type mismatch and potential overflow.

Make both helpers return int, so the type matches what the return variable
is (0 on success, small negative value on failure), and also the type used
by all callers to store their return values.

No functional changes are intended.

Fixes: a1c97c395729 ("amd_iommu: Sync shadow page tables on page invalidation")
Fixes: 786550e2d38a ("amd_iommu: Follow root pointer before page walk and use 1-based levels")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 79216fb305..0d273fd33d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -659,7 +659,7 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *   - IOVA exceeds the address width supported by DTE[Mode]
  * In all such cases a page walk must be aborted.
  */
-static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+static int amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
                                                  uint8_t *top_level,
                                                  IOMMUAccessFlags *dte_perms)
 {
@@ -702,7 +702,7 @@ static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
     uint64_t pte_addr;
-- 
2.47.3


