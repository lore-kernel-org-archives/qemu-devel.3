Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wWH-0003Kv-Ow; Sat, 04 Oct 2025 03:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUy-00022r-EQ
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUw-0005Oe-GM
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso24497845e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562164; x=1760166964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jsckaqb9TzxuZ4kW/TEprS5FqTjqvsqldlPp1fyhGNU=;
 b=WnZL28klOzXEMpN+3+/2S+/bTh2UV1vKUx2kxxDEQjYqsAt4VG2WRSX5OvHoU71Y2N
 dZ004AwaNMuHh9HZaHwX7FNkyn9GVE6d0iuRwnO1KyQ91dRq0YcqoRHHUZQY+oazqRj0
 5dcIXdhR6gDaoz7hNh1sIb3U9SPcqAoUPELHirq5OoGGeI7KBBIT1FZEas9w9p4PNXvq
 9wgHZwFwjvxm91vwd6j0Aj9Xp8m1RMmUTRSWyPEQGJrYlu62NbyJtwzAVBKpVuH+NhDi
 d6TuwqiF4kKfHEZEGOS83AWMW8z/mBRDtl70up2TnOWlMyr6MXayHXa/PvBD8ktW/66A
 OcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562164; x=1760166964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jsckaqb9TzxuZ4kW/TEprS5FqTjqvsqldlPp1fyhGNU=;
 b=wI9HqQFL1YpND9kCB03qhdRZyWBRr6oYTz4ct2gE5Fm2aebKaG6qDOtGKSPCCRO8dT
 pUEJKCNznOa3W3KM41Ivoe9DJWE9rjzfw7vPtqO/+mG0fdLGOJo3n7mInOZs8buLvOPA
 BPVs6h7RKKYUnOnYTfOZC3e/J9WHwKmJOT31gC2e1xEgCzX7suWdRJ4Ymjhw9xlDT9dg
 x1FBMaXCaM9df/X3iy1QSUoDNkA8mTpxNwEDvWm3nEPNN2HcIqqFMUABJp9inIZR+bYB
 zC9DeCukKWwnlK8Y6dO5F2yPtEF6z36S4RVHWUJzp8u5TchVIWstYwJst6gb1WaYJLZs
 Ul0g==
X-Gm-Message-State: AOJu0YwHmNcmXrES87wJrufWTeCsZ34C3Wlx9U7ykd4ne8tAywt0A5vr
 JnpTRXBTV5/mgdm+gh4syI5ffOUY0mn9sQzARIBa+DYUITcUNeGF4NjfsKCe321vJW7UEz9aJ03
 e4Fyc32U/KQ==
X-Gm-Gg: ASbGncvw2UgjBaWvmkykTsr3epPSBrGOckmUbk4E3ENJQhsQ6av2fwm3zKqA3PN9Co9
 i1SecmzSkEU+AeBxIdt4tqfYlLos/9svMhJWBpa0ShYMvacQtPKRT23rf3bYZz7VviLfabGR/TZ
 uCuC1jI0mskzZv17TWwauPO2QvqCd573YonDylmP9W65hLhsg1RkLGma3E5vHHV4X9OHmXynolf
 3MH6FV4LHYagBy6XMPJp6vLrf4ahWXPv3cK2IQ4zu05HEdELSI7YhNSkPxMNCS6txEWWorvIAa/
 u1mDYDEH9aBF+i3QJbonJlacbTRW/EihWTBrqOVP/xft6IQa+e7sV21D0qFrWfSWCvUp7lcmIZC
 QI71wJ0V0luIznJse+3FHPyKZ97dT2rF7gIMXbZX/+4c+BYd6zJaIuzsPe32H2TlJe8baZ+MSM/
 c22xz/+zBFs14d7Aw9uDzL2d/XOukINT8MfsM=
X-Google-Smtp-Source: AGHT+IHWTwwK07rtJH9uWz91V6k0TKKT6A/gjIKlHKB6DzOT5OBB8/nsLHKxyyoQh6fZkRQKTRD17w==
X-Received: by 2002:a05:600c:1f8e:b0:46e:1cc6:25f7 with SMTP id
 5b1f17b1804b1-46e711022d1mr37276105e9.9.1759562163909; 
 Sat, 04 Oct 2025 00:16:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e674b6591sm129429585e9.4.2025.10.04.00.16.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:16:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/41] system/physmem: Un-inline
 cpu_physical_memory_dirty_bits_cleared()
Date: Sat,  4 Oct 2025 09:13:03 +0200
Message-ID: <20251004071307.37521-38-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-15-philmd@linaro.org>
---
 include/system/ram_addr.h | 10 +---------
 system/physmem.c          |  7 +++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 49e9a9c66d8..54b5f5ec167 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,8 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "system/tcg.h"
-#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
 #include "system/memory.h"
@@ -164,14 +162,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
                                                 ram_addr_t pages);
 
-static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
-                                                          ram_addr_t length)
-{
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
 
-}
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
diff --git a/system/physmem.c b/system/physmem.c
index e01b27ac252..0daadc185de 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -901,6 +901,13 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     }
 }
 
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+}
+
 static bool physical_memory_get_dirty(ram_addr_t start, ram_addr_t length,
                                       unsigned client)
 {
-- 
2.51.0


