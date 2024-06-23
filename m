Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE580C2BD09
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 02:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLDFJ-00083E-SC; Sat, 22 Jun 2024 22:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1sLDFI-00082u-8V
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:46:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1sLDFG-0000Is-Ie
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 22:46:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so21662265ad.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719110780; x=1719715580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZP/WdcdmHmYxpaWrBiM0FoLrhAiPW6xvRvl4Nh7Rf4=;
 b=LvI/2ZtdnxXDBWABJPIdfUGJgZYa+W3dcJdt2loO3XzZ53IFSXkKHaKW+2mOPWVNql
 vk4EQnnWhk5VSDMZ09/cRWkiEeUAmmpbMpleSmMwIC8MuNkjsN1kHy2ZDiILd3w2Ma0P
 OR9IT+/iw4Wj4DDm9N8vWYL2pl0cCFtkK0QmKnGzllW1lXTk3LhlPJi+0vXYzAVliSuK
 IwhCPGppR3Z5EuxNgUHioPMElXWD4F+Kz/ESsOUvnpVa6vFcPDnmgb0gw6SbvC4KZz7t
 AJibiGkPREjVxc+PbXgdGAY/JWSyCiAza0vb1UKe14MVCpl2CjTTLmigkAgL2pm3bdWS
 vOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719110780; x=1719715580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZP/WdcdmHmYxpaWrBiM0FoLrhAiPW6xvRvl4Nh7Rf4=;
 b=XfZh+6u0XEyCbxC/u50KHSlxK+WpS3GSq0NOuKKeX5YfMi31DK9xV4wW2PJ8/2YOSz
 be+fEpLL3LY5bbcTDoGgbsF+wSbFnN7CQcY7Wdd9ey/PaRZKT/EVUVZBwB1avIzFIYFN
 TJ/HWB8FzYAdwsmEZSdt9ZFnPG/FvoYsMiBEDc7CHeCp8/+T9Io9ul6fJixBHYN9wyKl
 q3MbdwnAicg8e5X8CNvldE59J7IAezgxn9MGNTWKJy1B0TEmMe+mYemSY7Mzv41mcjMP
 xaLdNfexTz2Q+LdMqkJBA5MqyT/gzJEqNY+M4/Cr0RsBtrWxsY9Td0Je4iDt4GUWD0FR
 vgeg==
X-Gm-Message-State: AOJu0YxMkjXGtqRO7MlKl1GwgkRG7/9yI0iJ/PoopWXpNnkYdaQctqtu
 rtFOG2sXoCnFcCS+8XcnYgg0gSoT38FTc6zCUvZLM04RvyK2EdJO
X-Google-Smtp-Source: AGHT+IEnb6drM7t/fSd9xsk1lX///NZUDSNw1TNNSFM9dfgKK7tzvXj1BUxs1Nkfi2ISQpVIkkupFQ==
X-Received: by 2002:a17:902:e850:b0:1fa:2c79:7504 with SMTP id
 d9443c01a7336-1fa2c797598mr6322955ad.48.1719110780417; 
 Sat, 22 Jun 2024 19:46:20 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c8b5dsm37627625ad.181.2024.06.22.19.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 19:46:19 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Jeuk Kim <jeuk20.kim@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/ufs: Fix potential bugs in MMIO read|write
Date: Sun, 23 Jun 2024 11:45:55 +0900
Message-Id: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x630.google.com
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

This patch fixes two points reported in coverity scan report [1].  Check
the MMIO access address with (addr + size), not just with the start offset
addr to make sure that the requested memory access not to exceed the
actual register region.  We also updated (uint8_t *) to (uint32_t *) to
represent we are accessing the MMIO registers by dword-sized only.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com/

Cc: Jeuk Kim <jeuk20.kim@gmail.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 hw/ufs/ufs.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 71a88d221ced..bf2ff02ac6e5 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -55,17 +55,18 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
     return ufs_mcq_op_reg_addr(u, 0) + sizeof(u->mcq_op_reg);
 }
 
-static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr)
+static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
     uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
-    return addr >= mcq_reg_addr && addr < mcq_reg_addr + sizeof(u->mcq_reg);
+    return (addr >= mcq_reg_addr &&
+            addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
 
-static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr)
+static inline bool ufs_is_mcq_op_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
     uint64_t mcq_op_reg_addr = ufs_mcq_op_reg_addr(u, 0);
     return (addr >= mcq_op_reg_addr &&
-            addr < mcq_op_reg_addr + sizeof(u->mcq_op_reg));
+            addr  + size <= mcq_op_reg_addr + sizeof(u->mcq_op_reg));
 }
 
 static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
@@ -774,25 +775,25 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
 static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     UfsHc *u = (UfsHc *)opaque;
-    uint8_t *ptr;
+    uint32_t *ptr;
     uint64_t value;
     uint64_t offset;
 
-    if (addr < sizeof(u->reg)) {
+    if (addr + size <= sizeof(u->reg)) {
         offset = addr;
-        ptr = (uint8_t *)&u->reg;
-    } else if (ufs_is_mcq_reg(u, addr)) {
+        ptr = (uint32_t *)&u->reg;
+    } else if (ufs_is_mcq_reg(u, addr, size)) {
         offset = addr - ufs_mcq_reg_addr(u, 0);
-        ptr = (uint8_t *)&u->mcq_reg;
-    } else if (ufs_is_mcq_op_reg(u, addr)) {
+        ptr = (uint32_t *)&u->mcq_reg;
+    } else if (ufs_is_mcq_op_reg(u, addr, size)) {
         offset = addr - ufs_mcq_op_reg_addr(u, 0);
-        ptr = (uint8_t *)&u->mcq_op_reg;
+        ptr = (uint32_t *)&u->mcq_op_reg;
     } else {
         trace_ufs_err_invalid_register_offset(addr);
         return 0;
     }
 
-    value = *(uint32_t *)(ptr + offset);
+    value = ptr[offset >> 2];
     trace_ufs_mmio_read(addr, value, size);
     return value;
 }
@@ -804,11 +805,11 @@ static void ufs_mmio_write(void *opaque, hwaddr addr, uint64_t data,
 
     trace_ufs_mmio_write(addr, data, size);
 
-    if (addr < sizeof(u->reg)) {
+    if (addr + size <= sizeof(u->reg)) {
         ufs_write_reg(u, addr, data, size);
-    } else if (ufs_is_mcq_reg(u, addr)) {
+    } else if (ufs_is_mcq_reg(u, addr, size)) {
         ufs_write_mcq_reg(u, addr - ufs_mcq_reg_addr(u, 0), data, size);
-    } else if (ufs_is_mcq_op_reg(u, addr)) {
+    } else if (ufs_is_mcq_op_reg(u, addr, size)) {
         ufs_write_mcq_op_reg(u, addr - ufs_mcq_op_reg_addr(u, 0), data, size);
     } else {
         trace_ufs_err_invalid_register_offset(addr);
-- 
2.34.1


