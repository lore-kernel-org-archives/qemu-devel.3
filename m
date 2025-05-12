Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FE4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcl-0007k9-HY; Sun, 11 May 2025 23:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc0-0004qG-QO; Sun, 11 May 2025 23:13:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbx-00072q-Fb; Sun, 11 May 2025 23:13:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af6a315b491so3414131a12.1; 
 Sun, 11 May 2025 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019627; x=1747624427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxfUtgSOc/GLqLegPYk6b/4JXLPnqPz0Npk/FPOwRoI=;
 b=B00SBdQFSQvI8X6TNjfWm4C1CPgVhuqvaPTfPA1krj0QEaKQV9STTiW4ytGbQoLGKU
 hO9i3chFM97d39JsJTDXcOfnhEzUcEyBcUU6k/CwQ2SmnYkDu8rOiClC2xiwweVRLp/p
 M3KxY73mNSltVHnOhu3z48oNl4tkeUm3tn8pVtXWZAlkzqxaCv8UCNiAjnYlfD4YI4/n
 wI2m8MaM+BmfKsuiZ6qF3j1CxCL7ZnNqMb2lIK2rcm2dj/43Ybo91NtBmacTHPv481R7
 OtN11wCFKmXMe3FJPZZC4ASUcjzKQJrPnY9BorZi8zEAVbv5eBOrJzy1WY/EQlfEkbmD
 qWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019627; x=1747624427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxfUtgSOc/GLqLegPYk6b/4JXLPnqPz0Npk/FPOwRoI=;
 b=pGqtFp6yHCG6Q9U2si5/D9/ZQiWN1f4Xc3O1hVY8VMPcPCX+Zuav1p+fiJrQTpZbzj
 UBP7zl7t+NBFRzr87ZbQzVm3pMt84hFRqngWDSXz2afNstbjIZE3jphGMEcnNJLA1o4q
 adTDJv637g6jqFVMyfH38gUFopFJXcUn+x0oBbPxqBF50DI7qzR6stJvO7PQHJRogJzc
 0BKzOOOdXWAxDCoWfGOXfVhn/U0z5KmgUId4tzAXN2ZK86MPdb2yLkJFckptcwSQ1pL9
 pUgNyMYhuV9fhyR/ro43It/+EKnV27b0RZlFR+D1AoeGDlWcV2ApdCy1zVbJuntOv6Hj
 +KJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULyuNoZkVcXUitP2+c/WarOcz6SONGzxm2ij/phD7SgfPPdhU6b5Lb3LRjAYFYsjBFgbDtobD28Mjz@nongnu.org
X-Gm-Message-State: AOJu0Yw9pHyvNcEKoB3mDPWp2I/kdnGOQPMvLkoPrrCX8Qx8Ju0Z9U9B
 EFP01Htbq6KsSGhrU739lMjoO09wHmrQz0CzbMBlfiCq+ymZvbDRaQ2U5Q==
X-Gm-Gg: ASbGncvI8NZImEhhnmXAcLEqpFsG6oirkMNzzx5FzKTLu5ypBGtt/DwRkgpPb4u9iS6
 UQW8QO+jYf9fbOy1wLNc5x/VL7IsK7fWoqhJXWSzut88hNTQTDxhEOW+uaB6trCK7+WK5sk0WKL
 rc0URTL2u7ew3clR37W0sh3JPjMT7y1r4tTEBdaDbo5TfqqMnHqudTraBTCtWKT/jTB6FsCCk3x
 NRQQ3ZWDd7ICMiL+i1VbFlHi+t+Gt85WO/dyX7ftPPH40q/skOLCs0sf7VLh97133oBuEYorN4L
 z2DT4atljskxefsM38EyHv7wp83RdSZ7NZ8nWARH7/remc/bdLp8hyVB6A==
X-Google-Smtp-Source: AGHT+IF6jPVZoqb3BaiEdaME/kq0Krvj/fw23XexClrvTDneQfZQYjkKGHtiZOP5V1qo1ADUO5OVlg==
X-Received: by 2002:a17:903:32ca:b0:223:f408:c3e2 with SMTP id
 d9443c01a7336-22fc8b41541mr169182015ad.14.1747019627058; 
 Sun, 11 May 2025 20:13:47 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 43/50] ppc/xive: Check TIMA operations validity
Date: Mon, 12 May 2025 13:10:52 +1000
Message-ID: <20250512031100.439842-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

