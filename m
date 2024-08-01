Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946EBC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 13:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVe1-0000ZP-VQ; Thu, 01 Aug 2024 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVe0-0000YY-I8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:15:00 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVdy-0007U9-QP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:15:00 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f025bc147so9761505e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722518096; x=1723122896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7jwh8lRQxFh4MuUn3bOEyy7JI6tHJM1nsPaQiEvU4+o=;
 b=lpgjrqae2LJ7EmskjYMD70ejmfc2Qn2TdyUpFZS75hMBSsXQs4vhGUbIcipSlDQ3Ob
 wSQ2zyFK3mxnTUcyddahUI9JsF/jocbSiek/3G1GcdbZmHk8FXufYqIEc7tn/erB34a0
 4S6VYuIbNR6jnGZepr57Z9a6Po8epum8KCcsyQrmnT0cwM2VySs5cKZd08nUYZz6MFi1
 TK1gANgi+zfiThgEVc+o46mESxzzAt08tVzcUMKqe1lgsePqVNCZVbN5Luai5nMA7+W7
 IhSibZv3ZrRC95aUbxhFDUvXqN8OitUhrxXomF67qFGbN7o03N/cRSNo9eaNaAJkFQhH
 siQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722518096; x=1723122896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jwh8lRQxFh4MuUn3bOEyy7JI6tHJM1nsPaQiEvU4+o=;
 b=uPjsKG19uCJlj15CKgMf++Dwdg7Q8yMJ+rxSbCeDMOoaDG7U5WjNVGo9wmBLPFMUGj
 OcbRc+dH6Cd/7u5ZEW81PQDK2QSg6xCURTn1PmYBPat4+RlROhCqmxV7dXmHnzjS7NOj
 DZ7z2G1UKQKfC7qb6FLIzTj0e+jD2Is8qDUG4VLfrkoVq5u3mE6LjXOGDMyF3Kxceahl
 lFAjJpLKDd4ILLqD7vJEWx8sBZR56g02SOvD9IoguM6lKev9+LJxx86eespIwUwiAXSO
 qjEQawbkFHZkdazGam8wXDemkZW7CDgRDnWA2RA9Dm2XgpJ1+PvIkRFVyTj6pXuf0qv9
 HzdQ==
X-Gm-Message-State: AOJu0Yzrnz2ev46sG/PgFXMpCezwWg5eX0Y8Yh5GaUEo8l3D0fJtTjBz
 l6oO4VSx1/wjrOjOzxLkJo5bGTuiSBFj4/0MSIBNjcwrhiUdz9je32iI1SNDlkXDrLJ8Xm8/I6o
 2L0w=
X-Google-Smtp-Source: AGHT+IFDltY5HLk7iJijJ61W0mkLA6AfANbssOvnrf19t4bwqkm9cChuhqIDqQl8XZkgIc1M5ajjIw==
X-Received: by 2002:a05:6512:2208:b0:52e:9b92:4999 with SMTP id
 2adb3069b0e04-530b61a986bmr1708141e87.2.1722518096232; 
 Thu, 01 Aug 2024 06:14:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de47sm899780766b.67.2024.08.01.06.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 06:14:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1? v2] hw/pci/pci-hmp-cmds: Avoid displaying bogus size
 in 'info pci'
Date: Thu,  1 Aug 2024 15:14:49 +0200
Message-ID: <20240801131449.51328-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When BAR aren't mapped, we get:

  (qemu) info pci
    Bus  0, device   0, function 0:
      Host bridge: PCI device dead:beef
        ...
        BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
        BAR5: I/O at 0xffffffffffffffff [0x0ffe].

Check the BAR is mapped comparing its address to PCI_BAR_UNMAPPED
which is what the PCI layer uses for unmapped BARs.
See pci_bar_address and pci_update_mappings implementations and
in "hw/pci/pci.h":

  typedef struct PCIIORegion {
      pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
  #define PCI_BAR_UNMAPPED (~(pcibus_t)0)
      ...

This improves the logging, not displaying bogus sizes:

  (qemu) info pci
    Bus  0, device   0, function 0:
      Host bridge: PCI device dead:beef
        ...
      BAR4: 32 bit memory (not mapped)
      BAR5: I/O (not mapped)

Remove trailing dot which is not used in other commands format.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index b09fce9377..fdfe44435c 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
         monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
 
         if (!strcmp(region->value->type, "io")) {
-            monitor_printf(mon, "I/O at 0x%04" PRIx64
-                                " [0x%04" PRIx64 "].\n",
-                           addr, addr + size - 1);
+            if (addr != PCI_BAR_UNMAPPED) {
+                monitor_printf(mon, "I/O at 0x%04" PRIx64
+                                    " [0x%04" PRIx64 "]\n",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "I/O (not mapped)\n");
+            }
         } else {
-            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
-                               " [0x%08" PRIx64 "].\n",
-                           region->value->mem_type_64 ? 64 : 32,
-                           region->value->prefetch ? " prefetchable" : "",
-                           addr, addr + size - 1);
+            if (addr != PCI_BAR_UNMAPPED) {
+                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
+                                   " [0x%08" PRIx64 "]\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "%d bit%s memory (not mapped)\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "");
+            }
         }
     }
 
-- 
2.45.2


