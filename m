Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F03CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNe7-0006rq-7m; Fri, 24 Oct 2025 15:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNdp-0006kI-M7
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:40:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNdm-0002jS-DJ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:40:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso27423755e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334796; x=1761939596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FzH6bP8ELPeYTP6y896Uws7RnQ1srjQZb3yYWsL6TA=;
 b=vs3sD/SmtdeD9Xnty1aPNbmRcYbQWzC8qB/DKqTLow5PCacmGE9jv1x1lwZSjH9Lo5
 S8kGRZlIKNJholuAZhfPyu+J5FOINlrDqrrZlA4+DbFGsWEZTPd0L3TA8HIUeSsmc2HR
 MbWCjUbXYW8KjUg+X25L+cTvIWMbHrh9mXtwyVsnqYbYR7JHUoEVeqX27IWXwbuvRWDP
 HF3+y9uVi/ztnzIg0l9ZHO10i78vPL8qnVFXay0PnSgKFQEge6GY6GFwNuixRdP+Qcfc
 vZCfyeA69UjZw1QuyeLPbltphnCmnwqdpE++2BuPBvIMD2mLKzIi50NZCusoTb6/Fv5I
 moJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334796; x=1761939596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FzH6bP8ELPeYTP6y896Uws7RnQ1srjQZb3yYWsL6TA=;
 b=fcf1d1uGLUiNG9579vIS4RMF2yvKruVUbk79mOhNto61yY2cTnB5NXPEqX5Rw+Suwz
 wjGXp1/tVv9JCUUuWsNtIp/EZFQO/HIH3LeRBot+SvmgPIcnPXHaE4sSLPSPYOdGW5Mp
 9nCXa/JXjqiJV8g/juZPO5hne2YC7G5IJI59MNlCPsWK2eabqVnFg7GFiKMO9/TrPRT2
 BISEuhQhg52VrQ0zkY1t9ngtwkL/8vmRuOmWCmo+Y74bSU1DEJLaq3bfzTIbdBKgwXlj
 vthNs9rtHb8aO66UPeU3M8CHPYhNZK+GN2PLioZrvwamTTYfPmuivQuaweo+mXeIdX59
 WMkQ==
X-Gm-Message-State: AOJu0YwCsnwN52/7y1j5ZnCHHT1c9xTMuEHSzzNidVcN3+brwB0SNrxc
 pquYgWfYo1TZhMekR6JEiD+/sYLwc2yBBffcBrIg/w2894dUenPUrW+jCns4FSLOmQNGANg9TtM
 tb8SCCII=
X-Gm-Gg: ASbGncue61UX9cAAErtJ9m9eMo+qNQrwRV2YeRiKsagBqil65tUT0yH2U4Et7lWQQyz
 BRd6CswTVDZuwAwDQP4iXYp+1EsBwxFvrjqlzm4IGflpQZ4WNfIVtwSpCDLaciAIvGCndmXXsKK
 tnA5v4RRme9CvIdCJ9TV6JE+hP3pBUQ0V7PC36RQKF9a8SHpnrWSDOKLDF6vOP9hP8bup9de7K4
 BecfGq198Z9bvQAo+b9o1kNWcKFF43TsHyAt6vsZzpHvJ6d2q4TJa+d9x/zGgEKnyK8UonVz65r
 Y4/io+ZVszeu33Bz6FxQQrSow9zUnHHKJPy9iv9VNYb7qngKIPV6qopM+BXnkA6by+lE8f145Yh
 OmDHDdfMZBMaxubLA6+3fsZ2waq5CFoQvVBzEPCgCpMo/ajRMJlmcJyu8CtUOYg+9kdKwO2k5PK
 qxq+Lj73ArpPLsc22WuFwIJXrDBQeVtlmNiLlkFVU9LPKAG71FXy8afxVPgKXk
X-Google-Smtp-Source: AGHT+IFkKcF2kN3btUwRTFmlvWK1OjhqWr1tuBBt4m2MdygZA5bFcoeTQb0Zn2LUOkdPsNXkJc+D+w==
X-Received: by 2002:a05:6000:2406:b0:427:a27:3a6c with SMTP id
 ffacd0b85a97d-4270a273c43mr19858859f8f.63.1761334796188; 
 Fri, 24 Oct 2025 12:39:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm20312f8f.39.2025.10.24.12.39.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:39:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 23/27] hw/xilinx: Include 'exec/cpu-common.h' and
 'system/memory.h' headers
Date: Fri, 24 Oct 2025 21:04:10 +0200
Message-ID: <20251024190416.8803-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"exec/cpu-common.h" and "system/memory.h" headers are indirectly
pulled by "hw/sysbus.h". Include them explicitly to avoid when
refactoring the latter:

  hw/ssi/xilinx_spi.c:88:5: error: unknown type name 'EndianMode'
     88 |     EndianMode model_endianness;
        |     ^
  hw/ssi/xilinx_spi.c:89:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     89 |     MemoryRegion mmio;
        |                  ^
  hw/timer/xilinx_timer.c:77:5: error: unknown type name 'EndianMode'
     77 |     EndianMode model_endianness;
        |     ^
  hw/timer/xilinx_timer.c:78:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     78 |     MemoryRegion mmio;
        |                  ^
  hw/char/xilinx_uartlite.c:61:5: error: unknown type name 'EndianMode'
     61 |     EndianMode model_endianness;
        |     ^
  hw/char/xilinx_uartlite.c:62:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     62 |     MemoryRegion mmio;
        |                  ^
  hw/intc/xilinx_intc.c:57:5: error: unknown type name 'EndianMode'
     57 |     EndianMode model_endianness;
        |     ^
  hw/intc/xilinx_intc.c:58:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     58 |     MemoryRegion mmio;
        |                  ^
  hw/net/xilinx_axienet.c:320:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
    320 |     MemoryRegion iomem;
        |                  ^
  hw/net/xilinx_axienet.c:645:19: error: use of undeclared identifier 'DEVICE_LITTLE_ENDIAN'
    645 |     .endianness = DEVICE_LITTLE_ENDIAN,
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c | 2 ++
 hw/intc/xilinx_intc.c     | 2 ++
 hw/net/xilinx_axienet.c   | 2 ++
 hw/ssi/xilinx_spi.c       | 2 ++
 hw/timer/xilinx_timer.c   | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 8008171eea9..94f5bc22a1c 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -33,6 +34,7 @@
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define DUART(x)
 
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 5257ad54b17..5aa85ada5f8 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -27,12 +27,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define D(x)
 
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 1f5c7480476..f4f2571c228 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -31,10 +31,12 @@
 #include "net/net.h"
 #include "net/checksum.h"
 
+#include "exec/cpu-common.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/stream.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define DPHY(x)
 
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 4144c8a6270..6039a654c3d 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -36,6 +37,7 @@
 #include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #ifdef XILINX_SPI_ERR_DEBUG
 #define DB_PRINT(...) do { \
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index ff4a224d08f..51658ee2bd9 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
@@ -35,6 +36,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define D(x)
 
-- 
2.51.0


