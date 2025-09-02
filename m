Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7A2CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQn6-0000Ye-UT; Tue, 02 Sep 2025 09:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQms-0000Sf-2l
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmp-0004Rn-2R
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3cf48bde952so3723208f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818655; x=1757423455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bdjUdksMSi5PcEKm6NTkntw2W6DG2YujIlvk6/azIfc=;
 b=SrsnD9RrawR1dtynLS4siSs87MW6XyVElsaL3ekYgqUsvab38tF6LNEhpeZjrMlTbe
 OuF/ek1r8T4afXaLFQkBxlI1DS+2fu3YvlxQ8hC1Ajr+jOA6muUV0fLtBxxDHBjfDc8s
 8jvwLETwAZY5ddvMh6JGb0velZRQVzkr0ymPnJDV6rEbA4m/dGZ6ldT8FxXjhJG54q6G
 3AoEAQAfNp+F4cFN5B16W6xwgEMl1Fl0WMGID6KBL/fDClcSK+2JLVAF1F6KEmnKvNFO
 Lk3jBBQ7hjRx3V46XYgdjGPS1TqkdDuV95Rgec0uYsbzBHEvDOSq0NDYADnpymKDFjeQ
 AeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818655; x=1757423455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdjUdksMSi5PcEKm6NTkntw2W6DG2YujIlvk6/azIfc=;
 b=rm6ST+pBvXHTi2g4jdP0tOGKmLnSSKOwRlmvl+ACd5KK5jGNTDT7R+gg9I2u3tkcV9
 7TnZb69QoV+Jhq3MeGwgbrLEgl180hcjzS5FCodN94RFOLQJGDuLYRECdSM8cDdaBDda
 ujAwlEWnw5jgymrXGV/4HtlqZ3BVA64nxtoxfW+7QDlIuugAmnHnotANiWmY/ukyx39r
 PIcW2SYpYiBaPgcJPjWAp5yyDj9TWHvzGUDNfmfc/CDjngrxKj6vcv4agDNYDuForKB8
 3cUdyaEcUP4g8jPUY5vp4xVAoxDZKyRsYClPPU5+XTGEKRGl8QLvbgYHapN1kwwrRfQR
 XTKA==
X-Gm-Message-State: AOJu0YwpHXVI/PxT4IA7GzWwkyEwbYiVmMXUoPFPpNKP/l1adjtEvgf7
 d0ZsMXiZg43KG6UgPxtCGj+enow39/xUX1qQXBCydh+VG+h8b9T96yuGEME+yX3iUt/UCZvfBYP
 EGuJe
X-Gm-Gg: ASbGncty1j0f08jcX+VCbSu/6I6KseP8KFqxk25eE5TVMTBUKqjAtEdGhIFXdsibVHq
 tJjS3qF5DaoYHG9g/CnH0QsxTpK/SP1Xs6ZsJmgzGkiPqfW7/SW70/KHqoIpAZeEGJi3r4FWyEb
 St9vzgrFqZ84nRiCwa2L1ULjBiC9nPp0si5nyLDCpvru4kkSq5bcLp8lAgCRduslT8bOMOgSm8N
 ccFpSAHagdXfToQNInsVL1+LmPQ7xsBjNYUTB4dLgrKPaefGTHy/QVFIDt9vTk3q/1Q32tAy/xS
 Z1nDIEUV1RpmcRwpOgns54dodL3A4YKSjK36FVEyhRPi8LJ4c5br7V5KzJQvQGda/SLJWf0CSEV
 aeQ7FIV1XcOc4e0Nac1fdiPJ8oWfMYLfDWq5UO668pm3YcUhWeJiGni3Ix7Hz1WtkmXFAAmsDDA
 RTNCm7BC2dI8zpyPugsw==
X-Google-Smtp-Source: AGHT+IHltI4oUZ06r03G6luP97pDDV9ZGvIYrYSujgJRf2wqYNfl6pOPrkB12g0+jiUPX3f6NwPysg==
X-Received: by 2002:adf:a3da:0:b0:3d2:2989:224 with SMTP id
 ffacd0b85a97d-3d229892c7dmr5790880f8f.7.1756818654828; 
 Tue, 02 Sep 2025 06:10:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc3fasm19381159f8f.5.2025.09.02.06.10.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/39] include/exec/target_page.h: move page-target.c to header
Date: Tue,  2 Sep 2025 15:09:45 +0200
Message-ID: <20250902131016.84968-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250730220519.1140447-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                |  2 +-
 include/exec/target_page.h | 11 ++++++++++-
 page-target.c              | 21 ---------------------
 3 files changed, 11 insertions(+), 23 deletions(-)
 delete mode 100644 page-target.c

diff --git a/meson.build b/meson.build
index 7ff84787cf1..fa6186db334 100644
--- a/meson.build
+++ b/meson.build
@@ -3899,7 +3899,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-target.c', 'page-vary-target.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 specific_ss.add(files('target-info-stub.c'))
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index ca0ebbc8bbd..813591c9b51 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -62,6 +62,15 @@ static inline int qemu_target_page_bits(void)
     return TARGET_PAGE_BITS;
 }
 
-size_t qemu_target_pages_to_MiB(size_t pages);
+/* Convert target pages to MiB (2**20). */
+static inline size_t qemu_target_pages_to_MiB(size_t pages)
+{
+    int page_bits = TARGET_PAGE_BITS;
+
+    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
+    g_assert(page_bits < 20);
+
+    return pages >> (20 - page_bits);
+}
 
 #endif
diff --git a/page-target.c b/page-target.c
deleted file mode 100644
index 8fcd5443b52..00000000000
--- a/page-target.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * QEMU page values getters (target independent)
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * SPDX-License-Identifier: LGPL-2.1-or-later
- */
-
-#include "qemu/osdep.h"
-#include "exec/target_page.h"
-
-/* Convert target pages to MiB (2**20). */
-size_t qemu_target_pages_to_MiB(size_t pages)
-{
-    int page_bits = TARGET_PAGE_BITS;
-
-    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
-    g_assert(page_bits < 20);
-
-    return pages >> (20 - page_bits);
-}
-- 
2.51.0


