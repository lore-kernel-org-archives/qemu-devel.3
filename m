Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BB4C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krB-0002Uu-8S; Wed, 23 Apr 2025 20:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqN-0000zW-BP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpx-0004gc-Qj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736a72220edso415140b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455988; x=1746060788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcw0j/NlWHHUFrSWrBThXyu3TLmFkd4CNoNN4KpSa40=;
 b=bXRpGazWzl+hiQ2cGiqy9SqCNqD4hWUW7dz4blAmbCC9KvqxiFSu/OwphRMyEXXe5v
 9urXwQPI28webQZ/Si9W3Gprt8Rsyb7FfxwiwdujIe/ZO3e+i3jsTQGMnuWmCdWEgNt7
 mQbjL6Uv1lVNeR/BbeTOca+lptjpoawGc3rgJYEBSKhX3AHOvf36PKnGAnEPjHWFicXt
 hysTDVueDhQ6nub5tjX92GgyMvp7rjQASMyHfcwWvmRTQCvoEeY/xjv2GKAAuRQ3dh/+
 pFaTSqE7p/anLwl54AgU96xusETGlrXvkMPkQmwrxrx9O8ks7Ozfv6X1TZeZX5UsVnaT
 Q4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455988; x=1746060788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcw0j/NlWHHUFrSWrBThXyu3TLmFkd4CNoNN4KpSa40=;
 b=lAznUyTvbLxDtrMwisTzQpfYg2g40JIUoTsptgH5cZ1/iV5z/XKxxCrbQpTt/ltAQC
 nQuCxMdZ0JwIOgIBK7GpLvMHorBz71OTYaOJvVuM4GtxziaXzZBCyvX3TEDwzaR35TJp
 7t1l2NCv5AwYkhrDMnliXx3nUUa3pkOzBc9VE+dLluDhZgdmgk8v2NchPa6VRX99V6Wm
 hfvVE1Kv8tHjMdROnpXPa72Jr27tZCwZJVBYoe8paCWrkJvZZMM+0Tw/cJAljZ4wZ9IC
 Ykji96oAwKpGTKNSbHwGJ9pfWr2ZOoxaMaCQ7C/MUMaQV1WfzAwRzqixwWsb1Q+OGlZv
 l6Eg==
X-Gm-Message-State: AOJu0YxJthiOv2+xOynWUwy9dslsdlzGl+FkRgEfMJY/2Z+i27tTa4kg
 znkwr0Afj7faOAMdWESJvYkr7ufu8W/spxn2B9PiVdD6+6uSTCMrIZClBg1mFtDJS0otTjRL3c5
 A
X-Gm-Gg: ASbGncuDsmGfKdF5Gp9QIwE4vHNLlQoh5GRgb7OK5QUAlNOVFs3O0sAT+n1B3dokTpu
 8LNJJDMe4LfXrFGapK4cjkRRfN+R8OvUwVChwDxT1w+h3+LwmX7DErgpSQf9cBKu3u37cAkAE+1
 Ph/f3eVpaQzR0kXHO6Ff3iEu08EwFesAOLOaRkT6oBnkn8SuD/AIVI60CdWV8BcKgH7sVTEPWEl
 FdkFnE+8EeUIrnLaiT2NDEA3bx55gus3xCTlTKDNLPtl+74UCDBSML8zHTa8nukt1HtoLDmHeBY
 YbNYk67KSiaQiBO4hb9nMt347QuOtvmH8pCmZjPoN0HqDxwm81fB1nU0sKiS9LxCRVrtAeya5x4
 =
X-Google-Smtp-Source: AGHT+IELtKAMNA04S0ile3qvJ5rh0UcVMaL8lENKEYrrFKg6u+Lv5C7D991eQX27PAOYLkH7ueZGOA==
X-Received: by 2002:a05:6a00:1411:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-73e24ae5398mr1079684b3a.20.1745455988407; 
 Wed, 23 Apr 2025 17:53:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 045/148] target/xtensa: Restrict semihosting tests to system
 mode
Date: Wed, 23 Apr 2025 17:47:50 -0700
Message-ID: <20250424004934.598783-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


