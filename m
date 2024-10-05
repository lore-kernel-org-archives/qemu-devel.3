Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D95CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkM-0005Pu-Fd; Sat, 05 Oct 2024 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkA-0005NG-PB; Sat, 05 Oct 2024 15:47:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk7-0007f8-MA; Sat, 05 Oct 2024 15:47:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso31679335e9.2; 
 Sat, 05 Oct 2024 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157625; x=1728762425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWbe6sy8YDQU8OuL8fDc3zUrDVgXUCz7bTnLrmpVA0c=;
 b=O+OL3r9QYCrYfNcG1Pt0yZMY2yRizxOSDqeiDYg9t49SAKVI8x9hvCRKpFfRxq9fdU
 TngPFio9VKKhvFZZIDd6M/uPtHtM/HljOKT/jE1rMS4Ga+FPnyVerFnzMNC2DgsXgjWN
 bDIrVFoK9790tFf8ubFelqgPQoizQm0exg5bQxf9sLqYsCUrqBHZx4xf28GmIBg+t+ap
 1JPmeBltUoiouy1U866I3dbT388h0a5iyzio82fEHL8DjJMyZNNLpyz2VPkzckdvwW+T
 wxWtZw+cSYVbqc2sKPn96AOMf0i+SXF470LV8HxIa21gEi3atiVcEg+ihB6xT5IGaJZt
 jZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157625; x=1728762425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWbe6sy8YDQU8OuL8fDc3zUrDVgXUCz7bTnLrmpVA0c=;
 b=LNRt3H9PvttWAziXp02dzqOVLyN8R1fmWjiDJVF1rafIzretAGeP7iE5qw8DBE3rAz
 9Fu3dE2/+xQiW6zwWpiAoPxJy8IUkc6phVGkeiiko2Bzy7UmUELH5gaQpnYUAlpx2SAv
 Dggn1BstQgr+Et3OuzAs2lprXKPlIx/jgQMIZzz/vvystb+Fz+Xxatubm3pEcIihZVxi
 ijcKejiz5x+A1mDvjOjZWP55io84jqaRCTI9ah8ebkiYpP5PyWpa/23I1m65FzM4bG6K
 oX0CLkXA43NueEcBN6XdAC5A1ZdaMrtCjh9rdlihRzZ5H/nYfn6JDyGkxGvRLwnZqdIC
 Vvkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg8/6Bnz51uy8g7J7tIcJEstW7oBRimgJJmU9mlBkzBk/tb/FgY/z+yjug5w3N4dyuTSQHfJmTuecl@nongnu.org,
 AJvYcCV4ndNss7rP94KnQ7KWp+32pEvVC+GsPog438EUy4Sq4krjZwpzVzPVq+/AofyE+6T/5djbKbVP03k=@nongnu.org
X-Gm-Message-State: AOJu0YxurlrtV/IkFJX1oCpEkFisydt6/b+TJoLxx+KIhSgnIBN/vx2S
 zAfYMYmoUiIMjV7MkMRbMKsX/aNpFa5x2TfFavTlwokUu94o62hgYbxhAQ==
X-Google-Smtp-Source: AGHT+IG5g/rsq9seolLBlh/Iqe5qaVV5+tjlHe8Xnxx7UcmMrtqBcKJyRcVGC6FR0cLODd8FhnXWgA==
X-Received: by 2002:a05:600c:4e86:b0:42f:5ca3:d784 with SMTP id
 5b1f17b1804b1-42f85aae76dmr59578575e9.14.1728157624561; 
 Sat, 05 Oct 2024 12:47:04 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:04 -0700 (PDT)
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
Subject: [PATCH v2 08/23] hw/ppc/ppce500_ccsr: Log access to unimplemented
 registers
Date: Sat,  5 Oct 2024 21:45:48 +0200
Message-ID: <20241005194603.23139-9-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
Add some logging to see which devices a guest attempts to access.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/ppce500_ccsr.c | 32 +++++++++++++++++++++++++++++++-
 hw/ppc/trace-events   |  3 +++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
index 5d0e1e0e89..6659560674 100644
--- a/hw/ppc/ppce500_ccsr.c
+++ b/hw/ppc/ppce500_ccsr.c
@@ -13,12 +13,42 @@
 
 #include "qemu/osdep.h"
 #include "ppce500_ccsr.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t value = 0;
+
+    trace_ppce500_ccsr_io_read(addr, value, size);
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented [0x%" HWADDR_PRIx "] -> 0\n",
+                  __func__, addr);
+
+    return value;
+}
+
+static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t value,
+                                  unsigned size)
+{
+    trace_ppce500_ccsr_io_write(addr, value, size);
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented [0x%" HWADDR_PRIx "] <- 0x%" PRIx32 "\n",
+                  __func__, addr, (uint32_t)value);
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
2.46.2


