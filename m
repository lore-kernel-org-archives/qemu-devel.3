Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E3AC53209
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOT3-0001TL-AR; Fri, 24 Jul 2026 18:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSo-0001Rg-Rd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSn-0001HO-3c
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJcZAF4051683; Fri, 24 Jul 2026 22:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Ogw6K
 fwPRd28Gv+LiPJqwIP12opHUYeO91WIl1frHRc=; b=oqrP539qDcIB7T36cBI/P
 OM2X2ojH0WU64ZFGvu/HOf3El2HmSMXzVy/QFfvhzQE46W9iUbY3Rx9ALocG0y1D
 JP+cmtar+N0OWTyRB22+UuXn79pybI2SXp1SQfWzcrSs79OgNOyVhjDVYmUHkOgZ
 Y/NdrI1ySonedCC05weCHXz8U0tSLXfdwDaBkmZ4+AwhCoqffDWstHQ1KYWkHvis
 r6eoBaIAGHXX6WNywzMCTb9Yg1wGqG9MkcX2/aaZm5o02r+vb7fiUHdQhUYvSTyE
 GHaEnASYj5uUJ7COzCY7ruu+ZUvoXAQ1HEmr7wXa6yUKQV9YABAO1R4etiKn2wKV
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1mv96fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXYvd028227; Fri, 24 Jul 2026 22:33:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:50 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTW029565;
 Fri, 24 Jul 2026 22:33:49 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-6; Fri, 24 Jul 2026 22:33:49 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 5/5] amd_iommu: Do not latch unsupported GA log status bits
Date: Fri, 24 Jul 2026 15:31:31 -0700
Message-ID: <20260724223216.108667-6-dongli.zhang@oracle.com>
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
X-Proofpoint-GUID: leIwTeq3mRWwFnMXQfSGIo30De6aQNhP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX8bFMuZByg9WC
 cFYmsjhDO6rh4FEomCBq+DsEtpFC2yByS4x4e7zocL/Ei8L6BmGbw8ZvSm5A5V7oaQU+BIpvXWf
 wkeFogctuFkDX9FromxbtFJOBtzBT9nXEDsAV0whebNVg7asYbFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfXz19gUMHFlvaZ
 CROUiVd4UKLgWAC7ClTjfpPzG4f2YdWW0cfi5CZzK3AkHY3OkKjiMPtwPSzHBAOHioe+9Wxy61j
 vGn+bCY6uDrljtYr7PKrJ9BWCNaueh4NBuA3P+dnsy/mc2vkltOXKSVK7PM9pndj9p+3Pj0RFmY
 qrN8RWvQyiiYOsK+FjwiEZDYn/GFpEjohWiXrJDeYSCRosNInqu2b256eUYDKKBajPx1atS1T0t
 LX/2s+ztEz+U0vDytD0jZ+/YVWE5r99kLf0X+vF/DN9bCByJpifF76WvHA0jLFya5/pm7C2JF0+
 QxRUVVpmXOa6oSko8HljR+5sN6V+ciEWIuImRUgtvMbCj7FeaFQmhgGQerhrSSEyHzsKako9skb
 oMIvlVpE/oSPzb3Hr3XtjqxKTvBuQMIDIkbGkB+QkSzE6DCA1b1v2YdwsiN5ODrsaal9IRHJ1Ye
 BHmTKRZpMubAZcglqIA7BpSW0pAZqLVrrlSIDmxk=
X-Authority-Analysis: v=2.4 cv=ZpPd7d7G c=1 sm=1 tr=0 ts=6a63e84f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=Lma_THHDjEIY_MpWOOcA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
X-Proofpoint-ORIG-GUID: leIwTeq3mRWwFnMXQfSGIo30De6aQNhP
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

Fixes: 12499b23315b ("x86_iommu/amd: Enable Guest virtual APIC support")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
v1->v2:
  - As the previous commit replaced the hardcoded value 0x67 with a macro,
    update the macro instead of the hardcoded value used by amdvi_init().

 hw/i386/amd_iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 9cd510d790..4932568a0f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -125,7 +125,8 @@
 #define AMDVI_MMIO_STATUS_W1C_MASK \
     (AMDVI_MMIO_STATUS_EVT_OVF | AMDVI_MMIO_STATUS_EVENT_INT | \
      AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPR_OVF | \
-     AMDVI_MMIO_STATUS_PPR_INT)
+     AMDVI_MMIO_STATUS_PPR_INT | AMDVI_MMIO_STATUS_GALOG_OVF | \
+     AMDVI_MMIO_STATUS_GALOG_INT)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
 #define AMDVI_CMDBUF_ID_RSHIFT            4
-- 
2.39.3


