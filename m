Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301DEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2JV-0000F7-Nj; Mon, 19 May 2025 11:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qwinci222@gmail.com>)
 id 1uH28X-0004pn-MM
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:10:41 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qwinci222@gmail.com>)
 id 1uH28V-0003X3-KP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:10:41 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-54ea69e9352so5945850e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747667436; x=1748272236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hmjU4yCHcbWWF7c9lj7ZkaqLnb57uVZJ8BE2gA2Esno=;
 b=Dazn02ipzftNv4GDFZG1zrPhNnY0pKC0hqRbSHritY8Th+5i3G9QU9QY3163UIq/7U
 Sw8Lsd7DzDLFeDBqogY8lwSQFXRdvJcin03xb5Bpx0+xk7Ud0zzPiI8On9d9IsC7O1HY
 tv8PHCNRWNp0LmIaUSH/i/3AejOGEVZ/4jQM5H+91QT5aSZYSzCOvHCqH3AcesiWALSe
 zkIl5VsO1qXRs2D3hWZ/9k7IUK9wrm3LvZQWsRtLJSrT7iiJxFIKm32ZOwa/AHPXlmDE
 NKvee/6lS0fccDZCDrhrt0dXWSi7K7AVTGKbyWwfH/kMMpoePS0koQfUqNIXg8aSqioH
 lvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747667436; x=1748272236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmjU4yCHcbWWF7c9lj7ZkaqLnb57uVZJ8BE2gA2Esno=;
 b=B2On84CK/BXuPWtV2X8WNUA/OM6kRDR6GFE/l+ksn/49V1NZVCO1S/XTHDQBR53UbH
 JjbSqrA1m38afpCWXnzVKfexH0NQzp/fAAdNG2HwceMZpZjUXM7ALC3PKPoxWqSSnums
 VIzTByo7dxgrLMZyJ9+OTOlpUImD1/uYDgepxDE36746uA0mimJas8PGyyLTg/gOjJ/6
 haawuQPw1+mZP0GdseCKyFMZ9+2mWOqPK4t6khBOLdlB9Jcc4zIGe+f4W5wSk4WdvMAb
 FRnwaorhNk3xJ7VdqQdcxyRRmccVNjrfm41ZHtC3bRcMtAy9GUnVAbtFa/OoNfX3UThR
 gdiQ==
X-Gm-Message-State: AOJu0YxjEHlSDRD7Av/WxcO6VNSWz/0C7N7isIEkKURiyoF2lQ5uNUZz
 WXUVHYjxw+4k3ks52bGRW7hy6HBFwMkddF2eNpByGmrXS4qS5AAVeSRi73f8aw==
X-Gm-Gg: ASbGncuRsHmJpi7cxFl/H/frxn8asKGzwnQ/In9iGvGHqvkjIKmLUAm5yGni9XlGZyh
 4o3msJPb87upJxWoHvaKzTqOb5NQxeOBcpTPzUv0QSpBkew20r3sZ7xAXsCKSdRmt9H62e+4r+m
 x0BqMz60GUyqxzH6qhgSSXT6oeJyNVSdqRcGrEhZlupwFM0HF4IFUibXZobC7PLySd2lf7uXdcS
 yEYMbgTSXdkT/H42yXwPFIfP8MSBfU1pswOhZZYhtIx6o96bUt8tX3l65dd2n9SsO1ek+CY/Y5I
 eY1jB5or0LP3qJae406xY5pzr652MqgbVlf50+zYdlh2TnPhJ0NFZwV0Knk6/4yo+Qc5LeLXAj4
 lNwIfcT+pBU3UUXqd7CqelQ==
X-Google-Smtp-Source: AGHT+IH6guPC6gvANUuDpPosXjcPd7NqWenk7ZWu633l2zd7SStRNswubpJUtLaEgGqOlPtdLroXhw==
X-Received: by 2002:a05:6512:22c8:b0:551:e979:f929 with SMTP id
 2adb3069b0e04-551e979f985mr2208161e87.15.1747667435899; 
 Mon, 19 May 2025 08:10:35 -0700 (PDT)
Received: from localhost.localdomain (91-152-72-83.elisa-laajakaista.fi.
 [91.152.72.83]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e702cf84sm1898781e87.178.2025.05.19.08.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 08:10:35 -0700 (PDT)
From: Qwinci <qwinci222@gmail.com>
To: qemu-devel@nongnu.org
Cc: Qwinci <qwinci222@gmail.com>
Subject: [PATCH] vfio/igd: Support non-boot gpus
Date: Mon, 19 May 2025 18:08:39 +0300
Message-ID: <20250519150837.23146-3-qwinci222@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=qwinci222@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 May 2025 11:21:58 -0400
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

Change the IGD detection logic to also accept gpus with
PCI_CLASS_DISPLAY_OTHER class which is used if the igpu is not
set as the primary boot gpu.

Signed-off-by: Qwinci <qwinci222@gmail.com>
---
 hw/vfio/igd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7952d15a0..1ddfcc2c17 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -454,6 +454,16 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
+static bool is_igd(VFIOPCIDevice *vdev) {
+    if (vfio_is_vga(vdev)) {
+        return true;
+    }
+
+    PCIDevice *pdev = &vdev->pdev;
+    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
+    return class == PCI_CLASS_DISPLAY_OTHER;
+}
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *ggc_quirk, *bdsm_quirk;
@@ -461,7 +471,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0) {
+        !is_igd(vdev) || nr != 0) {
         return;
     }
 
@@ -519,7 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     Error *err = NULL;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev)) {
+        !is_igd(vdev)) {
         return true;
     }
 
@@ -685,7 +695,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev)) {
+        !is_igd(vdev)) {
         return true;
     }
 
-- 
2.48.1


