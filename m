Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C7D70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGigp-0007ie-Hc; Thu, 28 Nov 2024 12:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGign-0007i8-L9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:52:29 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGigl-0004O2-RX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:52:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso9674075e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816346; x=1733421146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u+IsHVrjSzPn9IoEqVOtBC65NeNmlEiYEpz17kxhMns=;
 b=xlNqQHPd8LXd0mFn2p8m5t0ox/XcVlkMQU44VflY3pgbMfPxZ3AO5pGUmKOQRQUqav
 xTisH7002nXF7xefk9QrY+WHQclLseFDFcBByabJlTa4zUo4CicmFGYgstwIAQsOSJ/h
 yZ3WDyOJLozlIHHloPc9nSygkPF4LW4BtSxHMhfmDF2qFmDOWFV9+jPCc6AiLVr0ypyG
 PF72CEijZXMaDXbafh1cLIY+dk624JqeZUofKoFatU2PT+Ewx8Hs9qleON7+Qri47wcH
 JDr6GEcUEpWR1sArZyMTg94yVd2Z41fw0pJPlE6vKjeYJAvEDT3l3YQkknlBvr78BfFY
 o/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816346; x=1733421146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+IsHVrjSzPn9IoEqVOtBC65NeNmlEiYEpz17kxhMns=;
 b=ag3guiQeZXuGuSckiG1MqCWlJqaiDHuV6rIkSdhhEyipYunX3dKXyNeC35bFguMQLn
 hg+cNtW06hX/r8WNIMdP42CIuChW5ALKqlQPLsQNPDso8bslZIzCkQOVd3wF9qSbjhpY
 HbaTXvrnXH91+YSlLpZ8yLniK2axW9x7BrI+BUIr4HbkJNtgKOq/pnfRgjxdOXfCq43V
 vcM8c7zdMEGKGt1Ol2eRXPaco7DYfQRxnXq2THpTx2+dZoFz0/rb8hlswZFDs85zNFm1
 ZHFCAhVLXyru414Rrtq3A81AbfKBl7tkxR5NPM45D7TekkX6IIos9fyshK2oCgzrrD4I
 lO4Q==
X-Gm-Message-State: AOJu0YzKhVdjJJshkCP0xxt6PhS6kq3hlCn2QjZJ2Xx1sDVTmq3R4Yha
 vlYK0AvY1GsXeVXPOnOf/ZrtyF0FLksmCF1vGUi6hpRKqcyUmelVU0h08F6QcTzEGdKiM1dF45T
 P
X-Gm-Gg: ASbGncuhNeU7LjcHN/IYrjjIy0j6fRPY1168hF8kfcAkaxef3iJDxTbwVdaiAf/GLnU
 EFasb3W/VaKF/Bzxh+O1g+kGpc/HQMN48ry6ciTHk4961Rsv1Pjz62F7jjYfsv8p9weH+r4cA6n
 W9z06R4iNyZjqeKMWyg9K2DF9DbSWUkO2OHgJo2OHJIiHIt2Nc0HW/5V5m0AAXYpOUCvEWS5vdr
 gcEEgkfmA2jtwqRTsHf2pkvDIhPTeMGS5mkVhNaIUtvaHMYHLOidU83ZElBnXA/IbELrfQGnti8
 DYYOnv/KrYKwswq4WJgBosDZGXG9wg==
X-Google-Smtp-Source: AGHT+IFXBwRsBXBcgBGdlHJVJK5jnWNpEeOyCkn+Xy8aduXn5gykLjUUpGMMBy5TFlK/nohkItVsQw==
X-Received: by 2002:a05:600c:3489:b0:434:a39b:5e44 with SMTP id
 5b1f17b1804b1-434a9dcff98mr82345175e9.17.1732816345873; 
 Thu, 28 Nov 2024 09:52:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa76b52bsm59924195e9.18.2024.11.28.09.52.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Nov 2024 09:52:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/display/vga: Do not reset 'big_endian_fb' in
 vga_common_reset()
Date: Thu, 28 Nov 2024 18:52:23 +0100
Message-ID: <20241128175223.15604-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The 'pci-vga' device allow setting a 'big-endian-framebuffer'
property since commit 3c2784fc864 ("vga: Expose framebuffer
byteorder as a QOM property"). Similarly, the 'virtio-vga'
device since commit 8be61ce2ce3 ("virtio-vga: implement
big-endian-framebuffer property").

Both call vga_common_reset() in their reset handler, respectively
pci_secondary_vga_reset() and virtio_vga_base_reset_hold(), which
reset 'big_endian_fb', overwritting the property. This is not
correct: the hardware is expected to keep its configured
endianness during resets.

Move 'big_endian_fb' assignment from vga_common_reset() to
vga_common_init() which is called once when the common VGA state
is initialized.

'default_endian_fb' value is always target_words_bigendian(),
remove it as it isn't very useful.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga_int.h | 1 -
 hw/display/vga.c     | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index f77c1c11457..5dcdecfd422 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -135,7 +135,6 @@ typedef struct VGACommonState {
     bool full_update_text;
     bool full_update_gfx;
     bool big_endian_fb;
-    bool default_endian_fb;
     bool global_vmstate;
     /* hardware mouse cursor support */
     uint32_t invalidated_y_table[VGA_MAX_HEIGHT / 32];
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 892fedc8dce..6dbbbf49073 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1873,7 +1873,6 @@ void vga_common_reset(VGACommonState *s)
     s->cursor_start = 0;
     s->cursor_end = 0;
     s->cursor_offset = 0;
-    s->big_endian_fb = s->default_endian_fb;
     memset(s->invalidated_y_table, '\0', sizeof(s->invalidated_y_table));
     memset(s->last_palette, '\0', sizeof(s->last_palette));
     memset(s->last_ch_attr, '\0', sizeof(s->last_ch_attr));
@@ -2117,7 +2116,7 @@ static bool vga_endian_state_needed(void *opaque)
      * default one, thus ensuring backward compatibility for
      * migration of the common case
      */
-    return s->default_endian_fb != s->big_endian_fb;
+    return s->big_endian_fb != target_words_bigendian();
 }
 
 static const VMStateDescription vmstate_vga_endian = {
@@ -2265,7 +2264,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
      * into a device attribute set by the machine/platform to remove
      * all target endian dependencies from this file.
      */
-    s->default_endian_fb = target_words_bigendian();
+    s->big_endian_fb = target_words_bigendian();
 
     vga_dirty_log_start(s);
 
-- 
2.45.2


