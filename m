Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F37D5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PSQ-00077M-LT; Fri, 08 Nov 2024 08:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSM-00075A-AP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSJ-0005aw-6m
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so18945015e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731074117; x=1731678917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9HEmAt5PwpOdPxQx3Mt4EnQUNxTYqpsNGqlaKkatdo=;
 b=gJ/ZFid3p9GBlG5b9ZsQA9mVoH5iCxSq5tkiOAgDRcpE5iILrWF7bVunLFMV6XatSj
 JqmxGEbTMkTSztEvFlDKg6lOfyDCKaaSaoPzkJ/3Tt7Onnyla6URXK551IBx72YNns49
 +9Q+Oi3sJHbgqvTAoz5kpNP31KBGgpcFj58qOfEkFYbvXWgjBZCFsMIm+1/34uF+7uGo
 yvQVSfk/7RpvbUdD+L44ZvA7wC18+szJgX74eJe6Gte3p9tiLs5qloZpIXtKv+ubYHDU
 OWwDf7oN89dhvtVK4SV0M884wksz1L2H2qHk9JYf+MaRpAaln9R969pczufHKUbQR/VI
 FWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074117; x=1731678917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9HEmAt5PwpOdPxQx3Mt4EnQUNxTYqpsNGqlaKkatdo=;
 b=f3CeECnSg/8druyEHFDNUlehtw8v3d5Jq981nIticVvwuOPg8jNpcnT4WMVFGyv9aH
 BYgX6J5jjAjr9ajg/jt1PxLQROiX6g5d1TUpCMEo3KbAp0xbIgMGJ2mkoPmxClxsECO+
 dvY12RoBgTHIXUnMfqYjpZf8uNgm/79MZBPV+nh01Gp3SPjYfteiPha5DmDiVKA+TVIy
 UB4WM4F0R3EESwWWSQsAXVtPlTq1t0mK/S+ByFD15PiZql2dnSm2S+9D8iA5DQnEMT0W
 IEspJNaFNUI5btO5V6+bCL8IwRfJ2dPLtv+odo3Kfh7+i/jyAU4DYFKQqOj+iI/ClD1A
 CkzQ==
X-Gm-Message-State: AOJu0Ywo1D/as2aOCCLFHggoAPvJ2f7b5yhkPQnIRASkrnPeGW7VVWt4
 X8UWL1Xgq5b65UxVHZIr66fouGfuoNA2Qo1zSUS6nHVeyYglcrcBtaYBqpnij4+6agQX1hI/RT3
 q
X-Google-Smtp-Source: AGHT+IFx9amY3L1g31TYcovcX2/zmSMf7J09PjsD9fEqdcbWZyR6XR3rN0ulOxvQODBkLi1a0NP/WA==
X-Received: by 2002:a05:6000:4027:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-381f17212c7mr2324020f8f.16.1731074117196; 
 Fri, 08 Nov 2024 05:55:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a2ccsm110082855e9.31.2024.11.08.05.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:55:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] hw/intc/arm_gicv3: Use bitops.h uint32_t bit array
 functions
Date: Fri,  8 Nov 2024 13:55:13 +0000
Message-Id: <20241108135514.4006953-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108135514.4006953-1-peter.maydell@linaro.org>
References: <20241108135514.4006953-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Now we have official uint32_t bit array functions in bitops.h, use
them instead of the hand-rolled local versions.

We retain gic_bmp_replace_bit() because bitops doesn't provide that
specific functionality.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h | 54 ++++++++----------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index cd09bee3bc4..a3d6a0e5077 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -51,13 +51,13 @@
 /* Maximum number of list registers (architectural limit) */
 #define GICV3_LR_MAX 16
 
-/* For some distributor fields we want to model the array of 32-bit
+/*
+ * For some distributor fields we want to model the array of 32-bit
  * register values which hold various bitmaps corresponding to enabled,
- * pending, etc bits. These macros and functions facilitate that; the
- * APIs are generally modelled on the generic bitmap.h functions
- * (which are unsuitable here because they use 'unsigned long' as the
- * underlying storage type, which is very awkward when you need to
- * access the data as 32-bit values.)
+ * pending, etc bits. We use the set_bit32() etc family of functions
+ * from bitops.h for this. For a few cases we need to implement some
+ * extra operations.
+ *
  * Each bitmap contains a bit for each interrupt. Although there is
  * space for the PPIs and SGIs, those bits (the first 32) are never
  * used as that state lives in the redistributor. The unused bits are
@@ -65,39 +65,13 @@
  * avoids bugs where we forget to subtract GIC_INTERNAL from an
  * interrupt number.
  */
-#define GICV3_BMP_SIZE DIV_ROUND_UP(GICV3_MAXIRQ, 32)
-
-#define GIC_DECLARE_BITMAP(name) \
-    uint32_t name[GICV3_BMP_SIZE]
-
-#define GIC_BIT_MASK(nr) (1U << ((nr) % 32))
-#define GIC_BIT_WORD(nr) ((nr) / 32)
-
-static inline void gic_bmp_set_bit(int nr, uint32_t *addr)
-{
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
-
-    *p |= mask;
-}
-
-static inline void gic_bmp_clear_bit(int nr, uint32_t *addr)
-{
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
-
-    *p &= ~mask;
-}
-
-static inline int gic_bmp_test_bit(int nr, const uint32_t *addr)
-{
-    return 1U & (addr[GIC_BIT_WORD(nr)] >> (nr & 31));
-}
+#define GIC_DECLARE_BITMAP(name) DECLARE_BITMAP32(name, GICV3_MAXIRQ)
+#define GICV3_BMP_SIZE BITS_TO_U32S(GICV3_MAXIRQ)
 
 static inline void gic_bmp_replace_bit(int nr, uint32_t *addr, int val)
 {
-    uint32_t mask = GIC_BIT_MASK(nr);
-    uint32_t *p = addr + GIC_BIT_WORD(nr);
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
 
     *p &= ~mask;
     *p |= (val & 1U) << (nr % 32);
@@ -106,7 +80,7 @@ static inline void gic_bmp_replace_bit(int nr, uint32_t *addr, int val)
 /* Return a pointer to the 32-bit word containing the specified bit. */
 static inline uint32_t *gic_bmp_ptr32(uint32_t *addr, int nr)
 {
-    return addr + GIC_BIT_WORD(nr);
+    return addr + BIT32_WORD(nr);
 }
 
 typedef struct GICv3State GICv3State;
@@ -301,15 +275,15 @@ struct GICv3State {
 #define GICV3_BITMAP_ACCESSORS(BMP)                                     \
     static inline void gicv3_gicd_##BMP##_set(GICv3State *s, int irq)   \
     {                                                                   \
-        gic_bmp_set_bit(irq, s->BMP);                                   \
+        set_bit32(irq, s->BMP);                                         \
     }                                                                   \
     static inline int gicv3_gicd_##BMP##_test(GICv3State *s, int irq)   \
     {                                                                   \
-        return gic_bmp_test_bit(irq, s->BMP);                           \
+        return test_bit32(irq, s->BMP);                                 \
     }                                                                   \
     static inline void gicv3_gicd_##BMP##_clear(GICv3State *s, int irq) \
     {                                                                   \
-        gic_bmp_clear_bit(irq, s->BMP);                                 \
+        clear_bit32(irq, s->BMP);                                       \
     }                                                                   \
     static inline void gicv3_gicd_##BMP##_replace(GICv3State *s,        \
                                                   int irq, int value)   \
-- 
2.34.1


