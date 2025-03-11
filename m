Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B598C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzF5-00066f-GR; Tue, 11 Mar 2025 09:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDc-0004i3-Hl; Tue, 11 Mar 2025 09:00:25 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDW-0008JI-5r; Tue, 11 Mar 2025 09:00:21 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso9001913a91.3; 
 Tue, 11 Mar 2025 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698012; x=1742302812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WONqQrZcwlp8hZGRfUQfRRo9qkCGxQct+x79CzVQ1Sk=;
 b=ZIV41OYTk5AJo+39WPqgjZBze6c4C9cd9fX09Uw0hlMSmT9s7wozivaWfYThsbMznJ
 aplUh0bRA7cCckjDRt+qyFAvva8fJ18m8b+uMFFiF32z5Ma/eVx0eFwLgnLNlfshq9tt
 Ux8Ql+qwvUmMIQyzQ5+CFOvJ8rdgobRu0P5BbBE5SI9XNRjldSFVeV8/XgU0uff1Yvp+
 kK+vWoxvBqoKSWS8sU3HfoxpeUcP82eG/iL1MdiYF1Jxexk0OO4BlBRj95NgFvaZJPip
 J5hl6AAo+nsO3XBHAej/GywqXk/IDxZW6kZQ7SpYGOAbvBAfAKiDTstj3TSkb5rJmMRM
 I5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698012; x=1742302812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WONqQrZcwlp8hZGRfUQfRRo9qkCGxQct+x79CzVQ1Sk=;
 b=P69hScfqykVy3sklPYLvUvQqTLW879uSfPAmAY3Qb4gLbkA7jQCdOt0fNg5U3WEO6v
 0DewdvIEcySzeJdsvGJUUcjGXUZ77DBuOCMQgKw9HIX9yV+PRr34A2ywaXvtaS8AfUPO
 SL7imw368FjX0agzlVoBoqalgNYuE0BuMrbQtQM043zlcyOrJN0o8c04BGHujvsj1czA
 tiXIOAOnW0YuRe4U3aOlXPtRkTIZ7uuMdJ4/GzVHvqsEU6fxqG5cZSRqiH/51VLPOEt2
 V1+5S3vL2nveRV5vFeZbtXwRyGNulo8ZCZ8QU4b1cCcncnKvEGXDjmU4QvyKRpnbct/F
 6XGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIXT2OJImLPh+6dxunVgrrw0FJG7d2XXeDwF5VS2jBNBLLBX+zI0Q5185s97qJ0Vzhf3GCC3szMw==@nongnu.org
X-Gm-Message-State: AOJu0Yyz9EttYr8AfMqlR8hOalmgajBh/i0y40+EXdE9br/UOh74xokm
 BnP605tcm1+yescWWsNV+DcdfeE5F53C6axDIsxkoRHbmu3STqEYbJmi9g==
X-Gm-Gg: ASbGncsKdueB2YZ4+XhQu4Q+5prJvZWVp1XgGxbpHp65df8GQisJnNoTXgglc9lTpq2
 XInjNIxdBNTcH7qd/jys/NXIF6YubZmlP/sKVb4soTgPv72E/eTjF0JIUMQuqKfZHYFQ9mKhd7Y
 9Z3wUZDoWZTnBARkqlsSIbnfKGRPUXHiwzGwSbfa2y+ZromQWyNKJydxPKa3/eEY4sLAaWaW767
 v8T8KWX+gRfVrF6D2GhfHOuh43Rccd6FN8BUi/yPne1vaaDgXbaJarVwR7+fv0OJO7ZTlHT78wq
 vuPI9EGbPpci4q2JlyojLlFQZrsH8vxerfFzyniZ0ZFTL+EjAZQ=
X-Google-Smtp-Source: AGHT+IEgV0fqBE6Z9BPqEchYJbCJvBp74KhJbKiEch9XoY6eS3Igccqlk+FjtY1eWACnQZKNFNeYvg==
X-Received: by 2002:a17:90b:52c3:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-2ff7cf22de4mr26426610a91.29.1741698012303; 
 Tue, 11 Mar 2025 06:00:12 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 34/72] ppc/xive2: Check crowd backlog when scanning group
 backlog
Date: Tue, 11 Mar 2025 22:57:28 +1000
Message-ID: <20250311125815.903177-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

When processing a backlog scan for group interrupts, also take
into account crowd interrupts.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c             | 82 +++++++++++++++++++++++++------------
 include/hw/ppc/xive2_regs.h |  4 ++
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index e925307d0f..f8ef615487 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -367,6 +367,35 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
 
