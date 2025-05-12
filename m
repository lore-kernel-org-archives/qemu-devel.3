Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC75C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcH-0006Kf-Id; Sun, 11 May 2025 23:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbo-0003fj-7G; Sun, 11 May 2025 23:13:40 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbm-000718-6c; Sun, 11 May 2025 23:13:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7418e182864so2901930b3a.1; 
 Sun, 11 May 2025 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019616; x=1747624416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cB9AS3Hy7G833dhHpjiFy0cXcBZXBTRVSZZBzftKkvc=;
 b=fT7l4KwpFDlD1TMnJPgk87YKYgB4g5UVoLM3Va1eP98hTYkKZ/YQYZ6rhkwK0vJiXI
 ik+ZHbo2kuCVArjhjm58tY/4Hn2oe+OU4fGqdoZraXVLounhntZUOpTBwdL168j4X0ST
 9JMUrZnUf5tLcnWl4HCDIIJDk20UHZKAVeMFTyG4RaNFAOTD9JHWCSEaNlARXTG/Ar2N
 VXNSKhWiStRFBhfAApS7zzCxP7PMusstppcVHn8rp/Q0qnLrsr+H4hvficLjiKYm58YA
 8o2DU0fLf5+T6aGw223FQIJVXI2hCvVJrM2JPrHc3TUJNYbex6bfXZujeuxezktFNTMe
 GVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019616; x=1747624416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cB9AS3Hy7G833dhHpjiFy0cXcBZXBTRVSZZBzftKkvc=;
 b=BWTzxAIDB1PdycZiQrYiq1VAPeJ+qoHWUn9ob8Vk9ALNW95jrv2VjxSDP9bCIQ+46S
 J0BJkZH9kokgQwH5t0ye0/sN/2ECII1cIKg3g7DL9Wy93TJ+rVfudC9rFyK9pdVhpzhc
 D4aJb0GRVHQnzKceYeMNipZL4WnKd5d3YETov+QhygMhoFc0RApdvFcrIeoyAwOxEF5M
 36Wr8UcWdGu7zzxJPmxw5F3MBMb0R9DyA4eA7Pwg1tGEmPL5G+75sz7zLlx4rHT+I8E2
 P18rPFkHctz3nqSD8+mo4VLNjCQ7IiR1Ti0/HA4AUh/TNmAxQk5A3XvJId+UDtU8R4Gw
 cV6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1g5fVkTFmAKeC4zJ9hTx6rjuYxJH+uz+SQL+sE/IVhujkDriCCftxO/zWZKNHXYFDkZr/bE7Yl31@nongnu.org
X-Gm-Message-State: AOJu0YwDLMZ8k1xiLq8FNRg3qTb8rbztvr3LM2vJ2M7wh5seOAJeSkAZ
 EDKRekcy4ZhCcZGU4n6CA3WLebw0IbJ49IbS0FQmlN6bK3tnKag9X1aklA==
X-Gm-Gg: ASbGncuYZXSg/W6nyRGSe+4gVX8CadPbLyEc/1pCTkE6ziWPKWXI9AIqFlA0v4bqmU7
 05VnCWvPVWyafo6AD2IBnswbIhGwtTimOrP1fBVJ2SKejcJN9XjhfkwHqNsP1orrMLg5JbCIFBu
 rvSGy5wVN11VgtS+FRDS1APyvcqPlMB8hx5hhSO0kVtfWjzrMxXaqYYA34/H2bFNqvAe16wlV2q
 UJmpbW+MiJlugxSRvIMH55d0/ePCjB9m/eBiT9vjj0Iux8Cag09gh9erznGHdUTtWdHf6SBYoPF
 JTdPuyjb1ZzWfDuZ8Mrez8teSLv2tJBT9vwdHZHaOUnpKtE0oya0zMc2Wdn5pxtjHcX+
