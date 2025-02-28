Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAABC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 19:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to5r3-000643-P4; Fri, 28 Feb 2025 14:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to5r1-000639-Bn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 14:16:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to5qz-0003RH-0R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 14:16:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439a331d981so22941355e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740770214; x=1741375014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fjU1scoyfl5EIaSm+J9opU/tuOBrWqDEPnsrPZdjWm0=;
 b=EJXbjtBQh2mLY5ncNR986r9+bL3awggca5Ucl9ZAK3NOmyCM8wZ2uCkL8/onTtqN4Q
 UbWnzgFmltDVkHxl4EZL9rRClbOxWHymGS1H/CDCFOp41ZsrPXT0tvwmvuZsNcE00xiS
 aHqPGhWue0Q2hJtAozdJgDCQNlreZwSuFxGjogDZYCrumX63sOSuk/RHY8fbVyQlaSq/
 O1jzvP8zgAhBqy59GweyiCkhoFPw3jAiara6QG3L4NP6hZX6QlyjUZ2yWUGBt6YtZmfR
 IecJc7Ke7ZTh0V50//Mut1+r+bpVvdzdfqXXk+VBnvx+IbRHDohwmJTzbQV0yf6KM5b9
 Q8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740770214; x=1741375014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjU1scoyfl5EIaSm+J9opU/tuOBrWqDEPnsrPZdjWm0=;
 b=CadsTa8xrOED3r987cPgzWeDu09mqgz/o48L6QR2SGhq7+O4Xrs/AjP6qp5z6drs2y
 qLW/6eXDPo1Qo/xgBFoNCRKQ4xsCrLbRdrPkKemC5XcqgZMkXbLWf6R1/qx+wjeBYLWF
 JWKLQWD2Fp5xEjwUdflwpN0tU8mXMZuAX6OrJbqcPBOqOXJ/yxv8vjOVk63YSfhELKLe
 clfGMBwXN/eEM3XjuQgs5ivM8gk3Qvgyp624Sz4bmBJnQjdpxBmzUKoBo4icI2G7Pgaj
 fl3DRlLjRzaae1SBDW06xigo5CWdDG7OMIndpZqi4FIzyvxjnxJH1MZqbHFaTKvqPrzT
 niRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEEiXzIs4n/QlKxFd3r8sSxo2So7H0uVt9yNpyjEkd+XL1biFJOvTg5njvYtalOdu7seanovCRiEVw@nongnu.org
X-Gm-Message-State: AOJu0YwWPZH+VR9CvXa0zJg14ETqahzJzkcfgqcMVFtLPcI3H6GdtBfp
 dcdIV0tzOOJeZ/uJw5skRBVsnkyN//FThn63Wt1E6Jfa5JIN3HxXbg05+B56PazhAyfD0T/SkpZ
 F
X-Gm-Gg: ASbGncv2PomVAEF7ERCoivQvCKq2et9gULOPasq1ybGs60/AsGiCDiyYoMhwnSkuHei
 px50eTIGZWEj8dc1hwPAirLVpommnaXxbUwXp4W9W+v3X7/VPLia4suyOhMUHX7wSqiYXywL5th
 R6tWYEiM416LuZn4NIusNUPzaQur5q5e9QX2atJlwpBcnrB6qLcAeTkeSdzT2pLTAWC6RSoytHD
 UwLDXjptSUklh6u1eC2YeTgREJoxLmrj7tiLAQW4VraoeoZWulCz0cvA6T+XcAApcMFmvWMyVlM
 F9VlG6ti6u3SKteU4XXGTy4G1iI9Qfi7
X-Google-Smtp-Source: AGHT+IFszYyExaDmdsRHgeNQQjVU+0bMC3pl7E06OZJJ0pA5IrOuZNbTuOOkyPtJSAig1LdHgQ28cA==
X-Received: by 2002:a05:6000:2cd:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-390ec7cd373mr3282103f8f.4.1740770214273; 
 Fri, 28 Feb 2025 11:16:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d6cdsm5980928f8f.84.2025.02.28.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 11:16:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/net/smc91c111: Don't allow data register access to overrun
 buffer
Date: Fri, 28 Feb 2025 19:16:51 +0000
Message-ID: <20250228191652.1957208-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

For accesses to the 91c111 data register, the address within the
packet's data frame is determined by a combination of the pointer
register and the offset used to access the data register, so that you
can access data at effectively wider than byte width.  The pointer
register's pointer field is 11 bits wide, which is exactly the size
to index a 2048-byte data frame.

