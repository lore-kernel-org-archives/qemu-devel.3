Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B09CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGW-0004ru-Vd; Tue, 21 Oct 2025 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGU-0004pi-JJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGS-000143-5W
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1501564f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079646; x=1761684446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VVFA48+wwFEfCjJAr08Wk2/47EEpFuLvgqa9uV1JQUw=;
 b=Fu3V+FuCq4HvJxTXJJuaC1Y7H64/f/s6PCcGEgFJ3ratvU8uxFLhNKfCcfmYsJPXFD
 MY4qG6rnI6g4fKLktsH11gdNqg3RT3fOJR38JIXaLXPthJ9Phb/D6KkkbpBx6Hu43NM8
 4HHW2M0ZsHZZ3mbFRsIKJciP5pHARdTBVkg9iy9PuHbNWVMlN7KAfGFJOQyBmslkWFXN
 jdBVY9JARZOi5cm+zpxY13iagdWOmsi51CqBP1YdMfDucZGQtHZ7uVN2oPFd+9pPRD7Z
 Ov5WO6l24OtiXP8ByufpIUJIgDtRF29a0n8knaeu6dsW2Acl1VSnrmr/kdI8Lk68EV0c
 7iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079646; x=1761684446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVFA48+wwFEfCjJAr08Wk2/47EEpFuLvgqa9uV1JQUw=;
 b=hP1sGYILSBLSlQpTjCDvusjTPfk+AkilSNZ++i9tZOS4glxP8VJKf1v4sUiItnFswB
 TbMc9xnpnn4AB16LYD2/UfXVuRz9v2yo6NPcW7Jn4YO4LWIZ7IpI7iUnCC5D6ihmx/AJ
 HCAN4Tf4Sjx0k1W0tiPYPf36gCsImcl/kxOZExzCNZj5kGmJHjXNBhLQMOQYny5lel37
 rkneh4yhy4Ljj/7dnwZ1EyrLnaWCBTkYUvjdA+DjWXHXohR7hOOBe16aD97eqN6pttm8
 3VV2uLp43e4t5DhtzdWDwAfVC5vlwC8M9xC4c0ltr7q3pZE55v4IHmseV/DYoZR4dqn8
 +nbg==
X-Gm-Message-State: AOJu0YyVfGrdQJg+cS1UlEw+QudqAaNoV4xJ1K7Tqtp0ID4neIvhpriw
 LnlYmX1S4EiPuhQSt2DPnejBzLwo2hyVVn683M7AIZ1xg3Y+aFlIEmatjg1byRnWL5y3vEjrfyG
 saCWyeXo=
X-Gm-Gg: ASbGnctxogO9rg7pM9GHG1x0RURMi0auIpvB+sX9ZsDVwTTu1Dc7DOrHw3CSN2M4ioJ
 FumsEZO9P2j/tx+viXcFNWIVeSYaFB9QW2pnjiX5nJuDDvwecpVhkC+wTw4vX3K57nL1HcYa2oN
 FHb7ZVwJfIBQjbwTUsqByFkrx53BVaYJNhvreqzQC63Qw0hnxdRC3k66VYtkhPR/GQ2aIMYrah0
 y/XpmfWBqxrL2FgHajx3a8PbALxBwBgFmueQUq82vvUxDsjLUygAPyx5wrbnYW3rQaNptzyCaNp
 Bveg3Hob4UVUL1KoMA+7eu3X7mhHbVyvN7H7Ys9Q9/rb7Uy75akKaYlYkmIocXA32Tsih3Ns29/
 56VXXujVUnPKxb4UW5uz1K9kn0Cek7uiJkfTpmZyc7RZxUAxQvqNTq3/g+mIdc7rSyvIciloPYb
 jlpvATGD9E6IC47LUwAiFP8kpOWcCwSWm6nwWVaCUBP+E5MW2BVA==
X-Google-Smtp-Source: AGHT+IE7pVkehO3E+ccpe1mlhe27kGiHRGX6OYRZBA8E+P2kNym0gKM+bWvMLa4rTa9Op8ovQLEzXw==
X-Received: by 2002:a05:6000:2c09:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-42704daececmr14800970f8f.36.1761079646084; 
 Tue, 21 Oct 2025 13:47:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c34sm21760533f8f.17.2025.10.21.13.47.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/45] hw/pci-host/raven: Rename direct config access ops
Date: Tue, 21 Oct 2025 22:46:19 +0200
Message-ID: <20251021204700.56072-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Rename memory io ops implementing PCI configuration direct access to
mmcfg which describes better what these are for.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <74fcd70106289663ea426161aada78e879995d6c.1760795082.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index ee9058e262a..e0ebc81c247 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -77,25 +77,24 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
     return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
 }
 
-static void raven_pci_io_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned int size)
+static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
 }
 
-static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
-                                  unsigned int size)
+static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
 }
 
-static const MemoryRegionOps raven_pci_io_ops = {
-    .read = raven_pci_io_read,
-    .write = raven_pci_io_write,
+static const MemoryRegionOps raven_mmcfg_ops = {
+    .read = raven_mmcfg_read,
+    .write = raven_mmcfg_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -253,8 +252,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_pci_io_ops, s,
-                          "pciio", 0x00400000);
+    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
+                          "pci-mmcfg", 0x00400000);
     memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
 
     memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
-- 
2.51.0


