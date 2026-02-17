Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94A8E68157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkS-0002f2-LT; Tue, 17 Feb 2026 04:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHk8-0002Ov-5F
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:47 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHk3-0006B2-Qr
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:43 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c6e191c4b8fso1354505a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321886; x=1771926686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH0dnvNM5971XYrImykDmi/zsT4QBP8YuEiiUlIsVhQ=;
 b=Ram+1Hl7of07iGuREUc+nsukug8UaCFxUDAYso7vG+W+1O7pOdCW+D3RO2bwnzFs8m
 b3lZKaOoHP19TABQx8pCtyL77lFdxn0cjSFgsouczDAWr8P/P6mqNM9a3vsbn0XMsnPV
 xv+D+WuQbfTJgMOEgBwdDpB/fD4MVSiuNoctwJqmOuSqKfXirFLz7xISaR8Heb3iEoLS
 81KrUb3E0oVjna8g6gtgFm/w3jOpy8cxtEtkXKYCYxsn5E/IhMlvHs2ygEp5VgXoFSiU
 bgNiA+3JUVpmoRc9/HRXWOWlkEjs9m3Ra15Nro4oS5mgbMWubbpKMB9qxr/4mh2/oP6M
 MXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321886; x=1771926686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lH0dnvNM5971XYrImykDmi/zsT4QBP8YuEiiUlIsVhQ=;
 b=LEWgh/3/b2a9KMHwKihiJbDytcx6/ErTAc3ROQximnTPTT0chLq5qDAiuYRxwC+Hll
 4335vPGK0NQDDxwKxn3u8LjuIcfPqW9lNZtY53qxjE7Wt+GQbu0xR0tMzoOHoKPze5ig
 SjIsMV/psSbLDZiPM2+MqEh1jn/12eHYu9DzlIelBU2x+xyLIf3lKM+kjrSJghCw9C2C
 EzQp3QkHKzp0Cunyn8WBgaNpgxpdwJ3N8EQIdYkKErbbYecqNHnRxj3OrdtXn16VpGQ7
 ddMWZ52N7+ZZ7RSnsGGR8BSqmdvGf52q3Xg8CuV2LGei36Jtkt6EO+eJOxjlWe5Iaqiq
 saxQ==
X-Gm-Message-State: AOJu0YzL8VnkuW70zrExnJ/Xd2/BmVtLPutOkcqG8x+hd7Ti08m1B4qG
 egvo3c02MO/nohnWJBf5f6lPZzn4TFX/PeaktrjiQOxg4C+zaLQg0SKrGHtqkP4M6yHxRM2qF2t
 E/rPg1kw=
X-Gm-Gg: AZuq6aIcBMZWLgg0q7JVtV++3Q5MXB0pgqGocMUJwK0s2KqfE5xIaYB0bOPx/eYXtjQ
 bHuBrjqL2nhUNUfRLCWRfI5kNU0lUbkZ1WniNJE9cfmUDHZr7ybKnyrRWcb0nOWqu5hByw/sWZU
 P1qCUYWLn+xZ5jWFb4QjmE4CqW7d59Bg3fc9/+BKK8gqIvMckicI00ZC1YhXkZ08N5wmvaKG5U6
 ybZn4km2rTwko6JJi0N7XYn1cgnTK/IEjUvPOgzVeUuGR+fNhnda3ivTuBppeb3I0Gv5gMMD0ti
 lI3xXdc06U5vBb1vFYn834XNt/ZOvNzFcatyuyLNSicn65e2FWnSvFZAIfKc064zHZVyFlbepqX
 HB0D7IBGnPT6xc1AM1PDPqlkd5srIJ6X6dPsEzt0o3jiYfJDwn80cGldGQrDXi+7fJ39wSI5wjv
 ZjaTVX+Chjn8kIEhJLuJirbtLFVaw5R1Q3tqYKaqKjJ6xfqMkx/rnjs12yJiMBOarbIbz9nu11c
 FN0tcbC0D+1M+CkCMFzTzbu9qsVUDfi44Jbqbw=
X-Received: by 2002:a17:903:2a90:b0:2a8:ff32:5f96 with SMTP id
 d9443c01a7336-2ad17430becmr94246895ad.13.1771321886297; 
 Tue, 17 Feb 2026 01:51:26 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 6/7] page-vary: Build migration_legacy_page_bits as common
 code
Date: Tue, 17 Feb 2026 19:51:05 +1000
Message-ID: <20260217095106.598486-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Use target_info->page_bits_init to implement
migration_legacy_page_bits.  Because this is the last
function within the file, rename page-vary-target.c
to page-vary-system.c and build once for system mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 page-vary-target.c => page-vary-system.c | 19 ++++++-------------
 meson.build                              |  2 +-
 2 files changed, 7 insertions(+), 14 deletions(-)
 rename page-vary-target.c => page-vary-system.c (74%)

diff --git a/page-vary-target.c b/page-vary-system.c
similarity index 74%
rename from page-vary-target.c
rename to page-vary-system.c
index bc4d8931b6..6c49c10e23 100644
--- a/page-vary-target.c
+++ b/page-vary-system.c
@@ -1,5 +1,5 @@
 /*
- * Variable page size handling -- target specific part.
+ * Variable page size handling -- system specific part.
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -17,24 +17,17 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#define IN_PAGE_VARY 1
-
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
-#include "exec/target_page.h"
-
-#ifndef CONFIG_USER_ONLY
 #include "exec/tlb-flags.h"
+#include "qemu/target-info-impl.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
 int migration_legacy_page_bits(void)
 {
-#ifdef TARGET_PAGE_BITS_VARY
-    QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS_LEGACY < TARGET_PAGE_BITS_MIN);
-    return TARGET_PAGE_BITS_LEGACY;
-#else
-    return TARGET_PAGE_BITS;
-#endif
+    const TargetInfo *ti = target_info();
+
+    assert(ti->page_bits_init >= TARGET_PAGE_BITS_MIN);
+    return ti->page_bits_init;
 }
-#endif
diff --git a/meson.build b/meson.build
index 4af32c3e1f..1dc10f144b 100644
--- a/meson.build
+++ b/meson.build
@@ -3835,7 +3835,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary-target.c'))
+system_ss.add(files('page-vary-system.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
-- 
2.43.0


