Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8812606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hYyp/04h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMada-0004WU-Js; Thu, 29 Oct 2026 20:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadY-0004Vo-89
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadW-0003d0-EF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLXjH73672987; Fri, 30 Oct 2026 00:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fS878
 JvDwSoxy21uWvQp1e6kUR96roNKbLzoZATfr7c=; b=hYyp/04hEGxpBnBAn3tlL
 9yZ9JvgYUSFHs3BP7FcQfY3we5zj3mTGxw4hRR4eo/G3GKi1PQWa/IpPcqmHskjv
 8AhPmTZB3ntNHIY+VvH+bC6XhUruiktdLGdbNlLlk9A9CVHtxBlCDNrv4denGHBv
 XsyC0IuGTyE/AvGKYlrjnM4hu0WE10Zj55wWzisThYQ9PeL6NNfzRLQGfCYsrXPz
 gOWMY4jGNMj6+d6lZf4szQEX/bOoQfNFUZ3kHRzw4FO/reTs1aHAQQ+XpyDygKQ7
 LTj6NwPDpgqN9IX5d/0gsqXQL8IH+M3/rSh7g/I6x4Ver5QkrX0+nFmvCHJ906ir
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme5m04b0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNg6vT2004177; Fri, 30 Oct 2026 00:38:23 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-5; Fri, 30 Oct 2026 00:38:22 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 4/5] amd_iommu: Make extended feature register read-only
Date: Fri, 30 Oct 2026 00:38:16 +0000
Message-ID: <20261030003817.3521476-5-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=T6EZ3PKQ c=1 sm=1 tr=0 ts=6ae3e700 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=7djCcrdboBqnOOnk728A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: wDKLyuU7kYR1J5m0A3PnM95-i2AzBbX6
X-Proofpoint-ORIG-GUID: wDKLyuU7kYR1J5m0A3PnM95-i2AzBbX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX8gjnLIf5qbEo
 zSCyUNohqAQXBSszHMUKSBR8ocxogykixod6+dKlR1euKf1jjS5LVSdKSFVIDg/hU9I4lPfoA3a
 h4s2PE1ZxmBoDgOoW7ds9g25w5SBBhEwgnitljTqkQQ1Oolgeh7ljlmLjYg7xbyIQ+3HVbW0M/m
 H21sZlx9v1P2e/fZw3YgUN+dmA48yM9VmCiNatVqaJyTsLHz2CsUKoTnVoSjLsXVaBbCjxejxTQ
 uX4Z9/Rn6RYEnwnaNklUyDzci1WAUH6oyKnYG5ZWtQnBQ4eyMi+iSNZD3wvmMNESZvEnlIG6awb
 4zRX42LDDDtfpe4RVS2sZDQYvS8NShLzAIQEpol8h9oeA+vEDPhqrD+JuebuQrAEn1QtIe8Jdgc
 Gk7os6fcWrTGPk8Nl6ExH6i+G31bGg83jLYLj5uAYl3Nj0IPEBKVWT/GZ/k8jk8m62xDUrvaUo7
 D8lRG8yUz9Vc8duc1CA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX/d0OeQ3wu+Pz
 rd6m0Re2Ouzasp66qv6aRths/jzxrw838YKZxAyRt10HK9wkK56zBnDKNs67s3B/gK2jQErOw/d
 GNHVTmZm7MV0nWnDqc1eTT3Cs/89DfKmKHS4DwLw2q7nyJMvChzG
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

AMDVI_MMIO_EXT_FEATURES is populated from QEMU's advertised AMD-Vi
extended feature set during reset. Guest writes to this register do not
enable or disable any corresponding QEMU emulation behavior.

Make the register fully read-only so the visible feature bits remain
controlled by QEMU.

According to the AMD IOMMU SDM, bits 25:24 (DualPprLogSup),
29:28 (DualEventLogSup), and 37 (USSup) are not specified as RO.
This commit modifies only bit 4 (GTSup), while leaving the rest as they
are.

Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
[ajz: Remove guest modification claim. AMDVI_MMIO_EXT_FEATURES writes are
not handled in amdvi_mmio_write(), so a guest cannot modify the register]
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 00842fd487..b0a721bc00 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -244,7 +244,7 @@
         (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | \
          AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
-#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
+#define AMDVI_MMIO_EXT_FEATURE_RO_MASK (~0ULL)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
-- 
2.47.3


