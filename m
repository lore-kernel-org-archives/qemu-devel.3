Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83614D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JFf-0002Kd-Bc; Tue, 05 Nov 2024 08:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFc-0002Go-AZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:40 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFa-0002Vc-NR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:40 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so5282848e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811937; x=1731416737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAZ8YzntwrQh/mqW41UtJKIzn7e3ZbFGPYghnfpczwc=;
 b=e3/WIxrZmVbUjv7muhynuJUt9uheb1R5hxiRw53dJTuxYDvNuM5yc/apqsTqJ8uLlw
 V1NfO9zkQY6J15j4X7Xhdjfn9ezJ7vz6sleW7dSAk4igWd085sD3fg7lCHgDyi8X1Dy4
 H1pUMwNcGa9B88AR6vBZKLaEoQKaSuyBD1Xxn6DaQ+yGxHdAcSL2ywX++7adcpqKM/mK
 HVnQ2w6zKL64UKNknbYB65PBMR2v2IlEuOLkirM5X+fHHBY11p++wkswXaTa82d//E1b
 gI+ZWXZt3Y6GcmNA7vzQOPAlqsWQ46hVLjLQa2TPBYBl1iN5ugNoyTJsS9wuvTl40lf3
 dYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811937; x=1731416737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAZ8YzntwrQh/mqW41UtJKIzn7e3ZbFGPYghnfpczwc=;
 b=G8ZAZCxP6y2akV5AgutY5nkXQ0blLVNVdHzLiNEytB+AIeh5J7AqOTQfeJb3yDpWvh
 B4sYWkUjzkflTMpWnTeZfULihcqa7TlHV7J/wjdF5UWfG29FRMVuFI9hhT+qoJ0FaFz1
 4BEBBXU+aLLVzb6cAaIKOcIMTPUndh7Xy2bvcwdM+ZMb/GKYKs5UWuV/snXlqMEJQ6A3
 EdnPLmSjxA0HMH1pAU7vIMdzOtcwYsQ+8KPZm1yr2ZKWbMBkdvR7mM0tx0Mqo2Tt0yG1
 S2IKZnWNE3LpuEIH0vzdc7aFZllTDUBDce8e9ogJdjZosLK65LeAbjdfT2unymfBUFDK
 1IoQ==
X-Gm-Message-State: AOJu0YywvUwndLxL4axGH7irtdF1AiwuiBlvSz3c2IFbqspkywpnWbfj
 glrR+l+SZCGEbqJ1FMNV6oBKqjGoEI1e0JlboYWARJVnAHqCcU0ouqrpAyXi4LtKF5ESqiK6yFB
 SUQw=
X-Google-Smtp-Source: AGHT+IFlV6iijvNoZg6eJKoOYnS/KaIw6uMQMysAPmvPv1rKCzVbG+2oPzYa5o4BiaDO5X+KwVqftg==
X-Received: by 2002:a05:6512:33d3:b0:539:e7b9:df03 with SMTP id
 2adb3069b0e04-53b348c3954mr18508026e87.1.1730811936350; 
 Tue, 05 Nov 2024 05:05:36 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e848csm222180125e9.3.2024.11.05.05.05.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:05:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/19] hw/microblaze: Fix MemoryRegionOps coding style
Date: Tue,  5 Nov 2024 14:04:18 +0100
Message-ID: <20241105130431.22564-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Fix few MemoryRegionOps style before adding new fields
in the following commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c | 4 ++--
 hw/intc/xilinx_intc.c     | 4 ++--
 hw/net/xilinx_ethlite.c   | 4 ++--
 hw/timer/xilinx_timer.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index f325084f8b9..a69ad769cc4 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -172,8 +172,8 @@ static const MemoryRegionOps uart_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4
-    }
+        .max_access_size = 4,
+    },
 };
 
 static Property xilinx_uartlite_properties[] = {
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66eb..2b8246f6206 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -146,8 +146,8 @@ static const MemoryRegionOps pic_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
-    }
+        .max_access_size = 4,
+    },
 };
 
 static void irq_handler(void *opaque, int irq, int level)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bd812908085..11eb53c4d60 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -172,8 +172,8 @@ static const MemoryRegionOps eth_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
-    }
+        .max_access_size = 4,
+    },
 };
 
 static bool eth_can_rx(NetClientState *nc)
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 32a9df69e0b..0822345779c 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -195,8 +195,8 @@ static const MemoryRegionOps timer_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
-    }
+        .max_access_size = 4,
+    },
 };
 
 static void timer_hit(void *opaque)
-- 
2.45.2


