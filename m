Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EC7C55843
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0yF-0000JL-BC; Mon, 03 Aug 2026 18:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqvYL-00078p-V9
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 12:30:13 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmazzini@gmail.com>)
 id 1wqvYK-00064N-DM
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 12:30:13 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so2531211a34.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785774610; x=1786379410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8RMFC6aqbbzeSqbGSDyaT9T2DRTJ5mAddBIlWTg4KFQ=;
 b=Sx+vkcaKxdf7VpiavL+pSk6yXccA/2FgW2hNWMfY7gsynNzHslamYYkHfj7q6Xk88F
 GpMB1ien5W+V7WmBlLRAd9ws9gaWy4ZRTqZzLsugJFND3GiJghfXJ7q8kknYk0ybQPU8
 ZkAWbOi0jeQaHGBZHLMEr8mEFfa6asMYSdUnXvKLotY4I8ytNlPRj6f1kCXLl4l7+5Vg
 3toWITvQ6U5IuW+eOB82idX/X57Oy9Kl7hcGtEJYq7xwGXsLrbpQM1gZaB/uWzF1RdHc
 oNDq7uJbwb8UII4DvC54H30o+/+Bpa6zY3plkXZybW0bMJRrgWGmEhopAUMsBavfIwDH
 qB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785774610; x=1786379410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8RMFC6aqbbzeSqbGSDyaT9T2DRTJ5mAddBIlWTg4KFQ=;
 b=HYPXLqPmDfXvvw9gyZozwgswwH6rKytStf1vXSFAA5vLN00wIYDbpyfewN1bLmXSm7
 GLpWKsYGMGvPKmJ31NWen3IRe4253Tg3YV8aLDooyb6gtNUIbZTeMVNLeef2+tb9oZR5
 g3nOecDBvZamU6NkOHBHOeeCu7m9yysTMMKhLCgt82VHopk+K6+Z2dF2FIHTgV0j4RvK
 XEJYRNZQ5KVYUaTDP+CG79ZAxqc/Mwl6jx8EZP+QN+g7VK7EXLaWvZzePjwaNb08WHJu
 /qnWGJSApb0z5lvKDcmLBf8V/y5rg51HD8D8HjimjrQ4236RNr3hjjH1Vp+0GtBTOINu
 fYbw==
X-Gm-Message-State: AOJu0YxRVgnamCyi+2VyK0Oxqo/uh8yW+API2Z3EzmI7WdaoXDZvX2QV
 DuKK0qrW6bkfAHxtoOMZEXH3i29nKC3R4wGvVTs7SOQnsL3i6B+x3kCQq1UtNOtd+9ZWLA==
X-Gm-Gg: AR+sD138D6MsmZ9UWfaL4SVypaDO/GD8ADxP6nn2YsOdZ5VMxz9WB33Zh2w9csFZ+DH
 rIastQp5YeexnoedrImUwzBBLvBXlRMQUvFmAzYPkYE++WGldyqT9oZFfxIVoOksFD0Kr+BAYji
 MP/J4+T6bezcA7RiOwO6nJh87xnMcqEZ4sn2WG/4VwGkQORRJN9ZrPsi8JR3DCWZSoykBb7D+qM
 7tTJPKItEte19AgkB1bwY36L81DbV4A0DbnanEkJwEEzmx2uLTy0Nvj/4yzuggJAE8Gts8NoNEJ
 OE7fXxuljQhFuz9OohI4hvUeS/tL4FlNnxIbhK5LHxX438GVLfRyrqCfLgxpzaXeT52r2c5K7tI
 NpmQwFc26VOqtQTbecZQ8E7HP/JypgrePdzbcWQh6A0GYkLNfuYllEluGrt0TGydY5ZlkgeC9eI
 Li3i5jNJ0iZ54gAuNV2XOKpkImRmMqO3pHrgMbgR+NDpHlzo+Yp6BaPIziA2U80GiBL613N29Ok
 wmNkQ==
X-Received: by 2002:a05:6830:488e:b0:7e9:d4b5:8004 with SMTP id
 46e09a7af769-7f196bccf05mr18939059a34.5.1785774609822; 
 Mon, 03 Aug 2026 09:30:09 -0700 (PDT)
Received: from devvm55912.cln0.facebook.com ([2a03:2880:31ff:40::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3e926sm7805907a34.1.2026.08.03.09.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:30:06 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, bmeng.cn@gmail.com, qemu-block@nongnu.org,
 Pablo Mazzini <pmazzini@gmail.com>
Subject: [PATCH] hw/sd/sdhci: model the i.MX uSDHC clock,
 reset values and DMA boundary
Date: Mon,  3 Aug 2026 09:26:53 -0700
Message-ID: <20260803162709.2112730-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=pmazzini@gmail.com; helo=mail-ot1-x32d.google.com
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
 hw/sd/sdhci.c          | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index e58a610397..f64159c38b 100644
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
@@ -619,6 +620,15 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         page_aligned = true;
     }
 
+    /*
+     * The i.MX uSDHC has no "Host SDMA Buffer Boundary": its internal DMA
+     * transfers the whole programmed block count and reports only Transfer
+     * Complete, so it never pauses at a boundary.
+     */
+    if (object_dynamic_cast(OBJECT(s), TYPE_IMX_USDHC)) {
+        page_aligned = false;
+    }
+
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
     if (s->trnmod & SDHC_TRNS_READ) {
         s->prnsts |= SDHC_DOING_READ;
@@ -994,7 +1004,7 @@ static void sdhci_data_transfer(void *opaque)
 
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!SDHC_CLOCK_IS_ON(s->clkcon, s->vendor_spec) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
-- 
2.53.0


