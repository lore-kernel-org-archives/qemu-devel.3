Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760DBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Hr-0005Zp-HK; Tue, 07 Jul 2026 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hl-0005M3-80
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:11 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hj-0001x7-R2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:08 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380feaa05dcso969985a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783413366; x=1784018166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9Lw79sO0i26l3geUFVoG2PMHuBvpLx6zQylyZ1cYC8=;
 b=HRQU5HRZ+Xp7ISsqcCnQaumuD2hkrdysh//dnc+3fty/2N0jDkcLDUyROEqvz0Atj6
 bdTVjR5a5sYqJ1MtpgC8tEtrwRM2ozrSNIe8VNjskHYeWXP/4AtjeGQPjIH1WaSxfsgo
 2/Y6/1MTlfkfuoIH2Qq3Y2ufaXHENR5Kw9f+udCxaaQVUi3SzrsRGmXFalyhmUz5Icde
 iDrbrGbEbtyIX4ZVV2Bzlp5MMRR1u11h79wgMDycyegJHPOnQVs9gbafbbIUTOFcDuWY
 aC6nW540Ka3KfG+eXgxDS+lMzZvphbzQX8nB1SHvFyEpPYvP2BYNfCZaB/8BRl0RGoUP
 1AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413366; x=1784018166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9Lw79sO0i26l3geUFVoG2PMHuBvpLx6zQylyZ1cYC8=;
 b=Bq8MXUjuz9+N772H1k0U4EAPFxVeAaX7p0QCqHtvm2EnMiYZ8D34OKSSYSoPr2OzDq
 qZGDrFhoFG38ULMlwjLHZNRgmphWQg7YkjrbXzHlv7vQPi3FWkW4Il0zTESf/eog8f6X
 F8ExY5VExPD3ENF9EBhKzwmU98Hjdu0MV+Aut2Izvhk+mb+kQtVLpkRpxo2D11oLnqev
 +XC7VNidJbRZXNPdpJ/WZVb3N+nqKm4XwFIbzBl81iKr6ET91NR72uivnK9aHQLKbdcP
 v7pZUFDln886Bl3t6oi7TFerxTpD3dEwbjGBgfr6IlEzWzYFRqq1DtN3XjDvB/5P0Ism
 DERg==
X-Gm-Message-State: AOJu0YwMbBraUdPS7nlKteV7Wnm/KpSDtOjq744gRxqDxdzkMoYEW3yY
 uqdusCfbwLRZyDbfeNtVAhN9PFW++oHp6VSnlnrW+EvpLuSXtgVihpa2jQygJbo=
X-Gm-Gg: AfdE7cl9qDC9WhlymPhfyNSXl5UJjYT4hCSvzhbMKKcSlt/YLXiTjN/0qyZh1BRU4/4
 oeDZi3PeuJ8oCMeojFCzkut8xvkOIf9DFE+Xo0M554Z4YBCV4xH0ZDMRQBYtJD5c/GGDxU7Pevc
 gFQOEcT/p5BHzoJ01FDcudJ3dr7tvrp0dKRKY9QCj11ggzKPwulflO8DL7melcek3GnYOS5OQ2c
 7csvxB3Cbo7QRYyj6KR+vbZB/28xNabMNmp8lu7OxmBNHYVmPI898IyTkbsyqiFYwXhWRt1WTv+
 F4kYtYbOcucXNGMEhcI0VIhkvciAlIIKS8MZAFUPjYxTnRKG2BOKMAfq7oVYNqPsuZ2CckgEjOs
 tIRO/y8nTNjbrbxvsUB8LSou7BxdgmnRAb5WyGq1CCntP4I1DHEHDfNMONU3r+KlGR08jAatVNP
 o=
X-Received: by 2002:a17:90b:57cd:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-387557685demr4417372a91.6.1783413364493; 
 Tue, 07 Jul 2026 01:36:04 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483e0a2sm5435221eec.12.2026.07.07.01.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:36:03 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v5 1/3] hw/pci: Introduce romfile_fixup hook in PCIDevice
Date: Tue,  7 Jul 2026 16:35:48 +0800
Message-ID: <20260707083550.25765-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083550.25765-1-tomitamoeko@gmail.com>
References: <20260707083550.25765-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x01.google.com
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

Some devices, such as VFIO IGD passthrough, require device-specific
fixups on the romfile provided by user. Add an optional romfile_fixup
hook to PCIDevice. When set, it is invoked from pci_add_option_rom()
right after the image is loaded, receiving the ROM buffer and its
size. This provides a place to post-process a loaded romfile without
leaking device-specific logic into the generic PCI core.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c                | 4 ++++
 include/hw/pci/pci_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..04372074ff 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2639,6 +2639,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             /* Only the default rom images will be patched (if needed). */
             pci_patch_ids(pdev, ptr, size);
         }
+
+        if (pdev->romfile_fixup) {
+            pdev->romfile_fixup(pdev, ptr, size);
+        }
     }
 
     pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..a65e77018c 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -159,6 +159,7 @@ struct PCIDevice {
     bool has_rom;
     MemoryRegion rom;
     int32_t rom_bar;
+    void (*romfile_fixup)(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
-- 
2.53.0


