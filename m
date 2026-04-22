Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3CCFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdj7-0005IW-4d; Wed, 22 Apr 2026 15:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdi2-00059i-Lg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdi1-0008UG-5c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso51085335e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887883; x=1777492683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wIJZsquIktrzIZSBPQY4Zli4+8g1iiXBsn/sLB3fVbU=;
 b=PBY/NbqsGLloyda7Unfo29cVry1gphZkxGfU46LchqYG08UaD3lrRe9wI7wiV6TZTu
 NJY1Q6ORdt0wdh9C2GlrB2yL6+EOrDmGuLDg0/qMlTtsY2vZrdo7KVtiDRDBE7qrK2x1
 D8r2N7xIaEE4/y/mFSLiBnbca8EGlMRqiF2OZiE2qqciKhISFf9c6LMYHeVBZrEiuYEH
 pdZpC7J69WP7n/Nrka8mgnl8cO4VclgIpN95/5V5oHn9BaShn9USSoJJgCbrMku8WuzD
 /PM2BeyctPlHbBRMyIR1SV0YwtRR+vUkpODADl61XJX3RLBUwqbBfwPQBOV8GIkvKJUB
 SW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887883; x=1777492683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wIJZsquIktrzIZSBPQY4Zli4+8g1iiXBsn/sLB3fVbU=;
 b=BoPijWHfm3QILMVDF4n8DTfhUUhFw5ZWZvPrYXcRI5munFzwx6VJGAbL+101QyQb4k
 mdXe3D7vNL8ODrJ/Ij5qcoiQuNhCoUX8tjz6aeXrUIFMjosavhFc9qs5K/kXbxxf/npy
 uonpCgcHQnrQe4z1xNSoQS+3L0tznFKs/sCnNo7N9x/5QiX3by1vBLAMZyNiZs0fTgJa
 +XX7Xm1UKch+WyBSRNZyDKqyrFVC/X/b2+1jP2DohaVMuxLKQftDkUSC+6i9ZUjh1Gyc
 hhUwIAPogRMDtpTHHI8c0EDAl4Vo2N6uTLFh6gt0EflNLAf4OquLGvA+WFvl8sJbvtu9
 sjew==
X-Gm-Message-State: AOJu0YxMg1cHFJDqOEE6N+7zcLUWULdp58XDFTP8weSDrkvBFUpQJqsh
 FxFAHBPArQlZP7RhNV9UbCZPUgsmzdKVFo/k2g35gOUW5W7eOBbJAeefodv6c4zxJ5cEAZ6I4TP
 ueG+In2s=
X-Gm-Gg: AeBDiesn0whDp8UJvXNBt8dPULtSLZdJs7e9ui3Z4PimsAg3I5vBqp7L+Gy01YWFUSg
 QY8hI45EpVkYJTaMWeQd3R5kZixv3JknCRz2aUL8L+LweDZdhrjWhhaApGlWPrnemiPPluRIU+k
 YYKGUH3rLh6wY6kg5RYKFHjxR4foHjmPgO2D8e0rQR75MjVZeAw16k6n7aSqaGLzWUYVP9xBtZz
 ULnZ1IVO5Yv2BKRtlHivhANbn0V5f4WU335TygYgH+F1kdEhrl6SydrXfyiIWUO436LbgVjQe+0
 MSpDh6ieKedAUt3JwOxk6scPfDLWzn4FFYL1U2QDQcXuRwBlS/t41He7KHxluOxT2FMlQSkuW/b
 s+OwKHcS1dMCgvm3ZQlZRbv2u3nZGV5Onmlpz9zjm6wv9DDXo6NI5CJ0BUAV23P4VaQ9qsKXSfM
 fnAFngYJozaA3m/KxZYig8ZxAnBZlqR8HLplAADDpLIInfgooO5C8BL2yzxPBeFwXyY/iQywXN3
 oRXPbmfDrw=
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id
 5b1f17b1804b1-488fb792e84mr262263555e9.30.1776887882970; 
 Wed, 22 Apr 2026 12:58:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891b46cffasm285619915e9.13.2026.04.22.12.58.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/48] hw/misc/cpc: Include missing 'hw/core/cpu.h' header
Date: Wed, 22 Apr 2026 21:57:00 +0200
Message-ID: <20260422195746.88865-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The "hw/core/cpu.h" header is indirectly included. Include it
explicitly otherwise we get when refactoring unrelated headers:

  ../hw/misc/mips_cpc.c:36:53: error: unknown type name 'run_on_cpu_data'
     36 | static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
        |                                                     ^
  ../hw/misc/mips_cpc.c:40:5: error: call to undeclared function 'cpu_reset'
       40 |     cpu_reset(cs);
          |     ^
  ../hw/misc/riscv_cpc.c:34:54: error: unknown type name 'run_on_cpu_data'
     34 | static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
        |                                                      ^
  ../hw/misc/riscv_cpc.c:39:5: error: call to undeclared function 'cpu_reset'
     39 |     cpu_reset(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-17-philmd@linaro.org>
---
 hw/misc/mips_cpc.c  | 1 +
 hw/misc/riscv_cpc.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 924de855ee2..d092f76f44d 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/core/cpu.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index 4bf2fd8db16..e04ccdf54fa 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "hw/core/cpu.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
-- 
2.53.0