We weren't quite getting the logic right for ensuring that we end up
with a pointer value to use in the s->data[][] array that isn't out
of bounds:

 * we correctly mask when getting the initial pointer value
 * for the "autoincrement the pointer register" case, we
   correctly mask after adding 1 so that the pointer register
   wraps back around at the 2048 byte mark
 * but for the non-autoincrement case where we have to add the
   low 2 bits of the data register offset, we don't account
   for the possibility that the pointer register is 0x7ff
   and the addition should wrap

Fix this bug by factoring out the "get the p value to use as an array
index" into a function, making it use FIELD macro names rather than
hard-coded constants, and having a utility function that does "add a
value and wrap it" that we can use both for the "autoincrement" and
"add the offset bits" codepaths.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2758
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: 20250228174802.1945417-1-peter.maydell@linaro.org
("hw/net/smc91c111: Fix potential array overflows")

I'd only just sent the other smc91c111 patchset when I found
another fuzzer bug for it in the bug tracker :-)

The "modernisation" of the code seemed clearer to me than
doing a minimal in-place fix (which would look something
like "p = (p + (offset & 3) & 0x7ff;" in both read and write
functions). But it does make the actual bugfix a little less
obvious.

---
 hw/net/smc91c111.c | 65 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 4a8f867d96e..f8012cb3681 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -13,6 +13,7 @@
 #include "net/net.h"
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
+#include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -126,6 +127,13 @@ static const VMStateDescription vmstate_smc91c111 = {
 #define RS_TOOSHORT     0x0400
 #define RS_MULTICAST    0x0001
 
+FIELD(PTR, PTR, 0, 11)
+FIELD(PTR, NOT_EMPTY, 11, 1)
+FIELD(PTR, RESERVED, 12, 1)
+FIELD(PTR, READ, 13, 1)
+FIELD(PTR, AUTOINCR, 14, 1)
+FIELD(PTR, RCV, 15, 1)
+
 static inline bool packetnum_valid(int packet_num)
 {
     return packet_num >= 0 && packet_num < NUM_PACKETS;
@@ -372,6 +380,49 @@ static void smc91c111_reset(DeviceState *dev)
 #define SET_LOW(name, val) s->name = (s->name & 0xff00) | val
 #define SET_HIGH(name, val) s->name = (s->name & 0xff) | (val << 8)
 
+/*
+ * The pointer register's pointer is an 11 bit value (so it exactly
+ * indexes a 2048-byte data frame). Add the specified offset to it,
+ * wrapping around at the 2048 byte mark, and return the resulting
+ * wrapped value. There are flag bits in the top part of the register,
+ * but we can ignore them here as the mask will mask them out.
+ */
+static int ptr_reg_add(smc91c111_state *s, int offset)
+{
+    return (s->ptr + offset) & R_PTR_PTR_MASK;
+}
+
+/*
+ * For an access to the Data Register at @offset, return the
+ * required offset into the packet's data frame. This will
+ * perform the pointer register autoincrement if required, and
+ * guarantees to return an in-bounds offset.
+ */
+static int data_reg_ptr(smc91c111_state *s, int offset)
+{
+    int p;
+
+    if (s->ptr & R_PTR_AUTOINCR_MASK) {
+        /*
+         * Autoincrement: use the current pointer value, and
+         * increment the pointer register's pointer field.
+         */
+        p = FIELD_EX32(s->ptr, PTR, PTR);
+        s->ptr = FIELD_DP32(s->ptr, PTR, PTR, ptr_reg_add(s, 1));
+    } else {
+        /*
+         * No autoincrement: register offset determines which
+         * byte we're addressing. Setting the pointer to the top
+         * of the data buffer and then using the pointer wrapping
+         * to read the bottom byte of the buffer is not something
+         * sensible guest software will do, but the datasheet
+         * doesn't say what the behaviour is, so we don't forbid it.
+         */
+        p = ptr_reg_add(s, offset & 3);
+    }
+    return p;
+}
+
 static void smc91c111_writeb(void *opaque, hwaddr offset,
                              uint32_t value)
 {
@@ -518,12 +569,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
                                   n);
                     return;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x7ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 s->data[n][p] = value;
             }
             return;
@@ -673,12 +719,7 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
                                   n);
                     return 0;
                 }
-                p = s->ptr & 0x07ff;
-                if (s->ptr & 0x4000) {
-                    s->ptr = (s->ptr & 0xf800) | ((s->ptr + 1) & 0x07ff);
-                } else {
-                    p += (offset & 3);
-                }
+                p = data_reg_ptr(s, offset);
                 return s->data[n][p];
             }
         case 12: /* Interrupt status.  */
-- 
2.43.0


