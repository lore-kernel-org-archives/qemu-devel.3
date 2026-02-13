Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A8EF99C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxtL-0007F5-4I; Fri, 13 Feb 2026 13:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtK-0007Ew-9O
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtI-00063r-PG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso9620175e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007263; x=1771612063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/K35hnw1YfjsQjH2gQ+ALFmPtNIwNBwDPgyu0NG3wY=;
 b=Mqv73W2lKeDtge7vVlWQ1uCtghmZbsMSdjoos0uGrriRS6b0SUzQKnvXUfzoztGBx7
 MH8sUNn6vGLD6D95YMEmbeO97n6pMi2BdpoHUc3JqRDFECuznSnVRRK2QwP/ZciQkozK
 6DfVk7znhU/iIU6pCLrvQqcxYkCp4zub8QM4adU9qpod3Xlv3vY7eTpylUds91+i2R0B
 Gvbhx3VA4mzlSv6UUEHlwjeBMw6I4GuPaieYtkVQkENtIJaAknprLb8mM40yzCl2cf9f
 ipwQcde8BaaAFLzCC9aVQR4PWOYZKFcBmM3AUC4QjafsZInLpR+zcjRkgNi5kC3RGkJt
 wqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007263; x=1771612063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H/K35hnw1YfjsQjH2gQ+ALFmPtNIwNBwDPgyu0NG3wY=;
 b=eZgWxo3sVFh7BjV5OTRtdR8RjKF/Tgp271vZ4eDlG2AGpKCHqLL8uBn1OKISmuqdTc
 aELQMBN0liyCtJEKhGmZhTV+h9laWT609xSJie3iSLUSQtvuvIshitxl2IiN8cKmNCHk
 IksZ2sn3CleO+nDJbhySWpzuo7JN6AIa6RCx5EUeGo2D/zz+I/WgNFKHgVORJAflkh/k
 fuhUGKUtcmOkubJ6MKjeVCCwYjLix5+4M0F4xOuhkqifkYZvrOSN9OuowEx7QXWpZNnR
 afqMdf0ss/lP1uXtyoKEb3AihnF4V+JopJ5qdvMeseU0uhNZgnM+MjMHzHIpuPxJCuuN
 uhnw==
X-Gm-Message-State: AOJu0YwEXxmUC0gHDU7rjEZ0ngV01aQql5f/3CVX97oObvPMLrSdlhAI
 wZ4Ew47+3lmz+sivd9OS3+c9Qai4rYC6a5H+N+8KlSnJWkS8ol3hHUkd12zzlLKX+ZsQ5ZWLrf7
 M1qO2K1Y=
X-Gm-Gg: AZuq6aKb9lWCC22eKWH45sWJgmKPUVfQApbZjHn6caHHMsXEpVTTvM+J6ZbLoV+JbV7
 jl/4O7lEyxvY4ymyCUXEdb8DZLwHvmqOhFRaSxe0L3Aui4o/op8KuQfKeppM5spq6Wq3gct4Zu0
 4rbLFf6Kk9WplB2vFxaXrry4Oc6h1FsZL3/+BoYhabFY+x7VBIOLKy1+3PWJfmRrtjkfGT0adKx
 rSZrSxIgWS7rMVJQv5sRkkJbu7VFXdIUcOCv5y1Zfexw0tZFRq9vFwgLltmVSk9qRrQl4CgimKJ
 K7xvGwSNBJabL4ib/Kik4vS03/Ga/cxROXtyNRM1mnts2UA7QUaQq6L7c1nT3AlHFq0gNwu421Q
 0sfiqAejURmKySsQCMnZ4wB6uNh7blWLY9WdcrWnoXRUD8Emvo2xO9ln3r0N9JEjLWr255jxDMV
 z85qeyTjOg/O3gjIHzmT7/yH4rhTVN9wMt2A9EiIEUokqzkKVvlvoVwRIg5lrY5gLLVbxQ6fwG
X-Received: by 2002:a05:600c:1907:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-48373a7a0eamr46674505e9.36.1771007262793; 
 Fri, 13 Feb 2026 10:27:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a1c2sm410793915e9.9.2026.02.13.10.27.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] page-vary: Build set_preferred_target_page_bits() as
 common code
Date: Fri, 13 Feb 2026 19:27:12 +0100
Message-ID: <20260213182713.44924-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
References: <20260213182713.44924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

set_preferred_target_page_bits() doesn't have any
target specific restriction anymore; move it to
the common counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 page-vary-common.c | 10 ++++++++++
 page-vary-target.c | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/page-vary-common.c b/page-vary-common.c
index ab77672dd41..a2417354cc5 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,6 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
@@ -43,6 +44,15 @@ bool set_preferred_target_page_bits_common(int bits)
     return true;
 }
 
+bool set_preferred_target_page_bits(int bits)
+{
+    assert(bits >= TARGET_PAGE_BITS_MIN);
+    if (target_page_bits_vary()) {
+        return set_preferred_target_page_bits_common(bits);
+    }
+    return true;
+}
+
 void finalize_target_page_bits_common(int min)
 {
     if (target_page.bits == 0) {
diff --git a/page-vary-target.c b/page-vary-target.c
index 5fb79eb5752..a81c91410b3 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -20,7 +20,6 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info.h"
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
@@ -44,15 +43,6 @@ int migration_legacy_page_bits(void)
 }
 #endif
 
-bool set_preferred_target_page_bits(int bits)
-{
-    assert(bits >= TARGET_PAGE_BITS_MIN);
-    if (target_page_bits_vary()) {
-        return set_preferred_target_page_bits_common(bits);
-    }
-    return true;
-}
-
 void finalize_target_page_bits(void)
 {
 #ifndef TARGET_PAGE_BITS_VARY
-- 
2.52.0


