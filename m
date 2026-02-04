Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32927EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAi-0001WG-Cd; Wed, 04 Feb 2026 14:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAg-0001C5-1I
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAd-00083X-8x
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MiaTbqhOE9vPSks7gTjD35BsK/E0RnS5hv86ySxDrko=;
 b=H3DYliCMEonbhWn64QQ2Lx4W1oE/0xPUu0vRXHPhaLHnHSw73JyanCvMuZsN2k1xjuMEyC
 1Is79y3h02EwWndY/KP7q20qVyR6IQr/CWrKyAQKBCGaE2yzcgxigFty3xHh9tsDyJI34a
 Kl59vEegp5/MLBbttxoUW+3ClhIYoUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-gwvebeLeMPW4vTBGF3RtXA-1; Wed, 04 Feb 2026 14:04:09 -0500
X-MC-Unique: gwvebeLeMPW4vTBGF3RtXA-1
X-Mimecast-MFC-AGG-ID: gwvebeLeMPW4vTBGF3RtXA_1770231848
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso149821f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231848; x=1770836648; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MiaTbqhOE9vPSks7gTjD35BsK/E0RnS5hv86ySxDrko=;
 b=L3GED1Asaou1AlnqIrwg90KYFaRCpjF4jIH1bptMAsm76W3FXWw1QEmHZKsm7syLYE
 a6dvUD/EDMXPt7KPTydN3OAFPEzbXgNFsE7DFaQXCPKuC4ciW3vb+XL5C5k6yjiNZQMR
 9VGnJ7Q/pngzYNvlmX2hsQsb06nTXCdimsLy69TSxPnDnKnKNz8i3W85JLwa9EhhwY28
 1YuTLucCXrtCa3OaaKhARSXPxhInNNrru2GXqIhVarZy3UPkUA2v0E8tUAfc7kBRq84I
 mq37H2PCaYDRyBPAUEKQ864oHL6pZf6ivOBd2QljoB5ggbTId1MXB0g3D3ZnFJDlHz+0
 5P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231848; x=1770836648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiaTbqhOE9vPSks7gTjD35BsK/E0RnS5hv86ySxDrko=;
 b=ZPc0f1GuYzGQisJ5sKteZRL7HOPvBtXIxqlyo9dilVU0SlxASPz8OhhAyoDF18y/ea
 7/npigJTENGIsdy1g1ikZ19SwyUrUtM0e48ip3tUoyMlkf1/KQkUKByQK5mIm5tjfdUi
 2Wn3YAdjXDOvDUf+4+HessU2ZGcGfgdNwBnqoaUNSfTqb0LtvhTgysXIDqESBN15sq9j
 67l0uFFSwAIbchJCkpMgCfQYJxnT7KJSLmaIdZU7hpn7WQ5ArkmpOSeGuiZvdG3ocOl3
 ENRXhVuOJPY0E2alzba1/MEC3AMFlO9agBE0I+twihgN8p4fF0oketeCbaaDghV2GJex
 dKsA==
X-Gm-Message-State: AOJu0YxCbAw/1qHUu0yBZ8sv9hgcfuzkpP+1GmuNb5XXJb4vylvTWxZo
 TlNaR2uv6spHE5svf6UwT3aRPtSmzwsGO71GbeghSULO8su0qom7fDtIeGl+10eQwo9GTaxNxKW
 qatrQ48YhNZLSGMcUw5UVXc4NUaNFu6hoo7HfGeJaHGoIVwkKqTIqkd4yLQKrPQKGhRIs0Wm2kC
 RFrK4IWCkSKlAD0fS0x93RNyfg+Liec2Utjg==
X-Gm-Gg: AZuq6aJ4YqVchHkkehuGEpi1pqeexE64t980cWAMSjf1MIRbhbrZtCkxIee794eLBpU
 AFR93pW9hFqkRHypxboyOmARfM3jO6VfxhQ2JpkEMPkP/ZGsT/XDin7MYN8HBRiwVXcO7yJvdWH
 oLRcDmbylKW25NEtccNno5SEgSAJDEUK9Z0T1iTD0TbRPiIggmggrKa8Kqkyn/RT6uyIKNdQuYp
 rLr2FXNK8yuyql+kMsydxVl9JK4eBuIj6rqvMwi/KcwV8fTJKBX98iYG7QU8YEg/2Idg5ORnABF
 gO0sG6paLLezNITSyYTYNB6JtHKtjgKSe+ueDyq2QZYjCZQSInbyNljOrDghbT64ukggT/MOH71
 JecF5Q/N4z6H6ZI8IGU0gZyFJHYwiso053Q==
X-Received: by 2002:a05:6000:2311:b0:435:9bf5:b336 with SMTP id
 ffacd0b85a97d-43617e3c6f3mr6205298f8f.19.1770231847783; 
 Wed, 04 Feb 2026 11:04:07 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:435:9bf5:b336 with SMTP id
 ffacd0b85a97d-43617e3c6f3mr6205235f8f.19.1770231847229; 
 Wed, 04 Feb 2026 11:04:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faf7sm8232731f8f.30.2026.02.04.11.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:06 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 33/51] virtio: Fix crash when sriov-pf is set for
 non-PCI-Express device
Message-ID: <0f5b6103768b1e09ada8c06f105f5e167715dbf1.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

Setting the sriov-pf property on devices that aren't PCI Express causes
an assertion failure:

    $ qemu-system-x86_64 \
        -blockdev null-co,node-name=null \
        -blockdev null-co,node-name=null2 \
        -device virtio-blk,drive=null,id=pf \
        -device virtio-blk,sriov-pf=pf,drive=null2
    qemu-system-x86_64: ../hw/pci/pcie.c:1062: void pcie_add_capability(PCIDevice *, uint16_t, uint8_t, uint16_t, uint16_t): Assertion `offset >= PCI_CONFIG_SPACE_SIZE' failed.

This is because proxy->last_pcie_cap_offset is only initialised to a
non-zero value in virtio_pci_realize() if it's a PCI Express device, and
then virtio_pci_device_plugged() still tries to use it.

To fix this, just skip the SR-IOV code for !pci_is_express(). Then the
next thing pci_qdev_realize() does is call pcie_sriov_register_device(),
which returns the appropriate error.

Cc: qemu-stable@nongnu.org
Fixes: d0c280d3fac6 ('pcie_sriov: Make a PCI device with user-created VF ARI-capable')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251204172657.174391-1-kwolf@redhat.com>
---
 hw/virtio/virtio-pci.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b273eb2691..1e8f90df34 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2183,15 +2183,17 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
 
-    if (pci_is_vf(&proxy->pci_dev)) {
-        pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
-        proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
-    } else {
-        res = pcie_sriov_pf_init_from_user_created_vfs(
-            &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
-        if (res > 0) {
-            proxy->last_pcie_cap_offset += res;
-            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    if (pci_is_express(&proxy->pci_dev)) {
+        if (pci_is_vf(&proxy->pci_dev)) {
+            pcie_ari_init(&proxy->pci_dev, proxy->last_pcie_cap_offset);
+            proxy->last_pcie_cap_offset += PCI_ARI_SIZEOF;
+        } else {
+            res = pcie_sriov_pf_init_from_user_created_vfs(
+                &proxy->pci_dev, proxy->last_pcie_cap_offset, errp);
+            if (res > 0) {
+                proxy->last_pcie_cap_offset += res;
+                virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+            }
         }
     }
 }
-- 
MST


