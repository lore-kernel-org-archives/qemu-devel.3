Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F435C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUk7-0000ay-8U; Mon, 27 May 2024 03:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUji-0008NS-2b; Mon, 27 May 2024 03:25:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUjb-0006NI-7x; Mon, 27 May 2024 03:25:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCCDD6A4CC;
 Mon, 27 May 2024 10:25:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 24B5DD8469;
 Mon, 27 May 2024 10:24:36 +0300 (MSK)
Received: (nullmailer pid 52915 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 15/21] hw/core/machine: move compatibility flags for
 VirtIO-net USO to machine 8.1
Date: Mon, 27 May 2024 10:24:25 +0300
Message-Id: <20240527072435.52812-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 9710401276a0eb2fc6d467d9abea1f5e3fe2c362)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3c08a894fb..f5408d981a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,15 +37,15 @@ GlobalProperty hw_compat_8_1[] = {
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


