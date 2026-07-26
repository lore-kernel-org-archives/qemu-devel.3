Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0537BC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyRh-0001BM-C0; Sun, 26 Jul 2026 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxrc-0001Xs-UM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:21:56 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxrb-0001eh-A1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:21:52 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-92e5c92c389so116451885a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785068509; cv=none;
 d=google.com; s=arc-20260327;
 b=UczclSNt1YkNP+Qgg+U/mDOpUWtGOOqQcnqwCJ0+XCo+FnNmT30eXyPG5m2ZpNLAmv
 4Uuem9x0ZD9W+BUX9LyxVG1Ph3nT5Hwz5CSSqozoUOsKB+hFSD2nZnQmPd4IedvkFnG6
 JVEQ353z28CFZy60SEjJHcZhJ8q5RqPRUwjLgADK1Xz3bBkAe2Zl54TEWkV3GZMrKCFF
 jFtWsztWqknnzvJdx6zsRgexm8fBSo3grrqrnDue0J4uLlSDJU/O2/mBth6XpmoClpbL
 rGyl/tySOmq9VuiWCRJH3eTiUh2xV/pwdzzgF6ceU7ZwF65wikHCPkpxV++pAjktz14X
 e2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=vpo6KPNjof4an8TwqmFldBdHBYJb8OLzCtdlBm/dH9Q=;
 fh=tM9uqhnisH6PlMOYdsdDavWujv1Qk2/fU/qZi5QboKo=;
 b=eNh8smZ2RRox4Y4UasF1Hi06X34u6VJhS9T8M3L5/L1qrNvu0MId5x5Tf063J8M3ny
 9jdDWTin2pT59KziZhpvsCBWrjCmCrVULHa1TRmAzzbUa7H4O/6rvvv3i07oNgEQ7aBT
 dZAyqbcdVvwaGZR6RnKC5ZGnyuDBaXrncd0gY8S5qMEFUGpaxW0uNmWhILPf0cr6+Blx
 7Evg3W0weiHsQCs4L776gUQSGkrOovg1JRDMAJahV2j1KjABpKYYzeO/bpU4z5TnlL0M
 hzHT0F+G2v0G9VLPsuiPOQMCJ480xNKMDpnwnllJRsQmMEvsx5YONcnhmare6r6eUihj
 3vsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068509; x=1785673309; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vpo6KPNjof4an8TwqmFldBdHBYJb8OLzCtdlBm/dH9Q=;
 b=EaJRAyANV0YwxnpEV1wvxAvqpMuTZOmQBSIHV6/9x/Ys7mHbGDXnmL889fdZpeaEoX
 TAkDqjhw2YlifSrSfbkpTmRI2dMhMqzDhI6T31tUl2sUiFpgv968Z6GJ/SMYNSBPqG14
 cH6qhCe/jLtDIgEe+M14M0U55BZfEPHj/WeymaMvSb3lgdYaGwDXWwHy/Hpk4LPJqEzb
 lM7253beYpbe/897Mcva4V6I6O9WNiawdr3OZa7AfgXC2scaDEUwX3pgWVFQ2pbMBCMr
 aMEwCeE4zdk4GysIF4apx4vGUhd8oU4Aly6chh2O7RsslnYPbLdmJu51tRJvjH5M8fUO
 2K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068509; x=1785673309;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vpo6KPNjof4an8TwqmFldBdHBYJb8OLzCtdlBm/dH9Q=;
 b=o3W5+x/aDibIX7wtgZe5Z1rVKXEdGMv24jQxxmeWU4itWCqEozSujJCikT1o+/0/iF
 2Ra/DCiwtsijvDMCNZAV+/is2h5BFplgjHMx7x3c7ywoQgqSeKFvR/UnJGXUgYQMyxHo
 XKXVNFxg2cqQfuaqaCF/Lq9EoOKBFi4hI/3hsqkMK7bC3/dGUkGLvvRJH9BEG8BYShLw
 TY31o7HDw+WMJuw7dYui7TYzNPXZgGcdHDhAljpIG4DsyK0etokCSjPCxDd2NyOIMwnE
 IIDh4tDTi/sFegDghdyeAadztdNACPTt+fX0fsq3cbAx68tmQDBEeeNRkViscrPHGNfl
 Np3w==
X-Gm-Message-State: AOJu0YyUb20TDQqsA0wRt6aCebcGv/gfrhvbHn4lLZi91tNVa5mynU7B
 rjMcBnmxU67bkwAgjeGEYRYPCdeh0Nj256bW4U4qPN5MzE/u8IWKzelAnH7PQPEZDlo2tyA9t97
 Eahrs8po6ZI27UK6Y3InpH42whCvnZO69ig==
X-Gm-Gg: AR+sD10j0mqg189KMbDQfdjuAc9syAC8/MCw4UKCVikrlqryf1trQrEMLpGM6USUN9x
 urOrteg3lYRW5zTe87QPru5nRacCqLe9DQXxY2YSTnO3r/VMcDy7P3yJbxrbVKrW+mYmvPkRP/C
 c+a53PPpeZXhey5fwha2G5gCZynKCYT1bxKbBgFW0WJRafoo2Moot8bUE9UY8bwOSL2mDreOBIV
 btdT9tAKV0E/yN8yaW9IBgtY4uypOZxb6AXr2hnJqf/f5l6uJLU2EkRObl9bAB1twmCR8FFtLeR
 XziAxRe/kGgpA/TWaA==
X-Received: by 2002:a05:620a:4006:b0:92e:c117:5edd with SMTP id
 af79cd13be357-932df6d83f5mr457785285a.93.1785068509068; Sun, 26 Jul 2026
 05:21:49 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:21:48 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:21:10 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:20:07 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
References: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
Date: Sun, 26 Jul 2026 05:21:48 -0700
X-Gm-Features: AUfX_mwaeP9LLF8H66IKHUMreTil2bgamt_bkXePA784YFmljhVQxposQz4AXhI
Message-ID: <CANVUYGtm19xCpqACSv2FYb7=BP05Av9oOxU5q-WiP4D-T6fA0w@mail.gmail.com>
Subject: [PATCH v2 1/3] hw/misc/iommu-testdev: support PCI MSI test writes
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Jul 2026 08:59:02 -0400
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