Certain TIMA operations should only be performed when a ring is valid,
others when the ring is invalid, and they are considered undefined if
used incorrectly. Add checks for this condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 196 +++++++++++++++++++++++++-----------------
 include/hw/ppc/xive.h |   1 +
 2 files changed, 116 insertions(+), 81 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index aeca66e56e..d5bbd8f4c6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -25,6 +25,19 @@
 /*
  * XIVE Thread Interrupt Management context
  */
+bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring)
+{
+    uint8_t cur_ring;
+
+    for (cur_ring = ring; cur_ring <= TM_QW3_HV_PHYS;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        if (!(tctx->regs[cur_ring + TM_WORD2] & 0x80)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
 {
     switch (ring) {
@@ -663,6 +676,8 @@ typedef struct XiveTmOp {
     uint8_t  page_offset;
     uint32_t op_offset;
     unsigned size;
+    bool     hw_ok;
+    bool     sw_ok;
     void     (*write_handler)(XivePresenter *xptr, XiveTCTX *tctx,
                               hwaddr offset,
                               uint64_t value, unsigned size);
@@ -675,34 +690,34 @@ static const XiveTmOp xive_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
-                                                     xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
+      xive_tm_set_os_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
+      xive_tm_push_os_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
+      xive_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
+      xive_tm_vt_push, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
+      NULL, xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                     xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
-                                                     xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
-                                                     xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
-                                                     xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive_tm_pull_phys_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
+      NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
+      xive_tm_set_os_pending, NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
+      NULL, xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
+      NULL, xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
+      NULL, xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
+      NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
+      NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
+      NULL, xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -710,52 +725,48 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
-                                                     xive_tm_vt_poll },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
-                                                     NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
+      xive2_tm_set_os_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
+      xive2_tm_push_os_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, true, true,
+      xive2_tm_push_os_ctx, NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
+      xive_tm_set_os_lgs, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
+      xive2_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
+      NULL, xive_tm_vt_poll },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
+      xive2_tm_set_hv_target, NULL },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                   xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
-                                                     xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
-                                                     xive2_tm_pull_phys_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive2_tm_pull_phys_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
-                                                     NULL },
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
-                                                     NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
+      NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
+      NULL, xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, true, false,
+      xive2_tm_pull_os_ctx_ol, NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, true, false,
+      NULL, xive2_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
+      NULL, xive2_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, true, false,
+      xive2_tm_pull_phys_ctx_ol, NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, true, false,
+      xive2_tm_ack_os_el, NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
@@ -797,18 +808,28 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                         uint64_t value, unsigned size)
 {
     const XiveTmOp *xto;
+    uint8_t ring = offset & TM_RING_OFFSET;
+    bool is_valid = xive_ring_valid(tctx, ring);
+    bool hw_owned = is_valid;
 
     trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
 
-    /*
-     * TODO: check V bit in Q[0-3]W2
-     */
-
     /*
      * First, check for special operations in the 2K region
      */
+    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
+    if (xto) {
+        if (hw_owned && !xto->hw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+        if (!hw_owned && !xto->sw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to SW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+    }
+
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(tctx->xptr, offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
                           "@%"HWADDR_PRIx" size %d\n", offset, size);
@@ -821,7 +842,6 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
     if (xto) {
         xto->write_handler(xptr, tctx, offset, value, size);
         return;
@@ -830,6 +850,11 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Finish with raw access to the register values
      */
+    if (hw_owned) {
+        /* Store context operations are dangerous when context is valid */
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
+                      "@%"HWADDR_PRIx" size %d\n", offset, size);
+    }
     xive_tm_raw_write(tctx, offset, value, size);
 }
 
@@ -837,17 +862,27 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            unsigned size)
 {
     const XiveTmOp *xto;
+    uint8_t ring = offset & TM_RING_OFFSET;
+    bool is_valid = xive_ring_valid(tctx, ring);
+    bool hw_owned = is_valid;
     uint64_t ret;
 
-    /*
-     * TODO: check V bit in Q[0-3]W2
-     */
+    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
+    if (xto) {
+        if (hw_owned && !xto->hw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to HW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+        if (!hw_owned && !xto->sw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to SW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+    }
 
     /*
      * First, check for special operations in the 2K region
      */
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(tctx->xptr, offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
                           "@%"HWADDR_PRIx" size %d\n", offset, size);
@@ -860,7 +895,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
     if (xto) {
         ret = xto->read_handler(xptr, tctx, offset, size);
         goto out;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2372d1014b..b7ca8544e4 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -365,6 +365,7 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
     return *((uint32_t *) &ring[TM_WORD2]);
 }
 
+bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring);
 bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
 bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
 uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
-- 
2.47.1


