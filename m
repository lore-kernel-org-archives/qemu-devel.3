Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5C5C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Oh-00070D-71; Tue, 07 Jul 2026 08:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OW-0006l2-CE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OU-0007IP-Rx
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZCuzVFqNPzg4TXtd0LNm2BLh8mjl/nL/c67zXfM+KQ=;
 b=NPr0lM1YsB4bEdfq91WkceeIbqWfChiFY7mnjTQrvYjR+ZXvn+YRAe+Xd9BERUxdLGLq60
 v8uSiblwRFNyAyxYMoIcDIuKekJ5vAKMneK2SkycPwiPkkfiEEHbMjtPVIpXoQh50RhrU8
 aOfALdIqxCoGkEKEcYoRZZRL7rKWW0M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-ritZzG4RNBma46eKIzJ8GA-1; Tue,
 07 Jul 2026 08:59:19 -0400
X-MC-Unique: ritZzG4RNBma46eKIzJ8GA-1
X-Mimecast-MFC-AGG-ID: ritZzG4RNBma46eKIzJ8GA_1783429158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE7E91805C3A; Tue,  7 Jul 2026 12:59:17 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F22601956040; Tue,  7 Jul 2026 12:59:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 11/15] s390x/pci: Tighten region detection for BAR read/write
Date: Tue,  7 Jul 2026 14:58:43 +0200
Message-ID: <20260707125847.1785168-12-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

For PCISTG/PCISTB/PCILG instruction emulation, ensure that the offset
and length provided by the guest does not overflow, and only return
a memory region when the specified offset+length combination matches
an existing subregion or the parent region.

Cc: qemu-stable@nongnu.org
Fixes: 4f6482bfe3 ("s390x/pci: search for subregion inside the BARs")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-3-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 10066ca6180a..ef20f7645eb4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -392,13 +392,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
 static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
                                         uint8_t len)
 {
+    uint64_t last = offset + len;
     MemoryRegion *subregion;
     uint64_t subregion_size;
 
+    /*
+     * Ensure the region is valid, the calculated address cannot wrap and that
+     * it falls within this region.
+     */
+    if (!mr || offset > last || last > memory_region_size(mr)) {
+        return NULL;
+    }
+
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
         subregion_size = memory_region_size(subregion);
         if ((offset >= subregion->addr) &&
-            (offset + len) <= (subregion->addr + subregion_size)) {
+            (last) <= (subregion->addr + subregion_size)) {
             mr = subregion;
             break;
         }
@@ -413,6 +422,10 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_read(mr, offset, data,
                                        size_memop(len) | MO_BE,
@@ -513,6 +526,10 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_write(mr, offset, data,
                                         size_memop(len) | MO_BE,
@@ -900,6 +917,11 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return 0;
+    }
+
     offset -= mr->addr;
 
     for (i = 0; i < len; i += 8) {
-- 
2.54.0


