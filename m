Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7B1C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38Y-0004bo-OD; Sat, 08 Mar 2025 17:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Q-0004X6-Fi
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:10 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38O-0005Kp-GJ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2243803b776so34770505ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474747; x=1742079547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcajlMgTUfCgyOIfOLm4spslr595y2hmlpKS/Lu7HtA=;
 b=DFIqQhLYzA7RJwFFFlOH2ETr1xlkYu85UEcZfrmq0o6k/8MZvQXCcfGKn/R5mvrOnT
 m50htf86mzvTh5BcCC2/C1Cgu1WyjLGEWQ74kNiH1qb4PUTFel8up5xvodUvof8YpRJJ
 UXbgcCf3Da/qzPgQIxYuDuCm6uPpPJy7x07PJLx9HWHtiQrKxC6DFZi3iqXmyfoB+uWS
 N3yFiBac9ZtuaNmNCHh9x1tSyiw53pPxb6Pwzldnuy7YxqbH+ydJhXbaTBAXAp2Ss7w8
 BCW9KFfiEv+MmVT6EJnbGjKhdg25og24NOB32vCFLBdCclPmMk1y2TNIrigfQIl6ofr+
 0K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474747; x=1742079547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcajlMgTUfCgyOIfOLm4spslr595y2hmlpKS/Lu7HtA=;
 b=vyDJV2KliJYf0JX4ByVmr0znFGhwFvrsX6mrNPnStBKP+jzBhGsq1JaCOzlZyjbUZd
 IhC5DDLVpz1gJt4y/HhceeNUF0pfv+DfVs5vWgcPzLjXuywh4mQjdXCrxG1GSQvWCN3w
 ZPj6DJJljgi7zJpD5m8Rg8Hqvd7oqZ7EqEfE6As843Krs0uo4kiix0n62kyb6bMR78FK
 Xf5tv8lxyTakwZ6vrIES1gIc/Z1SGnsuoEiihifYAe9RpL4cNeDRU5GZ672nUKv8KNYk
 BdOrLkFLhRHDC0nV51GWGwfl6pmWGziSFhpvHL4yb6vbKnrCUM9gLdRp1ejMwmdI4swB
 YQ5Q==
X-Gm-Message-State: AOJu0Yw6mzmTw9mqo1xTT+UY4IATwEgrEF2NmqjnYWcdPcrt725WFi5Z
 WyOSJInmniiPrKiNHnFA5P58ax/Z1H/zb0KldbZs+CWqliq5O+zgRReVhntjSFaJKiT0m5h23HZ
 6
X-Gm-Gg: ASbGncu2c0TrI9SAj1PmJJiFF9Fd/BIwWsI4m7tnQm4G0BXNydnT9jtYnndSOf58AKN
 qoyaWxiCTL0tSek7I1+0bbT37R97RN2eAHc0aKR91G4e4cstLyGRy7YHZB2o7deV9IFTwa9ENxO
 byytkym4CKdZBddgeh6Jkay5aRuLHDTdENhUlNg/3ltWqqUC9N0JDW5cHhcvGSEpNDUFF3b1AWX
 DHg3OZTRgOwWnqjdcvVwZSQLtcVWJ704l7uJNR6szqrVqwCQFEGrN7za5066lyA9dQDZMQOq7sa
 C1vln7Rsd3khKh/WbOz5ngIwwUo3jJquL40FjAEaGA1736aOxYy2eDG9bcRrAxsd9F1i7YFzJvC
 V
X-Google-Smtp-Source: AGHT+IF9UEhBahvFHy7TfbJiahotKU7YBC/qh0HKvNvAc0yHgbPU5VAoydc+4fZCx/bHSult98GuqA==
X-Received: by 2002:a17:902:eb81:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-2242888ab01mr150766635ad.21.1741474747234; 
 Sat, 08 Mar 2025 14:59:07 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/23] accel/tcg: Compile watchpoint.c once
Date: Sat,  8 Mar 2025 14:58:44 -0800
Message-ID: <20250308225902.1208237-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Move tb_check_watchpoint declaration from tb-internal.h, which is
still target-specific, to internal-common.h, which isn't.
Otherwise, all that is required to build watchpoint.c once is
to include the new exec/cpu-interrupt.h instead of exec/exec-all.h.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 accel/tcg/tb-internal.h     | 2 --
 accel/tcg/watchpoint.c      | 5 ++---
 accel/tcg/meson.build       | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 7ef620d963..9b6ab3a8cc 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -72,4 +72,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
 /* current cflags for hashing/comparison */
 uint32_t curr_cflags(CPUState *cpu);
 
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
+
 #endif
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index abd423fcf5..62a59a5307 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -75,6 +75,4 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 
-void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
-
 #endif
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 40112b2b2e..ba8c9859cf 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -19,11 +19,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "qemu/error-report.h"
-#include "exec/exec-all.h"
+#include "exec/breakpoint.h"
+#include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
-#include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 69f4808ac4..979ce90eb0 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'watchpoint.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-icount.c',
@@ -30,4 +29,5 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
+  'watchpoint.c',
 ))
-- 
2.43.0


