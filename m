Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C821DCF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPl-00037h-Ti; Mon, 23 Sep 2024 05:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPg-0002lu-Ti; Mon, 23 Sep 2024 05:31:25 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPc-0006z3-Dn; Mon, 23 Sep 2024 05:31:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d64b27c45so766462866b.3; 
 Mon, 23 Sep 2024 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083877; x=1727688677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gk0TI6PhzPVX9iexQrZ/MM+nIP2rF3HI992oH7AdJ4I=;
 b=ETqgGm81KZtoYruwD95OXByzSBBliL2PqzOpLoUAGLpenfEO2ihQVxFzk0Ln/hePyR
 Z0cxx8Blcka21YTQjQQJh+HOl+P//eEOGCqHewNphHS9WJhQXiCkKzo1sH0jOYzUYT2O
 pJxtH5OgqS7u4JjGMeYmeJjxVCW1xPWy1hwVS8g/mhkob2p4yJ2Stqq2y0/5b5sPF5aB
 0/ao+KgLRMvwYAEWUyTyBMjucKeFglQ2UCSAL+F0zPYtnA1XXPK+EKiJ2jfSf3GJLppS
 t3LjQMo5GRnlxhkzhX//B+uFO2mn8eK9teNK4xOMjkwPDtrzsQvbdEj53lbV4w0oXemY
 Oxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083877; x=1727688677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gk0TI6PhzPVX9iexQrZ/MM+nIP2rF3HI992oH7AdJ4I=;
 b=oqKVBWqzgM8VpGlZQ+vuShalMCvoE4D1cgT/DMBz9u+D6tIpopFBJpXcfwv64nOx5b
 9DxrilE8fYCNxOfHTm8Qo+gFTfi96fo9lFdeS/NBN/nlJf2Tyl8s5OW+J8P6e6ww4DmM
 19hwXXUZPiJ4K2iTy8X7OtxWIEaNoYwejuS1wIeRHZJDNtRldOOR4rt4DCC4Yg16t5lr
 5wmGkiSVuI9svGqpOccCc0Bi0C5yj+ET4Um/SKf8LZQu+IIjCnRHh6QK6JLhev0XX7Fy
 AJRDuqRRAQB3m1fs3O/vUbkQGSZWg7hUhFi+20HYH3IsP8XG0wSxDqMy5vpVEDE1v6H/
 gVRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuddZY8NIUan//EeKJ37ENar9K94NhorIWclHdlHVp7nFeNOt93Z8Hlr3dZIfziLBWV7KCShkqt2K0@nongnu.org,
 AJvYcCX5iQCPakbWA27mRv+N4tSF6z4fC5mnL8+zMGxtWKoLfRIMwudRB0qtwtRcOYsnhtpNeRjwV432zdA=@nongnu.org
X-Gm-Message-State: AOJu0YzWw3+q2G48PWnKT03OYX96hTL+CMcK4FzRNMDHBOH+Agd1z4dj
 jPyHoYdODrXl1CZyHjwVZ8NY7lGhq2FUAHwWH8eiNljryC4jLZrEiDiADA==
X-Google-Smtp-Source: AGHT+IG92EfphYA6j4+HK3yEweb6tY+YoKcMJvzq5HMag6Rs4+rgGUCH1A9CByPd72K2RFeKFLI9dg==
X-Received: by 2002:a17:907:e655:b0:a8d:5472:b56c with SMTP id
 a640c23a62f3a-a90d4ffdc5dmr1030574266b.22.1727083877205; 
 Mon, 23 Sep 2024 02:31:17 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/23] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
Date: Mon, 23 Sep 2024 11:30:03 +0200
Message-ID: <20240923093016.66437-11-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/mpc_i2c.c    | 9 +++++----
 hw/i2c/trace-events | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 2467d1a9aa..3d79c15653 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
+#include "trace.h"
 
 /* #define DEBUG_I2C */
 
@@ -224,8 +225,8 @@ static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
-    DPRINTF("%s: addr " HWADDR_FMT_plx " %02" PRIx32 "\n", __func__,
-                                         addr, value);
+    trace_mpc_i2c_read(addr, value);
+
     return (uint64_t)value;
 }
 
@@ -234,8 +235,8 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
 {
     MPCI2CState *s = opaque;
 
-    DPRINTF("%s: addr " HWADDR_FMT_plx " val %08" PRIx64 "\n", __func__,
-                                             addr, value);
+    trace_mpc_i2c_write(addr, value);
+
     switch (addr) {
     case MPC_I2C_ADR:
         s->adr = value & CADR_MASK;
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 6900e06eda..f708a7ace1 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -35,6 +35,11 @@ aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t va
 aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
 aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
 
+# mpc_i2c.c
+
+mpc_i2c_read(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] -> 0x%02" PRIx32
+mpc_i2c_write(uint64_t addr, uint32_t value) "[0x%" PRIx64 "] <- 0x%02" PRIx32
+
 # npcm7xx_smbus.c
 
 npcm7xx_smbus_read(const char *id, uint64_t offset, uint64_t value, unsigned size) "%s offset: 0x%04" PRIx64 " value: 0x%02" PRIx64 " size: %u"
-- 
2.46.1


