Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1124C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Qe-0005RS-4d; Tue, 07 Jul 2026 11:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7Qb-0005Q3-Hc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:41 -0400
Received: from mail-wm2-x02.google.com ([2a00:1450:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7QZ-0006Od-60
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:41 -0400
Received: by mail-wm2-x02.google.com with SMTP id
 5b1f17b1804b1-493b9643ab5so3479245e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783436978; x=1784041778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBb3xLV/5YedzzzrUj5U071p8Cemdeb+/y1/TOle2Oo=;
 b=C3ufMsd8/CsRHuZeJD24vErkN8EMkimaBv3K3XZ+N2qC/zajwFcf+hpsEp2g7yDPQZ
 gVtLPJ0KS+B5CgDmQakd8J4K9rcJOsGRhO6w2D+h5JuGlamoMBQ5kq16sxeD2oSTkruW
 Io66Rw/HT1JRARDN8qaX+3L2Zxq4rhQhjL6IELPxBSwt+VUKw7IJlteLUIq2U/iJvqRT
 anDcwI+V90LDEWAY0Wki9DjCRhSUv5oY5R6iPHSSDco7A986kY+KtbNb+1Jja2glgZAh
 O6HzF4ZcVB4aaVUlGdaJAkn4sDyfV1fAbdPaS2P7K6tpDwSq9hHFJP4IlBRhlA2c8Tjg
 5x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436978; x=1784041778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBb3xLV/5YedzzzrUj5U071p8Cemdeb+/y1/TOle2Oo=;
 b=LsDh03XmX9AHyNwJCky/cLdKGqS2jzcwdG5/MyS2usX4shlMiioHxlBNjELDWI7uYW
 yohsp8CGwyLsjQdvtkzdBpQy+o/KStXH2cmHy/FRDrUx0EqDhazG2eqx2S52I3Sb8bqN
 rjar7SWKYmcCSBNLjEwZKwj8TXiE7kyKsgZEQfPR3mvzDyCdBVQyUb1iYXjZQDEcuY95
 Lk/lyftu+8LAkbrDIBf81bS/R1IjvUxC2rgO1851JUcrYCvX4oJviJlGLd66lLeldlvO
 TgwFecuZjawgIEU+lZM4fRiOJ8k2QIQ1BB8mkE2STFZQLJ6Erp3Pve2nykfzLUCYfWD7
 tRPg==
X-Gm-Message-State: AOJu0YyT/w+rMpCyuvjGmzFGZ4OGDM3gEeII6pRx/2Wj+Sr6CKzEI4cY
 sQ+fQe1Ehl+lM4jHmIALcZ+d0vGlWdJbgm+OrsAKPh0Rv6b2pVCsHuwb38QeNIVhe7bxgqsbq7p
 +mXwvNxdDKuJi
X-Gm-Gg: AfdE7cl3f8qIhuuYmdJxOtcnE6k9QlYTA2OfRLhxmxJTK7ZNnV2m+FO0rdwTyQJoUxc
 AlhVsncNmTWXHO+35px+HS7iDpPFK66zlbO7m2N2k3d1B/Qh5s5Z7MUTq/1tcUYU7ZcMtuFv0ov
 WaeRJOPvR4TlYAaMOAPNt+LJXoptOW03r5ffJSeLAHqFOrjOf779o4b+Ysp4BTA6XOF2YUPYtWu
 MrWVXgPOKslVIBlzRv6eGjaRysss+oNXwcRCM6/FXh4qZxzWA5ErLJysc0E4fhANesJ51JPs/ew
 z7Ez02bG47aZeCB+Ur8aKEUEJywRyzfoaY6bW43I7gI8PvWk5JfZYtOrkyswyU/YcWHajrRwaTg
 NBhSG6pQAGPBnAePWdu5qOLkhOegPerTdGlT3leAMFz8FSfaIQDOAjRe+Wze+h+UEFGCo8ksnXy
 SSK+sYuCCLegfoaG6L2CjSM+iJjw89uFtwxpcotKzH0cLwjixcURGAWCU0yYPZCKws97hIOoaq1
 8RoeCuXHcmTC3NCMhOh/g==
X-Received: by 2002:a5d:518b:0:b0:476:dd2b:611 with SMTP id
 ffacd0b85a97d-47de668ef11mr5072409f8f.3.1783436977617; 
 Tue, 07 Jul 2026 08:09:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm34181813f8f.8.2026.07.07.08.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:09:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/3] hw/display/sm501: Avoid overflow problems in bounds check
 calculations
Date: Tue,  7 Jul 2026 16:09:32 +0100
Message-ID: <20260707150933.1410507-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707150933.1410507-1-peter.maydell@linaro.org>
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::2;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When we check that a 2D rectangle operation isn't going to run off
the end of video RAM, we do the calculations as 32 bit arithmetic.
This means that carefully chosen guest register values can cause an
overflow so we don't detect that the operation is going to go outside
video memory.

Abstract the check out into a function, do the calculations as
64-bit arithmetic, and add assertions about the ranges of the
inputs.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3920
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/sm501.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0da25477bc..d5e165daef 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -682,6 +682,28 @@ static inline void hwc_invalidate(SM501State *s, int crt)
                             get_fb_addr(s, crt) + start, end - start);
 }
 
+static bool sm501_rect_outside_vram(SM501State *s, uint32_t base,
+                                    uint32_t x, uint32_t y,
+                                    uint32_t width, uint32_t height,
+                                    uint32_t pitch, uint32_t bypp)
+{
+    /*
+     * Return true if the 2D area specified by the arguments is
+     * partially or completely outside the VRAM (a guest error)
+     *
+     * Limits on the input sizes mean we can't overflow as long as
+     * we do all the arithmetic at 64 bits.
+     */
+    uint64_t rect_size, last_addr;
+
+    assert(x <= UINT16_MAX && y <= UINT16_MAX && height <= UINT16_MAX &&
+           pitch <= UINT16_MAX && bypp <= 8);
+    rect_size = (((uint64_t)y + height) * pitch + x + width) * bypp;
+    last_addr = base + rect_size;
+
+    return last_addr >= get_local_mem_size(s);
+}
+
 static void sm501_2d_operation(SM501State *s)
 {
     int cmd = (s->twoD_control >> 16) & 0x1F;
@@ -731,9 +753,8 @@ static void sm501_2d_operation(SM501State *s)
         dst_y -= height - 1;
     }
 
-    if (dst_base >= get_local_mem_size(s) ||
-        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) * bypp >=
-        get_local_mem_size(s)) {
+    if (sm501_rect_outside_vram(s, dst_base, dst_x, dst_y, width, height,
+                                dst_pitch, bypp)) {
         qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
         return;
     }
@@ -760,9 +781,8 @@ static void sm501_2d_operation(SM501State *s)
             src_y -= height - 1;
         }
 
-        if (src_base >= get_local_mem_size(s) ||
-            src_base + (src_x + width + (src_y + height) * src_pitch) * bypp >=
-            get_local_mem_size(s)) {
+        if (sm501_rect_outside_vram(s, src_base, src_x, src_y, width, height,
+                                    src_pitch, bypp)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "sm501: 2D op src is outside vram.\n");
             return;
-- 
2.43.0


