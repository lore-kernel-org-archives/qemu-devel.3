Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA030C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjb-0002gD-5g; Wed, 19 Mar 2025 09:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjW-0002dO-Fq
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjU-00040u-Cj
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso48326985e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391918; x=1742996718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krg3MvTmntonI2/Wohd27AtoieJZs7YNIWzT3yjluvQ=;
 b=DZKgoF/ax2orvua7FtAsBoeA55vkfc4eSQsz3MBkFUtqR32GE7NLZtEv4sJl43cCGk
 OFVIQ1OOP3I06N4Id7fr4EQCs7cB34uE5D71oE5DLzIfbtJpS+OqcGU6IO1zySQ4gDCC
 80S6NUMOpvoq5RWlxVYk3RHfUbl2A4M4+DLGmIIvMKU7I61mtvIjrG8j19UFCS1oWfjg
 w3j7ptJ9Kj0Er5NEWJROU/V+mlnXI1p/XYke8y2oqUNwju6TtVawtLTrwI61/EQ5V8VW
 WH1j3Ea4giPIDwwY87qb9SScjAn4URNQHvPcGmgMDOg7Gic2SoOzp/Z9m3Y7ObPnHy6m
 L8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391918; x=1742996718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krg3MvTmntonI2/Wohd27AtoieJZs7YNIWzT3yjluvQ=;
 b=DYlQwh95tvaNGeJUnhPxJRRo73ulEgVB8FMmeooRvKSIEW3QnPsCGBdIfy4MWW4+Wm
 M7v3OB1dbANXafwPfV0+JIA2vwZB1vcozyClehgnvTBZ8xGLq5d404YSwX4GWUa5NCVb
 8ZhYwxLXVZYHthgkunz4/vEe9jPW2hJDSirZIamlUPCcGgrsedIsaQ4+kQTUmVvzIUEL
 MXTfOdm+KWKUaGVE6tB5bdJdLljFeSWZXKjDVUd9zg6CNv0SIEPa76G4z2p9RVW2p41j
 TourEXlocbCcgF7qHXlXwvA7/54cXL4i+fNqzsl6VoUI523JkORWahJKx/vQslwEjmee
 LNCw==
X-Gm-Message-State: AOJu0Yx430pICWY5UWS7TpjLoRCoKxoitAY/Poe3a3rTAS4C8j1U7wXE
 tzHl01x+tZIqZDO76TqLmAwa2ecLD1YDmzBrGQnEhXQiqZK0fb80qa8PgxdrQeLtpogn2QCnta9
 8
X-Gm-Gg: ASbGncu3mER6zVVJWEUPkT3qlfwIMxFmALdwsBz3qHCpdzDsSrYWlKrQmxp5mcUt97P
 AbJ5C/ztDxButloAzQT2S0WY9U7+KLJmEPB42ybNESm3A/auGfxUbTn5tVBZIWsC+Tficgolikz
 CtYaZK8ou7NmOEf+o2xa6bZjgpXKh59gc70NAWBN4NApP9jLsv81O8jui7DKuh/qO4OHpJsde8c
 ag7SwvIBrmMis6nchxNrrwEyzGJMGgp4kerr0TCJ3fgkI95EnOMjbFvP6L4yuYzx0VBhFJatkMu
 9IODyqp03EQVg2hZhOQoMtCmVjqQ5ILWpfzKhtb8N2rG6wPNweDg6GZScdS8c/cntw41Ejek41Z
 6rFEAs8HQs8oDnujNBt3iq4VtADiH8Q==
X-Google-Smtp-Source: AGHT+IEEWhtcouxAMK0MvY9ZiFkx8BkuYfGTfgKvugT+6MmZSc4KnEBn6SUkdmMVP+pnTXlhA6WFnA==
X-Received: by 2002:a05:6000:1847:b0:391:268:64a1 with SMTP id
 ffacd0b85a97d-39973b06e56mr2916073f8f.48.1742391918091; 
 Wed, 19 Mar 2025 06:45:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b83sm21695849f8f.52.2025.03.19.06.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 02/12] tcg: Always define
 TARGET_INSN_START_EXTRA_WORDS
Date: Wed, 19 Mar 2025 14:44:56 +0100
Message-ID: <20250319134507.45045-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
index a02850583bd..5dfddf995d6 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -22,7 +22,7 @@
 # error
 #endif
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
+#if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index ff06e41497a..c89d3ad52b6 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -25,6 +25,8 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1f..0417f8dcccb 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -31,6 +31,8 @@
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
index 6c4525fdf3c..9cb26cefd5d 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -38,6 +38,8 @@
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


