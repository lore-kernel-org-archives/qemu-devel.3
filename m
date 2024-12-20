Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F2EE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFh-0007vG-66; Thu, 19 Dec 2024 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFN-0007H4-2k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:12 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFL-0004YP-FZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:08 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so1381886b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659765; x=1735264565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xpx/pC7csSWAMTwJpfy2pCt1TJXuOjp6x6k2PZQ7S2E=;
 b=Qo0PDFdY1PGXXdO30RFafuBukXXj68G5NgXmOmBYQYgqM7kdzCkq05mt0a1WbPHhfk
 mPJUvNvwj1VbTIcMyh4jez1y82qflwS6RbKQIMTb9UUQJYEOAnao9yZb4lPL2bygZmwC
 vCjJMDy60HP9XCUcJqlghF690RdxzDto7MmuTQf+VroKhjsa1gj6Tu/lL+pLFzYPGlBO
 VkM4EyoyN9C3pAp/8m8P/BNpcyNJ+E0IOyRMTYPuwf6P9rlLSjY73Gk83ceJ13xKY7lo
 1NFvy5vC8cFzr0XKVmUcMBndpU1sVws+/onlh4JhfFbWc+rbuh20aD8CoLYcPslEZ6ro
 rIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659765; x=1735264565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xpx/pC7csSWAMTwJpfy2pCt1TJXuOjp6x6k2PZQ7S2E=;
 b=hdUMmpxmTHjBeS9hOaBHMizAd9eLH3LMBub26DAHJReyUqZOYWU9RfxBtgLJXaPQJB
 K+ezf+Qav54ZoxHoYevlwnlwVOmdDK/ooI/jd9yTyUZzBiU8/ak5mLY+Fdy9q1Encx3Y
 6oHFP/wQBBn6Y34zOZ/oJh1BzOs2V6I8F9byjSPYFqWoPDGWOrRhm1+OKTlEUSUgAKX0
 zoSwJnuqGflRrvuMed1I4MQChVcuXeTtBAqMXZi7U1j0/Sz1D1+A1lSiEERka0ej8Jmr
 J3MIHeZdvDvA5zy5d3WfhQIu/28SYGBmLFHgAsYdvvzwH1xHWDDwdbDtCf/sbSqLO1hY
 XT1Q==
X-Gm-Message-State: AOJu0YzW3u+OZQvjLyBuh2+MC+r1O4kFbJ1NRS3RRnBDEF6H4cF3T6+b
 aUjkJSOsXpjDmR3z4uUbdiXms9O+XB5wbGzzY+/QuepcgOFKeuVvo5H58mpz
X-Gm-Gg: ASbGnculOGt9TMUChY+84gFr2e3WKvlv8Z5Q38YmDQ+g/LSmjKrUvSObATpWmerS/Vg
 b3wiPyJyp3DDOCneebygAznv8WOavdAt5bC8POwE7nNkMsiczOvPwnLDAdrh/CB8ppk6i60BsRT
 +ZsyRWAHSrKTDOYx/T8jfM/OTFYgJ85kRNz7km6uSZ7x50zbW+uPSPZM1d5rq6T7JRxVWgDV/JA
 jTVZHLoeWmRWbJLjaxWnpXp7X+CHgjN635o2LiiGh5ODjctmX3ZmD/U+VvAhcx43d0z00O8qrfz
 zsw2+7Xxc3va4GQ6aEpU3D7Grjrm0rOlwlavcxmidydfDsVdJG3RASyZIXFAqoQ=
X-Google-Smtp-Source: AGHT+IFb759qkDhHpaEwPI3KEwT0I0QuuVcNWRhPZkZpx2rS0rNpk0EkKY+3q5IKTjajUdrVb7F8Bw==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-72abdecbdb4mr1324997b3a.14.1734659765511; 
 Thu, 19 Dec 2024 17:56:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 24/39] hw/char/riscv_htif: Explicit little-endian
 implementation
Date: Fri, 20 Dec 2024 11:54:24 +1000
Message-ID: <20241220015441.317236-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

Since our RISC-V system emulation is only built for little
endian, the HTIF device aims to interface with little endian
memory accesses, thus we can explicit htif_mm_ops:endianness
being DEVICE_LITTLE_ENDIAN.

In that case tswap64() is equivalent to le64_to_cpu(), as in
"convert this 64-bit little-endian value into host cpu order".
Replace to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241129154304.34946-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 0345088e8b..3f84d8d673 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -29,7 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
-#include "exec/tswap.h"
+#include "qemu/bswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
 
@@ -212,11 +212,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
-                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
-                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
+                if (le64_to_cpu(syscall[0]) == PK_SYS_WRITE &&
+                    le64_to_cpu(syscall[1]) == HTIF_DEV_CONSOLE &&
+                    le64_to_cpu(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
+                    cpu_physical_memory_read(le64_to_cpu(syscall[2]), &ch, 1);
                     /*
                      * XXX this blocks entire thread. Rewrite to use
                      * qemu_chr_fe_write and background I/O callbacks
@@ -324,6 +324,7 @@ static void htif_mm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps htif_mm_ops = {
     .read = htif_mm_read,
     .write = htif_mm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
-- 
2.47.1


