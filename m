Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18404C3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5CP-0002Si-H8; Mon, 05 May 2025 19:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5Aa-00070h-Oo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AY-0003zc-Qr
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso54826275ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487457; x=1747092257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZyZRD3+F1iwfSbHdRXdy1kvrAVUcrfC5UGzBivz9WE=;
 b=Dr6C+IylKvlrBMiBAfFYabyccq+c79O6wMzoNvEbB0lHYimXRbKCpQGTtAJQVh7AFy
 +VJXfA6s0YATVWWheQw4EzrmLoKnJtmpFrYZLku8Y/VeUGDHg7zsbOgOh3Uii08jV+Cz
 EMCzhi+65Er104K/ZKzUgaqP8XAwXfK7Tsk5RRTXuHE3qQ5GfSgAy0viFLdhj5TfT+4E
 0txN3hH4Eq3n3FqUhJGoMnIZoGwoTpihsJXhoZvhdCw2TuvgQTqFgd1MCSx4MJ3dw0yr
 +7/QicQbYgYIIJmxRinmvw09Q+FzxK9iby+kdQoIOIZ9OIqs+gZku1emVFbOTIWY9fjP
 affg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487457; x=1747092257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZyZRD3+F1iwfSbHdRXdy1kvrAVUcrfC5UGzBivz9WE=;
 b=kTPz9hnx9KF+yOQoXkCksh78+02mex2cYm/7rmyHgGODP7mAYRiR2NqzW3Y4rIz/yP
 0ESWm1RsigJIeDsXl9q6VEVx1Gnl54RB4ZFy60SmvejQgMqcjbHt1+43mQp5bS20A5WR
 F5ChQ1M+oGtIaT2l9WzJbdJK9tZV5H9a6HDJhGgR83gMOufqfd4sp0bq9AxDLMSHyA7K
 YYWJf63qxnSY25PtaFqgxpyI8WuTe5ROyXe5KkeaCveGUka9i/6ApecV5DnZArNRlNmX
 UuXt1D8/HqOALrRe7qGJKlU6PJvYGH3ijA2Uiuq1uJZhhbwVwqUKKf58p3ovpfOoGhCc
 e/WQ==
X-Gm-Message-State: AOJu0YzFfFRiX/6s+Vcw5oqKb/9bk96BZCYR25t+pYuJdUonaSo6wiNW
 4RgOQSSVQlsBHM821McQIwfJZQHbC0tZ+FNpVbEloPRx6FUFon+EhniKMx65Yd8pbf93k6MA1UF
 Cn2k=
X-Gm-Gg: ASbGncvnrGuwwCsqKYXtC3LtPLxDEefnld6ciyc0bYwb7Q4IM5kixg5+qLjoZP+uLbF
 deGrNcYFcoG5RF5kNJ01M5gV47F/lciV72NHmCKZDAcUxboyxPfkaSiDUL4tn4wn01fWiDktnNx
 u94qoM2P/PK60Z8W7OoDpWx35p1sXK9G2UoOdmnEWDKNdFgQZJCZTf4nZm6HrsFQmKiimp8fSpV
 h8xGI/cYZX0x4TlITl0ndasKm2R56qGQgxirb5zxkptpPyZMl4+gRmw6H9rr7mXSAejg9yqeYa7
 pTD9Kklgad64cQrnrauJcimaV92VT7uKkBGj9EIP
X-Google-Smtp-Source: AGHT+IFEA4+6Enx3vNjJJnWRowlGdPJWotti1f/99w5zc3Slf+B8+XCjIsdF9QTYHlr+hw5AzkI5eQ==
X-Received: by 2002:a17:902:fc84:b0:223:64bb:f657 with SMTP id
 d9443c01a7336-22e1ec35548mr130085795ad.46.1746487456895; 
 Mon, 05 May 2025 16:24:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 50/50] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
Date: Mon,  5 May 2025 16:20:15 -0700
Message-ID: <20250505232015.130990-51-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vfp_helper.c | 4 +++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b32e2f4e27c..b1324c5c0a6 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,12 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 7502c5cded6..2d1502ba882 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'vfp_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -68,10 +67,12 @@ arm_common_system_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'vfp_helper.c',
 ))
-- 
2.47.2


