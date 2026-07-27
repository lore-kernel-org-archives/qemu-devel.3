Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0295FC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woB4o-0006aY-3G; Sun, 26 Jul 2026 22:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4m-0006Vc-HP
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:20 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4k-0001De-Qt
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:20 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-92e5b048375so129399985a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785119298; cv=none;
 d=google.com; s=arc-20260327;
 b=IXkJwcZUrxaWRiLKf7MfWHzy7rlCDVLPFao4euloHrUJf6BmM0ktfy0RJMUZyZlKIY
 6w1K6gh5b+XWvoPq23XO6GUOmFM9v2wcllcXsK0ZPyxLOuWbnjRPS7DqQWLjpM9SxT3m
 DL7whi5jpl2FK3sB1+DRBLCxMTxPQx/frhPYFWAshVwl+/1/EACNyL+5SWDNXCfD9vmF
 dJAQ6H2yX5rnCgh5mXODug/fIZPXsf/bqizLucShtEz+2OeuASoGFo++tYLuKcBBaKJz
 ygiNLpeyKASvLdEf0Ukc74GXbjsgop4V8ZQCHweFmLacswArAVEoj7pVHMCGILYGlbz/
 8iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=lMi35gDihCwI1P51XMeGM8P/9jzYQBtwW4fd6qN5iX0=;
 fh=tM9uqhnisH6PlMOYdsdDavWujv1Qk2/fU/qZi5QboKo=;
 b=fYseTRCw4CppH1gDv+xAGqLcymVUvPfq1kpijiMzdgm+9vRfCc0YjFytxpH2Y1ZWIL
 sugp7Ga3WO5/FckUswUCfGAb8X7NUylfQPbsoRHya5xV0hFgZgoymRt4z0l8mKxfEohu
 KMaGpb0ZsV0x0MECK2hu0b6Z5aQ8nWnMAV3qFEoWO9vDUKCvgTSRWYHS7ji/sXi+6ht1
 7JNHKHB6tdwNFZrG6toL5fgEwn0RnPCVLh4Hmu5lS7mpbFlLqcrqDmgfRoyLD2D/DUgY
 QgKsuo/RUP8lkeb/tbYklefOKMv3Ur5UKEajFEn6qKQ1pn35tZalArp6Sra3m2Ufr+zw
 LT+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785119298; x=1785724098; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lMi35gDihCwI1P51XMeGM8P/9jzYQBtwW4fd6qN5iX0=;
 b=i2kywZ63ks616E6XOqLwi5yYFLYBouJLBUxE8+eHg9UXbEH4Q2QoO/csWUuykOGu8s
 gtbTR+rEjJO53DKL/xIF7GPaqH3ogv/W81nyQuwBAD0sX/nENdgkhfwMtufkwV94Q1Wv
 ilzfAubjYzzMjuZnOFDt8X3jc7qhAiSNRomEI5tbfNt7pFkUlkJpYuEMqBkXpyeayijB
 vB8sZQxLyBVRu+pevoQ/zzkI37fhGHHThU2R+Ll3/CR+upJRU1QLlfPfOH5N4SlWtN3l
 4EXD2pNLFxXVipZ4rDQ/CS2SRhRRBIE7lSfk+bYeZBG2eWae3I9PnPJ2e4ReOftH50zi
 YsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119298; x=1785724098;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lMi35gDihCwI1P51XMeGM8P/9jzYQBtwW4fd6qN5iX0=;
 b=bjkcjyvi/580wKee3b0TYbfRSQ6cvMtH6C3FkpiSwuprTPhbuSnioqmtUrjyehTFed
 k1q3nCZMgwnn82TcH0fkW8Ys1N1aLOcAWUWc8w3/U7/Y6fzeihGtjCqjQQhLN/djZ/4N
 ZbRSXp5HLvCU7eHU0cLzCIXP2nHn8E195J5dfjOJUth1OLao2KEqkP436HBJmTxgBKcf
 6cOtOCWAe9K1cTOxVWSKzESkJR/TKdd0d6xswEicZ2YQLQr3h4ORIiga0XRy8VQtxaiq
 K1o1gYEapA+qTO236rJOpG+f2GKphvZPlAENMr9IufP6gIMGf/jNYtf+7PPsJBPsE/ll
 CrYw==
X-Gm-Message-State: AOJu0Ywd4leMAAvESJKjlbW6cNUWf/q0Rlsm7EAdM0LynfbfKXhaHYhQ
 XEPjjcIdgmzxuUGDfB6LURmSza2xn1vmG8CKjWfQaDkk7mCBeimsDTrzyZNwns0EnAW8MecvDtw
 CECZb4D7+kVqDnIq2ChXQy73RVvA1bJWBPw==
