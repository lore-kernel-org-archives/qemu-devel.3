Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D96ED11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akz-0006Mk-PT; Sun, 03 Nov 2024 08:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akw-0006FQ-6q; Sun, 03 Nov 2024 08:35:02 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aku-0001Ga-GP; Sun, 03 Nov 2024 08:35:01 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9abe139088so506806666b.1; 
 Sun, 03 Nov 2024 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640897; x=1731245697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F19SeWagbzAvngzaU5ogyB638Uj1pnr+BrSpn2Lt6ZY=;
 b=UPJrMTfiKadutZyRBP0DEMOj9Ml1WlW+LDaJzp+eqmOaljSMlEmi3/iCOZ8eoyQtGv
 AYlD1xUXD0RtPjF307lod2U29/M5m0CtShADt5FfrOef1SF3CMY65Z8Y2B1+1IWTP4dy
 z5Y5hmiCvq1wmWO1o05MJpo3127P2jeVBBUEl/XWrn4lslRsLSdKEywpurTEn2LCqE7+
 xEnZLzultgYr4HhKIv+flV//9fTDEI6EXdFfvJNJo1mdv6nxOREB7X7qwqS89fMbf2IU
 5QoGmp+LkY+TxrIZMeHRuTH78IOGiGTKtDjoiVUzKZ88FcWap8A8bVlYZLTxDiyIffbo
 yV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640897; x=1731245697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F19SeWagbzAvngzaU5ogyB638Uj1pnr+BrSpn2Lt6ZY=;
 b=mbFb+Dx2Bo2V2mSRz2kYo2SZ6VXUgzBKuR7qtgJuFrgMKLB659hRGNrB6eNmT5K9it
 /cGNBJReNb2Xt8rUgag0UW9S3xhZ3/0THYvgDTXDSw0UOigJ4Rw3ZKSnLfgMz810KyON
 x0ejZdX5GriNZdmsw2bKjh2HeeGObIA1BkXkpUL7ZxY+BTWYpCYdEzleRcawMV728XLI
 ZD+PhFVfpbjaaZlPlgU1K/ztwmiv4SCdyD0NAw2rSG0c8PsiPckZl0qMIyQ54P7jZ907
 FXPE0r/ziCBKjXJyk7QBGfezDyukxNJGLu568zx+ibqWSdlaybvTjkTzpdk1RjgjMOpn
 H1Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhoeZCU5eoff0oOZJbTB3HnoZcEnFm7VNaUPHSP4X9XzMWz+VD4RVSHEXxugyRMwdjq7ZqyHi2NgFN@nongnu.org,
 AJvYcCXpoWER8Zm7EibWzd1cw3w2GV/bO1H3DC3VllBBvJxL20VXQ/iBQORF/Uhj0ixh6ajqcFvup6erZs4=@nongnu.org
X-Gm-Message-State: AOJu0YxWJ9Z5Mvmm3CJr25xM84ou4LmxNReieO6Zstr0on8cHOSiQBaM
 DyYDYzRpY53XZ8Qs/AXax3qR/91oO+9CykyJ7WJobCIj+hPOGJZqVg0oLQ==
X-Google-Smtp-Source: AGHT+IFGl5YfqmwGHjo+DGZ0I/pa9ZuB30gwX2CQEq7ObFiuNcsCrmaVKsayMPJiv3wh5b7HIHfHNQ==
X-Received: by 2002:a17:907:ea8:b0:a99:f3ab:c58d with SMTP id
 a640c23a62f3a-a9de5ce139dmr3074317266b.16.1730640896471; 
 Sun, 03 Nov 2024 05:34:56 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:55 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 11/26] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
Date: Sun,  3 Nov 2024 14:33:57 +0100
Message-ID: <20241103133412.73536-12-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
Acked-by: Corey Minyard <cminyard@mvista.com>
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


