Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26655C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyl-0005e7-N3; Tue, 28 Jul 2026 08:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyO-0005U9-Oh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyL-00038a-Hr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso846134f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241908; x=1785846708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+NA8drOMvPbg/W0pIEUVm9ErLpNSN5tCGIppYnQUqw=;
 b=OfaNPHXdnRF9ZJyAxj3GJ0VTbjMBorSYvnuM7Fe8OhcjvRJXGX881IMXZE7tP8g/Tg
 0xY2k0O2FJiieZEJGicxnfMJlc3IY2c3F7A9uKWwc760KS1G9x8ZlcQxhDBBrwrMSY2f
 pq70n+u46qFWTBS5AEwXP1cY4PlU5uEOuoEaKMWMGyusm5wus74E2lOgAQ40SXup751w
 HY5ZORbExjezfoW5kjuFBMzMqaaARnYp3sEQyOWB6O8P1LK8fOYXdErBvYZxoxfQ6A+6
 psAKRePA1Y2Q7efZ7tpZc0o5YdMrcEdUgMUlk8icMv9PYcVcqjT0eoNnjdj/ENAiznCs
 42Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241908; x=1785846708;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z+NA8drOMvPbg/W0pIEUVm9ErLpNSN5tCGIppYnQUqw=;
 b=WKCVhE6IQEzLm6ZBvEpnenB2lPuGOLVOmJbZ/XIVR9ZcJxd0Xu3DnsV4aZmeaMlgyT
 CS7zeMRNgaHm0di1TokYPniRc+urSSr0k8xso4N7jYoohHwFva9A4j8hyexoCq8dkHrQ
 RHnRoXD42N73ly4QdpBTtLYAhUthLaNQoRv19rWCeEn6hL6Nsihmu3lcFdPzO91jXcck
 ZJTyDnUeqasq+GKdi+U17rG6BmmEj11fO5DxF5z1wBYvh4E2etkZe6XM5FGxA5kGg8AY
 lOFAmeCQ3g3t9aWptxFBnqykR8ZrcT0rfqgfVaXsXmWKH2tN1SyorNt/MRqiaF4+6JP2
 h3mQ==
X-Gm-Message-State: AOJu0YxIaO0vkntcC57iBzzRL4PVo+v8GW+sPZibhZZ03jh6N2+/D9N9
 jP4M9KkyETgheoS+Mrh//wDs4eR9jwUJ8E/82a+XMzjQ74sMDOLb0Ecg3GOOc2ho6x0c17hqDc1
 hDw15
X-Gm-Gg: AR+sD111R9RwXS8iyAi8Dqb8Pyl+0N+SVWSz2LsWvMbxpolR8ai5bIv8xM+9ScLESr8
 wpdF9i7MeOIYj0Jjk7D5z30Cp2QWwO4BvY2pfH1UmVZ6Z4gad0PxaBhqSphmLCyVKsxjjnPN+eI
 E2s5O7HvcU5lDfgzbmilXgvsWZTHY69FinyWAUbmJeniFS98JvjL68vuPkXF6C4NF6kaz1FeRtq
 o6bsVGXPGKCpZLoa9ddQhstbSug+R7Orv5zgZ9R73VGhGVMx6ijgiSvVK9IaAGSpv8epdFqbe2d
 1F75O8b+0T1RQ5f2lEjZLbXqEkwYJU+83wAvKSQW2C7w3+HkYBPm1olDA7ZE8vs/u2p5/F0GX5m
 VEypw1O8hAAaktFsPcAvYo7OBh6eUf5NKZJfdudgYkE+kpH3bebQpV2VkunNneSa/JtiAOSaK9B
 FuZYEDIjrc02xVy4X/4W8MQtz3+FrdcvZHbjDsQMVWtPsG+ODiW8fm+iToxhxqB84eJBa4mrbGj
 PeY8bwAQSw=
X-Received: by 2002:a05:6000:310a:b0:47f:6e8b:699c with SMTP id
 ffacd0b85a97d-47fb1ecab50mr2686444f8f.14.1785241907769; 
 Tue, 28 Jul 2026 05:31:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] hw/display/exynos4210_fimd: Factor out finding screen
 width/height
Date: Tue, 28 Jul 2026 13:31:25 +0100
Message-ID: <20260728123127.1711653-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Currently we hard-code the expressions for getting the global screen
width and height out of the VIDTCON2 register where we need them.
Use functions instead.  Make the global_width variable in
exynos4210_fimd_update() uint32_t for consistency.  (The values are
clamped to well below INT_MAX, so there is no overflow risk here.)

Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-2-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 7507e4fd3ca..43ad5fa0b46 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1195,15 +1195,25 @@ static void exynos4210_fimd_update_irq(Exynos4210fimdState *s)
     }
 }
 
+static uint32_t exynos4210_fimd_global_width(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
+static uint32_t exynos4210_fimd_global_height(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
 static void exynos4210_update_resolution(Exynos4210fimdState *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->console);
 
     /* LCD resolution is stored in VIDEO TIME CONTROL REGISTER 2 */
-    uint32_t width = ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
-    uint32_t height = ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
+    uint32_t width = exynos4210_fimd_global_width(s);
+    uint32_t height = exynos4210_fimd_global_height(s);
 
     if (s->ifb == NULL || surface_width(surface) != width ||
             surface_height(surface) != height) {
@@ -1229,14 +1239,14 @@ static bool exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    int global_width;
+    uint32_t global_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
         return true;
     }
 
-    global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
+    global_width = exynos4210_fimd_global_width(s);
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
-- 
2.43.0


