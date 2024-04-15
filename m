Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8D1C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNkA-0002pi-PD; Mon, 15 Apr 2024 10:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNk9-0002p4-Ou
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:37 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNju-0002UR-E7
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:37 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso42171521fa.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192920; x=1713797720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26xL4nyLa03qsh/MrJ5eSnLADg5vlBGpuAoX914Cqss=;
 b=xvc5kimLxXb2u67kG4ew1S2OCiuf6Q8LLJg/ELH6cbhPTRfYN1no0p2LtyCjZOSQsA
 uxrVJEMYuAVubdMlFDuDECNIyNnIBoB5rzO8G9UeC5iZHCWkjmeM0iQ9FLQ1DTWdzlZP
 d6HkrvWjjEmdSydTjvuto6r1dGFVAcnCgRAAxg3YFOM/1AAmkpzr+gVE7tBkC7P1Tk0U
 KRVi4v1jcKxXCtuGfTbq/7VfRz5ETVj4/gXLuoz2ImUfWUPfu8DKaRtjdGIxgfHP5xiO
 ZflTOIXQZ4Ag62yq7jYMadjLAIcr5UJLDJ2TNC7EW6pUV0+O0ZkLBFKV5wl7eyYX7/C6
 1RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192920; x=1713797720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26xL4nyLa03qsh/MrJ5eSnLADg5vlBGpuAoX914Cqss=;
 b=QZbpL1K4y3RDiQsN2fT1UjN1AvnhKU1/pFOc0RnW5fvspp3kel8JDkRvAydzDV3o4j
 usu7qX/FBkHajFQd85cuRS+TKC4lTPWrItez/XUrGmRjfr8O7X+5sSdSbiphWVZXbv/s
 hD5mvD3H7dkUUcrOOBqVmHTgRRMzpkWG/GqyXOsDPxUOo+zZ+Jjnpb3ZbncUGg5PiOdY
 3zpxDuVG3JD0krZgavsbZzZaD/vSAQ7oDQ2QPDzJZ2Ysh7cdhUd9mDTazMwYgILu/Xg0
 Yl5Bc4B4+ey98cldXJu8ppmlnQ6agjIIa6Sjt6jFzq3IlNgIxRXo+Ows9SInWqayO0v9
 0wow==
X-Gm-Message-State: AOJu0YzO4u2GmqF75VxKiEgS301xQ/vND/ugi9EbPSZ3yKDdzOAhA1YP
 QY+8DqtcRFlxZCtExMzFJXBFCYLBXTLNyy2ls8tH7SOUB86vaX+UxEAVAYKtuWyzCY9z/PZruGo
 A
X-Google-Smtp-Source: AGHT+IGC5OJIjtV5dEH1v8O60J2IgVleuBvXDJwsy5DXIpn+q+lPuwrXU6joBxIRM8gYeAyYXSbYwg==
X-Received: by 2002:a2e:8ecc:0:b0:2da:6f70:56e6 with SMTP id
 e12-20020a2e8ecc000000b002da6f7056e6mr2257927ljl.24.1713192920284; 
 Mon, 15 Apr 2024 07:55:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 bi27-20020a05600c3d9b00b004187c57e161sm1369461wmb.0.2024.04.15.07.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Apr 2024 07:55:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/2] hw/pci-host/ppc440_pcix: Do not expose a bridge device on
 PCI bus
Date: Mon, 15 Apr 2024 16:55:05 +0200
Message-ID: <20240415145506.48179-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415145506.48179-1-philmd@linaro.org>
References: <20240415145506.48179-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Real 460EX SoC apparently does not expose a bridge device and having
it appear on PCI bus confuses an AmigaOS file system driver that uses
this to detect which machine it is running on.

Cc: qemu-stable@nongnu.org
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240411192443.B4D644E6026@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/ppc440_pcix.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 1926ae2a27..ef212d99aa 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -52,7 +52,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
 struct PPC440PCIXState {
     PCIHostState parent_obj;
 
-    PCIDevice *dev;
+    uint8_t config[PCI_CONFIG_SPACE_SIZE];
     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
     uint32_t sts;
@@ -171,7 +171,7 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
     trace_ppc440_pcix_reg_write(addr, val, size);
     switch (addr) {
     case PCI_VENDOR_ID ... PCI_MAX_LAT:
-        stl_le_p(s->dev->config + addr, val);
+        stl_le_p(s->config + addr, val);
         break;
 
     case PCIX0_POM0LAL:
@@ -302,7 +302,7 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
 
     switch (addr) {
     case PCI_VENDOR_ID ... PCI_MAX_LAT:
-        val = ldl_le_p(s->dev->config + addr);
+        val = ldl_le_p(s->config + addr);
         break;
 
     case PCIX0_POM0LAL:
@@ -498,10 +498,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
-                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
-
-    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
-                               TYPE_PPC4xx_HOST_BRIDGE);
+                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
-- 
2.41.0


