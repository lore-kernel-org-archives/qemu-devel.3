Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663FEF99F1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59y-0003lV-R7; Fri, 13 Feb 2026 21:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59x-0003k0-Bc
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59v-0004bi-Vk
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2535639f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035202; x=1771640002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jA9tgbrEfDfZ0b8iLr0ANDvJSEYKxUdxhaspqyGLjsM=;
 b=VV2bMd7f1PbyJSZDTH/FhvNQb6P4OGmU8WsHdsfy5p4qj3rxoW7bEaUtYEXhIp95kU
 oT6TMjBavlTyP5E9ayNa4JNqxtEG7FABw6jsbNfT/MBgxSMjXap+TPtYNLRJkqu9wR5b
 2oxbkktcHCcPpkNFbGRA8ehen60v4S0ylZXI8TRpdsmIi9S3LIFS7v4xrCOnJX51HJmI
 +lWJXdjdjnyR3pOzqgbWx1b4n4pg7DdBGSHGm5uazatY/x4wc/Fb5ViYhqjbz7C8utRj
 EDerRzTMZRQTfdYVTeFZWcgZYYBPe4aBGqsPQzTcHSwdgR4t2i3+xolJpsWRd1VMiTis
 nR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035202; x=1771640002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jA9tgbrEfDfZ0b8iLr0ANDvJSEYKxUdxhaspqyGLjsM=;
 b=PJFuS9vYz6mxi9mLu2pKbMcKKOHu8Lqyjii71w4Tqdu9EqRkkV8vCzXcjMXTamrQk/
 puzyes0erdGRR+J4ikdr1qjT7z3ZwS05+/KQdqiIhqSmQzZW8Dn1bJO1kn6E0/egqaPo
 uTADfA2psQTmltuhmpaIfSnT8CxrThCV4XesaRc5gmZEN9wwpmMHybCoNWesiEmXWyk8
 1GmgkYX+WyTfO8szHIB/V10Dx25W3aGEVDIesCVov9oJn9pIy+gRpY37x0o0j8/s7sTD
 9VAx/88bU1lWanl4y3Oma2xg+QvctUDurXD+MN8qDr4eJx7qWq3wiXRQmj6SzoKtce+0
 VzVg==
X-Gm-Message-State: AOJu0Yx2p6R/QZx9/0JUUOMHLyusGGbVS0srgkj+LLUtfsubn5eCt4ak
 eudeQKDkNPwkojvadXhWQ1jRBOSwcQBNtVQjm8dD/UvWB5RF3UrIAowgOsKAHwn6YBwDxA8T3mD
 A6AYDwpk=
X-Gm-Gg: AZuq6aJLSLHWCOhnnp6fLTNdslELoWyO/bbeZS0bYHkpxSA4BJmy0KGXbGJ0WOuYNze
 9RlcJ/VP1IPI6D5mHjjfharWw8T1UL0HxL3EcSR4d4xCkbEjr+3SiK8V88zocKXI987gf8hcRg0
 PFqnmX2qR94TaT3BQk7PNh6fLuVrqbRkBx2LSQy8jDJmB9wMzuPIRz2ZlVReCMHumqffMgIr/oS
 x0DKoqj3Iknn7zL1hu0z81IOAK8oIDTyPGikhXudWaoIVgaaFpQ9g4iAqx4DXtrcl4kll3jOoy2
 dR7kvpZ8ErAeStUCnsff0OtzxpoH8g+48pvvpP30lijoP4u8Cp50yhFF3BMOi+5M1AC/0R1FrDP
 YKtncmCSUyBWvH+tXVzmNZABs/iTHDZdxV3ZrGfwwbZPOqHz6FnTg2t3ntV9JG0d1dz5L6ykNJs
 AoTxR3V1uHtD6tSRSmLpFBDWYriJwG7EefqtuSabB7RCLZR0RbEZtTd0Yl+IEVuD1LGIUuCS0Z
X-Received: by 2002:a05:600c:1d10:b0:483:29f4:26b3 with SMTP id
 5b1f17b1804b1-48378d58838mr33975355e9.1.1771035202191; 
 Fri, 13 Feb 2026 18:13:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a2392bsm54809155e9.6.2026.02.13.18.13.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] hw/m68k: Set graphic display dimensions generically
Date: Sat, 14 Feb 2026 03:12:36 +0100
Message-ID: <20260214021240.58657-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

If a dimension is not set, have the machine init code
(q800_machine_init) set the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c          | 6 +++---
 system/globals-target.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ba32da2fa45..ded531394e6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -560,9 +560,9 @@ static void q800_machine_init(MachineState *machine)
                             TYPE_NUBUS_MACFB);
     dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
-    qdev_prop_set_uint32(dev, "width", graphic_width);
-    qdev_prop_set_uint32(dev, "height", graphic_height);
-    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_prop_set_uint32(dev, "width", graphic_width ?: 800);
+    qdev_prop_set_uint32(dev, "height", graphic_height ?: 600);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth ?: 8);
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
diff --git a/system/globals-target.c b/system/globals-target.c
index 989720591e7..e3f7d846ac0 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -14,9 +14,9 @@ int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
 #elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
-- 
2.52.0