X-Gm-Gg: AR+sD11s4UsISfX397POO+Nc+AxLFgyI8T94xmejfYCXljI7L+Nbkr0kSSReJtd25/q
 68CpbVxVUvxrnj2JOTqO8iw4GzNTCzlZTOz1V56xJMU3OiCKB9oL/gok2YtVZ9009Gdi5vyMcld
 bh3gB2T691LwUdZ9lROB4HFniBH9lAuN4iOuY1XODSTj5uTUcearzWhJ8Eousno0Hf7hpdx8a16
 ouQo2+5wzHvJiZOdXYGu6ZxugblH7hY1uQ9aiWVgq+bBNSjkyjEm7tXkdFg6WIfdZ+ADhlWeyQw
 C94mHlgUQbtkpyYf6CY6n7J5xOY=
X-Received: by 2002:a05:620a:648a:b0:92f:279:594f with SMTP id
 af79cd13be357-932df6c4718mr695740185a.78.1785119297619; Sun, 26 Jul 2026
 19:28:17 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:28:17 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:27:47 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
Date: Sun, 26 Jul 2026 19:28:17 -0700
X-Gm-Features: AUfX_myFbpYdzQLim1HMI4xOqWEb5E_vqLXOVjh8mi4NPRMI71Fsg3R6A3lQCQw
Message-ID: <CANVUYGu7QKOa5t52yQnBc4U0zQxP2doTDR7BRGR65z+vJw7zRg@mail.gmail.com>
Subject: [PATCH v3 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From 84574de55c0f63f0963b3e5e0d477b18de91cf33 Mon Sep 17 00:00:00 2001
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Sun, 26 Jul 2026 17:51:16 +0800
Subject: [PATCH v3 1/3] hw/misc/iommu-testdev: support PCI MSI test writes

iommu-testdev writes ITD_DMA_WRITE_VAL with unspecified requester
attributes. RISC-V MSI remapping tests need to select an interrupt
identity in the payload. The MSI trap also identifies the device through
MemTxAttrs.requester_id.

Add a write-value register with the existing constant as its reset
default. Populate the requester ID from the PCI function. Existing
translation tests retain their payload while interrupt-remapping tests
can issue a valid MSI for the test device.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/misc/iommu-testdev.c         | 14 ++++++++++++--
 include/hw/misc/iommu-testdev.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
index 15eb6de..6428a57 100644
--- a/hw/misc/iommu-testdev.c
+++ b/hw/misc/iommu-testdev.c
@@ -28,6 +28,7 @@ struct IOMMUTestDevState {
     uint64_t dma_paddr;
     uint32_t dma_len;
     uint32_t dma_result;
+    uint32_t dma_write_val;
     bool dma_armed; /* armed until a trigger consumes the request */

     AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
@@ -80,6 +81,7 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)

     /* Initialize MemTxAttrs from generic register. */
     attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
+    attrs.requester_id = pci_requester_id(&s->parent_obj);

     space_valid = ITD_ATTRS_GET_SPACE_VALID(s->dma_attrs_cfg);
     if (space_valid) {
@@ -97,12 +99,12 @@ static void
iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)

     as = s->dma_as;

-    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
+    /* Step 1: Write the configured test value to DMA address */
     trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);

     for (int i = 0; i < s->dma_len; i++) {
         /* Data is written in little-endian order */
-        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
+        write_buf[i] = (s->dma_write_val >> ((i % 4) * 8)) & 0xff;
     }
     write_res = dma_memory_write(as, s->dma_vaddr, write_buf,
                                  s->dma_len, attrs);
@@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void
*opaque, hwaddr addr,
     case ITD_REG_DMA_ATTRS:
         value = s->dma_attrs_cfg;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        value = s->dma_write_val;
+        break;
     default:
         value = 0;
         break;
@@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void *opaque,
hwaddr addr, uint64_t val,
     case ITD_REG_DMA_ATTRS:
         s->dma_attrs_cfg = data;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        s->dma_write_val = data;
+        break;
     default:
         break;
     }
@@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice *pdev,
Error **errp)
     s->dma_paddr = 0;
     s->dma_len = 0;
     s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_write_val = ITD_DMA_WRITE_VAL;
     s->dma_armed = false;
     s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
     s->dma_as = pci_device_iommu_address_space(pdev);
@@ -280,6 +289,7 @@ static void iommu_testdev_reset(DeviceState *dev)
     s->dma_paddr = 0;
     s->dma_len = 0;
     s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_write_val = ITD_DMA_WRITE_VAL;
     s->dma_armed = false;
     s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
 }
diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
index 3383659..2f4e931 100644
--- a/include/hw/misc/iommu-testdev.h
+++ b/include/hw/misc/iommu-testdev.h
@@ -81,6 +81,7 @@ enum {
     ITD_REG_DMA_ATTRS       = 0x18,
     ITD_REG_DMA_GPA_LO      = 0x1c,
     ITD_REG_DMA_GPA_HI      = 0x20,
+    ITD_REG_DMA_WRITE_VAL   = 0x24,
     BAR0_SIZE               = 0x1000,
 };

-- 
2.54.0

