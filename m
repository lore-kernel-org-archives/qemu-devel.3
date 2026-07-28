Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F993C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyg-0005c0-1R; Tue, 28 Jul 2026 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyQ-0005UU-KU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyM-00038u-TV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47de008b020so661227f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241909; x=1785846709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EU0Hj2x+C1JG5dyuVzTNdAuVbO3iH0ap19MHXO+1nAE=;
 b=gvpN0X9ciJU/CKUuDrQea9W180IlDunQbVDQzkS8h9Z2mu5kaxNmQnVTVepnMJaji4
 IV5b6yYx/6oKn0C26Gctpa3dAP5kMZwEZSuYrsiUZmDdF5N1nQSRK1s0daWr2BjL/juu
 +ha19PhoLt7P3v1QM+TIlh6he+gr9kwLvDw517LO9p27eYx3shXRFC5AJGwgzoE1/bY6
 7xjsROG+O09ggcdl4ePSMEz7vrfk4XgjBDyvkv1qfEhQ4LdZjU6sVcAWNAuS07fmXXR8
 Kdn5SZUtvgigjcIKOFoajm2UgZiZPSlW4U1Rs8qE8EUI4QqTYI5LfxnsaCJoMVXPTZrZ
 6QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241909; x=1785846709;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EU0Hj2x+C1JG5dyuVzTNdAuVbO3iH0ap19MHXO+1nAE=;
 b=nwaGHKqdZAfbMP0YxPEgKIGH3jL/NbEonN1p/1b1N27ITHQEMjrPewAvj/2bUJvn1O
 QgTe9psFPiflmtgyQcMBHOi25bQGOD/MZHvs2JMuORF3xRQNgYVtBTAwSVveKNZ4BqYT
 grzSISD++VMsKcbHzCY+qk2lZOFka41pW/ISe8waMv3KiWZ6hpt2uOgrGo4JSwu5b1tS
 M7fYCwSotxY6iZ8QqwOuhL6RA4YjsdMtMX9q8zdGfTkhuyDehcLr3fSW1pUXyitGSufe
 6gePMADGK624jpNmn9yZzIw1/PJhMN2Qjz06GHMZO5lsiwDM3viyxgyebj7nB/QOeNdJ
 FYcg==
X-Gm-Message-State: AOJu0Yw4MkhuEeK/ftho3zVr3G4zJUFtAJEyil1KZXrVpnisUYPtFz7X
 WcSU5k5C2m8/TD2rk1oduB+A6/tBvxcsddA+z+RohFdxhP8wjGvKBU+WXuTUo5OuRMr7kFm/hDD
 t8SUa
X-Gm-Gg: AR+sD10q5aEtX8CkC14/9ceT6wFkR96kcGVpx4wbi8EjUpGbNdWyykEgids+scZZA9c
 Iex7zFj1KYvXLUJO6sko81Fr33KnNpimJzh0No+xgTzMj99YPebSGxdyJnNJq+hoz/N/uUCt7r1
 eI1bIYcjZmi2Dq1PQziYAAQQ7+sgFEvsHH+YD0jSbsCCYKMjJVbzyNri4upsQf18v1YXE7QHLyd
 v+8cWg7KIqCfs/jvUtAAr3SzliobJ7lvDTszlVsYeF9MUXl5a7TMurcWcUMmWHb8xRVZ6dPFWQx
 dyiU2HofbcAYdZySoUJm5syiKeGInmegH0C9QihlA+a6NOUvrke6FHS7dTCb78BsRSAZ2IkwLm5
 mGbfDa/jR4BJCRaoT2V6SQsQppw5sizovlagN30irZKD7VvvpUPTHA4nheujaCMzNMqvO0rxtEC
 k8qr5tC31OO84c2fnLRu1DUG0e2qFTjt77+YEtqD3HPash15mnUR0NhtzUjBVkr9ZOc56GHiBAg
 Q9KyxKeXuI=
X-Received: by 2002:a5d:5f51:0:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-47fb1e9992amr2872885f8f.12.1785241909500; 
 Tue, 28 Jul 2026 05:31:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] hw/display/exynos4210_fimd: Clamp windows to screen size
Date: Tue, 28 Jul 2026 13:31:27 +0100
Message-ID: <20260728123127.1711653-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In exynos4210_fimd_update(), we iterate through the enabled windows,
blitting them to the screen. We assume here that the guest has not
programmed the window's coordinates to be outside the overall LCD
screen resulation, but we never check this. This can result in the
guest being able to cause us to access outside our allocated
framebuffer backing memory.

Since all the coordinates here are unsigned, they can't be off
the left/top side of the screen, only the bottom/right. If
the top left corner of the window is out of bounds, the whole
window is invisible and we can skip it. If the bottom right
corner is out of bounds, we clamp it to the screen size so that
we only draw the visible part.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3795
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-4-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 52f2285cf51..6c062a28c02 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1237,7 +1237,7 @@ static bool exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    uint32_t global_width;
+    uint32_t global_width, global_height;
     uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
@@ -1246,16 +1246,28 @@ static bool exynos4210_fimd_update(void *opaque)
     }
 
     global_width = exynos4210_fimd_global_width(s);
+    global_height = exynos4210_fimd_global_height(s);
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
     for (i = 0; i < NUM_OF_WINDOWS; i++) {
         w = &s->window[i];
         if ((w->wincon & FIMD_WINCON_ENWIN) && w->host_fb_addr) {
-            scrn_height = w->rightbot_y - w->lefttop_y + 1;
+            uint32_t rightbot_x, rightbot_y;
+
+            if (w->lefttop_x >= global_width ||
+                w->lefttop_y >= global_height) {
+                /* Guest has put the window entirely offscreen: ignore */
+                continue;
+            }
+
+            /* Clamp right corner coords to be within the screen */
+            rightbot_x = MIN(w->rightbot_x, global_width - 1);
+            rightbot_y = MIN(w->rightbot_y, global_height - 1);
+            scrn_height = rightbot_y - w->lefttop_y + 1;
             scrn_width = w->virtpage_width;
             /* Number of bytes to actually draw */
-            window_width = w->rightbot_x - w->lefttop_x + 1;
+            window_width = rightbot_x - w->lefttop_x + 1;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
             host_fb_addr = w->host_fb_addr;
-- 
2.43.0


