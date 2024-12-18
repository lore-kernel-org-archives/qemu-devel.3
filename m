Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2318E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bG-0005Yn-M4; Wed, 18 Dec 2024 17:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zn-0003XJ-KQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zm-0003JN-3I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21636268e43so2077615ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561088; x=1735165888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xpx/pC7csSWAMTwJpfy2pCt1TJXuOjp6x6k2PZQ7S2E=;
 b=Qh0vEGz+PWSFr8pOlmw39HM8jMPEeX0rIolHyO+XIVqlegZ+fEPhL6TKio1Mb1xTVj
 7AnupHHHkxgt18cRP1T/Sf9wnFTu96vflBZzLbCSBEJ8uVDSJQoZHctBxQfXzQAWTrG8
 74Qhl8sFWRM/KSGaF9fSL7giQW2lWo4cJtA1kQSLEJPAb7TWyewPYEhIfHDkzjTg35yO
 +cIeO5kn3U5Y2QV9W3TkPx/CxwiEAPKwgKrGI3pGCr+lJBOREcPoPhqhb0FdACYBMJ2F
 pLaN3wnYzjMEsAvbTRxo4SuIh0rO+ot7S0fI+3tkOhGoONzPcvFON/0RkaOa7d6g9umn
 0IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561088; x=1735165888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xpx/pC7csSWAMTwJpfy2pCt1TJXuOjp6x6k2PZQ7S2E=;
 b=Wpx1snKEDoprneNgdiJs4iQpZW12vMk1+zU4vJCUZy3QBI8fPtI05Ia3WH/7WdjN/w
 InzH4rwjvI3VzGaSuazSHn90dY5teGbBKwj/VoDI+7FPYW6eEmAz4wyH9ndJJTBrz0Sb
 zAaGj9RZCtGzW5tvqiZqqnhXmrmbSZ3nWZm40n4uBk3mgu1UdP24f/q8THI2JLqZI1xt
 rypSHkLbQampiUVYkIGIjOoIpC9eWCP5GMIpz7RlNnPqLrjY1lKY6aFIBZbXghf8xp7H
 WWhtbWJeV4lyMDNRIvx2z8B/8NskoNmK6F785API6XN00lOdGVPh1V8t8R+lFURryDh0
 MkoA==
X-Gm-Message-State: AOJu0YxFnAIa/2TIOrrRWKsdFFW23WvQnwZyV/aoYC5ZHIZvD7FvR3II
 thOcWBIg8jbQkVAoysYUDIh/hBh3kd+3hkVEfUVujBxlqpzi5k0jl1ja5Y3w
X-Gm-Gg: ASbGnctucjk5/XrdDyL8gRrqPu9HDgNDbmJv14JDIMteO1fEw7yTkb3q7wg7dLKL0FY
 rchLagamE9ypMC1b5MdaoDrT92dntnlHR8FCvQveeAda11knF6Rf3eooosHgKRJPrPxzDB3e5kP
 6uhML8V0t1dX7FYvV2fqEv4rKF0SjwEu1gKfIoAtKHUJP5vZDbeCfjaJKUrrcCzJgbJ6JRshzpF
 jryY/lp5MStC9pAKMsr9w98RRKNquL3VKTnGwt9u7sw91AEOhvv5l7xG6vXgVw+QPlrTxXu3EFZ
 5AfjbN9aDWV6GtOB9vlJ2iijgTwLdcdnpjdjTQ0UkwH5XrJXz3qfp5oVN+efbDA=
X-Google-Smtp-Source: AGHT+IEzAtug1H9Hax5+TgPevoUsoRWRW2NcmXSEtH46wP4LQJvIiVOBp/ST9yGeBwq6kSsJf90c8A==
X-Received: by 2002:a17:902:ecd2:b0:215:6e01:ad19 with SMTP id
 d9443c01a7336-219d968c291mr16865315ad.29.1734561088590; 
 Wed, 18 Dec 2024 14:31:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 24/39] hw/char/riscv_htif: Explicit little-endian implementation
Date: Thu, 19 Dec 2024 08:29:54 +1000
Message-ID: <20241218223010.1931245-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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


