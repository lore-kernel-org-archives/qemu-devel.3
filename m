Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C9E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E19-0003SL-OF; Sat, 02 Nov 2024 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0j-00035v-P5; Sat, 02 Nov 2024 09:17:51 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0h-0001yS-2C; Sat, 02 Nov 2024 09:17:48 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ceca7df7f0so584202a12.1; 
 Sat, 02 Nov 2024 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553464; x=1731158264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCD24XbECn5QO23uS9iwkiZNOhv+pKq+MzdKGgL8qKM=;
 b=edC2N3iJyc6FWUiQIJJXWwAwI2UbluuQSYgehgmiyL4N+aGJ+Wqf6Bi046ztKMB46w
 lWgUdcXSf5pUu66qD2HaGkmu0HQPNiff8mtDJ115U+ojGJRhIcyfFtWz4xCaIRYC1ndB
 b7MJBtjhOzWcJO8DTxe4Gj6T8UKDHfKNcdjThrvWSAwVpSLQV9h/HoUcOKYowrl41ci6
 dLBDusZY10koSbZ2+S1Fan8/Sd8eGX2D0AV3KcgEj0tbNP1iFINnmiQqAlVAeQnWWyU4
 Rm6A+ZjdadkkXMxEI11ctvn9QCmYuD6XwTpg80lTU7eYbk3kxJTPDzi0/RT4f3TP5E3i
 w73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553464; x=1731158264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCD24XbECn5QO23uS9iwkiZNOhv+pKq+MzdKGgL8qKM=;
 b=ZwyJe1XvZAoRWu349aG/Yot55cMwP4wSfhuLM6njRnYbfJH7yl/7bAFy6qUQtEhMm+
 8i9p3xc4pBKdmBSzZCQpvRFa4kuemYkX/61/MdQ9cJK9YmfshtFDO2BDR6eVpxPnsk4o
 oLa6q4Un71TMUe9aUpDjO/rR7WO37gxtpUyG8OGaffgdz8wuFYdfAWpExjhqXUUyyL00
 o/ygApGqPZ3dtnq6MTR6CnNgHTknywxD/XwSd7UvJFiYP8fUlWeKwslTJGncsWYKQYYp
 auxRPuIr0ZNjIg/Fw79WOnStdY9FXbbeT0/iQ/NpAALPnXQVm8lf/uQ1+Hlsjzr5W8Ck
 z9ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTl5/As1OEevYoUcx358RPgrY5FwzmUHY3NCCUPgPmJ/nZrLhYx/9pB00I2FHTQZLi11GQgHvFm0q@nongnu.org,
 AJvYcCXw+MqLMnPHxtIVuxl0oSqX2N1f7RdKZ3O3Xgi2I6T4LIYv7iLjcbF3/dNHb+H4GS+MdhrgKtaN7uY=@nongnu.org
X-Gm-Message-State: AOJu0YyD2+z7/Dd4YVCdaynjb7bXewG+glyTHXcsGpLJPAuUkGhWSWrs
 wjeJWyZV2aDqUZbPgxJ30J5enzRBsX9tGZa6hdGA0NO7xv54dj97Wcc0RQ==
X-Google-Smtp-Source: AGHT+IEYnUorv6VbFM+NKFRhQYrsQu6I7fZGWN6MCX0JY0aguL6S8OPZtNKcPGpxExfauUzSHH9mJQ==
X-Received: by 2002:a17:907:7e82:b0:a9a:230b:ff2c with SMTP id
 a640c23a62f3a-a9e654f8c59mr612763066b.30.1730553464362; 
 Sat, 02 Nov 2024 06:17:44 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 11/26] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
Date: Sat,  2 Nov 2024 14:17:00 +0100
Message-ID: <20241102131715.548849-12-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
2.47.0


