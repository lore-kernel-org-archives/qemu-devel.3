Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E031CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 11:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmtJ-0000MI-Q9; Mon, 08 Apr 2024 07:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rtmt5-0000LK-MB
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rtmsz-00035g-Qt
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712574600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y9AGIl7Vssy42wfT+MKHdHFl9fsU/bWl4Y+ZF8kYUbA=;
 b=XF0YvZnn3oyh/sdh0lwsQghlkw/EyOiONy70XuIL8xNsbq2/RnoTH4NoxxXxh9nL3eIBVO
 grpTV8n4Cmn9jIR8vo/pFMZ2H0hU9g5HntDH73KBkGJAJwkJB3NCkDgpENi1Y5az4vHcIY
 N2BIOKs3J+kbhLbi0av9ud2nLwBIbJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-kRAUTofuPIe5DlfBqdouuA-1; Mon, 08 Apr 2024 07:09:59 -0400
X-MC-Unique: kRAUTofuPIe5DlfBqdouuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA5F110499A4
 for <qemu-devel@nongnu.org>; Mon,  8 Apr 2024 11:09:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D38EC26A4E;
 Mon,  8 Apr 2024 11:09:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH] kvm: error out of kvm_irqchip_add_msi_route() in case of full
 route table
Date: Mon,  8 Apr 2024 13:09:56 +0200
Message-ID: <20240408110956.451558-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

subj is calling kvm_add_routing_entry() which simply extends
  KVMState::irq_routes::entries[]
but doesn't check if number of routes goes beyond limit the kernel
is willing to accept. Which later leads toi the assert

  qemu-kvm: ../accel/kvm/kvm-all.c:1833: kvm_irqchip_commit_routes: Assertion `ret == 0' failed

typically it happens during guest boot for large enough guest

Reproduced with:
  ./qemu --enable-kvm -m 8G -smp 64 -machine pc \
     `for b in {1..2}; do echo -n "-device pci-bridge,id=pci$b,chassis_nr=$b ";
        for i in {0..31}; do touch /tmp/vblk$b$i;
           echo -n "-drive file=/tmp/vblk$b$i,if=none,id=drive$b$i,format=raw
                    -device virtio-blk-pci,drive=drive$b$i,bus=pci$b ";
      done; done`

While crash at boot time is bad, the same might happen at hotplug time
which is unacceptable.
So instead calling kvm_add_routing_entry() unconditionally, check first
that number of routes won't exceed KVM_CAP_IRQ_ROUTING. This way virtio
device insteads killin qemu, will gracefully fail to initialize device
as expected with following warnings on console:
    virtio-blk failed to set guest notifier (-28), ensure -accel kvm is set.
    virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/kvm/kvm-all.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d4d57da265..10fae1db05 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2001,12 +2001,17 @@ int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
         return -EINVAL;
     }
 
-    trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
-                                    vector, virq);
+    if (s->irq_routes->nr < s->gsi_count) {
+        trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
+                                        vector, virq);
 
-    kvm_add_routing_entry(s, &kroute);
-    kvm_arch_add_msi_route_post(&kroute, vector, dev);
-    c->changes++;
+        kvm_add_routing_entry(s, &kroute);
+        kvm_arch_add_msi_route_post(&kroute, vector, dev);
+        c->changes++;
+    } else {
+        kvm_irqchip_release_virq(s, virq);
+        return -ENOSPC;
+    }
 
     return virq;
 }
-- 
2.43.0


