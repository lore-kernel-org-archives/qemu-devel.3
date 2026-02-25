Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A1FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCJ-00087w-Jg; Wed, 25 Feb 2026 18:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCH-00085k-V1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCG-0004MS-Ds
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso2360305e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061695; x=1772666495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ARdIpARQ3lv1qJ8PgJ5wSqMR0eYFxZ0UZbHfUFLSJ4=;
 b=gLkpfFDxNZOzqmKc/iMEr/jhVB4fSqG53HuYFWLeMGDDsaUDIL72BHVc/PU6DFxwVn
 FaGG5VVw9zl61RuLA3pLhBjn8srJOIHe1lSQ0o7sB2NU54O2e2hhcrQpCTR9KJorygHe
 xmfBxlIOXhQvEZ4VSR/pUm15otJYhN1YwasYTAKeGWf8JHbccUpaTUH1WXFMEk9HSrAQ
 qZ1cYtLgkSJEAPbftUYwVOWwAWWr1rWpe+syLm02XoT4IVUgbjClbvBX1CdPJak5QIXo
 guj05aaEmmrDKkmqLpWNLorIMrdnXamI5IDMkPkFCzr7yYn3j/WVBaKSAgg7i/RDxvTE
 J04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061695; x=1772666495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+ARdIpARQ3lv1qJ8PgJ5wSqMR0eYFxZ0UZbHfUFLSJ4=;
 b=wbJSWnw9M2RfX+SEbaMNFVHHBQlQrED7rqi6Ql/LuJzFvh9tDFB5TocdqqOSL4tP5u
 npQy1FtWRMffI8X6LavrPC8iKZPs9udxSFJ+cZnpYARCySE+1ttwnT8ZmuSZgUyKt/JL
 8Z0LWvYRbSe7BL1/k53LybyNF43ogrsfCwmJagc8HZTMEnYYyJD5IQRcIX50f+jVQfRa
 0qqIU0A1x4RIQLU3fY39wZuegGrQ1xt/lB0lJxjFgv+Nnv3M//qpPYUP4t/0V6UcMpdi
 AGIo/35BI0G7k/TZMWkHufTyjPPYkNQtWkxJWluRs4ueVJUMHgKXEmMrwaTy4YCW0dRR
 mMbg==
X-Gm-Message-State: AOJu0YztyBlKHXvS7zpPUJWe+z4MMwTWy2OzqeoMC2WpmGmYtVml5v7q
 2qEGs84nYgyUrzps4yNYHFPRtWrynD/G0Fjd5v1REGHhfMXhJQ1dtz+DzJAb766CVx3Bt0il5Zy
 1wIiK1bM=
X-Gm-Gg: ATEYQzxOPJUyasQPu7oqsjpNpIMAAQ4ti6ofKMhVqVRMPv2z4JiTBxdKIBN+IftKp+h
 RdmLZzJDf7Ru6NEIH/EGY7jTP3qQ4C47sOi8fJG59MyhsUOVg+O8dxRW+ru9M1rFHMMJ//f/f4b
 Ygis67LB8AuL9p/VV0iqYNyKyZFveOXtnQuLrUdwbyvfW6xRbRSmp116hvAkLHAwU6zoEEA5rD/
 9jSciTh+hb6OBGSA+LiUS2wa7X7ch59jMsI9BZeyXYOLRbAy2Nn9RfEKAg6oF5fwT+ScvFntsRC
 d+SHQnPt8WbuBn19XbDhxVoY65QaloZJIpFT+O/26MTTWPK+sB2xr/LptketvSGtwtpN193/RGT
 vFtjwML5YnDwvtDOgpU0swmT9BIw59FAMh9Dso1eW1TXqNt5vq7wmU+uUAKfvJ3wzYl01G4fxjv
 HTiWW1YYB+1q4weFi2QMp+WRH34fJf5e4itSkoP11RXugLSMBwUWuXVZPEH6H+poK74Tq7gB1eX
 uYScrZFxMY=
X-Received: by 2002:a05:600c:4e0f:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-483c3db50abmr1442405e9.6.1772061694558; 
 Wed, 25 Feb 2026 15:21:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770e7sm4535055e9.9.2026.02.25.15.21.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/70] page-vary: Expose TARGET_PAGE_BITS_MIN definition
Date: Thu, 26 Feb 2026 00:14:05 +0100
Message-ID: <20260225231411.96482-66-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We'll use TARGET_PAGE_BITS_MIN in page-vary-common.c,
so expose it via "exec/page-vary.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260213182713.44924-3-philmd@linaro.org>
---
 include/exec/page-vary.h | 14 ++++++++++++++
 page-vary-target.c       | 15 ---------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 101c25911c1..3c77689ca52 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -20,6 +20,20 @@
 #ifndef EXEC_PAGE_VARY_H
 #define EXEC_PAGE_VARY_H
 
+/*
+ * For system mode, the minimum comes from the number of bits
+ * required for maximum alignment (6) and the number of bits
+ * required for TLB_FLAGS_MASK (3).
+ *
+ * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
+ * page size to match the host page size.  Mostly, this reduces the
+ * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
+ * There is no true minimum required by the implementation, but keep the
+ * same minimum as for system mode for sanity.
+ * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
+ */
+#define TARGET_PAGE_BITS_MIN 9
+
 typedef struct {
     bool decided;
     int bits;
diff --git a/page-vary-target.c b/page-vary-target.c
index 49a32b4fe51..ab92da4539d 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,21 +23,6 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
-
-/*
- * For system mode, the minimum comes from the number of bits
- * required for maximum alignment (6) and the number of bits
- * required for TLB_FLAGS_MASK (3).
- *
- * For user mode, TARGET_PAGE_BITS_VARY is a hack to allow the target
- * page size to match the host page size.  Mostly, this reduces the
- * ordinary target page size to run on a host with 4KiB pages (i.e. x86).
- * There is no true minimum required by the implementation, but keep the
- * same minimum as for system mode for sanity.
- * See linux-user/mmap.c, mmap_h_lt_g and mmap_h_gt_g.
- */
-#define TARGET_PAGE_BITS_MIN 9
-
 #ifndef TARGET_PAGE_BITS_VARY
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
-- 
2.52.0


