Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BFBE6C60B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIM4L-0005T7-Gx; Tue, 03 Dec 2024 01:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tIM4G-0005SX-8L; Tue, 03 Dec 2024 01:07:28 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tIM4E-0004yi-Oa; Tue, 03 Dec 2024 01:07:28 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724e1b08fc7so4516548b3a.0; 
 Mon, 02 Dec 2024 22:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733206043; x=1733810843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=njl64GlmxR1Yi1La0DjJl6kmD+HNmU+XtFJgaFoqXe0=;
 b=mHyj4dNmSEecQmw9gM2Z2kbtbe50XEGWoXt4dz8dLL9Wck08g8OPSh7/FWJ2C/G6ca
 ToOPVg5MOl/su9hZHPDesA1oqWYrAdk8Sm0Qy8cCXRAGjLQC9eaVAdG/0Sd1PhMSvl50
 EdSLGCfC3Je/q0bk/HlVIWtVu6DQMvGBYnwYFrZYm6FctDeM6RNTPNP8wcKWActuQ1oo
 kQr1zcfzCr3CU276YWhjSurMA8lve1JBejO7D23+2BqeRAqP5R7U5AFB+vKU7dekKD8f
 PffpibgcKp8SDAKg0myq6oouAngS9q6LNo8TbS9+dALyGUm2P5Fw27sWdmHJDqsktp+W
 7B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733206043; x=1733810843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njl64GlmxR1Yi1La0DjJl6kmD+HNmU+XtFJgaFoqXe0=;
 b=LtlfLNtGQ3jZnX88GBrRL74kLq8dYDY7xbQdwnaikCc7EwoD9m4bMzZM03cqkLDptW
 yZ+etTDIX61grZxJ7IuK0PmgJdqKXDsYxnGC+aIbmzU/r8cQ5iN5jepcDUtw/UsdpzBF
 4q+zSG5fbDTK7IJLqbfZQ/SLeyqaC5aJt97HN3/qHcreDqz8iVO8o8I8izTM+UG9LA4P
 J8zQbO/5r4caUmQXz1taGqT3s1jyYI8b2Hy6J+XBCBJ+4miKIqUJHpEyaNVHA+LANkXW
 a0yPhs9npK247caGphSfOmED6JCO8VoYdSJXvd7+rsSAqeY/x89hCFQHKI8mbtIUlX5N
 Zjrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4rGnLwqqvxVNvsZdxOzQVlkZ8LkZSDrW0BJ4znAUXGj1LYbcHr4dD6oObzeXWt2jgSLWul1pVvqFc@nongnu.org
X-Gm-Message-State: AOJu0Yw5RdK93Hh47FgHzVoJkvChirQx99/K5osBCTeeBrwGYBFIMyVF
 kb+0iKAiX/QVSm+LJU2ncSU6ETZ3Q3FTmYNay2eTYiHrEMFVB2d7Grh9tg==
X-Gm-Gg: ASbGncsbEOet4q+lmsyFCp89Uo0bdqwPgnLlZwpi3L4Qd5ary0q5Ivm283rCgcY8Fl4
 Xmre0G2xyn1C5V2RtEIjhCQ4GB4PR9edvu+c+XD/2Yb5fuIfFITT3DhPYBSf3WGsaR526wLAoSd
 ecRBn8XVIvTjBy3RcF0Hd8Asq2zZ6mR33OqKNGfXNm5lH58l+18NYgJyy6TWjFaYrthhRs8W4nP
 p6Nb0aN0sI9cyjIA9uZ1jguOqvlmmegWLoM6vtcecGA4tWnkyyOTYCdc0OXpV6X7X1e8shVyQdG
 fld3Sw==
X-Google-Smtp-Source: AGHT+IEjzO5OpWGvimE/X+2/cre/QIHejaaJnjc3EFdVFjaCu6GuiMrHLFN7m+SD2zJH8mhF9Aeh3g==
X-Received: by 2002:a05:6a00:2e25:b0:71e:4196:ddb2 with SMTP id
 d2e1a72fcca58-7257fa63975mr1483767b3a.9.1733206043499; 
 Mon, 02 Dec 2024 22:07:23 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254177d0b4sm9583601b3a.83.2024.12.02.22.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 22:07:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Subject: [PATCH] hw/pci-host/pnv_phb4: Fix LSI irq source calculation overrun
Date: Tue,  3 Dec 2024 16:07:14 +1000
Message-ID: <20241203060715.1149886-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

PHB5 has big and small PHBs, that have 4k and 2k interrupt sources
respective. The LSI interrupt sources are set with a 9-bit register
field, that selects the aligned block of 8 irqs, giving a 4k range.
This is initialized by hardware to 0x1ff in order to select the
last 8 irq sources.

The small PHB is meant to ignore the MSB of the source ID, so the
LSI default would select the last 8 of 2k irqs. The PHB model does
not mask this bit consistently, which can cause the irq to be
miscalculated and the source irq array to be overrun.

Move the lsi_base calculation into a helper function that does the
masking and some extra checking.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/pci-host/pnv_phb4.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index fb129f3266..5486ef44ea 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -458,6 +458,27 @@ static void pnv_phb4_update_all_msi_regions(PnvPHB4 *phb)
     }
 }
 
+static int pnv_phb4_get_lsi_base(PnvPHB4 *phb)
+{
+    int lsi_base, nr_irqs;
+
+    lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
+    if (!phb->big_phb) {
+        /* Small PHBs ignore the top bit of the source ID */
+        lsi_base &= ~0x100;
+    }
+    lsi_base <<= 3;
+
+    if (phb->big_phb) {
+        nr_irqs = PNV_PHB4_MAX_INTs;
+    } else {
+        nr_irqs = PNV_PHB4_MAX_INTs >> 1;
+    }
+    g_assert(lsi_base + 8 <= nr_irqs);
+
+    return lsi_base;
+}
+
 static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 {
     int shift, flags, i, lsi_base;
@@ -487,9 +508,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
     phb->xsrc.esb_shift = shift;
     phb->xsrc.esb_flags = flags;
 
-    lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
-    lsi_base <<= 3;
-    lsi_base &= (xsrc->nr_irqs - 1);
+    lsi_base = pnv_phb4_get_lsi_base(phb);
 
     /* TODO: need a xive_source_irq_reset_lsi() */
     bitmap_zero(xsrc->lsi_map, xsrc->nr_irqs);
@@ -1597,8 +1616,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
     if (irq_num > 3) {
         phb_error(phb, "IRQ %x is not an LSI", irq_num);
     }
-    lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
-    lsi_base <<= 3;
+    lsi_base = pnv_phb4_get_lsi_base(phb);
     qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
 }
 
-- 
2.45.2


