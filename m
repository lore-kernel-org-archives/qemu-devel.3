Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B949AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwuM-000322-FM; Thu, 25 Apr 2024 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtE-00009y-6k
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwt9-0000G4-I1
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa83so1814755e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043006; x=1714647806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AM4wpjhaRu1VnbLScsMczsVnLF9tLEy5hd6kj7QFVIE=;
 b=DRP/e7hmF6iTP+67jZNGAZC5bdVnFmP3bDeqkkvXVRtNO1QVv9eP+1BQ51xeN1OnO7
 GrQgB+KpD9aKhDRUDjNILD++QhzOgAoyQo8ZV2wS16RW7tPR+z9QYb4viTK4x6Tv3tOf
 PJn0lKmm26v30ffqOJfJkntUbhMQN6/WZqaOTMQyaNG5DpTPxDWZx+2xj3ZuAmZx4rWZ
 53j8HNEgGjxvtECCQ5LQ+OPHXbHisNkuBtdoCc8+NbausmdY4/8V0bMH29qz8ZrME+2D
 BR2kWIENkCnd41O60ynhaXnLwMEJqjUYvwqt8ORwK6XzUuaraxXQQRa4oPp8YIxglKm+
 1UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043006; x=1714647806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AM4wpjhaRu1VnbLScsMczsVnLF9tLEy5hd6kj7QFVIE=;
 b=pajwHbasfcXPaAhindbfoIlB7f0BQlOCex0TRtfo9z+Za3MxG4tjOa2R1vBtEgs1Q3
 /E3aRGZqNGJ+bODNo7rxQXiSWxawZZIrH9OSB4+3QI8nYN/w4W5WVXBzOJpb+a2L1e3/
 LhV4qDjhUoAq1SQGwtYpZZSyl8rfmMePGGS9kKVHYu9ws7mC/JGdL3B+6eQztR5xEDjs
 ODCu736Q/xGJcBDyYXM0SWsqWY11jblmZHZRDFkKcmYNYuo8gMX6rm844xtLn7wFZVJO
 Z9XrCTLwAt1NsfQcQoBa9z7I0ZhxG+mmP3NZLcauTmUcTLowXKuSpmtP3T5lsLxIV0fV
 Lqgw==
X-Gm-Message-State: AOJu0YyyuI/7yfjf7uncyuQnMiFAanOt2Oa6pE+t90a6MUr6Vn4fJT89
 4fzOuIhAXkkevgIKpCir3cRRDsOi3yA0RMuTvulajnAMQrhVio8cqsuzGLic2JYtfiMQRKqgW1t
 V
X-Google-Smtp-Source: AGHT+IGe49IAc2SdSXO25jaUyqK6FP6td8CeYnIlxdI0bb6LP3p3uwTpqkW0EOAH6Idsm470AsYsHQ==
X-Received: by 2002:a05:600c:4508:b0:418:f991:8ad4 with SMTP id
 t8-20020a05600c450800b00418f9918ad4mr4383715wmo.6.1714043006094; 
 Thu, 25 Apr 2024 04:03:26 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b004186f979543sm31187720wms.33.2024.04.25.04.03.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 15/22] hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
Date: Thu, 25 Apr 2024 13:01:48 +0200
Message-ID: <20240425110157.20328-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename "hw/elf_ops.h" as "hw/elf_ops.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424173333.96148-2-philmd@linaro.org>
---
 include/hw/{elf_ops.h => elf_ops.h.inc} | 0
 bsd-user/elfload.c                      | 2 +-
 hw/core/loader.c                        | 4 ++--
 linux-user/elfload.c                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h.inc
similarity index 100%
rename from include/hw/elf_ops.h
rename to include/hw/elf_ops.h.inc
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index baf2f63d2f..833fa3bd05 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -383,7 +383,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index b8e52f3fb0..2f8105d7de 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -305,7 +305,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_word        uint32_t
 #define elf_sword       int32_t
 #define bswapSZs        bswap32s
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 #undef elfhdr
 #undef elf_phdr
@@ -327,7 +327,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_sword       int64_t
 #define bswapSZs        bswap64s
 #define SZ              64
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 const char *load_elf_strerror(ssize_t error)
 {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f4a0b78c75..a0999dac15 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3572,7 +3572,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
-- 
2.41.0


