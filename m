Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F018CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3PJ-0008OD-Gc; Tue, 09 Jun 2026 16:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PG-0008NV-J9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PD-0000Mi-5O
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:41 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659KBuAs3718354; Tue, 9 Jun 2026 20:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=nI8p4
 se1GPvXLWM0FkhDNNSa/V/GBb35nS0CG2F0fLs=; b=Hfb8uKO32MO96j+/OQB/U
 uDtBjqXpIYOytD8sn9Q+STNqxUNokK5eYW0yv3j5llh1WX82ADMHxggMw5JXU9IC
 33K6crRUKcwMIBbxoD5TaVO919HDxwzhyKa+ICmO4Xoc5Ij602dmLrFHL83D90pt
 QKnNuXWfYm1WVcYt2+cLuU8ucta1LkuioULtN/5uPq8V6w7Th5r/Mdf0nKXQkSPQ
 w0SSnn0PxEvkwY/p1VzJpzLZyUvrWkdvPiCwurzqJ2UrGRoJfOMGvRbU97YiHTW1
 aZnotklSk+LM5zHBc65Vrr7OmN6LljN6h9REnT4F+P2Gb44P2G8c6LfpHqfc4T2S
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emaf95arx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 659KmX3L023220; Tue, 9 Jun 2026 20:50:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ema0qn7mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:32 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659KoTpN030607;
 Tue, 9 Jun 2026 20:50:32 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ema0qn7ju-4; Tue, 09 Jun 2026 20:50:32 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: [PATCH 3/4] amd_iommu: Do not latch unsupported GA log status bits
Date: Tue,  9 Jun 2026 13:43:34 -0700
Message-ID: <20260609204403.323149-4-dongli.zhang@oracle.com>
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
X-Proofpoint-GUID: ejkLztwXp9jIVxNW7D5qYLy13XNnMoem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE5NSBTYWx0ZWRfX8u3UoDV74ZHI
 cxz4+LibovXrGDS6MdUp0ELzYlQlxby7WRhpkzL29BLTlKKd9bVzsJHCT6xCYdnpPfa5WVQrYCx
 bzUnG8tXNHyXEG6Lb4MyIUEYTzRo9PWUoQAq5RnVhNb4TK/58oeL18A5VbbmQi/Vco6sxMA39q7
 u5KqXSkLADWBcmT8wYTZxfCg0iD29oAqwg03oBiS885EvyMCggPr03Ck0W8LnCgXeu9vnN51W6o
 aOdYRTgAxuoCtvwYj4cBBDEayfLD+3ch1kTCrm9vgS6jINBmRZhqcelLckVqhUB5gLxhLifPjo4
 KvRRr1gXscWXgUhBY9fHn6KfQN4p6gLTs9dbyXeFJ93uW1NSyTRvhSk3wl7l5ZhBfbLkXct06L7
 Yq3ReI6JEB1QJLdHeHRSHFcVmz5RVUyg4QFWmXXbPnK4M2AmO6+NYgNrHtcFU9KGwAYQMpR8SWK
 4QRRxXOCwkMhZa3ge5OyInqvZQzS5++2lrulZrIU=
X-Proofpoint-ORIG-GUID: ejkLztwXp9jIVxNW7D5qYLy13XNnMoem
X-Authority-Analysis: v=2.4 cv=OYeoyBTY c=1 sm=1 tr=0 ts=6a287c99 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=g3kzBQXNrAJJGXb_Qw4A:9
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
w1cmask so guest writes cannot create unsupported GA log status. This
does not implement GA log production. It only prevents guest status clear
writes from creating GA log status that QEMU did not generate to
emulated IO page fault for guest Linux kernel.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.c | 4 +++-
 hw/i386/amd_iommu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ca9d79bb51..996c154a3f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2414,7 +2414,9 @@ static void amdvi_init(AMDVIState *s)
     amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
                    amdvi_extended_feature_register(s),
                    0xffffffffffffffef, 0);
-    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
+    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98,
+                   0x67 | AMDVI_MMIO_STATUS_GALOG_OVF |
+                   AMDVI_MMIO_STATUS_GALOG_INT);
 }
 
 static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca512..0b2e8d207b 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -113,6 +113,8 @@
 #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
 #define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
 #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
+#define AMDVI_MMIO_STATUS_GALOG_OVF   (1 << 9)
+#define AMDVI_MMIO_STATUS_GALOG_INT   (1 << 10)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
 #define AMDVI_CMDBUF_ID_RSHIFT            4
-- 
2.43.5


