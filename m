Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA2CCCFA00
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 23:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFhLz-00020I-H1; Sun, 02 Nov 2025 18:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vFhLv-0001zb-1I
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:19:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vFhLs-0006KV-Ug
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 18:19:14 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so31173085e9.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 15:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762125550; x=1762730350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zP++Ansb9I8fwj7wo+F1/RmZsu5pPQloTJcaKpaIT3Q=;
 b=KLnBK1xpq+7gNV/3WHi5SK0keqatLqaarM3mvQDfBCXUdqXk5fHmRAoH0IPrqrkfRi
 1QkFr+JJiJmhMOgvvzoFlZOEcGbap9z7x73EFRoAW+T40ERzdGIC8GETTDHJImugQiJl
 Zd/erQYD6UAV4Fp4WGzvNuEBma8RPc/l/RoCGkgYBpa6MCaioLBOOIYJZqQ1fwJApb/r
 a4O41HCz4XLG/Za2+0B1XtrH73S++4ohzOwY3AbxCCRdOcEC7GeNiETjzJXLae1zlvbN
 izIGJTh5S6MYFLvKH0BDVOyX3vOq2flhtfvrvC8idh98+hzqksp7DeYEzEehdC70TsUf
 htsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762125550; x=1762730350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zP++Ansb9I8fwj7wo+F1/RmZsu5pPQloTJcaKpaIT3Q=;
 b=PlO/w0rttCWhxJoww3dwNPX3anNd87Hs2a3fgH20dOQEM0LjLD8uMu+bP9IrpFgXD5
 3gLwXfYvxh8G8rGYV86V1AqH46q05Vz3We4FACIL72ZTa1loMV6kupjcarLIiHk90lAU
 ufFpcq2PktU6zfvjR1ccAzozCpu8TeJGsE14lqpyop77z3jKg0bBHIv7FYA0D4oDOVXw
 kxNuVCFdAXLO674HLantRZWsPLRe5A5Gaf5Lxzb0QUgRBQDjRIvmbHCLCbKpfFAmjCZE
 RPbUmUIUWhwygJKbHPUK931Xo/Pp5qgmafqxOlgF9bWiKSHaneJZvqjAFERmHs7zs8Qu
 s2/Q==
X-Gm-Message-State: AOJu0YxAMEayJ9MAq3lU0K65rcHFCJ82P/R768HBJdcMJpKWVvcTa6Rq
 PsrpTU6YFA5vw9yXo7Ok5R2VMdq+UmT0uZiUfrqHvDMDTl+5LjU18kZyD0MsCw==
X-Gm-Gg: ASbGnct+t/ttBiCspXujm3IBISQqbhyfe2m40r7yJl1PU7tcNc4pAz/CFOMyD4XD31P
 sextnTFmt+LyDr953IYnDpxNUgtRTY9VXoJMnlJ3IqH1MKUHwv6vAn1M9NcohtJXMhdcTEJgj3V
 Lap1t0jCkt3guhsNN8sdA/AoS0HELLrCAFj6yBux6VBEz59RbyWkXp4bPt9Dw9rXD2Tfq/d/HVT
 5AOfaPoRKbx5abcmdyHg/SYW1GrDSU3a2XmJygQ5f1YFmG1/FbefqGQFa6BLkZ9e+Tu4jKVG7Br
 ZLli8fIR1K7sHAwGSTylzI6cM3HuBuabWmrBio4Vg+SyRCGz863cxX1NjzOV4f8mu/CBty1A0LK
 XDn6Z30n08bAyiIHwW0TkhLYCi4UMhubuKOv02Nm2XA8uwhrTB26Hqf2PfPB5UY++CX4qu+Dqxh
 khmSn2RTc28CuFcA==
X-Google-Smtp-Source: AGHT+IEAnBaiFiebdLr4mtDT7h25ZIRGM56+ebO1M9DaLq/AJfJre5FsPMzn+95RdocXDgN0UnRJXw==
X-Received: by 2002:a05:600c:3b26:b0:477:19b7:d3c0 with SMTP id
 5b1f17b1804b1-477307dbbdemr102559355e9.2.1762125549415; 
 Sun, 02 Nov 2025 15:19:09 -0800 (PST)
Received: from osama.. ([197.46.228.139]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fc068a8sm72394095e9.4.2025.11.02.15.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 15:19:07 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/audio: Remove dead code from ac97_realize
Date: Mon,  3 Nov 2025 01:19:03 +0200
Message-ID: <20251102231903.65409-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x32c.google.com
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

Remove unnecessary PCI configuration register initialization that was
marked with TODO comments indicating it's redundant:
- PCI_COMMAND register is already 0x00 by default, no need to override
- PCI_BASE_ADDRESS_0 registers are automatically set by pci_register_bar()

This aligns the code with the pattern used by other PCI audio devices
in QEMU (via-ac97, intel-hda, es1370) and removes 15 lines of dead code.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/audio/ac97.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index be7a39377f..60daa62ea3 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1279,30 +1279,11 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    /* TODO: no need to override */
-    c[PCI_COMMAND] = 0x00;      /* pcicmd pci command rw, ro */
-    c[PCI_COMMAND + 1] = 0x00;
-
-    /* TODO: */
     c[PCI_STATUS] = PCI_STATUS_FAST_BACK;      /* pcists pci status rwc, ro */
     c[PCI_STATUS + 1] = PCI_STATUS_DEVSEL_MEDIUM >> 8;
 
     c[PCI_CLASS_PROG] = 0x00;      /* pi programming interface ro */
 
-    /* TODO set when bar is registered. no need to override. */
-    /* nabmar native audio mixer base address rw */
-    c[PCI_BASE_ADDRESS_0] = PCI_BASE_ADDRESS_SPACE_IO;
-    c[PCI_BASE_ADDRESS_0 + 1] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 2] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 3] = 0x00;
-
-    /* TODO set when bar is registered. no need to override. */
-      /* nabmbar native audio bus mastering base address rw */
-    c[PCI_BASE_ADDRESS_0 + 4] = PCI_BASE_ADDRESS_SPACE_IO;
-    c[PCI_BASE_ADDRESS_0 + 5] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 6] = 0x00;
-    c[PCI_BASE_ADDRESS_0 + 7] = 0x00;
-
     c[PCI_INTERRUPT_LINE] = 0x00;      /* intr_ln interrupt line rw */
     c[PCI_INTERRUPT_PIN] = 0x01;      /* intr_pn interrupt pin ro */
 
-- 
2.43.0


