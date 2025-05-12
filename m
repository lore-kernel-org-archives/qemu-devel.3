Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F224EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbS-0001ZM-RD; Sun, 11 May 2025 23:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaW-0007zi-EV; Sun, 11 May 2025 23:12:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaS-0006oo-5h; Sun, 11 May 2025 23:12:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c277331eso4294824b3a.1; 
 Sun, 11 May 2025 20:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019528; x=1747624328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEdXjDJ13RR/jJAKE74zIAL/Hxp1w/7NC/XsktyHuZg=;
 b=hnsMovcpRNUQoFnEPaVCrNcMhy2qaJCr1nc9OnK+/loq5cFJR26rjMoNf/rL37xYGj
 P4TSg4P38/vVNj72/Bd+xAUB4R9pa5TzIXhSYr5/vLiNWUlHBG6ElZxFl7Iv2nFUFHqz
 DtJVJVjaNLjhwYDwvBDdvQcAs/I7HdR2Sc4aVXgzB1Tpx4ULBrxEz09SfgGO41h9sSqp
 Fh0ctc8Xr0NTbv00Mk6bZ48lAeAIC1dX3CgtlNJnmyEotsjaXsNreWDlclPLUiP/+TM2
 1aCM0ePdqBejaGALSq0mOdMn1hbIP3ZpFRoYvyoKeuDt2ucPrfg+jEKK+NK417K/i4YF
 2/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019528; x=1747624328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEdXjDJ13RR/jJAKE74zIAL/Hxp1w/7NC/XsktyHuZg=;
 b=YgrDTtMn3+iQ3R9VZZx0SwxMQ50o1bfzByyScNjfRecssL3Co8zhbJq59f25xcOmr9
 vPTRxC81yW8cApDvJgXpgW+znlcYbaIjUMmy3gDs9p3wrdvbjYd9tRLP4vtS8eqlahlL
 EbP/rQO6gmcqNMYpbOc4IPGhvwIp/ZCmMnCWD/rkErSHOVRtWLzyNsS2LIfLRlBNWN1F
 BAV/c0SJ79lH8QxQo15c+poO06uVmfDSf1TTitJNNf4bjWM9dDQ6nBZ6x6XXuQvA5l0x
 JJ5+vZTuJmxsoj7MHdJkzzzbEfC6gtFvQy02PLjUhuIYj2z8bxNiFwJmyksr+Bgo5djZ
 tZ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqInnCF/Bys4CKMedIMen8rpvXOVL6UOI3I+1tz4wg/lbJAQAQHmXGyqcs5TRYZL/SWaYg6JYbwHFa@nongnu.org
X-Gm-Message-State: AOJu0Yzm1FGQXTQjikfxecOMrwgHjJWlHIuvlOsGLHeLRFGqUx/a+wjg
 Zg7CGEzbGDfcMkpGuNalUmJCi+fxsiyE4euS7VCkTWrpccX9cgmyGKUWIA==
X-Gm-Gg: ASbGnctH5rJSs8i+WVdbGg2rqQgjU2HaVBmQwGNygjduFhPH3QINC5IDu1AksMJEk/r
 rAO3Rn5dSf075r030VF6fdVZLMrM9kfHcR2RTW10yhktL7kQ2c/beAc3KFfg51bP3B/FrQe25iB
 lSSHVfU1RS1M8pPB/bsVS2FURs4vkSNsCavkD4MS88cNOKrBRs7YROr8TJIZCvv7KC2La3Uol7S
 C9A89evjXJ5Ndqe4Nk2D/l7gU3/m7rh5bV5y3Edbe9PAtPYwjKeO+ef8zpFXokKS7TG7QBB9+tW
 ZsIYVpq3gusPdTpcaeOOXarrJgNfqt3zvcVTShO7Cinn7PUJ2uXGj2QHDQ==
X-Google-Smtp-Source: AGHT+IFW06RGD5Ij07IKRvxV8bo9Wx3LuLo6mLU4YhGmJvMjk3Kq62HWrqHa/ES5pBpZ+7DfDGhC6g==
X-Received: by 2002:a05:6a20:6a2c:b0:1fe:61a4:7210 with SMTP id
 adf61e73a8af0-21599f766b2mr22670290637.2.1747019528176; 
 Sun, 11 May 2025 20:12:08 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 16/50] ppc/xive: Fix pulling pool and phys contexts
Date: Mon, 12 May 2025 13:10:25 +1000
Message-ID: <20250512031100.439842-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

This improves the implementation of pulling pool and phys contexts in
XIVE1, by following closer the OS pulling code.

In particular, the old ring data is returned rather than the modified,
and irq signals are reset on pull.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c2da23f9ea..1a94642c62 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -241,25 +241,75 @@ static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
     return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
 }
 
+static void xive_pool_cam_decode(uint32_t cam, uint8_t *nvt_blk,
+                                 uint32_t *nvt_idx, bool *vp)
+{
+    if (nvt_blk) {
+        *nvt_blk = xive_nvt_blk(cam);
+    }
+    if (nvt_idx) {
+        *nvt_idx = xive_nvt_idx(cam);
+    }
+    if (vp) {
+        *vp = !!(cam & TM_QW2W2_VP);
+    }
+}
+
+static uint32_t xive_tctx_get_pool_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
+                                       uint32_t *nvt_idx, bool *vp)
+{
+    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
+    uint32_t cam = be32_to_cpu(qw2w2);
+
+    xive_pool_cam_decode(cam, nvt_blk, nvt_idx, vp);
+    return qw2w2;
+}
+
+static void xive_tctx_set_pool_cam(XiveTCTX *tctx, uint32_t qw2w2)
+{
+    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
+}
+
 static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                       hwaddr offset, unsigned size)
 {
-    uint32_t qw2w2_prev = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
     uint32_t qw2w2;
+    uint32_t qw2w2_new;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vp;
 
-    qw2w2 = xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
-    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
+    qw2w2 = xive_tctx_get_pool_cam(tctx, &nvt_blk, &nvt_idx, &vp);
+
+    if (!vp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid POOL NVT %x/%x !?\n",
+                      nvt_blk, nvt_idx);
+    }
+
+    /* Invalidate CAM line */
+    qw2w2_new = xive_set_field32(TM_QW2W2_VP, qw2w2, 0);
+    xive_tctx_set_pool_cam(tctx, qw2w2_new);
+
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
+    xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
     return qw2w2;
 }
 
 static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                       hwaddr offset, unsigned size)
 {
-    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
-    uint8_t qw3b8;
+    uint8_t qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    uint8_t qw3b8_new;
+
+    qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    if (!(qw3b8 & TM_QW3B8_VT)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid PHYS thread!?\n");
+    }
+    qw3b8_new = qw3b8 & ~TM_QW3B8_VT;
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8_new;
 
-    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
-    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
+    xive_tctx_reset_signal(tctx, TM_QW3_HV_PHYS);
     return qw3b8;
 }
 
@@ -489,7 +539,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     qw1w2 = xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
 
     if (!vo) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x !?\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid OS NVT %x/%x !?\n",
                       nvt_blk, nvt_idx);
     }
 
-- 
2.47.1


