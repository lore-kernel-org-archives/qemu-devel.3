Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF47C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mSK-0008Se-Nh; Wed, 16 Sep 2026 06:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRk-00088d-Cq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:58 -0400
Received: from qs-2003f-snip6-11.eps.apple.com ([2a01:b747:3006:204::3f]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRi-0005Gq-QR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:56 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 A634A18009F0; Wed, 16 Sep 2026 10:00:50 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-7679-76d4-937e-43d07503887b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpaA11UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552854; x=1792144854;
 bh=nXTBrq9QmP+EI+S6P5g+rgoGsRJ/zxEegKF1eFwtIzY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CoEOfu/Z2Z0hxQ7FWm8aFlf8ERp0E8VdK5H3HckQB9h/Vxu+jCzjUtByNelHLpuLA4rUtHUU1Zpuv8ehUVZ58smMtNsfWbK4Qjl91Dyy73XfDCQZ0P+fDRCJaNGrKJe+5loNjpfNDtmBpB2ivwJOxzA+3DmFR4eDxYW/Ba+DRRbWL6aGdA+UkG/V56cQH+k+AVxk1+uM6K0XkRM1BU51PRpptzYDsC4Pp9L8kWMJ9cBBlN1qxErA8XGC2a+oMy6dGEsKaBh7gcwrUa0xpzcceqtDc2DPUKiH0Tb77qhJZqKr8ld0jhp3iWUCYD3WRKivSbOY8LttrwAELLyFeUPlUg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 4782C18009ED; Wed, 16 Sep 2026 10:00:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 10/10] hw/vmapple: virtio-blk: allow FileVault off
Date: Wed, 16 Sep 2026 12:00:18 +0200
Message-ID: <20260916100021.73825-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=cbTfb3DM c=1 sm=1 tr=0 ts=6aaa68d4
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XTwg747VhcxLksJOh8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX/p93+7Skz2lN
 s2o0x1larrbi3u4rxfpQAvWXpUC/3vJgsoWgCgehigI0aKYh2xNsSMRYPwNHuIJUxDQARX7kLwi
 mIdjBCcx3gRgfOXfiuKV+ZBs6XU+eHdZPS2SBFEEhg4/zSvKGq2sICYgLAYAEWDVBGPv3ON8zcp
 UhStSHmUqXA84lOfbY5ZqCZMsvsiUo3pJKIFb0qny9BbCqIOaMpbqT53sMr3F695sR272+mc6DT
 UwUPfM54LgyCzC0tDC6CqseySg2q+RnjFcGKE124tXGRGDmCKHY0ofSb0J/59nkdlfrRKxZXC4m
 5Q3kwzy/kPDu1oIJTErMgxlZ5RhkvNlxY6Ij2KULTGtt/Isv9AsBMWpdzg4wrg=
X-Proofpoint-ORIG-GUID: mSNohsmmwU0Cy0u0Q5E2_V9tUb8Bp4y3
X-Proofpoint-GUID: mSNohsmmwU0Cy0u0Q5E2_V9tUb8Bp4y3
X-JNJ: AAAAAAABS1Dvq5mZs8DFngDUrJFvPwtTuTBIHnuOA5udU0IyH0FAtRlCmh1CjCR5mvHT7+f8Ga6BOnKibds3x+Y54GhufXLP1NImgXqCse0+egVz+lwHRedIVxfmnFdCZNRDZoxuyusub5nELHOHVJ/viNhuq7MBxtaZSsxMKqfVr1ed7Umzl6eIZYvopBWt4IUwk/SZ0rwrc497aTu3ugSSVJ6V1LZvHYiemX7dT6B5T6QKO1C8V2Lt+feWc6Ytz5hdxyM/c+RQXuVzDVFj+GUarzedWh9le4HCMbfbN08WYhPJS2bDZ6LbZxg1LmEu5MTo8IE4Tjv576qu46MwWV1aPSpXNkh9DS7Jb/mJ5215bleQJikmx+l3OEkulLUWDfFWFWXb/B+5PuzPpJyVTsKvYxuc+/Gq15Rt0k1DAENg/g9KzmJ0GsPFcf3GINumwIXav09M4m8Am7fJxF2CTP9FtBW2K6mscJqpw6Y/OY4FQryjwIKYyRiLS9lwsXegWg8hjb3dq1y3cs7nK8r8yo+dksmK04DZud8x32ZlItcwbPBc6ngp+d4zdJOM5sS0rZ5feaXHiXxoldM+7KRka+EENze6a2MMs1ueccwfY2oict8In5WxgTywj8cWbZ2sTkRF9hYuz40rUmNjilY5YgR0Nr098V7qZ9Qbi3i8Of2Pk8M/GQCSI0/gLJ/akJ5sArLf/oiUAb45Dy7JcmcCa5hsaRmjIr7nMfNFnI1VI7prbREKHoKkI94xzC+z1TJqahV/jiEX7KXqPgjlLzs3j23xtYCNaE395rhJPlCHMyzoqu+snJvjknVzWmBWwZkkUGn0YFDzfs2rkJtrncZxWEvZaHddQDEQr2+fLF9J
Received-SPF: pass client-ip=2a01:b747:3006:204::3f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Otherwise, a newer macOS version with FileVault
disabled in the guest does not boot.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/virtio-blk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
index 9de9aaae0b..906c2b2ec8 100644
--- a/hw/vmapple/virtio-blk.c
+++ b/hw/vmapple/virtio-blk.c
@@ -119,12 +119,17 @@ static const Property vmapple_virtio_blk_pci_properties[] = {
                                            VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED),
 };
 
+#define VMAPPLE_PCI_VNDR_SIZE 14
+/* Disable requirement for FileVault to be enabled on the guest */
+#define VMAPPLE_PCI_VNDR_LEGACY_FEATURES_DISABLE_ENCRYPTION (1 << 0)
+
 static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     ERRP_GUARD();
     VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
     VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;
+    int offset;
 
     if (dev->variant == VM_APPLE_VIRTIO_BLK_VARIANT_UNSPECIFIED) {
         error_setg(errp, "vmapple virtio block device variant unspecified");
@@ -162,6 +167,19 @@ static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err
     pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
     pci_config_set_device_id(vpci_dev->pci_dev.config,
                              PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
+
+    offset = pci_add_capability(&vpci_dev->pci_dev, PCI_CAP_ID_VNDR, 0,
+                                    VMAPPLE_PCI_VNDR_SIZE, errp);
+    if (offset < 0) {
+        return;
+    }
+
+    pci_set_byte(vpci_dev->pci_dev.config + offset + 2,
+        VMAPPLE_PCI_VNDR_SIZE);
+    pci_set_byte(vpci_dev->pci_dev.config + offset + 3, 9);
+    pci_set_word(vpci_dev->pci_dev.config + offset + 4, PCI_VENDOR_ID_APPLE);
+    pci_set_byte(vpci_dev->pci_dev.config + offset + 6,
+        VMAPPLE_PCI_VNDR_LEGACY_FEATURES_DISABLE_ENCRYPTION);
 }
 
 static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass,
-- 
2.54.0 (Apple Git-157)


