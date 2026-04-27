Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1AEFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLRO-0003qx-ON; Mon, 27 Apr 2026 08:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNc-00080l-Rb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNZ-0005eC-D6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so122375705e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294079; x=1777898879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QHjElnEbH83AeQYXqjknRBF7S35lhCc1cC2LPJvmubE=;
 b=WpzsQy8YdjSs9rtpEYpqB/+nztrlWX1qDkEbcKlU6LNVLXoNolUF4wmElshov2uFKW
 4KbglbuyRt78n2e31Zsx6sqTs88W+7zfsKUeot67/+HZyYjbNxNpkKnSz4dqS/LASzBb
 +AN3UXrCQUTRhud6ugcHgDhD8k3HLzW5NBJZDqbMDRAODudRuR+iHQS7lH/NaJc1CIxO
 7Ogs8mHjv1dCFD7zYDMrW6LVe0w6cDZRRATYOj1TGl0IqEhYJn41hqRuyEEptAuC1BER
 IPVvRdY3rItRw4Z47+ufonaOTjSUx2zLY0qRFTCXpYCyLTWlnJ+TmreqKtX5Cs8Fo/CY
 Z3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294079; x=1777898879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QHjElnEbH83AeQYXqjknRBF7S35lhCc1cC2LPJvmubE=;
 b=LpKSSkyv6xPonJn0JmveyiWr1+LaTFfo8DuwnNKZXbAin3ybDezdlsqQsnSTGp0BrA
 D5voW0R7lvdtXKHS+jzmzREzBwK0R1LoFf/8D43CSjU3gIfXLGibG+Ca6lPs6GpU4hCk
 usTvuXn/eS4oBKnOVGemdFBrsJ7GHEM/Brpp3qR2ZyllHgPpsAwPGM47Zn49PqYwQ4O9
 0oqfWs7ym/jZtF4Ea0qTfbnzimb9gxVozOhB2U4eG8NW8yd6vwqQY29D/zHg0FxaeQjL
 1x6go2393UGLinDJMs6eWUIzeqDvDf8/VCj51rCbRqxXbwFeznOV7Vg4S3BQJomgW70e
 ixlw==
X-Gm-Message-State: AOJu0Yw0hZ93lqAthC/IvnwdKrOvU6ryK1dIec4CjcNSb4uF1VOhu/G8
 iopwnL+EL4wZ0/rYp72TXdQwyQInO+kgt8AMcXs73tw1PLyxauESe5CNkBSrStAH05mF3scQmof
 hcEGa
X-Gm-Gg: AeBDiesBahVRV4ASkwl76SbTkW0qFaFM6PmfWbH37vrdVvis5VBj8iTgj3Oy/xY/DVe
 Z+LZxmX+X4bUCBKtjnnwHDj7YEZjDddvyaoUGJmWrhIaSHQK4pfZMCQQZR7eLtH0u+kA4PH08aM
 cmTZKNDLGSUwx+Ewmt5b64xEmzAGRbvvZFHrhR4r+KtmxAbI0Xmvj2s/CkbAiIrkUzzQG4pL+dU
 rjbRNDBdN6SX68fZTYyIqMbOskeL1XEqrT3hRd5LAn/E2b4ruyTEgIAJ9WunOHHmN842+KSOWT6
 Co7g5l8lkF+AZ0BQOGh4OSf5PM9odYfhFmmFUbgFYII+agljEcLJPRPXPIadlQFe6SFDfue8sC0
 ft4ZuAf5QSMfREeGIgObSbrQl49lVCi8jXesdQJgKDercXbMtsx2u3ftWt1wm74+RpeVIIixUbI
 fhClZgfXVvigo5uHOiAZypEnsbjUXClx6VZgb3b8tgWkwyOLmFhfVMnIrqq9C+YeRGAkdbQ+dwS
 SL72Xkj7+rnyTfGvn5WXvJVls74ML8HE67v12vZx9FhR645WuZF
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a592ce7c2mr358001665e9.17.1777294078620; 
 Mon, 27 Apr 2026 05:47:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/63] target/arm: Replace MO_TE -> mo_endian() for MVE helpers
Date: Mon, 27 Apr 2026 13:46:56 +0100
Message-ID: <20260427124738.966578-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 47 +++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index a5a23c9705..64ab804abc 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -160,7 +160,7 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MFLAG | MO_ALIGN, \
                                      mmu_idx);                          \
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
@@ -184,7 +184,7 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MFLAG | MO_ALIGN, \
                                      mmu_idx);                          \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
@@ -235,7 +235,7 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MFLAG | MO_ALIGN, \
                                      mmu_idx);                          \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
@@ -263,7 +263,7 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MFLAG | MO_ALIGN, \
                                      mmu_idx);                          \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
@@ -326,7 +326,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -413,7 +414,8 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -439,7 +441,8 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -466,7 +469,8 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t *qd;                                                   \
         int y;                                                          \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -505,7 +509,8 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -531,7 +536,8 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         int e;                                                          \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -556,7 +562,8 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -587,7 +594,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -614,7 +622,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -640,7 +649,8 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t *qd;                                                   \
         int y;                                                          \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -679,7 +689,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -706,7 +717,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         int e;                                                          \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -732,7 +744,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
+        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
+                                     mmu_idx);                          \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
-- 
2.43.0


