Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE16C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLl-0002QK-Ab; Wed, 22 Jul 2026 08:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLk-0002Px-IH; Wed, 22 Jul 2026 08:47:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLi-0001by-Nl; Wed, 22 Jul 2026 08:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=2qVTxSuD363q38U5X97v0npquu4q2mlyLrPFSROAVQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZVJfL4jHxG17Jwjiq8uwNQXPD/8/NEdWXYh6vsVTpsC7+vAsd1zxqeo6PmNYT7o72
 Y46aNNacWeR0/71h9ikqAy/f3hAD4Shy6g9/33B4du9zr781RtKEmNq4xw4tt4iajF
 imWCmGtkJAzc/sLMyJzynvESvsFdNfFNIBYdhyiQOswvD39oCfjbSx4Cs+3AU9fn3t
 pCnK5F9mYLrlY0isl4yHyDX45PcZcunvD8NHbXjqErzjSiNdwfxvafCnXz4llrwfZd
 BOXTllWRwysIxc9GRjlsksU0QT1DDnhf+3X+CyyxrkTjE5AF1ljmJ8EAPHLAlOde2g
 719PJL4ZVDlPA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 535731C3AFB;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9788C3F3755;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 45B5817EDF; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 082/122] hw/display/sm501: Avoid overflow problems
 in bounds check calculations
Date: Wed, 22 Jul 2026 15:45:31 +0300
Message-ID: <20260722124622.31034-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

When we check that a 2D rectangle operation isn't going to run off
the end of video RAM, we do the calculations as 32 bit arithmetic.
This means that carefully chosen guest register values can cause an
overflow so we don't detect that the operation is going to go outside
video memory.

Abstract the check out into a function, do the calculations as
64-bit arithmetic, and add assertions about the ranges of the
inputs.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3584
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20260707150933.1410507-3-peter.maydell@linaro.org
(cherry picked from commit 422734d5fc2b5adec704b352082385511959d5a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 13ccc4941df..d451a1fe7d7 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -681,6 +681,28 @@ static inline void hwc_invalidate(SM501State *s, int crt)
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
@@ -730,9 +752,8 @@ static void sm501_2d_operation(SM501State *s)
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
@@ -759,9 +780,8 @@ static void sm501_2d_operation(SM501State *s)
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
2.47.3


