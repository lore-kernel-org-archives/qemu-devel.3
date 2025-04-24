Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D6C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kzN-0000Og-S4; Wed, 23 Apr 2025 21:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0004zV-DU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwl-0005Tv-4h
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227d6b530d8so4631565ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456409; x=1746061209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD3+nJDQxNuFLk7Pe2oHBRQSgwi4i3j139vVWlzEmKQ=;
 b=lDi1g0gtwNkCMmNQVmAy0euEJ73WQRiQkSdfPZw8GsqwUodjtvbUKHKuMoa/jV34Pt
 ZkgsqTvt3jg2v/siYO+h3Sn1r542Mkf5lTvnA2wQn2XXTo+o4M8QBhRfdv3Gb4wlR3R5
 JN4dWGjm+Hz99WgvOrZa1BMu+N3IymAWGhTPV4E+vCd3X/Ey7suDVSFkGcY2BMr57SZb
 zuHsO1coUaDd+Pn4zTThgIXQAbFG0zGPpmD5lgY4fclK7vbi9DC7jLymKp2wnLKKja5b
 lndMsuh+42ZW3RLXeJaMGJX8s91FFhHX+UIgUdeDRVz6Dlx1g6UhsbJSaGPW1kBKTV7x
 fADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456409; x=1746061209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TD3+nJDQxNuFLk7Pe2oHBRQSgwi4i3j139vVWlzEmKQ=;
 b=A5sU4I2+eVM7vwyw/hhWvgB5YsaKDWlcQ7MrApzBZLv75GVh+2aJLCWM7KIeUry33e
 o937Fj6QIZh64xxUi+SMDDumFMI1ZqHezS9CksTg5NCHpp54dsNIfkQDo9xL9WwCMdxY
 pdRuspsOQYaHc6tT54pisKRaeO85Rr7UPjj5qOG4T8FaoDvq8rYM8UB2Lr2Gyaud5n5f
 DWR8hLqhr1nNssNNQusC2DF+ThrIuzWeMV6rWvi9h/7dP/3LbFpww8o6Qpx784hD6kDs
 1z19+6BinaKo9L9ELQbXZWbNb+ztAI9TZvaWLkn1kpWaKBXP6yNuobB5hv0iMZgYKlw0
 l/tg==
X-Gm-Message-State: AOJu0YwJbFK7caJPqBzNENguJSdfzvg+DwVVe6+gHLZk6BVQhbwT2c6T
 ol3jDrkgF6tonWlcD69jV69eUPt5ve3eF5ORnHv4dHtHYbrOJI8t1aFEETP5KLfw8LCNnsYoN4B
 9
X-Gm-Gg: ASbGncvnK7sUKo8pd5KpQlSAT+cui3BLniRzv1bHFBeBpVTzGSedRQkM4Fb8y3h+0uZ
 eHIFxPEnh+HzDhyG6ju4bec9QQqg2JnlF4dWbSWqYvNuKGDfddPYjiW0nFX1VOWDSD5V5lS9Rh1
 crc3D4s6Wgkyx7lD70DCcw3pz74ei7VbIWQp1bExeP38xmm0kncTIrKYaDhf1I18DT4tR7WmHXE
 PgE00ANCNXLdrmcRCs8yJvX7PRA2RAB1cbAtO7guSaEnpaW6A99+Mf2UrGvXQ27cBYkHHoTUdsa
 Rj83WFpDffXQY7q6eD2uNE0ki9EYi08Mrsey5W6BFOql1/3EEa2JS4K5A7nTKaMSgrdqwn4LXow
 =
X-Google-Smtp-Source: AGHT+IFKYYOq+hfSeFE8HMRyFSxiMPwenTvLmyTbMnBdPgbtPuxmly5lpwMoy0DBnQylRXPr7Z1Llg==
X-Received: by 2002:a17:902:ebcb:b0:22c:35c5:e30d with SMTP id
 d9443c01a7336-22db3c0bf11mr7968205ad.13.1745456409399; 
 Wed, 23 Apr 2025 18:00:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 129/148] tcg: Always define TARGET_INSN_START_EXTRA_WORDS
Date: Wed, 23 Apr 2025 17:49:14 -0700
Message-ID: <20250424004934.598783-130-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Do not define TARGET_INSN_START_EXTRA_WORDS under the
hood, have each target explicitly define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index c439c09f2f..d416d19bcf 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -8,10 +8,6 @@
 
 #include "cpu-param.h"
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
 
 #endif /* TARGET_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index bc46b5570c..cded92a447 100644
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
index 63989e71c0..dd44feb179 100644
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
index f5248ce9e7..9d37848d97 100644
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
index 45ee7b4640..635d509e74 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e5..dbe414bb35 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,8 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 553ad2f4c6..d0651d2ac8 100644
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
index ef1970a09e..84934f3bca 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d..eb33a67c41 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad05..e7cb747aaa 100644
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
2.43.0


