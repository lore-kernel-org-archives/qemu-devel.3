Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D5CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQWp-0004Jn-EO; Mon, 27 Oct 2025 12:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQWm-0004J9-E0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:57:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQWi-0001Qr-Lr
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:57:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so4449903f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584212; x=1762189012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cgsohnlqfIwKcj+UfAMSb5jLmeYbJmNA4yX9S32MCE=;
 b=RvnhzdJTzQ5sa0jAaGSOIvWJVyLcXY1CL+JZBqHHp28Xmy+v4njXzcSNLa/yKYqUZl
 yo+MhDgNWweu8ECsA58LH5i2QfNV343wNOrv6xiZLtP7iqwlPxyV2k034vYgDrnYJ979
 r2h9wwUN1MLmDJ9aHXnhKQeWdEK1iSrb8M+zeklGMCYEHSiu4EQl+wve2lpr2vcsN0ql
 d24vKYDhc6GyAjdpYhUJSpO8/Nvcp5usSL48OAHIlv/grNN7+EZgu/6HOzphM606j7kg
 a4/nOqpgQmTquaGCHoqwCc4219rZBgjFpayWZBzMakqGrFY5T3v8/4FdM01gzzimzbTL
 /q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584212; x=1762189012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cgsohnlqfIwKcj+UfAMSb5jLmeYbJmNA4yX9S32MCE=;
 b=NiMBmRKYaUXw91jfRNbszV4Y835Mmf2vA3wp8gQ7rCBwBpSHiiJrYroTkStuOwvFvN
 0mXgpWv450lAPiFB3A1BH3IMu2uPi3pL+WJbXb61pe5LWEfevjmg0nRN1TfrPOMHCn0F
 FTHw4OjpTMq8zr/JtMWczJOu9vzr63GgUnCne3gdilPPKO9rNG01JSgCSkHv2Kb+K818
 /A3Bot3mytk3E8uYkf4pZ2jIWmLma4Wz/nGr/mYxYAFSFSEYHE0Ao2aX2gC/QxO7oPGa
 K/RAWcmiXW+elKLJ8U+KVUv3cPUg+rMvyEe76RqJGW5RmYuywpKVpQLST25jmJp+fo0B
 YpOA==
X-Gm-Message-State: AOJu0YxEUDJ731+niveWJMmvkzUMjnKPV9yVacvHrar6u4F3M3cWa7dh
 /TV/90qXNCfZfDsJlQ8+/hx94lQbU11O+8cXMjfWcbKUPL8tWvJRI9sAOHgkwdprQiua2k7+hrN
 0vqhU59g=
X-Gm-Gg: ASbGncvEA7xvBy8LsLwGoaIWtBg94svrynfm57lDqhIeqCiOi3nwKGQUW1jDoTmVcRO
 XD4ZPf4OwdG8I1CPPw6Fy7Wed41+uSGuVjkNB8wME/SAG9Q3wgZlex/QlOey4JO+Mui+fkJQOWL
 ki90zvUL5fOgRhhxVxn7411wpaDFp5/Yiv+z1CuGATbSqZLApOlDWcPUXS9IRVdKf6Gp0kI3+0K
 FvW21QgcqtomLwgFvlQzQT8QwMdbXWkvI8XTlgNoa1PRdh2XaQSF546y9sNT4PkcviCbbIbzeSx
 Id8dHAWqAxZd1le3bIM2eCP2D0nWbleEvRFQP1Cm6QSQtEknGreJq54/63IjnJQBtRg6F2WIXE1
 6LmHciDFeX+qIsm7EDdvYeeoHaqf8qPY/wSmJl4cRV2X0dS6x63pB2eGnf18Wh9xP7JoaakKSkp
 umz+P0aRkZeQaEpUibrHsgqXITgwaujdI9YhfA/ULiRAX0/sRoDw==
X-Google-Smtp-Source: AGHT+IEjovgpOz7XN12E1ogjYuZ5/HhI/Cxq7vKPig9ZFea41DRNg/SoJufOiYB1YV7fQj1ka/pnew==
X-Received: by 2002:a05:6000:2405:b0:429:8e79:a181 with SMTP id
 ffacd0b85a97d-429a7e9ca2bmr301011f8f.56.1761584211671; 
 Mon, 27 Oct 2025 09:56:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm14793791f8f.15.2025.10.27.09.56.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:56:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] hw/pci-host/typhoon: Re-use generic
 pci_host_data_le_ops MemoryRegionOps
Date: Mon, 27 Oct 2025 17:53:03 +0100
Message-ID: <20251027165304.98296-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Avoid duplicating code, re-use the generic generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/alpha_sys.h |  1 -
 hw/alpha/pci.c       | 26 --------------------------
 hw/alpha/typhoon.c   |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index a303c584383..c193f0a9b56 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -14,7 +14,6 @@ PCIBus *typhoon_init(MemoryRegion *, qemu_irq *, qemu_irq *, AlphaCPU *[4],
 
 /* alpha_pci.c.  */
 extern const MemoryRegionOps alpha_pci_ignore_ops;
-extern const MemoryRegionOps alpha_pci_conf1_ops;
 extern const MemoryRegionOps alpha_pci_iack_ops;
 
 #endif
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 7c18297177b..d44cee570bf 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -38,32 +38,6 @@ const MemoryRegionOps alpha_pci_ignore_ops = {
     },
 };
 
-
-/* PCI config space reads/writes, to byte-word addressable memory.  */
-static uint64_t bw_conf1_read(void *opaque, hwaddr addr,
-                              unsigned size)
-{
-    PCIBus *b = opaque;
-    return pci_data_read(b, addr, size);
-}
-
-static void bw_conf1_write(void *opaque, hwaddr addr,
-                           uint64_t val, unsigned size)
-{
-    PCIBus *b = opaque;
-    pci_data_write(b, addr, val, size);
-}
-
-const MemoryRegionOps alpha_pci_conf1_ops = {
-    .read = bw_conf1_read,
-    .write = bw_conf1_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
-};
-
 /* PCI/EISA Interrupt Acknowledge Cycle.  */
 
 static uint64_t iack_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 4c56f981d71..f5a9d6e6ed4 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -911,8 +911,8 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
                                 &s->pchip.reg_iack);
 
     /* Pchip0 PCI configuration, 0x801.FE00.0000, 16MB.  */
-    memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &alpha_pci_conf1_ops,
-                          b, "pci0-conf", 16 * MiB);
+    memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &pci_host_data_le_ops,
+                          phb, "pci0-data-idx", 16 * MiB);
     memory_region_add_subregion(addr_space, 0x801fe000000ULL,
                                 &s->pchip.reg_conf);
 
-- 
2.51.0


