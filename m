Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50622F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYZ-0008CR-UC; Mon, 23 Mar 2026 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYS-0007gz-OS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYR-0000in-40
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso3203535e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284901; x=1774889701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ioqUJCbmJfeCQyicE47R1nMMQxu4wy5T8sm43npFB3E=;
 b=EYVUu+Qqd+guA/EpxPKbuR9VcpI7cgpMvT2H9gmX0YnI6vYFfuOgmxcOQ7V18XhMzk
 VjhzQJk/H/iwRzhDFOZKeJxS+bCC/olynH2Ss/0LDWWKbe9Kz4uLng9/Yd8qYahVPnWR
 AxZh3Z7Jrv67dcL23qFK9w103GeCJtKg4TXRCaDu3fjcBTer7uqfLmbKIs8GJRtJC2SQ
 x0oH2TAEdrweJRNxsfelsX737Jp2f/1yV8JyqobrpTTFDCWwr1HBHaC1heBVOjDI/0K8
 V+rqc3y8T/K6DxFSQj/8vhxsP4+D7sIBgRryZzexFWtSVNVo1OgpARPDGU9ZpyHWTHSU
 IpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284901; x=1774889701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ioqUJCbmJfeCQyicE47R1nMMQxu4wy5T8sm43npFB3E=;
 b=LIISsK/n5y0HdSgLhSJTcKTgsNGMsMsGW9aAq+Z2EZvfjs40QKCYcrTk0G35YJn6Vq
 zztSF9jvNahCNkwVkNS8VlU5ZuskckL7OiFaJ2iPhaXorl1s5gkdOaktShfkkP4zgFLO
 uHeIYq7osfFhb05WBmHxP0HDXVe1CTxep/lkPkNqbZLS7tlXBzNi6rsYB6ZPbLnwZv7a
 +o/0m0L6Y5gKr7N3HbRddSdIMKlhqLes3n4XofaYvcB3rfwKb73uwMxcOuiKJlLKcCN3
 BZ3Q3PUB3opJ8Xp65wtq+DDT58aX/dloKA+EsGXG0QTn/9LHC03oS+CgHuEKlkxh382J
 ZVzQ==
X-Gm-Message-State: AOJu0YxPkosJ0KGYcafEDTbvdr6Y0enSTdNxJV0F4geJDQWi857nrvTq
 et01p9LmvKwsq1bAzS4rLmmL+zwleVzqDhGV3eFkh/nr8pahCR3Dm/BhMe8UFVwEjYw3I9BXZcP
 bYM7QCNc=
X-Gm-Gg: ATEYQzzv5/s2PExXjbcZC4UGHYo+kWI3HEVWg8IOQSdexp7db6wdlfQTKanlsCcRSSf
 hmEVkH8cWM2uSPUvW4DTWJZGjMOGub1SeGxm2sgdQHwe457MqVft900LnkKf6rp7/qjC798yC+E
 gUFxOxwGQa4BRZSV/cd5/gkWtLek2IkazKK1ESk6qmqLRKikLOZuexOk5pNsDiu+kslZ18/Cf2i
 JgTD83JSFhwhVjWixpF50bFp39pfh7rVbOaMDV8siryVJK3xcX8kI9+FqXvEfHhDPrzvFwTDb3P
 c6vueXNYKzk/ZlMkrVUMTBwNsovtpXQlPiYQOrz5b0MGp0aC3CxhR5kIcVRogwYpR0ga43Nq9LV
 idcXqHaldq33XDc1rs6IOtUKl44R/rjehV7wG9+aVf2RZzOW012DnKwMhUgxfbswBPmbGmwG70E
 Hqxc5srU8KKLCgP0qpz0Ov3pFae5s/BWDzLv5RZMjsHjQpLrSTERxp7YDoJwPAy6nwHnP8IEe3
X-Received: by 2002:a05:600c:c083:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-486fedf9be6mr141830765e9.10.1774284900998; 
 Mon, 23 Mar 2026 09:55:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm562206375e9.7.2026.03.23.09.55.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:55:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/27] ati-vga: Make sure hardware cursor data is within vram
Date: Mon, 23 Mar 2026 17:52:15 +0100
Message-ID: <20260323165218.96607-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add check to make sure we don't read past the end of vram when getting
mouse pointer image.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <2ecf42bdeb96a4206b27dc39b3ff13cc8a6190d0.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c054c9aa7a2..fc19737d1f0 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -150,6 +150,9 @@ static void ati_cursor_define(ATIVGAState *s)
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
+    if (srcoff + 64 * 16 > s->vga.vram_size) {
+        return;
+    }
     for (int i = 0; i < 64; i++, srcoff += 16) {
         data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
         data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
@@ -204,6 +207,9 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     }
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
+    if (srcoff + 16 > s->vga.vram_size) {
+        return;
+    }
     dp = &dp[vga->hw_cursor_x];
     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
     abits = ldq_be_p(&vga->vram_ptr[srcoff]);
-- 
2.53.0


