Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0AFC3ABAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGVz-0001nG-Ns; Wed, 30 Apr 2025 19:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVk-0001jp-Bm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVh-0007VT-Qy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso538033b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054396; x=1746659196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xMaU5nrZM5+S10tBG1u5byuDyb2bEX1pAEZKHt2spGs=;
 b=Nmxhxib1/QS0Lf+lH8iJSUtFflNK723L5rT9VA7VoYxUwAvpJh3heZy5q6FlZPF2vA
 NgMNr25D2+lvukZPa049fBS6xQtLAZfULXBc+HEoqHdg9rsvb5jX8tbT4SkOQcyibFpi
 ZesDtdFWHMD8WsD4Zn2rDAdeRWBESh4HFxxIxEH3fozhDcLWOB1pMMb5G5Xs++3aUgpq
 g0NgXy/UjdlT/5HBeqeJHmjJVTLMMT20P8NLICONSavT4yDS3CeKuEZlRqqvwVil0GRl
 4+okT8wbOWOvZ+JKtgCYsn2WCmQoVaUphTeAnLO/IiMIwHD/TyTbbhF3tSZqUPKFwyMb
 Fukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054396; x=1746659196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMaU5nrZM5+S10tBG1u5byuDyb2bEX1pAEZKHt2spGs=;
 b=qr1tlDgp5zV/YG1eG7ID+4Bkz8zJf66jYdJUatV5qVqZrIcSXzQfL/BX/+CIYMuW4n
 8vXJJgj4Ft36erpdkGLDMFnX4Za0TNM2OdGzKKEsuP4CY1wj5U/hXUtaaK6V67MUbBQj
 4U3AM2f85yPVj7GBn1u5KfzuWfP1UTN1BQ5IQMbYDK04u+YCeEyXP3JL1N5u7dPcQcr9
 l0bBz6PYSgBwL+916QX5MpFbeEHH0QxHympmUMd1cMR4CXziYzirY1YQ5eLXB2lbCnLC
 t/L3iLtTecitE+Z4g9yfjXyTMdvzQl0I1AuvBRboP6tZxFJMZMAWn228HaHAWEzXk7ai
 AY3Q==
X-Gm-Message-State: AOJu0YztbyghhNA4lC8qEz8H2sxSSA41mUlG8xGQk20yuqhysFUjMge+
 2iIryAmkGbTR5udT+h8hxofrjtAxU+DI0AYNQGeVr2oohDasyySEhxGEfbB/TKcNtizlzkwLddX
 B
X-Gm-Gg: ASbGncsOeOWrMbAZiZdVQQQU9XKpICWPlXUnhPMPimQgJ+mv4k9Hd0VGc+7LKkzD2PG
 T44AGiWfJHIDMcHW7WMTlvVdf0Q4p9hHUxj8SBn+nDngOBhuG3O9CfUnnnVfd33t1s7tCjWepvZ
 JwiTa6zATNQpuhUIFZ0PnLmgf00g5nXPJDvc0vJnbUaUUBZl3yclYCupitDlqASO1Kwn3BqJ1+R
 ibpMDNac0Uf7qT+hsLfzjjggV8kwH5MtNsk14bvVM7eNEFtj9AnG22F7rONw0kR4xedh7IE4yUB
 iLhTISTO/hL8i/aYfaQcQFurhA4k/Jiqhmwi1pT3ZpiGG1FzapeoJQo39JKSldXS1OvoQivVcGs
 =
X-Google-Smtp-Source: AGHT+IEO/RxG9awda07Yx1ue/lcFte7OKURfpucGQExFxJovsNDXf/s4pc8IvzzDdj2hdaEk7rxJ4A==
X-Received: by 2002:a05:6a20:c887:b0:1f5:8b9b:ab6a with SMTP id
 adf61e73a8af0-20bd6b4d8f5mr466232637.18.1746054396283; 
 Wed, 30 Apr 2025 16:06:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] accel/tcg: Build tcg-all.c twice
Date: Wed, 30 Apr 2025 16:06:30 -0700
Message-ID: <20250430230631.2571291-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430230631.2571291-1-richard.henderson@linaro.org>
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Remove some unused headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c   | 6 +-----
 accel/tcg/meson.build | 4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 0ce34ac912..6e5dc333d5 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -36,15 +36,11 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
 #include "qemu/target-info.h"
-#if defined(CONFIG_USER_ONLY)
-#include "hw/qdev-core.h"
-#else
+#ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
-#include "system/tcg.h"
 #endif
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
-#include "cpu-param.h"
 
 
 struct TCGState {
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 7eb4619aea..d6bd304add 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -10,6 +10,7 @@ tcg_ss.add(files(
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
   'tb-maint.c',
+  'tcg-all.c',
   'translate-all.c',
   'translator.c',
 ))
@@ -21,9 +22,6 @@ libuser_ss.add_all(tcg_ss)
 libsystem_ss.add_all(tcg_ss)
 
 tcg_specific_ss = ss.source_set()
-tcg_specific_ss.add(files(
-  'tcg-all.c',
-))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-- 
2.43.0


