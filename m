Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BB6D59F60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l37-0008SG-SR; Wed, 06 Nov 2024 13:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l34-0008RJ-E9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:35 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l32-0000vm-Qa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:34 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so11610066b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918791; x=1731523591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yO3kVmbmcBoFVWzYS+y583sX7R+jYDZcKW8eZMLJiQc=;
 b=NgFGhTipH9Q57B0CgUSTZwcisRJrrerO575IRQ8mlU+ITHWkQIBblkurs2owa1VlCN
 c7mbTYedBooI/RXQTMqdJSgLVnhy/kKDz5Hv9DmdaLGugCtRO9PClSaghVjYk8KwpXiM
 4Pd8mbvyj28bVIQ4fD0sRAKZ9GArc9Z/Glp/ACvMlkU2ggHWQe02l1hzjVIsDBITNoGO
 Lv9cjJ0Tx1lpkbwA6UYK0erdXQSS6YfwkEaDefw1CXuOQRJi+pBG/qgr+vavY/GzwpGe
 i1x89eTXhHMJu4UZkmbh2wTwYfwWaggabAFUuoB3QwreYmsywVjBxWNuq7I9w/t6Ki7F
 cv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918791; x=1731523591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yO3kVmbmcBoFVWzYS+y583sX7R+jYDZcKW8eZMLJiQc=;
 b=sPTQ8fRbMFlPVfy8kftpPbieoRtePU53+hRs/oBL9UYG1QC9Aegm4VxvsSIXrjTyZE
 C38UibogPsefrffvq0YVv1Lavx6CND4Uyb3XStnEy5YeaVlvjPpUC1ZaC3d/bWbpgvwg
 Q8z9gGddYWiuWtZJfyosfm3NQKAR/5IK+6R2M/PGVyoymhYeEhhw7Hpv6br+CnMwrwUC
 lSyW+p7JtYBzxdRh/1+iiwsSMP0gydf8+JU7dOPECAss8SU63tsHND9T2todUQ5UJj5n
 QRpQOtzMhJe/jR+OjDPzHbe9tw0DYQUhExVh6vVkE8gqZ+n/g1zvW3gOZ5nxJHnkWxhG
 iSQQ==
X-Gm-Message-State: AOJu0YwxWrqVcnhFn3hgqiqimvvie5S2o5RlzKzxdLGxk5crYKA63Y/5
 yjNA1fBvNQEKMY0R3CtzHZGAWbeCTsyCFybbS5FtYM7itpASbh+zf0eQmmQG7dH0hWiclACKCtU
 o
X-Google-Smtp-Source: AGHT+IHLwEYzjh7bE7VY6UKu2vqJy3kDHJGLTpvdAYwpwyzxfVfdumNtAIjQKBsxyhavBG7XBennEQ==
X-Received: by 2002:a17:907:7ba7:b0:a9a:522a:eddd with SMTP id
 a640c23a62f3a-a9e5089b4admr2275919566b.11.1730918790907; 
 Wed, 06 Nov 2024 10:46:30 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16f8e2csm315523366b.91.2024.11.06.10.46.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/m68k: Mark devices as big-endian
Date: Wed,  6 Nov 2024 18:46:10 +0000
Message-ID: <20241106184612.71897-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

These devices are only used by the M68K target, which is only
built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/mcf5206.c  | 2 +-
 hw/m68k/mcf5208.c  | 6 +++---
 hw/m68k/mcf_intc.c | 2 +-
 hw/m68k/next-kbd.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 7247cdbe5e..4892924fc2 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -582,7 +582,7 @@ static const MemoryRegionOps m5206_mbar_ops = {
     .write = m5206_mbar_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index e37cd50d18..4166877066 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -155,7 +155,7 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_timer_ops = {
     .read = m5208_timer_read,
     .write = m5208_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
@@ -192,7 +192,7 @@ static void m5208_sys_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_sys_ops = {
     .read = m5208_sys_read,
     .write = m5208_sys_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
@@ -224,7 +224,7 @@ static void m5208_rcm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_rcm_ops = {
     .read = m5208_rcm_read,
     .write = m5208_rcm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 9fc30b03ba..5f38c49077 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -166,7 +166,7 @@ static void mcf_intc_reset(DeviceState *dev)
 static const MemoryRegionOps mcf_intc_ops = {
     .read = mcf_intc_read,
     .write = mcf_intc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf_intc_instance_init(Object *obj)
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index bc67810f31..4d87edc2de 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -163,7 +163,7 @@ static const MemoryRegionOps kbd_ops = {
     .write = kbd_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void nextkbd_event(void *opaque, int ch)
-- 
2.45.2


