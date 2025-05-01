Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F76C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcvz-0000yM-I9; Thu, 01 May 2025 19:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvs-0000lQ-3a
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:03:08 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvo-0002SA-Ky
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:03:07 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d81768268dso12735185ab.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140583; x=1746745383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxbj7/6jpfy/qwZ4ED6zTk/j6/a5zMwR5eVDDNTE+Aw=;
 b=Lsp1AG9lDLZgHf6eAETrKJR0UGj/z18y6zKyRKj0S6rlJz/WA4zGXLeAOJswN0/Ml5
 eL5vv2sLoK365D7od33wWYGCfmMc0XqLOLU26/z5tf4zrjW8LZAHHFv4g5XGheTujwjT
 BDBRtzkXkJqG1Vq2BYo0J0TrlULxSj7re/2JLuafklDdf5gIEfa52PSxP7EcXGPK5YjT
 atYo9nAM7wwXmrZTWWgp3cvaOEs6t8FLQ23xx79IOnzRNcnsaRGcAEPPdj2Y9pAryZqj
 68VqAyXS72CDXURIapSpFj/ZKVTsawGhhS8K7qcSwoyft1YCbOWya4TiX7RFV8UISRBe
 L1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140583; x=1746745383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxbj7/6jpfy/qwZ4ED6zTk/j6/a5zMwR5eVDDNTE+Aw=;
 b=Gkfkhu8ZdNoaIRWziogxkvqetX2bJI0+NptJH308Puj6zxm7B+XGok6CtNyhH5sBvP
 qNVLVP9HppL6a02iDT4IZ2cjFYWd2yQzsr2uDkqOb2A7Hw+39wgKu802mfib6U+IV7Dr
 CbF2vDsllchjXG+EZURe9VnakrrHJhAYaSPPAL3pIgFzyj7bzq4j7qEbNxUiAacd/8Am
 iqiL4ugLDd9l4DyhdRqLDex+XTxbsdKJDxUwUhPQILbhBvZngxaiL2QlQbUUiBFDVOZN
 91C4V+QDAXOiSVz0OElkJu4WmnISsgi6g344ngJOe/qeA24oyILPCwMgkE49W3XvcX54
 g6Ng==
X-Gm-Message-State: AOJu0Yy+fL2nU5P6Ec+K1BuEPlsKz5Wh01V5WsHfyruTIJ95ggvpPHhM
 7Me1+Dewf4AtmbfxfmwapJcR3tK0lLX2xx0Mul1fZhGuK+4JZRrwvvLATiT7vTssgWF8KPCgdZu
 p
X-Gm-Gg: ASbGnctdQk9p+Mg3q1IaDebxF0KIzH3rDLHJLdlVZcbvZ63JHhEyALRlOwORU76t6fn
 4R/OERvCzIYpDqTh9av+rfI1F6XseqlpDpNW2Eehb6GNwpaiUXC+uc5FUm4sgHH40KvKGqtfjzY
 ZyHSLR5AFZSwR5akpyUsE6WuSemETMW5o3sDq3e2iVePxI7xRNJVMte7K4+zwsQTcRRrWl3kyJ/
 aBHFGIbyi4J7Xc6tu8XmM2RKfY0Hhz2OJgfb4zUyImSm7ft6sm+vfUu+N+3629q7yLkSIi1x9Ft
 KyWmRiS9Ga/ARg0+DHYZgRxiL7bWo6MAVc6348E6O9bZpC23WB14+ny2B2sTKvC8o1aBKqhUtnv
 X/t5ZNizw7lnv1Qn/dy5dMI1MtobUdww=
X-Google-Smtp-Source: AGHT+IEXbuFFne0bt1KlOJySBL/5o8UWkx58G4hGCj6erG2/vT7c9L0SEJFjHFzcVa0/pob8KTwFnw==
X-Received: by 2002:a05:6e02:16ca:b0:3d6:d145:2ffb with SMTP id
 e9e14a558f8ab-3d97c2579fbmr10256185ab.21.1746140582938; 
 Thu, 01 May 2025 16:03:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e7d0d3sm3507565ab.28.2025.05.01.16.02.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:03:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 10/10] hw/display/vga-pci: Do not expose the 'global-vmstate'
 property
Date: Fri,  2 May 2025 01:01:28 +0200
Message-ID: <20250501230129.2596-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The "global-vmstate" property is 'false' by default, and was only
set to 'true' in the hw_compat_2_12[] array. We removed all machines
using that array. Stop exposing that property on the PCI devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/cirrus_vga.c | 2 --
 hw/display/qxl.c        | 1 -
 hw/display/vga-pci.c    | 1 -
 hw/display/vmware_vga.c | 2 --
 4 files changed, 6 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index ef08694626d..f9f704ab440 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2987,8 +2987,6 @@ static const Property pci_vga_cirrus_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
                      cirrus_vga.enable_blitter, true),
-    DEFINE_PROP_BOOL("global-vmstate", struct PCICirrusVGAState,
-                     cirrus_vga.vga.global_vmstate, false),
 };
 
 static void cirrus_vga_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 18f482ca7f7..32329a499d7 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2495,7 +2495,6 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT16("max_outputs", PCIQXLDevice, max_outputs, 0),
         DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
-        DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
 };
 
 static void qxl_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b81f7fd2d0f..562cf526db4 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -338,7 +338,6 @@ static const Property vga_pci_properties[] = {
     DEFINE_PROP_BIT("edid",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
     DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
-    DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
 };
 
 static const Property secondary_pci_properties[] = {
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 544bb65320b..c43026bd9c5 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1335,8 +1335,6 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
 static const Property vga_vmware_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct pci_vmsvga_state_s,
                        chip.vga.vram_size_mb, 16),
-    DEFINE_PROP_BOOL("global-vmstate", struct pci_vmsvga_state_s,
-                     chip.vga.global_vmstate, false),
 };
 
 static void vmsvga_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


