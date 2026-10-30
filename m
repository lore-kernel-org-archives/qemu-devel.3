Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GBJ09t6u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMadm-0004ZH-G5; Thu, 29 Oct 2026 20:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadk-0004Yu-Mw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadY-0003d9-Dg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U0BBbb409647; Fri, 30 Oct 2026 00:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=OmBs+
 FrQ/XtXVbUQyk/xjCjt9d7HevdPxF1DNOshKjA=; b=GBJ09t6uQ6utPDa041JeY
 AO7hFass3pdH/3RT6QY8ycEP6D95ppZmK8FQTIfMw85ADr9tLR/kz2hiG/0/7ruT
 fcww2R24pU7ggej4cuIPIi8OjuhNDr9OTk38E1EU28/qTkHngkOtp9MM+gZTukF9
 qGh0ufrnaQeTgS74gBJ3dB5Y/Oau7aoHMI+KIr9z9XngQWQDfULt9c6BMk9tAdHm
 tfwVce6fe8biEjwyNOsJKEMSkVu1O1jBupVkWiJIQxaEZVL2ReALn/SU73LoKG38
 qRj7A7zznDpwezN/q78966cSqDR9B+73MgS8gZS3C138V7YK7Bto32tM2c8pMuhn
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme5pr4bc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNg94t2004283; Fri, 30 Oct 2026 00:38:24 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-6; Fri, 30 Oct 2026 00:38:23 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 5/5] amd_iommu: Do not latch unsupported GA log status bits
Date: Fri, 30 Oct 2026 00:38:17 +0000
Message-ID: <20261030003817.3521476-6-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfXxHBVY0sj3fF2
 05LI+pmFqY1ss3vUMAZOJyieaPxlRXfb542acnj1YF8tolm83Ofco37Eb1OqgSOBrGIOtFkguC2
 9femzmnPpx6Lp2AeajX/P8iNCsSb4qu7/rG2jgLYbY7q6/e1cR9sspUH7ZJksJu6QrB+MmohFEj
 YnHIuqyYUi1coUqfKtliWIG670n/18TUWYWfHHWi3uy+YwpttxfXx8d2Mrytdtil5dAxm/zHqVp
 m8Zt2dvmMg1B4SVxYTwIjQGoCJuk0aUr9L6j7cP0AywHLVK8oLF1dHU9qGNrWv5f64AZcdKoas3
 5AeUCbYSg/SgNeCESqoRbbmG08v50nfYYXwLQbHXSwXusNw4BEgF/eNeUYx+LeyWBBwnkbdty1F
 4YQNC796uG5htSfB2BwIVb7o6R69ba7J66fRtZHuh4GWpv16rIb8rm5TVxtRQOG7aribri5966L
 XAT0eaFh8U2dmzeg0YQ==
X-Authority-Analysis: v=2.4 cv=SI/Xx+vH c=1 sm=1 tr=0 ts=6ae3e700 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=Lma_THHDjEIY_MpWOOcA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: iDXP-0_yeM_gmLLh1O0JJbELq9X3QwD_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX1U8D/Ux57c43
 SyI1KW64QGazn3SS9nL0vftas8X9fQLA8EXPAHjy6fV7ExUdobO5HWAIhUlSKweuoOI7KZn0/Gw
 ZUe+Pyns1p9vvSR2kPQlzQDS64zQBbLjd1cqkJfPqdimiYVuj9tn
X-Proofpoint-ORIG-GUID: iDXP-0_yeM_gmLLh1O0JJbELq9X3QwD_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

When QEMU records an AMD-Vi event-log entry for an IO page fault, it
sets the event interrupt status bit and injects the event interrupt.

Linux kernel prior to commit 2379f3485239 ("iommu/amd: Refactor IOMMU
interrupt handling logic for Event, PPR, and GA logs") clears the status
register with a combined mask AMD_IOMMU_INT_MASK when handling any IOMMU
interrupt. That mask includes the
GA log interrupt (MMIO_STATUS_GALOG_INT_MASK) and
overflow (MMIO_STATUS_GALOG_OVERFLOW_MASK) bits, even when the interrupt
being handled is only an event-log interrupt.

QEMU does not produce GA log entries or set GA log status. However, the
emulated status register still accepts guest writes to the GA log status
bits as normal writes. As a result, a guest status clear write that
includes those bits can latch a spurious GA log overflow. The guest then
observes GA log status that QEMU did not generate and repeatedly
restarts the GA log.

The below guest dmesg logs are from v6.4 Linux kernel.

[   57.818224] virtio-pci 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x0009]
[   57.821130] virtio-pci 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x0009]
[   57.824003] AMD-Vi: IOMMU GA Log overflow
[   57.825099] AMD-Vi: IOMMU GA Log restarting
[   57.826338] AMD-Vi: IOMMU GA Log overflow
[   57.827425] AMD-Vi: IOMMU GA Log restarting
[   57.828657] AMD-Vi: IOMMU GA Log overflow
[   57.829758] AMD-Vi: IOMMU GA Log restarting
[   57.830986] AMD-Vi: IOMMU GA Log overflow
[   57.832063] AMD-Vi: IOMMU GA Log restarting

Mainline Linux commit 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt
handling logic for Event, PPR, and GA logs") avoids triggering this by
chance by clearing only the status bits for the log being handled. However,
older guests still use the combined clear mask.

Add the GA log interrupt and overflow bits to the AMDVI_MMIO_STATUS
w1cmask so guest writes cannot create unsupported GA log status.
Add AMDVI_MMIO_STATUS_GALOG_RUN to AMDVI_MMIO_STATUS_RO_MASK. This
does not implement GA log production. It only prevents guest status clear
writes from creating GA log status that QEMU did not generate to emulate
IO page fault for guest Linux kernel.

Fixes: 12499b23315b ("x86_iommu/amd: Enable Guest virtual APIC support")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
[ajz: Add GALOG_RUN to the read-only mask per Sairaj's request]
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index b0a721bc00..3d2ee9faf5 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -121,11 +121,12 @@
 
 #define AMDVI_MMIO_STATUS_RO_MASK \
     (AMDVI_MMIO_STATUS_EVTLOG_RUN | AMDVI_MMIO_STATUS_CMDBUF_RUN | \
-     AMDVI_MMIO_STATUS_PPRLOG_RUN)
+     AMDVI_MMIO_STATUS_PPRLOG_RUN | AMDVI_MMIO_STATUS_GALOG_RUN)
 #define AMDVI_MMIO_STATUS_W1C_MASK \
     (AMDVI_MMIO_STATUS_EVTLOG_OVF | AMDVI_MMIO_STATUS_EVTLOG_INT | \
      AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPRLOG_OVF | \
-     AMDVI_MMIO_STATUS_PPRLOG_INT)
+     AMDVI_MMIO_STATUS_PPRLOG_INT | AMDVI_MMIO_STATUS_GALOG_OVF | \
+     AMDVI_MMIO_STATUS_GALOG_INT)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
 #define AMDVI_CMDBUF_ID_RSHIFT            4
-- 
2.47.3


