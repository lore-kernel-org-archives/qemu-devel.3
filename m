Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637C2C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPl-0007Wd-Bd; Thu, 01 May 2025 17:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOs-00052Y-QZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOp-0002DL-QV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso1660514b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134694; x=1746739494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLPkA6JOnUOzci2wJy576ikVBoJf3Va9Je+srdX0Qbc=;
 b=sByrXzekG7JpRmFSAuNqaWQFGoY2I1i5d0P98bf9ppq2yPPyG5OO7LVEkzhQGkXX7L
 i9LMtzB48RjySSAbLapWIg0Hgmr/R79dNT6UhrvOAriWq5vCm0Jl39h/W2m5ogJ0WPTC
 rg+Jpe1hZ9oKCLQEEGTu6+BmvtLjPn469YcoYINeEjJHj3jQycM/UISVoMlS2zgj8Pu6
 PIZO2wBNTb8DxdNOA24PxKZE7Hq8b1UW5UWz8i1j2mLlanpDIlkUyLgPEijn7ggPB4Af
 UA1ubRhPVz2Z+Qi/DvSGsLK8J9p/90V94F8sxiEkTSpjxW99c/MIhWjw9i0OspC9opnG
 f0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134694; x=1746739494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLPkA6JOnUOzci2wJy576ikVBoJf3Va9Je+srdX0Qbc=;
 b=j6USW6EtxxWvDxcQzs5fhN8LAobQ2yTNrw/+sJx7j+s7ABezK0kn/rnmPKwvh8TF9A
 wcOrVTdAi47/dYI+fdUbzNBrSQ0SwHHOJY1p+oikqFP+yZJV+xF3IkHnaRWhHC+w+pGU
 0juvLJJrAnaxhiz9j3pX2o7C/HRAlyislhSE56+Ef6FkCLAqXDkcJ7khy8QApEjvWO8d
 cqda/OkNX4fsJ/gzjWanrtCJei4vNWHR5ji5sUPyR3w8m9Z1lBLz3vCvibcxsb/UNFx+
 tBCvNA0zDFoJNtjxUntHY5PBqs5XYI8G4wXJ8du5Vml/dBCwajYOMfvBIW7Zv4RfB/U5
 E4Sg==
X-Gm-Message-State: AOJu0YypwUQQmirI9ku648LsC8HfpSW3ZWNQOWgsJz/RezirycfWxNrZ
 zZe3BatFzJgdTpB7vd0aLwk7/DgpWqNOVrC5/Cunb8gHvwm5lBuzHT/puDzdiDJxWDrjK8S8YSh
 T
X-Gm-Gg: ASbGnctwRe6yG2O0j5982E6CslvlU7+sh2dkCf2smXL2ZesQ6kOwHAaGPkLJ/PEBNbT
 hxF1Mi7Fe/JbqkHo99yzF+nzJwpM6AUQo9B6VjPR7lkUaK1ocVtetIIClAHt+fvhilLiCfhgS4h
 VQOWAtqF9znffFVEjkuVmuhpJXt2zAvZG52fKx0XQyHBuZZ7datasonFkewcVmCkIwBNy3K8Z9q
 KXRbqiYRshsKvYdqO/gxogZZymupuDdtNXEhZfYCb8A55n0jjrxMULJEuiLfgevKsON9OrxqNay
 K7g8UnT0WgIQrFzNJr3PmPc2ZfQfaDMttFgCnLnp+/7GAx6iEjtnWP1gwn1x7sX2bdQKsOXc2Ts
 =
X-Google-Smtp-Source: AGHT+IH8FVdQwjBao55PZS0VSDl4tdpYSTTq3jGHsuVpKpRb5vsE53KSalB40MUFFqGyko86vH6Y3g==
X-Received: by 2002:a05:6a00:448c:b0:736:592e:795f with SMTP id
 d2e1a72fcca58-74058a20d67mr624109b3a.9.1746134694358; 
 Thu, 01 May 2025 14:24:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 51/59] accel/tcg: Use target_long_bits() in cputlb.c
Date: Thu,  1 May 2025 14:21:05 -0700
Message-ID: <20250501212113.2961531-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b6d6f7975..35c467aace 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/iommu.h"
 #include "accel/tcg/probe.h"
@@ -771,19 +772,19 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 
     assert_cpu_is_self(cpu);
 
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx(cpu, idxmap);
+        return;
+    }
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx(cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
@@ -809,19 +810,19 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     TLBFlushRangeData d, *p;
     CPUState *dst_cpu;
 
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
+        return;
+    }
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
-- 
2.43.0


