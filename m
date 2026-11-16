Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1746606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=R1r7cW38
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ks-00087J-GW; Mon, 16 Nov 2026 15:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KR-0007mT-Og; Mon, 16 Nov 2026 15:29:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KN-0001fS-R9; Mon, 16 Nov 2026 15:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=w6/IKUlqncvA6rP8YNnBc6JWhuX0SGwsp66LHWQ+Jv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R1r7cW38JKfLstZvyqG/wf1kRSkxUwSgNhaSARbtZBRs4K/AYZAg9BQvWGsS3BS5M
 gnyOMeO9Iy43BU6jnlPY73hzmHiZO72R6BIx9f23WAYbrIqVut0slLr1p2mpg2PHZT
 nonnrnYinPWxKhBzKzSSQUCZbV7WmGXuVVEsTD6j7UDX7ktHPY3YQoKouTobDsYQHK
 VRnPRsqo6Uls2o1T4nCyqBo5j/4RCJE705MqPSJ3MnqPb6Vg/+PSEpr422hcAAJwWe
 TsaSiwoH0FMuNKlbIscMX6coM/mUjCi6+s6s30cM4js1YSOEVKodgUuufmnjz8ejgu
 v1RGrIxwhSzCA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57CD21E71BA;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 541EC45FBE6;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 33D89B8E90; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 37/63] pcie_sriov: fix null pointer dereference when
 initializing PFs in a system with user and device created VFs
Date: Mon, 16 Nov 2026 23:25:16 +0300
Message-ID: <20261116202554.535325-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

pcie_sriov_pf_init is only used to initialize PFs for device created VFs, and
as such, it is checked that the PF has not been referenced by a user created VF
by means of the sriov-pf parameter.

This check crashes if it is performed for a PF that does not have an ID, and
there are already user created VFs in the system.

Example:

    qemu-system-x86_64 -M q35                                   \
        -device pcie-root-port,id=rp1,chassis=1,slot=1          \
        -device virtio-net-pci,sriov-pf=f,addr=0.1,bus=rp1      \
        -device virtio-net-pci,id=f,addr=0.0,bus=rp1            \
        -device pcie-root-port,id=rp2,chassis=1,slot=2          \
        -device nvme-subsys,id=subsys0                          \
        -device nvme,sriov_max_vfs=1,serial=s,sriov_vq_flexible=2,sriov_vi_flexible=1,bus=rp2,subsys=subsys0

ASAN message:

The signal is caused by a READ memory access.
Hint: address points to the zero page.
    #0 in g_str_hash (/usr/lib/libglib-2.0.so.0+0x49954)
    #1 in g_hash_table_contains (/usr/lib/libglib-2.0.so.0+0x4ad3b)
    #2 in pcie_sriov_pf_init ../hw/pci/pcie_sriov.c:161
    #3 in nvme_init_sriov ../hw/nvme/ctrl.c:9088
    #4 in nvme_init_pci ../hw/nvme/ctrl.c:9218
    #5 in nvme_realize ../hw/nvme/ctrl.c:9696

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-4-danielpaziyski@gmail.com>
(cherry picked from commit e1b6779cd4c29e9cc24f88a45552a93219c68241)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 23a2a43af78..81891226f7a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -158,7 +158,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     BusState *bus = qdev_get_parent_bus(&dev->qdev);
     int32_t devfn = dev->devfn + vf_offset;
 
-    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+    if (pfs && dev->qdev.id && g_hash_table_contains(pfs, dev->qdev.id)) {
         error_setg(errp, "attaching user-created SR-IOV VF unsupported");
         return false;
     }
-- 
2.47.3


