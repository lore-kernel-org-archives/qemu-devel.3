Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE2BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoUW-0001sx-CL; Wed, 07 May 2025 19:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTY-0000WS-Q7
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTW-00037z-Op
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22fa414c497so1235765ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661613; x=1747266413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg06Y7bf5KiymTc5nVCG7BgUS7AMOOtDTvF6y7Zvpa0=;
 b=WocrnGA/VDNHQtRz25AHvLnOjlHXAcOVWC9H/ZX+F3in3/WWSemdCVAX/BGE2MIt0/
 Ql7goZmG4bB5quPKhzweoUcmHiexqtlHpXftqvrT3KwHXbjDZuxmNDngmwOllVvmATV9
 auc25936EIfxKOvu6mksf3wnQPPqWe2X+mcmsUwqyTdJKXOxC5MzRPH6Yd5FwHgQOoNm
 jWEaru1YdBHhTk1ffkEWrE01XxAts9fgaivHUL6rokNTNOGzrXXEaXYJ47B5DReTbKLa
 sRhGEbsVlnJPcJJUpok7ZZduRP+q1XSzI4zRuw2IWKS2I8WhNmUSmIm/SbEhX8xKK9DK
 a4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661613; x=1747266413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jg06Y7bf5KiymTc5nVCG7BgUS7AMOOtDTvF6y7Zvpa0=;
 b=savqB+3NX9Fmz/0Ftrhn0wOhkOuSyb3V8XTHch8gqEsZ68LmjnRGbCglLde3iZ1EdG
 OKksr1utuFfPtmucWlXiIAhe2eTJ7D0RlLgVEWU6BbdEYJ4Xg7PeVhHrIWqbtuDH6AoI
 49uU0J2uKYx+3HGH0rXeMm4xnbkzDvFTspR9o8GAzGWYNFALkpSmSmcAaggP7xApD2aX
 RhjaRMFC/AyUKYm/xrzqN1rRhxCQSY1SPYfM5WkVcZqXiMNRUjugMY7ORDBiWjrGF4bB
 jQwiud93ZZLAH+inQ7gBYs1ylD4xkH5s9SQK5pZ/i27ty/19LGm+sCq80FcYCGc2dVN+
 5UfA==
X-Gm-Message-State: AOJu0Yy4e+q5nIDj038b9lk8f64M7UzOFk1vWM3hqzUq5BvABTYGnrKh
 Fdr+BopemXhd5j5xEOamBBIwPs+/FXmNFnC73VEHF03URPnN1r5EtEV0JnNlDDqkP1pxPKmI1/+
 Kq/pnMA==
X-Gm-Gg: ASbGnctjfpp9Ao2NPSGX/DhrR+WJz6xVSUBYD6+gYQM5zitx8/PTvRzoOpzU9kKTb/P
 siXv6/NoiLtPqUcfXnQyU5pxVkW3zzjvE+tj+sPhOS0SGfE/ET8sRY/ttYnaW9qBBq9EjJXMFWU
 KB7ZDxrweoJvti+WdLc/wB9QtaMaCHi7z+//C14g485augnFNSvu7ppZoRMOktpun1E9jv7x9k6
 qTc35C3NXmzF9OSC8ma6ebHIAemrxYj5wwLjsmEXVNIJa5aHomEbUYWhdob2E0YfOBIFwTLoCMh
 xzAGCvmuf5/5JnhZwqZJ+T7AX0HB79c7DSluQVig
X-Google-Smtp-Source: AGHT+IFx3IqBq3BMdslXcG7H1lDPhBPcNhNXcmyld4UJ174Kiz0M4FVxecE3zmVfYGRR5gVd3aFm3Q==
X-Received: by 2002:a17:902:e38a:b0:22e:634b:14cd with SMTP id
 d9443c01a7336-22e634b171emr48243855ad.39.1746661613583; 
 Wed, 07 May 2025 16:46:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 42/49] target/arm/tcg/hflags: compile file twice (system,
 user)
Date: Wed,  7 May 2025 16:42:33 -0700
Message-ID: <20250507234241.957746-43-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/hflags.c    | 4 +++-
 target/arm/tcg/meson.build | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index fd407a7b28e..1ccec63bbd4 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -9,11 +9,13 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 2f73eefe383..cee00b24cda 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
@@ -66,3 +65,10 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 arm_common_ss.add(files(
   'crypto_helper.c',
 ))
+
+arm_common_system_ss.add(files(
+  'hflags.c',
+))
+arm_user_ss.add(files(
+  'hflags.c',
+))
-- 
2.47.2


