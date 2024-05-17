Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004AFC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 07:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7sPZ-0005BU-7P; Fri, 17 May 2024 03:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7sPX-00052Y-1o; Fri, 17 May 2024 03:53:51 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7sPV-00051y-3x; Fri, 17 May 2024 03:53:50 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5A305424DF;
 Fri, 17 May 2024 09:53:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, jasowang@redhat.com,
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com,
 farosas@suse.de, t.lamprecht@proxmox.com
Subject: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net USO
 to machine 8.1
Date: Fri, 17 May 2024 09:53:36 +0200
Message-Id: <20240517075336.104091-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
version 8.1 can fail with:

> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
> kvm: Failed to load virtio-net:virtio
> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
> kvm: load of migration failed: Operation not permitted

The series

53da8b5a99 virtio-net: Add support for USO features
9da1684954 virtio-net: Add USO flags to vhost support.
f03e0cf63b tap: Add check for USO features
2ab0ec3121 tap: Add USO support to tap device.

only landed in QEMU 8.2, so the compatibility flags should be part of
machine version 8.1.

Moving the flags unfortunately breaks forward migration with machine
version 8.1 from a binary without this patch to a binary with this
patch.

Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/core/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c7ceb11501..95051b80db 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -50,15 +50,15 @@ GlobalProperty hw_compat_8_1[] = {
     { "ramfb", "x-migrate", "off" },
     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
     { "igb", "x-pcie-flr-init", "off" },
+    { TYPE_VIRTIO_NET, "host_uso", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
     { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
-    { TYPE_VIRTIO_NET, "host_uso", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
-- 
2.39.2



