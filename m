Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB9AC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fd-0004Im-Ly; Wed, 02 Apr 2025 17:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FV-0004Ft-V2
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FP-00064W-K5
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3965c995151so114887f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627820; x=1744232620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W61Nij3hGw3m1XytqemSo+GMlPX7UfCwI1m0BO9rotE=;
 b=efi/ULBUOW3N1U0xx0+N+U3WCGEYIdyphmZ6ZR0/wd6fTfc70irMWSlXVncH/ih/9a
 H0PKz+cx8H/Z56lFHBmFNLRNMHyhog9lBSdYNhnSdQq3cJgiZ4vUamORVthJoGsE9YYt
 Tsbfdn9ZomYNkQsaR0YDBUSSSOeoBnxPC66WHAxAK4aynoA0Nfm/Bz9dJEzcv0tx2Lln
 M5Pf2eQnZugyTTc3UtXPTbUUrcsvYeG4ME7uaWhj+5dNgpMNDCxnVYLyEBCK2qanKG85
 XWSyzSdfON6e8TW7jqymM9FuFeqkqZ2S8F8FCn2qsnlS4ECrVav/gscKVMaaE/PmXNGj
 irZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627820; x=1744232620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W61Nij3hGw3m1XytqemSo+GMlPX7UfCwI1m0BO9rotE=;
 b=MWWlrzJHYQZ2AVcAXauwaOvtH6vM/WGuwL+02j5VYzp8Uvo5y89lw9Gtvy19MHdlwq
 qX/bgMb+OBPIJJSG+to1HA8YwBMm7081NBCBaHJRApi6xZQuXgMJVSYYaPUfhpF+96/N
 s3gdLERMe8OzWOwqRgUpFlwAyGRf2uzgEbqEPp6qNAgDh8/c12NPCcUa+TX49JucR4A3
 1UUEW0YMiBa9EbO9v3+9Yx5EfJt4eQ5iqq+gdFZJfIwJuVfzn+Pise9xj7FxTNe9vAAS
 y5juSv9ag9NmfJtGCBMmNEPZwjsmxY+fo0LMxVuDjgL8yvxJIGgcY3r65FTUonaOm75a
 oGEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD9JwyTptCWbIUjcMj0pHA9NhOMFAlCl62qm8O3qcsj7FEK+78JLgfyoDX0EDF1NHr1SCU5EwkRB8z@nongnu.org
X-Gm-Message-State: AOJu0Yxjs4GZKEOK+9oMEB65EyWmnASBlZ1+niiCPps1p7/0fEyE0j69
 wVcfpt2FB/MDVRF4WHBjTjk4EMncYn78FK0uovG+M+eYkmoiKj8SybUNEKn5LIb24stNDGRO315
 v
X-Gm-Gg: ASbGnctopI9vf5aXd9HIKuvDhyW3K3RiudOVLh8ashQbjmG/ivnNUZa+TGh7R3YtIY4
 2lU/hu9qSv7MC0swAw8GpUZVkfW7pNwtMZinV0HMWZi0gO1hq7Tm+73xYHebNVV+dcpaFROdVov
 WJIK6NN1+ZSi9iNJw6raxg1WI732PbK0MieF6d6ZEw+bs3IVjJ0g2cH6n4EFCY63hopa5rqhs7T
 ca8Dje69gFfA1ABz8T/1VBAUB0gowjBzdODUraer7yK+HXvE+TO3r4d+DfKeLex28k1Cnv1YmEq
 7bn0BhAL5w9IJM75kUrBKnmdNAvc68GFDMsP1rOujiJQTSl4olyg8vQKbZdD4B9ak4fTqAQ+uKo
 /zHQ/Ztaso+87FRwgvpw=
X-Google-Smtp-Source: AGHT+IF9RfFz9q3umE5DmYiy5miHELFOM4ShkSjN6alDGEzZ4BPCWVOYBWOiuQ5PQQNbucun19iVjA==
X-Received: by 2002:a05:6000:1787:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39c2975344dmr3835507f8f.17.1743627819975; 
 Wed, 02 Apr 2025 14:03:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm2049385e9.14.2025.04.02.14.03.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 02/43] tcg: Always define
 TARGET_INSN_START_EXTRA_WORDS
Date: Wed,  2 Apr 2025 23:02:47 +0200
Message-ID: <20250402210328.52897-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Do not define TARGET_INSN_START_EXTRA_WORDS under the
hood, have each target explicitly define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 4 ----
 include/tcg/tcg-op.h           | 2 +-
 target/alpha/cpu-param.h       | 2 ++
 target/avr/cpu-param.h         | 2 ++
 target/hexagon/cpu-param.h     | 2 ++
 target/loongarch/cpu-param.h   | 2 ++
 target/ppc/cpu-param.h         | 2 ++
 target/rx/cpu-param.h          | 2 ++
 target/tricore/cpu-param.h     | 2 ++
 target/xtensa/cpu-param.h      | 2 ++
 10 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index 50c18bd326d..394c191da8d 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -8,10 +8,6 @@
 
 #include "cpu.h"
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
 
 #endif /* TARGET_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index bc46b5570c4..cded92a4479 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -23,7 +23,7 @@
 # error
 #endif
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
+#if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 63989e71c06..dd44feb1793 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -24,6 +24,8 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f5248ce9e79..9d37848d97d 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -25,6 +25,8 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b46409..635d509e743 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e56..dbe414bb35a 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,8 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 553ad2f4c6a..d0651d2ac89 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -37,6 +37,8 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index ef1970a09e9..84934f3bcaf 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d2..eb33a67c419 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad059..e7cb747aaae 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,6 +16,8 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-- 
2.47.1


