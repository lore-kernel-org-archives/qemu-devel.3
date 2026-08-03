Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0065C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0yB-00008H-WA; Mon, 03 Aug 2026 18:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqvwV-0001IJ-Hz
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 12:55:12 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqvwT-0001Ib-8z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 12:55:10 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so1643345a34.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785776108; x=1786380908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FDQYQuAOCiXKhm0JQeg1ZjVTKHWYWTzjTg1cjoh81jI=;
 b=m72y/0TZTJiYL0aSm68xeGEGRMmTWThXq/cBXNUxwKpSpHxHnwOPKzB/toUNc0JSAO
 XdWGIO3FyVxfStiJxVXDeB5stcJgoyIVvddDddr7gxJoEunJtPfaUvLAV28Wk4338ogO
 UzlvnwIU4FQVCWeICiu+JbRkq6cifUmtskhdvoaf5AgnUj92u/FJ8ZPPfRMkGVewPj+T
 8TcwoF1LyYNtUOy7uVE8NdaxlIJlsWq358VsWO0rLH9bR87URtbdddS0eKjtjpZK7uav
 JWj0nz1BP9zuCwjWDO1iJbqWbq7QTZGIygSKFUy/Z7w9rX3JX8ABVdf5cJMZ/in4h2W9
 T7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776108; x=1786380908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDQYQuAOCiXKhm0JQeg1ZjVTKHWYWTzjTg1cjoh81jI=;
 b=OwMZX1srKup++Bu0nS1m12o9UULTd3O9z0VAPuGO0BVexsPgDWdrkn0OaBERpHz+yc
 ra5O+UD9rbijk8RVMVAvLLvESQ9gCizpfPbFUiW3TAvubLVFse0HkQ8v6QI1YYhUZWaB
 aAO5fE7wToGBqyXwQ7wZA6QhiM6CkMg9w8YXgYDb2fQZntcAT/fLvxN0mPdETYry0x0C
 LDegjpNeMepjS6nYE8htSbSJ1Vko/2keAIGgQ6RwFo7pMwgR5YZmEqnKS7FTT2c/nvPQ
 wbjUeTNqWUfAIzdaZ+7FdR8F5CZ33Yc7iy15AC8MH2ZUKQiBQYn1P4cvtZId3u3XOgW0
 R17g==
X-Gm-Message-State: AOJu0YxwJo7emBTKZwQHJQJ2IK8vocDdhyndlPK9Z0MHPVvrlCAv28Ax
 h1NBPneXCZL01F63YEWF5F4b27P3NJee2q7ZR2XQM6ljX5BlTtrfreJc+AAU05p+DV6djw==
X-Gm-Gg: AR+sD13R9/y9B6z2fo/Gc8i60XrT78EtQNTTVpfv7+5WjD/jn5DsEQSuiTeP7XdPhpR
 +JnZNNDKONioU7VVWvI4aZRSskTS1r0fZXgg9XioxdtGlbt/6ZzjixpZfQz/XN0/XSau3Yg820i
 3yMzfr5+BcStlr8y37wj9KY9KVDUZZ1tJoGNCST/ZUgkAQSgoIE0Ze9ICvkJWz3DGy18OyipozH
 2zPN6B0OCvE16LzY/sRKfUHln42mai6KgCxmHjg4jmrJYYsb0AXMQvemuBuZZR9rPGtcJ7rk4Wt
 KVsER3MWGS08aPgEkSQ3FMr2h7aTtn2izmJJxpVjaj8afY0oyidArDlGTjggFbEqXV9RGLR0aZX
 awEckML38MIamzCk311TKIHaH3GRrrgNSXZ89BpjeJPbbJi0HyI6C83DIwehMyWrSfyRa89m39/
 azgFTLuoUxrPAtGP/ukDiQTPpoqmZZrKZuz8lvAtHJVudRB3c9Nvu2xWTEASqjfioEYOdHeM/z1
 lN1sA==
