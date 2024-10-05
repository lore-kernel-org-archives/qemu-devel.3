Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6215ACFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkI-0005Ok-Gu; Sat, 05 Oct 2024 15:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkD-0005Nl-Sw; Sat, 05 Oct 2024 15:47:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkB-0007fb-6E; Sat, 05 Oct 2024 15:47:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so31362605e9.2; 
 Sat, 05 Oct 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157628; x=1728762428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmPlGvENuR506VnaTPZdPC+ldftCElBorI3DqzYxhaE=;
 b=m7g43lRQcH4BNfZMMx9JcdxBuq0bDoObF5ozfqg2rbsTJ5jUwtF7CEGqpLykTk4d8H
 DqbvVFMzZjrOjxDfKCmS1aarlAGG9/+KU9eNujRMFlxMjkTrhXQoFnhMdVa/YPfsbLRu
 KC0BQgRGsU/AnjdnJwx27smDLOiCQKXteuVdJmacQEpuRBBxnrcxgZaZDAWKupT8i82x
 DHWYCjStxLfyzz1obSdxn5D7mG1qRD7TVvkW7u9WUDrdBGl8jV263EvimUSTEKAnZYTp
 P1qEVSkOmuXIwjuuaXjPZ11Fr+NHulG3fLAyFSgsp9oHyXNyx0zpnAhoF6SY7wShSl/H
 sHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157628; x=1728762428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmPlGvENuR506VnaTPZdPC+ldftCElBorI3DqzYxhaE=;
 b=bb0E3z5/1hEebiQnOAVN4uQ3+XZqlzviG18568qa8EI7vhBPDO2ehQYojp5SK8DJkv
 UnfDH/I7g9cYVvXyIyLYX5YZgp9TBRIZdeZbSepvte3+HebroJwt+XGxrbw4RLlnEOmx
 aXJNCyIzyLh8ov4aQOZaOSdSsLFaHAzPvwbtcsNKKHwGvgwoNwxc1SVnfJm6aFtb3xRU
 DZMeP6QASUp2ra2FrceEdktvqIVhyrp9UrwWeS4/2H2xTyw+Lw0eD7HlzXBW7ruv03FZ
 +ytdmq/ihoxroTP3jmxKrs6dqWjSmI7v7KYXw1UDyKqtNLh0I0+rl2i7hlUKI2IkSRss
 t4eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNGR7xRfdev4jpLr5S9IA36BDQa8l3RsTnT8HxwzDeUQNlAvZkcQsoJR1otx/rNPOBMKSZoBF5Uh4=@nongnu.org,
 AJvYcCW7ucrVBe0Gh/8dz887XKiGVRI1ZvIYFLx8jMAwhbc0luYP4yVHAM81zLP4yZNaO3wCwkgWE++r5URa@nongnu.org
X-Gm-Message-State: AOJu0YzMabCmkh3ataHG9CKdlqxb9s/qxPi+YGLueFK/TZzD9qiTc6HQ
 ktKwZ7jDdW09iouv7TRjkTBAn0eSAZQwskCoEQ/6OG6Wsa4/jdbwY9a4Ew==
X-Google-Smtp-Source: AGHT+IHCsiwuPA/bhLZdggdOI4/TTDTLJzSH3fEg5GRZT8UWre2zyV9P0+AYxzv9bouG3BcBq/RJRQ==
X-Received: by 2002:a05:600c:5105:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42f85ab6657mr44233995e9.15.1728157627484; 
 Sat, 05 Oct 2024 12:47:07 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:07 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 10/23] hw/i2c/mpc_i2c: Convert DPRINTF to trace events for
 register access
Date: Sat,  5 Oct 2024 21:45:50 +0200
Message-ID: <20241005194603.23139-11-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
2.46.2


