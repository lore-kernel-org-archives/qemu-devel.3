Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAEBC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2AW-0000ps-Dv; Tue, 10 Jun 2025 12:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15B-0004MK-1u
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP159-0006A9-FX
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXZqE006965;
 Tue, 10 Jun 2025 15:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=tds6gG+dA5WZrNQV0J7lwZQNk4HjqQon3BwKAvCaj0Q=; b=
 amnzo27s1YYhIKtNMheqc+9K6hg6dDSGuR6ba2anzWtrntEp9L0JJmgrxPyqdTo3
 MCm9Mo2CmyJQVmashiGHXy1sWD1ykpUpa6/loG4zSQkOCtH9lND10oUb8uQK7FlS
 SYHssCaT3rwGNoa9/1cJUp6RJa09AuBZ7dVT9xLiq5fSTVdGRj8tHPhormN9npwc
 x1JNQ/AZv4z1NKxEDuBoX7obqvhvfAErIPIzaoLJ/qMu3MW7yJkDy+IXTBHEZfbJ
 INt5KewKrNWFQy2iGF/hr8IkjntQlbMCAzbknr6iXqn4xs39trn6AjiUjqQPy1NS
 pI7J+kard8mORxBBNQwZpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vjqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEfgqL003281; Tue, 10 Jun 2025 15:40:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wax3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfR028825;
 Tue, 10 Jun 2025 15:40:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-11; Tue, 10 Jun 2025 15:40:07 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 10/38] pci: skip reset during cpr
Date: Tue, 10 Jun 2025 08:39:23 -0700
Message-Id: <1749569991-25171-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684851d8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=9sbxz00wAFZublB0PowA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: rRW8Tlqh5UfDfSPDAIYE-1uvnmrGDIKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX6o5jhaiwoN15
 y6TOan90+EaAK5kYaldTjD7DTRWV+SLF2gKnWf9XRezs8NEo/DmxWERfIBpFMcIz51MbUIydIBW
 SfHJubxGODZ0RYHYFWDsQqFvAlAUJSnXhkfBHHzE+i9CHnbv4FFG2dwe1ObO5qYHAZ/McgLSTO/
 6QGsKOz72RLj1zrlheu1IZXjKmc1vgTCCcdKt++0UfJB498dR+j4+aKNLr6swC7Hvl7EovME54v
 RH2sgXm5XDdygK0Zt1BfyuvsEfmotl6YN+C1Oxk/Rwn/LNfTiDJN6agNcg1b6vbM0Mn7SFC0vY/
 7YP+fYlFpDUF8U8beduvRI2kMCi/Uw3XUFekyzvoFeG9gNonoQAN0nRhC6qWST3KgRq/oyugwvw
 cOv+xzLzuz67oKVwXl7MuqW/xMueTufLd8R99i8oRoEZkIaAt6n2efiFSGOwbIXKwRxc4PiZ
X-Proofpoint-GUID: rRW8Tlqh5UfDfSPDAIYE-1uvnmrGDIKn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Do not reset a vfio-pci device during CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/pci/pci_device.h | 3 +++
 hw/pci/pci.c                | 5 +++++
 hw/vfio/pci.c               | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index eee0338..0509430 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -182,6 +182,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* CPR */
+    bool skip_reset_on_cpr;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9b4bf48..0f6b9b3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/cpr.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
@@ -537,6 +538,10 @@ static void pci_reset_regions(PCIDevice *dev)
 
 static void pci_do_device_reset(PCIDevice *dev)
 {
+    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
+        return;
+    }
+
     pci_device_deassert_intx(dev);
     assert(dev->irq_state == 0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d8..819170d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3408,6 +3408,13 @@ static void vfio_instance_init(Object *obj)
     /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
      * line, therefore, no need to wait to realize like other devices */
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+
+    /*
+     * A device that is resuming for cpr is already configured, so do not
+     * reset it during qemu_system_reset prior to cpr load, else interrupts
+     * may be lost.
+     */
+    pci_dev->skip_reset_on_cpr = true;
 }
 
 static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
-- 
1.8.3.1


