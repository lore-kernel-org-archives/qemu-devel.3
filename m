Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EEC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFgm-0008W5-7c; Mon, 27 Jul 2026 03:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgI-0008QK-AB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woFgG-0005q3-Le
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:23:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cab973140bso31498355ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785136999; x=1785741799; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=flKuMLmYn1iE4Z5uvavFCm13BX48Q/2tMyNn1rgehsQ=;
 b=YY33OHEUmH2mmKU4X/AgX00hEF427Om9/KZNjD5G7BkaNvhqHZZ/H6StrUUts6n3ol
 B2HurZvCdEeQL6AfDrn6PNjGLr2b22Rmpj8TbuEs/f28wqBALC8FTneaJXmWzdPsLhQF
 P4/1PhutqlVbV2joSK2ioFKVNdC97wyvAs2H3tRaU7ibRRnoEtBnjcSzjxm8fQIePVGm
 1ltQbEQ5BrwBQAue8PaZKWalwhvpA3qfMv2V4AVf1m0kJCHJfXl6aDg983Dc79WG8nFI
 Dwn4YmHl+yqY5K21WvKVmYErFfYmPCabgYlzAWRdbg5lDuZ/Gq2+lWtUFNlzvn2m+/Pa
 3FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136999; x=1785741799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=flKuMLmYn1iE4Z5uvavFCm13BX48Q/2tMyNn1rgehsQ=;
 b=OfL0ZHV+l0Hw8rgN39oiPJKkV4zOmDtkSdbvEbyPAnbZ89TVNc7qJmz/c5XPiBUfiV
 xbSwARbtrqk4e+v+c5x74b4J1Lyio+1WJCnASbhXoZLJYNDv5wXAsrNFsXqujlrSFgux
 HQy3QFi0NLQ1w2eArYahiS2aj70f0oBj2APelqHyZkNNUNyea7QHwr/kL70Ho68XLZ+4
 72aOaw86Ka8n13wEcI4YPoc2s9gMo0wM8vHKFecy27gYVnRarIEcfCkVAT3Uyw7SgNQF
 lQbwTq3v/dNesmz7J5Tk9ttTuNYnUR94fZuCHL2Sc/tab+rC+PIGs4PxhakDz6SedDQN
 xMdA==
X-Gm-Message-State: AOJu0Ywhl2Gfu3NVl+8Os5My5Y9IKBPxml40QOmASxCpTCXpJlC6Rgxp
 jF5kT/HMt5s5uPwZrIEUqCStOe03x9ZUE5VPBrP3nHA6mc2g9lHoLh0b
X-Gm-Gg: AR+sD13eUreuzeUttEnhvRZpgqA+84jnk4BVtRQSTGbsEQ8QtsibIi6cyYuyslw5vZi
 FIiAJ3wp6EgKNr8gJCRZcQ0PRGMVikGSmcZFppYKyhZGl+FD8wFC2pffyhsfHX36DVfBEzxR3ze
 nE2U6YnfAX55LjBOdcbfrIbNu5ue8RHZhqSPhGnimRqnRJRKzFZ5R0jy3Lfhwrh0ioZukH/vgW8
 ZVywuIMRcpKcoCnfo9zdC0jX80K6bhBohTUtVyBXGUxzhqYKNhO45oWjRGfM+pXROHadHOQ9pnE
 MNYQNjtp31O0nND2X8tCW4132+JAwJMda882Ov1TFNXAtOwjMtyYEO9s7v5R8Yy78SWveqjwC/m
 cPZJOwYcPdsxt36asou0Auk0uwH2X+d7xpFR/04dAhCD8Ghg87NtURE4ih9+rIVOy+ABNcOOT8a
 SfKLT0M1OvGmBp+bQzhN09BVq99gNcDpWmubp6TRfwa232vGKcsqxpVZKxM2ih4hW4M/yReM+S6
 ve7xMOW5lkdLOM=
X-Received: by 2002:a17:902:f647:b0:2cc:6817:d9bc with SMTP id
 d9443c01a7336-2cfde8952d1mr72093365ad.38.1785136999254; 
 Mon, 27 Jul 2026 00:23:19 -0700 (PDT)
Received: from flavien-macm3.ddns.comp.nus.edu.sg ([137.132.220.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419c52sm28481032eec.10.2026.07.27.00.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:23:18 -0700 (PDT)
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Mon, 27 Jul 2026 15:22:57 +0800
Subject: [PATCH v4 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-qemu-mrif-v4-v4-1-73e0890ad395@gmail.com>
References: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
In-Reply-To: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Flavien Solt <flavien.solt97@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785136991; l=4023;
 i=flavien.solt97@gmail.com; s=qemu-mrif-v4-gmail; h=from:subject:message-id;
 bh=yIX+yizbuFr6xs+s2GSP1Z8I3zE1QKm9lbVXzs9EUOM=;
 b=qTtW8ZHvdx4oCwNTcaIg8WOdf+aUjrep/4ZeMYDANYsNFc3Qc5aJFh+ss8fDrDBQKOwckE/3x
 R/GXZoxUuTuChgnW52ut/S2caOsECkU3m+odM3cQUp/e103JA6UgozX
X-Developer-Key: i=flavien.solt97@gmail.com; a=ed25519;
 pk=wEVvqF5SMWVnTyKNb8WAo78S30Q6giJmU/VisghJRtI=
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=flavien.solt97@gmail.com; helo=mail-pl1-x634.google.com
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
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
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
@@ -97,12 +99,12 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
 
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
@@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void *opaque, hwaddr addr,
     case ITD_REG_DMA_ATTRS:
         value = s->dma_attrs_cfg;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        value = s->dma_write_val;
+        break;
     default:
         value = 0;
         break;
@@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case ITD_REG_DMA_ATTRS:
         s->dma_attrs_cfg = data;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        s->dma_write_val = data;
+        break;
     default:
         break;
     }
@@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice *pdev, Error **errp)
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