X-Received: by 2002:a05:6830:6018:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7f196bedf8cmr18091302a34.6.1785776108041; 
 Mon, 03 Aug 2026 09:55:08 -0700 (PDT)
Received: from devvm55912.cln0.facebook.com ([2a03:2880:31ff:59::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed970adsm8080490a34.8.2026.08.03.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:55:07 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, bmeng.cn@gmail.com, qemu-block@nongnu.org,
 Pablo Mazzini <pmazzini@gmail.com>
Subject: [PATCH] hw/sd/sdhci: model the i.MX uSDHC clock,
 reset values and DMA boundary
Date: Mon,  3 Aug 2026 09:53:56 -0700
Message-ID: <20260803165419.2349160-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=pmazzini@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Aug 2026 18:17:03 -0400
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

The i.MX uSDHC differs from the Freescale eSDHC that this file already
models in three ways that a vendor U-Boot depends on.

Clock enables.  The classic eSDHC keeps them in SYSCTL.  The uSDHC moved
them to VENDOR_SPEC bits 11-14.  Teach SDHC_CLOCK_IS_ON() about the
VENDOR_SPEC enable.

Interrupt status enables.  Unlike the SD Host Controller standard, the
eSDHC does not reset these to zero, which commit d060b2789f7 already
models for fsl-esdhc-be/le.  The uSDHC behaves the same way.

SDMA buffer boundary.  The uSDHC's internal DMA has none; it transfers
the whole programmed block count and reports only Transfer Complete.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 hw/sd/sdhci-internal.h |  7 +++++--
 hw/sd/sdhci.c          | 12 ++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4aeed120bf..60bed5af30 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -124,8 +124,11 @@ FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
 #define SDHC_CLOCK_INT_EN              0x0001
 #define SDHC_CLOCK_SDCLK_EN            (1 << 2)
 #define SDHC_CLOCK_CHK_MASK            0x0007
-#define SDHC_CLOCK_IS_ON(x)            \
-    (((x) & SDHC_CLOCK_CHK_MASK) == SDHC_CLOCK_CHK_MASK)
+/* The i.MX uSDHC keeps its clock enables in VENDOR_SPEC instead */
+#define ESDHC_CKEN                     (1 << 14)
+#define SDHC_CLOCK_IS_ON(clkcon, vendor_spec)                  \
+    ((((clkcon) & SDHC_CLOCK_CHK_MASK) == SDHC_CLOCK_CHK_MASK) \
+     || ((vendor_spec) & ESDHC_CKEN))
 
 /* R/W Timeout Control Register 0x0 */
 #define SDHC_TIMEOUTCON                0x2E
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e58a610397..b354c0f31f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -308,7 +308,8 @@ static void sdhci_reset(SDHCIState *s)
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
     if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
-            object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
+            object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE) ||
+            object_dynamic_cast(OBJECT(s), TYPE_IMX_USDHC)) {
         s->norintstsen = 0x013f;
         s->errintstsen = 0x117f;
     }
@@ -613,9 +614,12 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     /*
      * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
      * possible stop at page boundary if initial address is not page aligned,
-     * allow them to work properly
+     * allow them to work properly.  The i.MX uSDHC has no "Host SDMA Buffer
+     * Boundary" at all: its internal DMA transfers the whole programmed
+     * block count and reports only Transfer Complete.
      */
-    if ((s->sdmasysad % boundary_chk) == 0) {
+    if ((s->sdmasysad % boundary_chk) == 0 &&
+        !object_dynamic_cast(OBJECT(s), TYPE_IMX_USDHC)) {
         page_aligned = true;
     }
 
@@ -994,7 +998,7 @@ static void sdhci_data_transfer(void *opaque)
 
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!SDHC_CLOCK_IS_ON(s->clkcon, s->vendor_spec) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
-- 
2.53.0