+static void xive2_pgofnext(uint8_t *nvgc_blk, uint32_t *nvgc_idx,
+                           uint8_t next_level)
+{
+    uint32_t mask, next_idx;
+    uint8_t next_blk;
+
+    /*
+     * Adjust the block and index of a VP for the next group/crowd
+     * size (PGofFirst/PGofNext field in the NVP and NVGC structures).
+     *
+     * The 6-bit group level is split into a 2-bit crowd and 4-bit
+     * group levels. Encoding is similar. However, we don't support
+     * crowd size of 8. So a crowd level of 0b11 is bumped to a crowd
+     * size of 16.
+     */
+    next_blk = NVx_CROWD_LVL(next_level);
+    if (next_blk == 3) {
+        next_blk = 4;
+    }
+    mask = (1 << next_blk) - 1;
+    *nvgc_blk &= ~mask;
+    *nvgc_blk |= mask >> 1;
+
+    next_idx = NVx_GROUP_LVL(next_level);
+    mask = (1 << next_idx) - 1;
+    *nvgc_idx &= ~mask;
+    *nvgc_idx |= mask >> 1;
+}
+
 /*
  * Scan the group chain and return the highest priority and group
  * level of pending group interrupts.
@@ -377,29 +406,28 @@ static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
                                             uint8_t *out_level)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvgc_idx, mask;
+    uint32_t nvgc_idx;
     uint32_t current_level, count;
-    uint8_t prio;
+    uint8_t nvgc_blk, prio;
     Xive2Nvgc nvgc;
 
     for (prio = 0; prio <= XIVE_PRIORITY_MAX; prio++) {
-        current_level = first_group & 0xF;
+        current_level = first_group & 0x3F;
+        nvgc_blk = nvx_blk;
+        nvgc_idx = nvx_idx;
 
         while (current_level) {
-            mask = (1 << current_level) - 1;
-            nvgc_idx = nvx_idx & ~mask;
-            nvgc_idx |= mask >> 1;
-            qemu_log("fxb %s checking backlog for prio %d group idx %x\n",
-                     __func__, prio, nvgc_idx);
-
-            if (xive2_router_get_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                              nvx_blk, nvgc_idx);
+            xive2_pgofnext(&nvgc_blk, &nvgc_idx, current_level);
+
+            if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(current_level),
+                                      nvgc_blk, nvgc_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
+                              nvgc_blk, nvgc_idx);
                 return 0xFF;
             }
             if (!xive2_nvgc_is_valid(&nvgc)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                              nvx_blk, nvgc_idx);
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x\n",
+                              nvgc_blk, nvgc_idx);
                 return 0xFF;
             }
 
@@ -408,7 +436,7 @@ static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
                 *out_level = current_level;
                 return prio;
             }
-            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0xF;
+            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0x3F;
         }
     }
     return 0xFF;
@@ -420,22 +448,23 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
                                          uint8_t group_level)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvgc_idx, mask, count;
+    uint32_t nvgc_idx, count;
+    uint8_t nvgc_blk;
     Xive2Nvgc nvgc;
 
-    group_level &= 0xF;
-    mask = (1 << group_level) - 1;
-    nvgc_idx = nvx_idx & ~mask;
-    nvgc_idx |= mask >> 1;
+    nvgc_blk = nvx_blk;
+    nvgc_idx = nvx_idx;
+    xive2_pgofnext(&nvgc_blk, &nvgc_idx, group_level);
 
-    if (xive2_router_get_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                      nvx_blk, nvgc_idx);
+    if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(group_level),
+                              nvgc_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
+                      nvgc_blk, nvgc_idx);
         return;
     }
     if (!xive2_nvgc_is_valid(&nvgc)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                      nvx_blk, nvgc_idx);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x\n",
+                      nvgc_blk, nvgc_idx);
         return;
     }
     count = xive2_nvgc_get_backlog(&nvgc, group_prio);
@@ -443,7 +472,8 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
         return;
     }
     xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
-    xive2_router_write_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc);
+    xive2_router_write_nvgc(xrtr, NVx_CROWD_LVL(group_level),
+                            nvgc_blk, nvgc_idx, &nvgc);
 }
 
 /*
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 9bcf7a8a6f..b11395c563 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -236,4 +236,8 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
 #define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
 #define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
 
+/* split the 6-bit crowd/group level */
+#define NVx_CROWD_LVL(level)      ((level >> 4) & 0b11)
+#define NVx_GROUP_LVL(level)      (level & 0b1111)
+
 #endif /* PPC_XIVE2_REGS_H */
-- 
2.47.1