X-Google-Smtp-Source: AGHT+IHExpnOQqaYEKSt4DdVFJtiVC4noxRnYqo67wg1IXHCzSB1U+X56COUB1gH7Cp76v7/IMO8HQ==
X-Received: by 2002:a05:6a21:b85:b0:1f5:7ba7:69d7 with SMTP id
 adf61e73a8af0-215ababbfcamr15626234637.3.1747019616022; 
 Sun, 11 May 2025 20:13:36 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 40/50] ppc/xive2: implement NVP context save restore for POOL
 ring
Date: Mon, 12 May 2025 13:10:49 +1000
Message-ID: <20250512031100.439842-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

In preparation to implement POOL context push, add support for POOL
NVP context save/restore.

The NVP p bit is defined in the spec as follows:

    If TRUE, the CPPR of a Pool VP in the NVP is updated during store of
    the context with the CPPR of the Hard context it was running under.

It's not clear whether non-pool VPs always or never get CPPR updated.
Before this patch, OS contexts always save CPPR, so we will assume that
is the behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c             | 51 +++++++++++++++++++++++++------------
 include/hw/ppc/xive2_regs.h |  1 +
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index e3060810d3..d899c1fb14 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -512,12 +512,13 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
  */
 
 static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                uint8_t nvp_blk, uint32_t nvp_idx,
-                                uint8_t ring)
+                                uint8_t ring,
+                                uint8_t nvp_blk, uint32_t nvp_idx)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
     Xive2Nvp nvp;
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
@@ -553,7 +554,14 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
-    nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
+
+    if ((nvp.w0 & NVP2_W0_P) || ring != TM_QW2_HV_POOL) {
+        /*
+         * Non-pool contexts always save CPPR (ignore p bit). XXX: Clarify
+         * whether that is the correct behaviour.
+         */
+        nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, sig_regs[TM_CPPR]);
+    }
     if (nvp.w0 & NVP2_W0_L) {
         /*
          * Typically not used. If LSMFB is restored with 0, it will
@@ -722,7 +730,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
+        xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
     }
 
     /*
@@ -863,12 +871,15 @@ void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
 }
 
-static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                        uint8_t nvp_blk, uint32_t nvp_idx,
-                                        Xive2Nvp *nvp)
+static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
+                                      uint8_t ring,
+                                      uint8_t nvp_blk, uint32_t nvp_idx,
+                                      Xive2Nvp *nvp)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+    uint8_t *regs = &tctx->regs[ring];
     uint8_t cppr;
 
     if (!xive2_nvp_is_hw(nvp)) {
@@ -881,10 +892,10 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     nvp->w2 = xive_set_field32(NVP2_W2_CPPR, nvp->w2, 0);
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
 
-    tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
-    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
-    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
-    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
+    sig_regs[TM_CPPR] = cppr;
+    regs[TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
+    regs[TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
+    regs[TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
 
     nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
     nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
@@ -893,9 +904,18 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     /*
      * Checkout privilege: 0:OS, 1:Pool, 2:Hard
      *
-     * TODO: we only support OS push/pull
+     * TODO: we don't support hard push/pull
      */
-    nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
+    switch (ring) {
+    case TM_QW1_OS:
+        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
+        break;
+    case TM_QW2_HV_POOL:
+        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 1);
 
@@ -930,9 +950,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     /* Automatically restore thread context registers */
-    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE &&
-        do_restore) {
-        xive2_tctx_restore_os_ctx(xrtr, tctx, nvp_blk, nvp_idx, &nvp);
+    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
+        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
     }
 
     ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index f82054661b..2a3e60abad 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -158,6 +158,7 @@ typedef struct Xive2Nvp {
 #define NVP2_W0_L                  PPC_BIT32(8)
 #define NVP2_W0_G                  PPC_BIT32(9)
 #define NVP2_W0_T                  PPC_BIT32(10)
+#define NVP2_W0_P                  PPC_BIT32(11)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
 #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
-- 
2.47.1


