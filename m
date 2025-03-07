Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D74C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWHH-0002RF-QB; Fri, 07 Mar 2025 06:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWHG-0002Qa-5N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWHE-0000No-Mz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vP08kGh1gBxCAKNj7Mea7eFddJb1NSFNTaj+GwlfRgc=;
 b=cAbDG6R3DnI8lkF80ug7eTwfZbxbc88xmWerIwE7U4ta8DloVfJw3sBskWVNTSOqKZycYC
 kDE0UfIDhFG/kF9pY1t0hI+t2QBj6IlCJpsYKd0pLGrxqCk5c7UuKIajbfFUifUtu97CNL
 y93N45pCBIRRjeCeXJIQkeGE5xbm9ws=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-BDwsAU0sNzqTptpSMzn6-A-1; Fri,
 07 Mar 2025 06:54:02 -0500
X-MC-Unique: BDwsAU0sNzqTptpSMzn6-A-1
X-Mimecast-MFC-AGG-ID: BDwsAU0sNzqTptpSMzn6-A_1741348441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C01B19560BC; Fri,  7 Mar 2025 11:54:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21BC91944F2E; Fri,  7 Mar 2025 11:53:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PULL 15/15] s390x/pci: indicate QEMU supports relaxed translation
 for passthrough
Date: Fri,  7 Mar 2025 12:53:14 +0100
Message-ID: <20250307115314.1096373-16-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Specifying this bit in the guest CLP response indicates that the guest
can optionally choose to skip translation and instead use
identity-mapped operations.

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20250226210013.238349-3-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-pci-clp.h | 1 +
 hw/s390x/s390-pci-vfio.c        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/s390-pci-clp.h
index 03b7f9ba5f7..6a635d693ba 100644
--- a/include/hw/s390x/s390-pci-clp.h
+++ b/include/hw/s390x/s390-pci-clp.h
@@ -158,6 +158,7 @@ typedef struct ClpRspQueryPciGrp {
 #define CLP_RSP_QPCIG_MASK_NOI 0xfff
     uint16_t i;
     uint8_t version;
+#define CLP_RSP_QPCIG_MASK_RTR     0x20
 #define CLP_RSP_QPCIG_MASK_FRAME   0x2
 #define CLP_RSP_QPCIG_MASK_REFRESH 0x1
     uint8_t fr;
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 443e2229127..6236ac7f1e6 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -238,8 +238,11 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
         pbdev->pci_group = s390_group_create(pbdev->zpci_fn.pfgid, start_gid);
 
         resgrp = &pbdev->pci_group->zpci_group;
+        if (pbdev->rtr_avail) {
+            resgrp->fr |= CLP_RSP_QPCIG_MASK_RTR;
+        }
         if (cap->flags & VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH) {
-            resgrp->fr = 1;
+            resgrp->fr |= CLP_RSP_QPCIG_MASK_REFRESH;
         }
         resgrp->dasm = cap->dasm;
         resgrp->msia = cap->msi_addr;
-- 
2.48.1


