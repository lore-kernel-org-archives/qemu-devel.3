Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF1C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEvs-0008PO-BR; Wed, 30 Jul 2025 18:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvS-0007wP-3z
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvQ-0002I4-2P
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24009eeb2a7so2989735ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913126; x=1754517926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESNH6tmDlZQKXvIEUDfACzeOwl9XVsRpSNf/MFEy7Vk=;
 b=Y3GLZlOH84bS1YYGGR0WmSxJcN/VCzuMDY0VEHk3XWxYhEg1Mw6S63f7F6ZM7qomrt
 1ONkzduKpZ4qUcJeathXk4pSBeraWs9WE8nI/38GCJ2AxVrQDXasTcRVY75hZUbmIt84
 gpRDX2OCTD3a+NfX88UUwEpc2C4Gi8n5ZIbPhBIvkSNf6JN77+uJJrWFYlz7/2T37V9c
 8+B1sQhZpehIbbCqyLLQbg7UzcC9UPPwJ5t+MnVfU+ZhFXZZRxKYhpGKEqjJOB7QUx/c
 Cmfk2BtF4V+gcnWSmSbn7578qI7nOrKVgMeqzH+JefwnlG+VULDIB1kNciRaF8jzEykC
 v/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913126; x=1754517926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESNH6tmDlZQKXvIEUDfACzeOwl9XVsRpSNf/MFEy7Vk=;
 b=LsivaGNmvGhfiaZ7df6bT+WnlGclSrd2p/s2nYBKmHAZGOrbGBsJuWg/kYPq4qO3P8
 Y0hQP9uJAZkeQMqwns1nUeCvj9ZJu+orbNKrytuo7grE6yooKXxWn2ZnqFnEqZzC0MXG
 yucyxc6/1vvsbWzOk7oSyTL53bYwJDPK/uyvUGPW6a7edi6LlkxGbffqBpWMzs2bQ4a9
 SOwjH/VNtvsCqOdPdICjR5iahQmxCk0MSlBaX6RsmbBEHaghoZ0Wb6P7lW6K0fzQHblo
 qfFkwE7sHysVSzS5++Ty5Vciq9C8zg5BiC789cSa0Iz4cky5dzPFX38Ya3pxNyCv76jd
 FHZw==
X-Gm-Message-State: AOJu0Yw1YkAejRJcVtzU2ydEGBNl8l2FMeRlkcQE12l6M6VL9qqUPkH1
 gQi7NR9quCFB5QpAB+c4gKqpVjwHbZdYsFwVOqSUCSYecM8zj1CgY/OkAm6H5WaFXkIrwaxxOkh
 ol1xx
X-Gm-Gg: ASbGncuXn8JxBCUv3soXCyF4/1v5Yl7Tnjb4c7BfQhmZzQkbG6aaMoij9OGu3YEHMl8
 H6hUj3hl7KqamCVwkjI6nRJGNcPWZhweabdMQQiPU9MOM69DH7UdxI+fGdxRDivjHEi4pM6TIHr
 CswxocelxieriZ7HBgb/O6aCD4GLWzBj9REYWIGBKpN9pz+a6MFMvIqZJssxfihKbmfTgg/a9Kr
 mFVKFbRu5FWOEr785ZbesGthBwxnW0/VlfYBtsaFXQH0QsoYWnvWR9KGvqbjCm2bhdKJnnap4Rg
 tMFi5qJ7/HgIIMOB59GVekrJRbsTPKTnpX0QVZu7vnz080MUkCNaPgI3a53EYOpQRcA0ytyGpi7
 6TL16bd1RNRVwrnsNAwl33/m6qMZi1Pe3
X-Google-Smtp-Source: AGHT+IENLnl7toIwOFRS4iMQ8FbhV3WtKZb/Axrn6nfG+1o3qfmgV0pPHd3Kx0Ku6h58uhHnzIgi1g==
X-Received: by 2002:a17:903:11c4:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-24096a66231mr69425055ad.13.1753913126256; 
 Wed, 30 Jul 2025 15:05:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241afb7037asm1266325ad.0.2025.07.30.15.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:05:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/3] cpu-target: build compilation unit once for user/system
Date: Wed, 30 Jul 2025 15:05:17 -0700
Message-ID: <20250730220519.1140447-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build        | 3 ++-
 cpu-target.c       | 5 -----
 target-info-stub.c | 4 ++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index e53cd5b4138..218a9ad203e 100644
--- a/meson.build
+++ b/meson.build
@@ -3874,7 +3874,8 @@ if have_block
 endif
 
 common_ss.add(files('cpu-common.c'))
-specific_ss.add(files('cpu-target.c'))
+user_ss.add(files('cpu-target.c'))
+system_ss.add(files('cpu-target.c'))
 
 subdir('system')
 
diff --git a/cpu-target.c b/cpu-target.c
index 772e35495b8..f030e2c642e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -27,10 +26,6 @@
 #include "hw/core/cpu.h"
 #include "trace/trace-root.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
diff --git a/target-info-stub.c b/target-info-stub.c
index ca0caa3686c..d96d8249c1d 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,6 +12,10 @@
 #include "hw/boards.h"
 #include "cpu.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = SYS_EMU_TARGET__MAX,
-- 
2.47.2


