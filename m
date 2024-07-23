Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6517C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWK6I-0002M5-E8; Tue, 23 Jul 2024 14:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWK6F-0002BW-O5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:18:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWK6D-0003Py-Mt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:18:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-368f92df172so2748481f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758734; x=1722363534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vG3d6DT4g3RTpV52ZpbZlI+FaEaMRrTOU5HFxUCX76U=;
 b=tMjlGTxyeboy5TTnnJRSldCg3E4nVZKFnTcwKZVv+hfQHDNA9rop/jZpeEegUAe7sZ
 vle7kA7ZWdQCYfKIIO5uBt/FSZUYYwWUo+Hzj8VsZEKpc5AlesSLmu/+bClzPpPvKy6O
 8C3cRCAgX9lOSPPpufgPBLWIm0AksXXU9xWgFvjVEHjo+y41B5ihTNNHLy0FkVyVHWqf
 NpNMAyfMc2chp9fgKHkUMU8aEB8uVRMEr5Len/SfT5Fx1zuJszIIAy2iVLctD6EnP+nY
 d6pI5nbFdkcsgyI135ZRrqi/iMIA8z1ok6pMLCK5JE5lA0wPsMkKQRstO04B8uAI2g6h
 RCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758734; x=1722363534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vG3d6DT4g3RTpV52ZpbZlI+FaEaMRrTOU5HFxUCX76U=;
 b=rqCy+ZfRX2OsmkOv7naQ4C7fEDr5lUKx9qV9nsjI7IfqwXKz/Nx78kVy/lb7rh9UVg
 xwz90IOnOi7CpnIE4KyvUDNKUXozYirtnnEGsNRAgMjRHwjv4oDsHq33rny97xdqwE6W
 2E53B/P444jlGJvq4q6JfetFT0ryIHJt0IW20TlQ12XYX8EvlMjT/DOd0ZpLYTOkjixV
 w1ptWi7uYTThu85LWW4lYDqqQZl/krvBiOLb7s6VKw+3Rky91nyA5cSdq3kXQlqpiDjt
 a98ryKEwbv1g0lA38V0JFFHstCUBM0MlZaWIbhZHM7AxHEPn+rkA1X+nWNreJzCCYkU5
 h48g==
X-Gm-Message-State: AOJu0YyM/hLmxx5hf4jjtndU4lMgYQ7tlHBIdUJE4Xun1Kk+shE1iEhe
 7EwR5v0ZK4ZCXaBaQQFmbsMbpeCTypDcqRe8ZkGOOB1gELn2GHbYA0pV7Bx4owwE3kfTX36kgWH
 w04c=
X-Google-Smtp-Source: AGHT+IGj05aWK5QgZFj/2geDfW+a04XjSDDnF+6EyisVXheXj8dQzdOsjk+iJa/2UzCRBAdI6Uu3hA==
X-Received: by 2002:a05:6000:2c5:b0:368:665a:4c64 with SMTP id
 ffacd0b85a97d-369bae30740mr6539755f8f.5.1721758734031; 
 Tue, 23 Jul 2024 11:18:54 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ac48sm12216796f8f.29.2024.07.23.11.18.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 11:18:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/char/goldfish: Use DMA memory API
Date: Tue, 23 Jul 2024 20:18:50 +0200
Message-ID: <20240723181850.46000-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Rather than using address_space_rw(..., 0 or 1),
use the simpler DMA memory API which expand to
the same code. This allows removing a cast on
the 'buf' variable which is really const. Since
'buf' is only used in the CMD_READ_BUFFER case,
we can reduce its scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/goldfish_tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index f8ff043c396..cdff46bc13b 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
+#include "sysemu/dma.h"
 #include "hw/char/goldfish_tty.h"
 
 #define GOLDFISH_TTY_VERSION 1
@@ -69,7 +70,6 @@ static uint64_t goldfish_tty_read(void *opaque, hwaddr addr,
 static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
 {
     uint32_t to_copy;
-    uint8_t *buf;
     uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
     int len;
     uint64_t ptr;
@@ -97,8 +97,8 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         while (len) {
             to_copy = MIN(GOLFISH_TTY_BUFFER_SIZE, len);
 
-            address_space_rw(&address_space_memory, ptr,
-                             MEMTXATTRS_UNSPECIFIED, data_out, to_copy, 0);
+            dma_memory_read_relaxed(&address_space_memory, ptr,
+                                    data_out, to_copy);
             qemu_chr_fe_write_all(&s->chr, data_out, to_copy);
 
             len -= to_copy;
@@ -109,9 +109,9 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
         len = s->data_len;
         ptr = s->data_ptr;
         while (len && !fifo8_is_empty(&s->rx_fifo)) {
-            buf = (uint8_t *)fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
-            address_space_rw(&address_space_memory, ptr,
-                            MEMTXATTRS_UNSPECIFIED, buf, to_copy, 1);
+            const uint8_t *buf = fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
+
+            dma_memory_write_relaxed(&address_space_memory, ptr, buf, to_copy);
 
             len -= to_copy;
             ptr += to_copy;
-- 
2.41.0


