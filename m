Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65228CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJK-0001wb-DG; Mon, 08 Jun 2026 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJI-0001rE-U1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:37 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJH-0001oU-6v
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:36 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-138188a7dccso3849298c88.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926394; x=1781531194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k1bsJjY8Pm3QqNdtzXNMjSxvoCU22dmmB0G8fCK1/U=;
 b=QLaMXjh+KHgPLxmtXVQM0l4X/XP+pJuTGQb04Jgq7wIB+MqKzRU0MdTzjkkDWqnDpj
 W8TEBKgUSruq040MaqLYlNqEewWPqWLsOeXnTzwEq38stDRhGkS7tcB4K8MZ2QinoBmN
 Ini7DMm11Zt5ZudYyYmxe9SYdWZTLgmwYZxaElI7RF73+QFZJWW/WOpVkb+7G0tCJk7H
 J/rrVLDFC9mJZhcpRYbCDNxOItl/kgVOoLbCWZiPomiQEGi3PnuoA8jDIJoTkdL1loYp
 jZ4MD4sL5+g2oaofMRYm024fbzxXasvx5NwYwkHWF+oKbPdO2wz01wSJAzIVsQA33WWI
 ggBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926394; x=1781531194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9k1bsJjY8Pm3QqNdtzXNMjSxvoCU22dmmB0G8fCK1/U=;
 b=mtHOr+DFDPBWtEmi8IwaU12j2mUHe/0lCllvbwlWvpqiwIUtvJG07gZtZsU/wHMgBP
 OheEsNK8KvHtbtwZJToTsKFEzPP4CMzCbc//5/fAfNSXc+UIZiP6Co9nB3EVyP4C5A5a
 EpV14l02LRkftqESjsZbaJ7z87P2SI3r3BFx2HwgFJDpk7VS4PbqxKrKmCbP5/m4iYae
 DJNbSIOPmHZpQjW2Cv/2BkzXl3L9HCHb0IyDi+JGEXySMmBqDmVK+maXmkGHrGn5UrXg
 +wOQ4cTrivM+lf0M5oAj++DL/xT2Kc1XHUmKjmCUZesmksn/JvBP4ki3QfyFt6dTbqCX
 cs6A==
X-Gm-Message-State: AOJu0YwnX3qkb0yZhqKCVY7qv9zMnpaLQoCfQAOzDA8FPwmJ10mHgpUS
 UZMO/Zo4rWpnqHjWgubEEFasZd/ddcrEGv4BslCwmzr/c7OPJ03bHomYTKkZaOj2+g==
X-Gm-Gg: Acq92OHcwLINvgnPBf5uSu4TgduTxVonTNiqtVDPRcn3i2vOVeU3zxEuhZkMqTE4p4H
 PmPza/FsMELE8WGZJFzeHzVyY3En1psMoSnkslt/UcVuAWfCvNFlm0cbxYtdh3pjqwkdrW9pJDV
 HR6ajiSUJl+14AqER7oIFJ3rznQZCqF+k7tqg0ULiaoTGJ4dAV3RJ8a/B+jJKRzRTWgzR7r95Q/
 BHXMONY5ok/juLMSx3Zu5VZLZTNoJZKhsUBYCDy+hk1wytuFlgdylQb/9/0r8yuMrSaGyotpAIW
 f7R1gV2jy9a3/0liU3UcC5lRlBXTdMm+xU7oFpd1eanCz+bQb8awxhwABExCBVdhQnYQnlmftVr
 fM1y2Fw9zAQYdQ6qduqRGuX75uZKPi/lLr1LKTx2yELDxkxnzvdvkbT1As5TCR1KN94qcjNCvhy
 sK9dLpAQGveq5NGRjfYlSMOBSzbZ53jUt8Tf2VSxRSWQ==
X-Received: by 2002:a05:7022:f8f:b0:135:608a:2864 with SMTP id
 a92af1059eb24-138067251ebmr7691398c88.33.1780926393565; 
 Mon, 08 Jun 2026 06:46:33 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:32 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 6/7] vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID
 patching
Date: Mon,  8 Jun 2026 21:45:57 +0800
Message-ID: <20260608134559.23971-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Remove the duplicate inline logic in vfio_pci_load_rom() that patched
the device ID in an IGD option ROM and replace it with a call to
pci_rom_patch_ids(), conditioned on the rom_need_patch_id flag.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..6cbd65126e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1029,6 +1029,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     uint64_t size;
@@ -1084,34 +1085,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
         }
     }
 
-    /*
-     * Test the ROM signature against our device, if the vendor is correct
-     * but the device ID doesn't match, store the correct device ID and
-     * recompute the checksum.  Intel IGD devices need this and are known
-     * to have bogus checksums so we can't simply adjust the checksum.
-     */
-    if (pci_get_word(vdev->rom) == 0xaa55 &&
-        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
-        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
-        uint16_t vid, did;
-
-        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
-        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
-
-        if (vid == vdev->vendor_id && did != vdev->device_id) {
-            int i;
-            uint8_t csum, *data = vdev->rom;
-
-            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
-                         vdev->device_id);
-            data[6] = 0;
-
-            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
-                csum += data[i];
-            }
-
-            data[6] = -csum;
-        }
+    if (pdev->rom_need_patch_id) {
+        pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
     }
 }
 
-- 
2.53.0


