Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4486CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbQ2-00088d-6o; Thu, 28 May 2026 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSbPz-00087I-FQ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:09:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSbPx-0003tV-LF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:09:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso41962855e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779977340; x=1780582140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2H+hmMQgkzbtuGDT05A+VqXcRfQN69Gi2dkyM6rkJ6E=;
 b=CE3OwO8r/yO+vUt60G+shhD8si2p/pulZUSWMG/LS1rX5wMhW5DmCiSM5XgxryyPtC
 J4TUpWV/Nl3Gi1SerGbKtLLMKO4P9owDk3iit8+1ShJFC3ADFM+q2RsIby06GJnDl2sg
 t4N1/yDfxEZB9Dwy/LD9iGrrD345IQR5WN5iqu/5uacYn1QCXdQDS81fcM3yVPOmukb9
 BuXHW0zZNGbSZ1g4IR7pePzKJFyCYfroRpglaLSl60iDVAMhAWBUivLRW1cQbN6E23GW
 hpIV44WHohn40ex0N0YH1XrMf5qa1OSRa1w0CjA73VXmwekIi7m/7nucddY5Pq8lk4Qs
 irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779977340; x=1780582140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2H+hmMQgkzbtuGDT05A+VqXcRfQN69Gi2dkyM6rkJ6E=;
 b=aXivrczJLPoQQn0XwkQSm42B5QCx+DpuVfrAS92VjpGQfB4dtKbo02FXlye0iJZQ4t
 7xo4NW9s5lLxOaGQgvVmWmbvk21r7mQzjZIbJi5FklOI0TyJ2D/CostBxFpkg8il/4ew
 OGdczRtcGf4b24q9cIQ+C2zIKRx1ahpIwo+WWmbInnckH9vqLLTA6ukXbgi4qgipK+2B
 8cYdrvupQzUv3RedXqFc6pGXygn7WSPecrygBi8y+3irZ5Hr26Wek2g9Why1BaFLKaiK
 e/fT6cPB/j6hvYhB5Pwkzv535Hq11Ks+kkNK/OCdsFoKiVQuWWV+13x9kOMraCF2r7Ay
 xaDA==
X-Gm-Message-State: AOJu0YzEnnmOBEwXNUEGGozMtoPgjUAYe/pB8NsgLc6MfiencVniRi2Z
 7A9KjWy8ASQNuee0eWbTvn8V7iQOGIk3hQyhdKiiL0uSY9Oz6kaeObSHqHRw6FtsNkAGrWOCI+X
 5RQGmhc29oQ==
X-Gm-Gg: Acq92OEyPQKReVej3XgZnymzob8Q27y+ga28cHeBieQ3tYUnHOSNttbcikmssR+4yen
 rW5clGRtCZ5NXAb/rv+spqsJAdGxdokTtlERM+tMJdgF6NrwaQNWfv0R+1hif/Ev1TCLkTJrZhU
 EWP62ISGERmVur3GxqJ5vLCZYul326mdk0IX0JZrgcf7Elk2OS6WEJMRPrFJ0ZarPZ9VZ8scWU3
 iA7hEO5SdFcmgCvjyY/TB+9AYVYPYqY6wXqXfHt24mGCoL61DYRsfZ1z3vz34JDWlesESWw8cqx
 NdIfd04ctfPFzEIv/L0QiZdWJrV5JeTa5a8P+mXt/NSO0uhi576qmzJ0I1rOrWyUahMKxTFyF+G
 Cxz8m4w5O1D6X+XCnVBKcY3lnZvH36K8VIQiVYhMbMz7EXkr4g+gEdFwyJrm2bP1dSk1irJi5qd
 IF32Z/mddTs/jcLeKA4R81bp9tf8w15k5mZ9F7p1vlFpI/KGeRf9WbpUBgCT8BLH0kRQ==
X-Received: by 2002:a05:600c:1393:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-490428e5b31mr453622015e9.27.1779977339763; 
 Thu, 28 May 2026 07:08:59 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a82ea2sm75587895e9.9.2026.05.28.07.08.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 07:08:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] accel/common: Remove last bit of target-specific code
Date: Thu, 28 May 2026 16:08:57 +0200
Message-ID: <20260528140857.44130-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Initialize the TypeInfo structure at runtime using the TargetInfo
API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
target_cpu_type(). Since the code is no more target-specific, move
it to accel-common.c, removing the need for accel-target.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Pierrick, this is an alternative for both
20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
and
20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
for your "single-binary: fix compilation/execution for {arm,
aarch32, microblaze}" series. WDYT?
---
 accel/accel-common.c | 15 +++++++++++++++
 accel/accel-target.c | 41 -----------------------------------------
 accel/meson.build    |  1 -
 3 files changed, 15 insertions(+), 42 deletions(-)
 delete mode 100644 accel/accel-target.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 9c5b4111c8d..62590a7d9a6 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
 };
 
 DEFINE_TYPES(accel_types)
+
+static void register_accel_target_type(void)
+{
+    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
+    const TypeInfo accel_cpu_type = {
+        .name = name,
+        .parent = TYPE_OBJECT,
+        .abstract = true,
+        .class_size = sizeof(AccelCPUClass),
+    };
+
+    type_register_static(&accel_cpu_type);
+}
+
+type_init(register_accel_target_type);
diff --git a/accel/accel-target.c b/accel/accel-target.c
deleted file mode 100644
index 7fd392fbc4a..00000000000
--- a/accel/accel-target.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * QEMU accel class, components common to system emulation and user mode
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2014 Red Hat Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "accel/accel-cpu-target.h"
-
-static const TypeInfo accel_cpu_type = {
-    .name = TYPE_ACCEL_CPU,
-    .parent = TYPE_OBJECT,
-    .abstract = true,
-    .class_size = sizeof(AccelCPUClass),
-};
-
-static void register_accel_types(void)
-{
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_types);
diff --git a/accel/meson.build b/accel/meson.build
index 7da12b9741f..1b5b37e3097 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,4 @@
 common_ss.add(files('accel-common.c'))
-specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
-- 
2.53.0


