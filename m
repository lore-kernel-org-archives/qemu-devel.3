Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C1E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0z-0003Ed-3H; Sat, 02 Nov 2024 09:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0g-000359-3M; Sat, 02 Nov 2024 09:17:46 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0e-0001xy-F4; Sat, 02 Nov 2024 09:17:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so466939266b.0; 
 Sat, 02 Nov 2024 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553461; x=1731158261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a850vDBXzHXJ7cyIPByVZxmHOqLVyh2zVKfhVANSK04=;
 b=ltvei1A9Yyg26aOH522sHjqN2XsYQ/iKDd7Ik9SGr9v1b2AxbNrB36qhqJ6j1RsZT4
 lE11fFybLthciJW9f1xR1IbjeLoUEp/F79e5JfvvJoHcF5XwdqTLAzWkslz73jR5GHfS
 gp2la/qdxsqbDoIMmRQODad0acLhH70dCkAVTCl1aVQUwxhXBvfZFbVGZzjZ5jr/fpNG
 I17GmSYWFSq+CaGQMDTZc3mfQo5ccBxngN4FKmaE/0TJnAamNNduWd/juAqXFyqpzfGl
 PnK3QdysRkyMliXj5RJqruWjbQOHoyRi5SA4hHDp+TNVjV6DlaBIyowm8W+wGaAbfAS0
 hgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553461; x=1731158261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a850vDBXzHXJ7cyIPByVZxmHOqLVyh2zVKfhVANSK04=;
 b=CZcitGEHdX4GPQz9koJCkzTp2sY8FIfRQRFLDpC1Pu0j7i6bNA44SeiEsIefnJ7SEQ
 HGiof3KbvpXtYGWYK2piW4L+c2iD0Q/kJpCCRwdI0pyklT2GNh7CH0xo5YvYE06JvPb3
 FwqLr3AACxsJ6mxlRhr7d1zNKAVoPPjHWsk70p6RDBswkuIAwttqP0iD6NOcyvDQ1hE+
 b0eHavuiwoTmf71aCYY6HC8hOSMc3FCVWKIEDjhSXulc6MC/SUAPbdHsZ1We0nhjF8rm
 hPkeTsE1nrE9VNdd/2sI80V4jHe2UpTYKZXj2iAe28Q4PY9BHubQN82FwIhcAP5mEOWm
 95pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6x0QaFshPBP6n+4iJiqU9yYFe0orC2XUkIP2GtILro7X4NwBZZJY6H/Ypz1LMM27fl6ocDf/VJCI=@nongnu.org,
 AJvYcCWpau0qg7lgnt+lrKwWrwcXyOLyrBLVsN6EBvxgLF8wVUtboqwlBLrDhI1Q/0+zcM2rAIcJ0Cj11nR4@nongnu.org
X-Gm-Message-State: AOJu0YwPcOaifMYgujln2vJmZnVP2LldGke4VTkvl7yI308GyBC7t1Wj
 IQEdYf2AfYzYFGZiiG8j7hBwWWrQ+BNDpsftUaD17LeZJ99PhghCo6sf5w==
X-Google-Smtp-Source: AGHT+IG7pSL75drlXt+jqIFdGmscG4ofpult5VeikrWGtLFmHWvMKj/e8ZBh6AXNI2qMgz/xrk+/dQ==
X-Received: by 2002:a17:907:6d0d:b0:a9a:147d:fe9c with SMTP id
 a640c23a62f3a-a9de61d5d59mr2694010666b.43.1730553461485; 
 Sat, 02 Nov 2024 06:17:41 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:41 -0700 (PDT)
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
Subject: [PATCH v3 09/26] hw/ppc/ppce500_ccsr: Trace access to CCSR region
Date: Sat,  2 Nov 2024 14:16:58 +0100
Message-ID: <20241102131715.548849-10-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

The CCSR space is just a container which is meant to be covered by platform
device memory regions. However, QEMU only implements a subset of these devices.
Add some tracing to see which unimplemented devices a guest attempts to access.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/ppce500_ccsr.c | 25 ++++++++++++++++++++++++-
 hw/ppc/trace-events   |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
index 5d0e1e0e89..dfd8e80c2d 100644
--- a/hw/ppc/ppce500_ccsr.c
+++ b/hw/ppc/ppce500_ccsr.c
@@ -13,12 +13,35 @@
 
 #include "qemu/osdep.h"
 #include "ppce500_ccsr.h"
+#include "trace.h"
+
+static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t value = 0;
+
+    trace_ppce500_ccsr_io_read(addr, value, size);
+
+    return value;
+}
+
+static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+    trace_ppce500_ccsr_io_write(addr, value, size);
+}
+
+static const MemoryRegionOps ppce500_ccsr_ops = {
+    .read = ppce500_ccsr_io_read,
+    .write = ppce500_ccsr_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
 
 static void ppce500_ccsr_init(Object *obj)
 {
     PPCE500CCSRState *s = CCSR(obj);
 
-    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
+    memory_region_init_io(&s->ccsr_space, obj, &ppce500_ccsr_ops, obj,
+                          "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->ccsr_space);
 }
 
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 1f125ce841..ca4c231c9f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -143,6 +143,9 @@ ppc_irq_cpu(const char *action) "%s"
 ppc_dcr_read(uint32_t addr, uint32_t val) "DRCN[0x%x] -> 0x%x"
 ppc_dcr_write(uint32_t addr, uint32_t val) "DRCN[0x%x] <- 0x%x"
 
+ppce500_ccsr_io_read(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] -> 0x%08x (size: 0x%" PRIu8 ")"
+ppce500_ccsr_io_write(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] <- 0x%08x (size: 0x%" PRIu8 ")"
+
 # prep_systemio.c
 prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 prep_systemio_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
-- 
2.47.0


