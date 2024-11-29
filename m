Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A7D6EBFA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGy49-0002RS-HE; Fri, 29 Nov 2024 05:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy48-0002RK-6d
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGy46-0002o2-Mb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:17:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so15419025e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732875452; x=1733480252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0P3q4DMKMIpQLw5XNROBR41JdakZ6VH4T3cx52YGOPg=;
 b=dHueWyPlWUjnMqj7H8sOaR/MkZhLBx50U60mRK3zeoThxJWIUi2g5oUBR7Hwd9w28B
 nTk88c9GBk2FS27a1EetJo2bPAdvz6gRdeHjDpk1qDIMY83kxnkz2wi/Bbi3k51PiIBb
 of/RP66jIicHmGVWhtoRPjzvEhuGwug1ySDmPyLHPfWydnXVVa1IepD2+sXimjjiGm3q
 rJ9q0+BPucCc2wcTtmi4eqdAX/cuNPHbhc+5fmByXajIFmP6k0Pj17ueiM7DjP9AgUk6
 i7ZP+BEM1vDaU9j3DEGB25oNzwQamGGsCVj5PLBwDygDKyep9rdzoJGv/Jt+l2+2r9B4
 EEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732875452; x=1733480252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0P3q4DMKMIpQLw5XNROBR41JdakZ6VH4T3cx52YGOPg=;
 b=FZdLrGBJEj+jcwILz8DMTs6QTRDp1J0c1WDoJ1b0t+Uctmwr/tIFcreXPdfYBjzVOM
 wMMrtNJgRTGf1NSipja95Z7ANA0n+QoeSY6UGUt5HeEZ64GizrTHBvti22q4QZQjmkzN
 +89m/SaE9KGT2hL2C3eBc3Km2QBATnPJtgjU/IUpelhg9rgR+Al1ixjL0PT2N5cRDP33
 9R3ZVe9jF7r8bjxy7JTYS89477oL5bOot+emh2Zx491yWjyYUbnQ3qL7jPb1NpBQADzM
 k4r1NidXpdcSRqsAoERgxyyz4iy8ju0+CnoDrNTrz8PfslOmGKnyWxw0Kbw4XFtdAtqX
 49qQ==
X-Gm-Message-State: AOJu0YwJVlWVzSVtOsmnn9W6n/sB7hPtBRS92IfGdCNALZWMbSKmmh7E
 ZWfIGSmoiyjsF245xYc9+QgJ8eFo9bsp2fre5rnDoyR9v1PMEMq+e6MNbTZ8/2UM7HML9ueWk3E
 h
X-Gm-Gg: ASbGncvLfDD0yOFfsjLmGZv3qHztX3xnvKOIJ9m7zTMUwPhe0W2BUs4eYnQGCYKJJmX
 UXHTzN0SUM8d+XXp0u1OGaa/pkpQw7CG5bYrdDUkwHvtUvOlXKu0zAplSw/xpJmPgBe4u/MmXxW
 OtZOIicuFutruVimVG47JuBn0oBRuwOPhfNFIin07X6qtZWeH4q0WdhdiyTAR7UXYsVD5tiZ1bS
 kV02u2rTYY7Q+gyCPrcibkezK0SwB35eakWAIZsMgXYx2bOI2iKyEQQG3p3R6adxJDHCTqAEMOX
 qFG3gbSHI/3npv92o91VFsZC1s1BaQ==
X-Google-Smtp-Source: AGHT+IEpljWYKLzCcG0GnushvXyC11xgQnr4hZcFwoEyq8E1xaOPI/ab5NsYSw8gVVsY46yv+lXpnw==
X-Received: by 2002:a05:600c:6d46:b0:434:a5d1:9917 with SMTP id
 5b1f17b1804b1-434a9de4533mr83226665e9.21.1732875452611; 
 Fri, 29 Nov 2024 02:17:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd36557sm4036801f8f.24.2024.11.29.02.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 02:17:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/display/vga: Remove pointless
 VGACommonState::default_endian_fb
Date: Fri, 29 Nov 2024 11:17:21 +0100
Message-ID: <20241129101721.17836-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129101721.17836-1-philmd@linaro.org>
References: <20241129101721.17836-1-philmd@linaro.org>
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
index b074b58c90d..6dbbbf49073 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2116,7 +2116,7 @@ static bool vga_endian_state_needed(void *opaque)
      * default one, thus ensuring backward compatibility for
      * migration of the common case
      */
-    return s->default_endian_fb != s->big_endian_fb;
+    return s->big_endian_fb != target_words_bigendian();
 }
 
 static const VMStateDescription vmstate_vga_endian = {
@@ -2264,8 +2264,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
      * into a device attribute set by the machine/platform to remove
      * all target endian dependencies from this file.
      */
-    s->default_endian_fb = target_words_bigendian();
-    s->big_endian_fb = s->default_endian_fb;
+    s->big_endian_fb = target_words_bigendian();
 
     vga_dirty_log_start(s);
 
-- 
2.45.2


