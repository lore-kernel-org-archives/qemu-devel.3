Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30501CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78OP-0002BS-A6; Fri, 10 Oct 2025 04:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OL-0002AV-BA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78OF-0001Bc-ND
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760084534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkEwpiKaLxBSUhV5xR+XfwVb/cPt8uBBF9xkbsKEvGo=;
 b=NM4lUQ/11zgjEASPZvUbFVTaH8owT0v0qmAnubVCETfvrbzsXwRknqe3bBPwurkTx0aArs
 21ZjlyyixSP7OXJNjuqoGqC0L/l3nDdNzhu3avW8CxUBeebXdvO350oozH4EayCDjyAjJu
 6m8LtxAxp8MfikDFiwGDP0KMn8m0EUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-bX2RmarzP12cibn2KWB0Tg-1; Fri,
 10 Oct 2025 04:22:09 -0400
X-MC-Unique: bX2RmarzP12cibn2KWB0Tg-1
X-Mimecast-MFC-AGG-ID: bX2RmarzP12cibn2KWB0Tg_1760084528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8B7180057C; Fri, 10 Oct 2025 08:22:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21BA51800452; Fri, 10 Oct 2025 08:22:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 9/9] s390x/pci: set kvm_msi_via_irqfd_allowed
Date: Fri, 10 Oct 2025 10:21:44 +0200
Message-ID: <20251010082145.576222-10-thuth@redhat.com>
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
References: <20251010082145.576222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Allow irqfd to be used for virtio-pci on s390x if the kernel supports
it.  This improves s390x virtio-pci performance when using kvm
acceleration by allowing kvm to deliver interrupts instead of QEMU.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20251008203350.354121-1-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-pci-kvm.h | 7 +++++++
 hw/s390x/s390-pci-bus.c         | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/hw/s390x/s390-pci-kvm.h b/include/hw/s390x/s390-pci-kvm.h
index 933814a4025..c33f2833a3c 100644
--- a/include/hw/s390x/s390-pci-kvm.h
+++ b/include/hw/s390x/s390-pci-kvm.h
@@ -14,12 +14,19 @@
 
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-inst.h"
+#include "system/kvm.h"
 
 #ifdef CONFIG_KVM
+static inline void s390_pcihost_kvm_realize(void)
+{
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+}
+
 bool s390_pci_kvm_interp_allowed(void);
 int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist);
 int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev);
 #else
+static inline void s390_pcihost_kvm_realize(void) {}
 static inline bool s390_pci_kvm_interp_allowed(void)
 {
     return false;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e8e41c8a9a1..52820894fa1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    s390_pcihost_kvm_realize();
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
-- 
2.51.0


