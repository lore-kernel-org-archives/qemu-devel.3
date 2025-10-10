Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB98CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OL-0002Aa-Kr; Fri, 10 Oct 2025 04:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OI-00029N-DJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78O6-00010a-OB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fasr0vDcyU3Al2j8YMauSw32DE0/KtFTqpUjIgb7dME=;
 b=ef8f7SafXfgKzSD0BwSGlbQHDRA6Xs9CQSlQgiodjMQaEgfvy9obFjh0qyJKJD2OFG032S
 3/PU6bJCuiD6j8sdLfmjEh9IRHHRZozKIxvuiTRg3YpbrURSFGnjsmOmUuIOxKwtcOwqAU
 RCPCA6xEb+bpziznHZTnaymz8RNFYvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-MtToXS--P_izpP5cVn9joQ-1; Fri,
 10 Oct 2025 04:21:54 -0400
X-MC-Unique: MtToXS--P_izpP5cVn9joQ-1
X-Mimecast-MFC-AGG-ID: MtToXS--P_izpP5cVn9joQ_1760084513
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 299E8180057E; Fri, 10 Oct 2025 08:21:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F8C11800446; Fri, 10 Oct 2025 08:21:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jaehoon Kim <jhkim@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 2/9] s390x/pci: fix interrupt blocking by returning only the
 device's summary bit
Date: Fri, 10 Oct 2025 10:21:37 +0200
Message-ID: <20251010082145.576222-3-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

Previously, set_ind_atomic() returned the entire byte containing
multiple summary bits. This meant that if any other summary bit in the
byte was set, interrupt injection could be incorrectly blocked, even
when the current device's summary bit was not set. As a result, the
guest could remain blocked after I/O completion during FIO tests.

This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
returns true if the bit was set by this function, and false if it was
already set or mapping failed. Interrupts are now blocked only when
the device's own summary bit was not previously set, avoiding
unintended blocking when multiple PCI summary bits exist within the
same byte.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20251001154004.71917-1-jhkim@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f87d2748b63..e8e41c8a9a1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -652,7 +652,16 @@ static const PCIIOMMUOps s390_iommu_ops = {
     .get_address_space = s390_pci_dma_iommu,
 };
 
-static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
+/**
+ * set_ind_bit_atomic - Atomically set a bit in an indicator
+ *
+ * @ind_loc:   Address of the indicator
+ * @to_be_set: Bit to set
+ *
+ * Returns true if the bit was set by this function, false if it was
+ * already set or mapping failed.
+ */
+static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)
 {
     uint8_t expected, actual;
     hwaddr len = 1;
@@ -662,7 +671,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
     ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
-        return -1;
+        return false;
     }
     actual = *ind_addr;
     do {
@@ -671,7 +680,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
     } while (actual != expected);
     cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
 
-    return actual;
+    return (actual & to_be_set) ? false : true;
 }
 
 static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
@@ -693,10 +702,10 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
     ind_bit = pbdev->routes.adapter.ind_offset;
     sum_bit = pbdev->routes.adapter.summary_offset;
 
-    set_ind_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
+    set_ind_bit_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
                    0x80 >> ((ind_bit + vec) % 8));
-    if (!set_ind_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
-                                       0x80 >> (sum_bit % 8))) {
+    if (set_ind_bit_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
+                   0x80 >> (sum_bit % 8))) {
         css_adapter_interrupt(CSS_IO_ADAPTER_PCI, pbdev->isc);
     }
 }
-- 
2.51.0


