Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81240C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZM-0002ii-FN; Tue, 18 Mar 2025 17:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY6-0001LB-06
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY4-0000p6-7x
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso116514275ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333550; x=1742938350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcMlC8YA6iYsSudLw9pQkFBFmlvqHQzrCYvrc7Y0wec=;
 b=svJGE8bmdnWGUHctXYnW7T014qBCIIbBcgeiQTg/O+mCEYnndE5oAxQCp2S5K7wD85
 TEtuGtLLGyR6DCiVfZ9GWRiRkw+xoQdgQyN1F/kEKhVqW6nWeEirpjkwdrolA4dJj6DU
 EbBdLbHVmm6dE/QkDGyMYjGmfkjBgE2Zr7cIdgqOlMZjxdZA6NzOicEuIqBCF7ZuQvxQ
 lwxWxlImFxIdIPZ4XSRCKKNjF93s/L+nEQ1xPCv0qaj0qWDxHAcLXHXtIoj/fMjdZwdx
 9za+cjkNx9WbMDmf3mVx4u/UE7Wryrv2UgvmoMF0pNCUCWsDQoNpmPFFOndKHZhwgRLl
 s/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333550; x=1742938350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcMlC8YA6iYsSudLw9pQkFBFmlvqHQzrCYvrc7Y0wec=;
 b=NDJrPJaWe0501P7StwqxM+nNqIKS7jWs26cBi4ueoKdVy3P2vrIRNoFb79dA/43BLQ
 a/BWHdfgH6Dz7IcECWy9rLRGZnh8F/FkzWdfXhhAo9PJK9pUuQbQV2JG00yLID+jszBl
 wkDp4l8ZZk53H1Kl54aXgcNjQ88/jZWmdYBEw/pvuByoYPKFt6C/TTSrHYrEZUa7Vojv
 fmHkgmNWKaU+whokbvOFY7pR0rimby407zXsYmA9/GibjT0oECsiem64dMtIlZFTPLdQ
 CgpuJDdsqhBTLhLKL3eNCnpz4+N9/BZia6gviLp7NvDRyhqedMe+2EnZJcYPtCWJRZsx
 h4uQ==
X-Gm-Message-State: AOJu0YwHIWBpc444M0J5voFY2Ubn6+jnQkjbiDFb3mnSB7rtymRSwqAh
 fPSNp6UuFHIbFJNwxF2W/a2VwhScpgVWth2asO9MozNAXa4in+XxUfCmQsZr1xtfxKK3JfF0vAQ
 a
X-Gm-Gg: ASbGncsq9GcZcuXbKoWoOPBPg6mLiGD6Pf2iWRMvYlazgPdwTV+Mq114Tye0pvyzwP6
 XFOTQepFQEcFW9E+jxYasCyNoc7ISNykqR0ZqrA+U4gApK2UuLlAjGXTh1jlOZnMYoDGSElYxqY
 OkKiOauJ7WLOybYNQVIAfG437RVN0aXNKd8BqQtXmC3y45geaYIi/8ZCuUst4x2M5S63oi+4hT9
 bwdAvq8P1gUunRvbR+nBhctFdW5Y/8inZTwfXLI58JoG19o6WaJg7wNP3AiN1k5VFav08aV9KGV
 KLwQNRKZ3qMyb0lbW6jGhNSkGI5MaNcYecWb+Zg0KJSkuGUoXfvYmqoO0HheLWIrHZXWAizu1+l
 VGmXVs/Fr6Fg=
X-Google-Smtp-Source: AGHT+IGGiZ3l00xu2Sjl97BvYp5imG0ES47q4shwsvMdwY+09w0DDEbLT3JHV86O7zvC5q4MZP3g0w==
X-Received: by 2002:a05:6a20:9151:b0:1f5:8e96:e75f with SMTP id
 adf61e73a8af0-1fbeba91ffamr305861637.18.1742333550465; 
 Tue, 18 Mar 2025 14:32:30 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 28/42] target/xtensa: Restrict semihosting tests to system
 mode
Date: Tue, 18 Mar 2025 14:31:53 -0700
Message-ID: <20250318213209.2579218-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

We do not set CONFIG_SEMIHOSTING in
configs/targets/xtensa*-linux-user.mak.

Do not raise SIGILL for user-only unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f02cefde3..cb817b3119 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -35,14 +35,14 @@
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "semihosting/semihost.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
+#ifndef CONFIG_USER_ONLY
+#include "semihosting/semihost.h"
+#endif
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -2241,17 +2241,15 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
                                         const OpcodeArg arg[],
                                         const uint32_t par[])
 {
-    bool is_semi = semihosting_enabled(dc->cring != 0);
-#ifdef CONFIG_USER_ONLY
-    bool ill = true;
-#else
-    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
-    bool ill = dc->config->hw_version <= 250002 && !is_semi;
-#endif
-    if (ill || !is_semi) {
-        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+#ifndef CONFIG_USER_ONLY
+    if (semihosting_enabled(dc->cring != 0)) {
+        return 0;
     }
-    return ill ? XTENSA_OP_ILL : 0;
+#endif
+    qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
+
+    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
+    return dc->config->hw_version <= 250002 ? XTENSA_OP_ILL : 0;
 }
 
 static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
-- 
2.43.0


