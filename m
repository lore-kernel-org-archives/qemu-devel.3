Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B81BC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJv1-00048f-Sf; Sat, 18 Jan 2025 20:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJua-0003HV-Uu
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:37 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuZ-0003ke-BE
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:36 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso4518900a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249333; x=1737854133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hepX22FTlqXSa6p5bX3QV0CVCwBYpn5hMPqWA0qdSSQ=;
 b=DzVFNibvcFVY5obGXd1o6sHdb0Wgyqvit1AvHRi80+LOJvhfrEK01B6qrkAYe76TqP
 d914E3lmIUC37LvDueUZt5dcyHPmO7UnXH2Uk073NrURk6oq/P1Udl+ryhmZt0nSwkYn
 uhlQpy0GeL+bSYLdIuXYVkwxw+/kkRuj4Ag6vZhyHbM4NDwgsqNa47n87vxmLZUCF+DW
 9rD6iyQMfuC2lH1IPnAlFVmi3OcfbiuqWRVRZp36pBLV+hkQh9f/DsG28UYdTSQTCFxF
 JZl4i9Yj3/OYpa+1XMYUqo7KMp6m743ngheehOMRzNjyefOR3LHPlfqGh+GE1jXNqHj0
 D+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249333; x=1737854133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hepX22FTlqXSa6p5bX3QV0CVCwBYpn5hMPqWA0qdSSQ=;
 b=hOP9HqRkuG2wKMXhekl3PsLe7N7MzkLu8EpeWIPKR/lgRqMmIpyFZbudxttNjkvIs7
 yrEzi2lqogrjEB/RAx/d9tkbcahFvXQpCGtkWej2qNKeuOKQqiAVub3vl7cD8lKKdy6P
 qrQ2ogRrgij1JWKF4lmFpmCraJ4/AZIw9qZt0a3oXh4DK39afgUR/iPwWamUVimrJQTT
 8MIOO1jq4CFONz20U77AqFHNdxjyQwMWZhaOASVJEt3qAXpeCA6gRuzTKfW9MXqN9lHM
 uN02PUUUMlvq2y18cQv9N2XDjQMz0TRxnBABcf/mgn7m/vnL3TAHdzE4FxTbYFBGRiwf
 aflg==
X-Gm-Message-State: AOJu0YxTu5VmxJYLJ66t9vVNA2oi1+++83XKi2YcNy47Vg4MlD1fw7LU
 7YpQPdWcNIB512//v8MMqapDXRoUhuTRiDVDXJ+mQniBT/hbY/F9WOYe5ak7
X-Gm-Gg: ASbGncs3wftvIhfY/mmycRbPlRAI7mxvVmpFnOduWhCKRrKfMUXLvx6xHl3aWE8AXW1
 j8SLCGiUGaYCQNrM3TBySEXB3sRR3RyS86bzexYmQD24+G1vywKGsKXRVdSo7KbVLx2wu9EfHcl
 uLlxEomNHaJLBH4dKNkuxotATSI3jhPJV968hQXu3E1ojcDoDma+nkRI1DP4RwqfhNWYc5UE6ti
 1ofpA1pQ53T4LKDkcAVe0MEhflbTamVAEGlNLCh9m5G7IOTfn7g9PMsCgOLliBmjzNX2c80C2gS
 jp99LbHi96pmquujEjjYuPVuZ/I31dhZ45V73FZ3mlalvEdgGKAHugaD7+PLFmB+fIFDSkLATQ=
 =
X-Google-Smtp-Source: AGHT+IFFExOCzBrIeCEsMVLCdorywvVhLUyiADbeXukGTIqSF2Q38CMCGPEUZHNFXPPA+gxVenhoqg==
X-Received: by 2002:a17:90a:c2c5:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f782c9c88fmr12762086a91.16.1737249333565; 
 Sat, 18 Jan 2025 17:15:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 50/50] hw/char/riscv_htif: Convert HTIF_DEBUG() to trace
 events
Date: Sun, 19 Jan 2025 11:12:25 +1000
Message-ID: <20250119011225.11452-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250116223609.81594-1-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 15 +++------------
 hw/char/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 11a0e1a7b7..ec5db5a597 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -32,14 +32,7 @@
 #include "exec/tswap.h"
 #include "system/dma.h"
 #include "system/runstate.h"
-
-#define RISCV_DEBUG_HTIF 0
-#define HTIF_DEBUG(fmt, ...)                                                   \
-    do {                                                                       \
-        if (RISCV_DEBUG_HTIF) {                                                \
-            qemu_log_mask(LOG_TRACE, "%s: " fmt "\n", __func__, ##__VA_ARGS__);\
-        }                                                                      \
-    } while (0)
+#include "trace.h"
 
 #define HTIF_DEV_SHIFT          56
 #define HTIF_CMD_SHIFT          48
@@ -159,8 +152,7 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
     uint64_t payload = val_written & 0xFFFFFFFFFFFFULL;
     int resp = 0;
 
-    HTIF_DEBUG("mtohost write: device: %d cmd: %d what: %02" PRIx64
-        " -payload: %016" PRIx64 "\n", device, cmd, payload & 0xFF, payload);
+    trace_htif_uart_write_to_host(device, cmd, payload);
 
     /*
      * Currently, there is a fixed mapping of devices:
@@ -251,8 +243,7 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
         }
     } else {
         qemu_log("HTIF unknown device or command\n");
-        HTIF_DEBUG("device: %d cmd: %d what: %02" PRIx64
-            " payload: %016" PRIx64, device, cmd, payload & 0xFF, payload);
+        trace_htif_uart_unknown_device_command(device, cmd, payload);
     }
     /*
      * Latest bbl does not set fromhost to 0 if there is a value in tohost.
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 3ee7cfcdff..b2e3d25ae3 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -136,3 +136,7 @@ stm32f2xx_usart_read(char *id, unsigned size, uint64_t ofs, uint64_t val) " %s s
 stm32f2xx_usart_write(char *id, unsigned size, uint64_t ofs, uint64_t val) "%s size %d ofs 0x%02" PRIx64 " <- 0x%02" PRIx64
 stm32f2xx_usart_drop(char *id) " %s dropping the chars"
 stm32f2xx_usart_receive(char *id, uint8_t chr) " %s receiving '%c'"
+
+# riscv_htif.c
+htif_uart_write_to_host(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
+htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t payload) "device: %u cmd: %02u payload: %016" PRIx64
-- 
2.48.1


