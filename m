Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D60C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExyv-0000ct-2g; Wed, 05 Jun 2024 17:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyt-0000cC-5H
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:39 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyi-0003Pb-8I
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70249faa853so185198b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622126; x=1718226926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BA7oin0aTWc6AVl6UHRopsqXqPUuD9tfreQpdBVLhl8=;
 b=iU0qnl2qfQDmYuo1qAuthBgF8N/Cn0hRqIgb9bretfYubueqser2bEKndADPZqilHi
 MlimSH5sEkFCGqDkAwCzDlV/QzqGw8isB43cgl7o0YjzbKa9XFp1xpdgYEDltM8zmL/T
 phxNi2ggH9B+m3yzAc8tI8P/BapNX+oyQYCDmKq528uDRKTf3n9JfRgYc749Wckex38i
 o7SU2WpgXrSP8jl0WwANhsU69GOVqcyHyxvBBC54tLWgkQrU/vcFiAnVtzzmaDb8BDLo
 D4sEXUmTQQkFgJWk8FvE8i7EQMssy8R9RWWnIOOI/uIcAs64waaXKIlT9K/wpCOmAntP
 EqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622126; x=1718226926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BA7oin0aTWc6AVl6UHRopsqXqPUuD9tfreQpdBVLhl8=;
 b=j/y45uxH4EKNrwlsmjChXh9OH8LzVWUJ6ZTRAqbCugl3G0W413U3rNqyTPIG3jPIkq
 uVCfKBm5sT8O/+Rg1sRZrC9uKOtxmpzsok+lMmuSW6Ns3frIZab6QAptFUi0Ht7RYrYy
 S1SVNIEuzNpiCQqPwkhCps3SWaU4fwomBCG6snUg3cjGVqUxh0GJoXEAUISvBw3Zo0ZX
 nUPT5wvsxgtGSDzo9J7vS21Cop7Shbbx3bxhcdsBdn5hEIYv9k2c+C8RCpMa//4yIEEZ
 Ygc36BF4PqGMnOGNYJEsVsj5LtoDyl4n+Q83NaTYg05KKC5DZk4dB5u+h3ONUY4NJGYY
 aW3w==
X-Gm-Message-State: AOJu0Yys9UyYfvTKSGwp19d+Z/fOInSEjS2j8xh+7J3oMBw71hoTPJKM
 6R8ad2GO3mw46Gn2YC3XSAnh4xXXoSyoRmTDsNLtX17nfaHYPRQVku3DDFZv4v2pMWHr5uFSMSF
 n
X-Google-Smtp-Source: AGHT+IEDxkpE0PjbyH28nkbaDNmfBdtYsla0vA+D1i5jzdQV1AU+iq3VSZoa54e6+1yoVnELCugRFg==
X-Received: by 2002:a05:6a20:7348:b0:1af:f8e7:76d4 with SMTP id
 adf61e73a8af0-1b2b6ed9cbemr4875899637.18.1717622126493; 
 Wed, 05 Jun 2024 14:15:26 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/16] hw/mips/malta: Add re-usable rng_seed_hex_new() method
Date: Wed,  5 Jun 2024 14:15:09 -0700
Message-Id: <20240605211521.577094-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.

Extract common code from reinitialize_rng_seed and load_kernel
to rng_seed_hex_new.  Using qemu_hexdump_line both fixes the
deprecation warning and simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Use qemu_hexdump_line.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-7-richard.henderson@linaro.org>
---
 hw/mips/malta.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index af74008c82..664a2ae0a9 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qemu/datadir.h"
+#include "qemu/cutils.h"
 #include "qemu/guest-random.h"
 #include "hw/clock.h"
 #include "hw/southbridge/piix.h"
@@ -850,15 +851,18 @@ static void G_GNUC_PRINTF(3, 4) prom_set(uint32_t *prom_buf, int index,
     va_end(ap);
 }
 
-static void reinitialize_rng_seed(void *opaque)
+static GString *rng_seed_hex_new(void)
 {
-    char *rng_seed_hex = opaque;
     uint8_t rng_seed[32];
 
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
-    }
+    return qemu_hexdump_line(NULL, rng_seed, sizeof(rng_seed), 0, 0);
+}
+
+static void reinitialize_rng_seed(void *opaque)
+{
+    g_autoptr(GString) hex = rng_seed_hex_new();
+    memcpy(opaque, hex->str, hex->len);
 }
 
 /* Kernel */
@@ -870,8 +874,6 @@ static uint64_t load_kernel(void)
     uint32_t *prom_buf;
     long prom_size;
     int prom_index = 0;
-    uint8_t rng_seed[32];
-    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
     size_t rng_seed_prom_offset;
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
@@ -946,14 +948,13 @@ static uint64_t load_kernel(void)
     prom_set(prom_buf, prom_index++, "modetty0");
     prom_set(prom_buf, prom_index++, "38400n8r");
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
-    }
     prom_set(prom_buf, prom_index++, "rngseed");
     rng_seed_prom_offset = prom_index * ENVP_ENTRY_SIZE +
                            sizeof(uint32_t) * ENVP_NB_ENTRIES;
-    prom_set(prom_buf, prom_index++, "%s", rng_seed_hex);
+    {
+        g_autoptr(GString) hex = rng_seed_hex_new();
+        prom_set(prom_buf, prom_index++, "%s", hex->str);
+    }
 
     prom_set(prom_buf, prom_index++, NULL);
 
-- 
2.34.1


