Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E4CFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdml-0006JK-J4; Wed, 22 Apr 2026 16:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmA-0004cv-Su
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdm9-0003Nj-Cc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso65391315e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888140; x=1777492940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTP8G/3syFvWMTvC3Oy537xBcJoeDL0PeXldlkypUIc=;
 b=Gvoey9IyQXd2lSiVm+eAif12FzuPuDs+xHv0ixCT+1c9RBXK5pUwhIRt1zAY3nDcQM
 q7p+PpucF7vAzUUsk7yNCO9PgJNUw0w4H5PxA2vjoQjTx5N/byI0MHxMHUgd1rXxxng4
 r/Vt1y+d4C6dgeHpq7be9tEK9X25mIFlnCQXIUrhlzlO+iV17/MSHZCu7MUcZe4y5G84
 FYv0DQv1zCWQ8jINY262UC41Eqjd40XJsej+JNDVGmLCeveVL/7k1g4lECET7e2HytRC
 RW+mBeUmHU7EULufPUzY6D5s8pz52h/sg+6QQuwDG4ilomVT20bq/YkiO6KK8p0stbgl
 GnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888140; x=1777492940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RTP8G/3syFvWMTvC3Oy537xBcJoeDL0PeXldlkypUIc=;
 b=jQVqy8dzx0RIzC1RerTz9BslQxCsJtARhiQg1iqEi5VFCfoXnL+5R7QdJgF1DOFTLw
 Dmj6foq7/E8XBcjKr7EhGd7p8Z53/YEIW6RS7CeNDQYXpabKRMwMVwFvcziRGfUT9sOP
 oBLyN91ACacHVstAJJF58kwX1YxkQ9fHfKftugRy+BZMztXfBg47nl6IFFe9BY4MxujG
 D3WSztMbTYCakr9WuzwhFdZ1mTsRWtqj3ZPovDntvTSoab5g1bZZtnM7eA9YPVNcwHFe
 c8D33zMbHLql/s6+RoEB+dMMmyofla6Z7c5q90jF+vb7ahP8Y8CsCyuutsL/0T6DQuDH
 mUGw==
X-Gm-Message-State: AOJu0YwiVisCYLaaY++lBYvWdE+2hWgz0fIH/0e6sjuwXWf7jUwhr8Cr
 +68T7pAU9z01mBTfhThL9CMjXK9ZLvsZ3M84F1OiT2edaZTcBw8c3YRIUmBycBGXM2NWgkQWqqx
 uLyhA47U=
X-Gm-Gg: AeBDieuAoxrGLgAsAwr/0I1ieadJYpGekYuVJC80cRr20E4LBo4UaThvZyGnW7a2cJP
 Ye6banVb6qF8vaMSn6CE+G76o9XUijTcHi2AXTfkRtTN0s1ABDta7u3/yOtw0+6U0eU5CFzDT1q
 PxwcFovNJ0RC2u4FqEkQJy7d2hrGSFan4ioVhKt2XnInzMiCffCQPdbryEhg+wirgqSX+XTgUBo
 B/XjYbN+ufpMpcZCr+/0u/PHs6LHuKkFdlhBL5XeczdAla60aDBvN9pJQ7hc9FD0Rp5KdxgEaUi
 y7qvC5kpyXlF+AKF7YPopU1nwS5Dskt2eOcDYKlMXjEYYmwbZLDnNVWk4yJhH7OjZMWzGhucfmf
 rhaJJvUZhqB8HqGw9zHdG84lfHi7dxehryrW0y93RrutAKWFQD/KHU+hrWxbTERhILNRouW0wTB
 O7llunbCHQKV1nWZeGf3d1PAxUSgQQDSC2G3oXJLfFF4TwO5AmYCnd+nCgPDxMet4FAtbtjCcyC
 xBKK0Crjok=
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id
 5b1f17b1804b1-4890e49f7d8mr161664245e9.17.1776888139542; 
 Wed, 22 Apr 2026 13:02:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm196110925e9.8.2026.04.22.13.02.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/48] ati-vga: fix unsigned integer overflow in cursor bounds
 checks
Date: Wed, 22 Apr 2026 21:57:36 +0200
Message-ID: <20260422195746.88865-39-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Junjie Cao <junjie.cao@intel.com>

The cursor bounds checks compare (srcoff + N) against vram_size, but
both sides are uint32_t so the addition can wrap past UINT32_MAX when
srcoff underflows from the cur_hv_offs subtraction, causing the check
to be bypassed.

Rewrite the checks as (srcoff > vram_size - N) to avoid the
overflow-prone addition, matching the style already used in
ati_mm_read() and ati_mm_write().

Cc: qemu-stable@nongnu.org
Fixes: 2f1fbe6ee9b5 ("ati-vga: Make sure hardware cursor data is within vram")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <20260414141458.1076014-1-junjie.cao@intel.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 88a5bbbf07a..0489995d00b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -149,7 +149,7 @@ static void ati_cursor_define(ATIVGAState *s)
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
-    if (srcoff + 64 * 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 64 * 16) {
         return;
     }
     for (int i = 0; i < 64; i++, srcoff += 16) {
@@ -206,7 +206,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     }
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
-    if (srcoff + 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 16) {
         return;
     }
     dp = &dp[vga->hw_cursor_x];
-- 
2.53.0


