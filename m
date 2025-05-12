Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB6C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcO-0006oz-Qc; Sun, 11 May 2025 23:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbv-0004QZ-9j; Sun, 11 May 2025 23:13:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbt-00072K-FW; Sun, 11 May 2025 23:13:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7423fadbe77so2212072b3a.3; 
 Sun, 11 May 2025 20:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019623; x=1747624423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztsSWF8WvVeZRhhOoYgAiI0iM2KcYhtlNL+PbMDCDMs=;
 b=XJPZC2IdE9lw2Vlr6zDFU5Pfy6u/B0+g70PrrYDiQAd4Aqjtdgy3C+lrVED8ph8EnR
 B1Edh4if1RK4Ov3SCbO1rvXxPbEHxGh8c+pot7k1nB7S+KA4evc5Ccam3iHBQjpeBAKG
 KAGjAekZmPi122yqLmxio7ICBQUZgjwTbzgnD4iS2Z6BfaABYdTag4MYSbm5ZPcL1m5C
 fbEVuWubndSv0IEzZyWT96P11o5ojYol8OYIunmL1UqJEDNiycheTbCx2LXWMoisq8cu
 tfLhKyj0inbgJSGfsP55MuK3qCnF9s/LKJreTYZnHIBITNajBIF8JjGgUyzXQvejrcYD
 GzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019623; x=1747624423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztsSWF8WvVeZRhhOoYgAiI0iM2KcYhtlNL+PbMDCDMs=;
 b=cVBBef61/sCQtMwFzJgSgPODtot5O9eAbBKM4afNn5kzKCXX9e9zoDTobDApe6NtBA
 Re7BUti0zViq4U62TtnPszEeUyBgEJ/0iA1TPv0p5CRTVWMHTkh94D/vjZKGzf1JaAQV
 h/neg5npb0KD6XsiBFeaGI+JpOrOaD55eX6UToB8HPAatASVZtXf2cg2HtWJJLvJ4Ia9
 vKt5vyil2jNTfHFyLdFEb5DdMBRYGDv93Z04M85k72mKCcHUJXGsErnvQMEegm1OkfXV
 AXDr4GSE97dSGZt+vduOsWXefbeqDXh8VTvFdP04CUeGvyVNqsDqtmUbwa5QaI8QLHz+
 5LDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ4U3kUoeuuaBkHKwNZTZ3YR5y2iQTfLZmoqVZZsMVqyL7dVTDOoIAptxXxMwuIJ8EBrZ0t6xczyOx@nongnu.org
X-Gm-Message-State: AOJu0Yz3oI2O0fewY0mfhnHer4Hctpip1Lt1fH4XWoh0gOroQtacTyAR
 sk56q4szGM1H0UeMYVnvfR+xudy7TeL4uraLkyqtCmTGrXZ8MUKVkx/p6A==
X-Gm-Gg: ASbGnctnAOTMayEQm2hdLEw7nd4cqKgVZ/eEW5rg0M39b735WI2fOBt6R0WcLyPlw9u
 iv5DHKJcLiSQlS2EO9v+hQUVR+YA5AHKXplAr3ZI2U7/240QPXi/fH+Kgx5PWVAMsg+wMmesgLr
 gZLE4LXpPyW2jB7gqr6eh3n9SN3CEZa3cZ4iXTNMXYdD5/rKaU9Hak5pj0pTL0RwsThlc6rzle1
 8nqHNYsEvpFQHnsN9VJBzh0X5+EEn2ATWDgeDu6eQgF/fbD1oN/eRVJHydHAmurUhZ8dUY1KLeX
 LRYLqUwaRR67eRHjiT05MYIi84AYx4Mu3+neJC1wMw44FwED5l9JLgTMjg==
X-Google-Smtp-Source: AGHT+IGAr+32y2qrdmxO/zn4qD0rPiwrrA5K7hnbLtYzALymFTew+MvCWwoOV/Ur9g/aScSZeGrh8Q==
X-Received: by 2002:a05:6a20:e188:b0:1f5:8dea:bb93 with SMTP id
 adf61e73a8af0-215ababc07fmr18436831637.7.1747019623394; 
 Sun, 11 May 2025 20:13:43 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 42/50] ppc/xive: Redistribute phys after pulling of pool
 context
Date: Mon, 12 May 2025 13:10:51 +1000
Message-ID: <20250512031100.439842-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
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

After pulling the pool context, if a pool irq had been presented and
was cleared in the process, there could be a pending irq in phys that
should be presented. Process the phys irq ring after pulling pool ring
to catch this case and avoid losing irqs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  |  3 +++
 hw/intc/xive2.c | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 81af59f0ec..aeca66e56e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -320,6 +320,9 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     xive_tctx_reset_signal(tctx, TM_QW1_OS);
     xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
+    /* Re-check phys for interrupts if pool was disabled */
+    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW3_HV_PHYS);
+
     return qw2w2;
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index aeeb901b6a..917ecbaae4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -683,6 +683,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive_tctx_reset_signal(tctx, ring);
 }
 
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -739,6 +741,18 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         }
     }
 
+    if (ring == TM_QW2_HV_POOL) {
+        /* Re-check phys for interrupts if pool was disabled */
+        nsr = tctx->regs[TM_QW3_HV_PHYS + TM_NSR];
+        if (xive_nsr_indicates_exception(TM_QW3_HV_PHYS, nsr)) {
+            /* Ring must be PHYS because POOL would have been redistributed */
+            g_assert(xive_nsr_exception_ring(TM_QW3_HV_PHYS, nsr) ==
+                                                           TM_QW3_HV_PHYS);
+        } else {
+            xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
+        }
+    }
+
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
         xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
     }
@@ -925,8 +939,6 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
-static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
-
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
-- 
2.47.1


