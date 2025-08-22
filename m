Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9986FCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTGu-0001qE-9w; Fri, 22 Aug 2025 11:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGg-0001kj-3h
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGT-0004zn-Kq
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:25 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b474e8d6d01so1447083a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874870; x=1756479670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ip/07jDLRmn55A9AxAO0k3ZA6eMIYcjBUNqH28VJGig=;
 b=tB4/W2GAU+7YQ+NVl6rU1Aftfznn96o8TfhOlOXW4WcQT7JUgGU7gWX26Nvt56CQmx
 eJEymmUtZU07S/4FplQJ6p8uHhkgsNJcfl9ziACmDgXNt58k12xfqiVCzUCXRpIFM4vE
 YNRiFCMUSFGC+UQO8t/qs29UYXa9hOXJ2oUVpB8aitl+Ul0r5Z7NyGvnMH0KeB6+zsXA
 27GuT30N30yo7KHiO7MyWAYzxNpOca8yZ12xWCTpdYNzfrw63QBP62GdknJNS4hiucF8
 92w+KtIeZHGV3A9tVEeKA+ONx+B/fi3ODBjy3MF01mA1SPBuvaHDfeBRCI2V/GFQnA2b
 j8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874870; x=1756479670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ip/07jDLRmn55A9AxAO0k3ZA6eMIYcjBUNqH28VJGig=;
 b=QTT8GtdASV715W9hS4I30Ww6ysRshFm0cElW/vMwSnIc/d6W64BcdLiDEwOuQAviaS
 pvJCBwZyzuhTPb5uJkc8/GbOESmMnH7lUEzzekflCT56TkPWKDSLNm/07bUn1tNZzDu7
 Dng+q+RosfY7XdYL8kmYYMtfjYcaqy1+1MutsP14O3lZc+slZs147y7chpt4BkCle6BM
 LK7O/QhBZahvqHqwkBn+PSciVac84c3wq/cf5q6QyPdWTB7ZgVmaiPOUcY+sXgyo+uIX
 MtklFAcX8zacIaPGU3F34jHEt12nXq8NR6yOrEteFAd4/MnlKw16reNiqxr1W16Z9alj
 jbcg==
X-Gm-Message-State: AOJu0YwFkZZ7u06Y1//4GjMYOn8VfHXAIoukBVTu7vYpnLk8HcN1+GfN
 QhB/RKuJzQ4N9w3EqIpDSePAACzFux8tM9MeAcXfRmOR+3bZkjxQqhr7aJcnYbrh0WhWyz1a4sq
 eclLEZDFxcQ==
X-Gm-Gg: ASbGnctlCNLQ1hrmDb33IxvW/wCwYjQ9aCBYClw86+QkGgbjDubisU/a0HYFDzIUsLs
 PwjuOjVZVXBWxZbB0A090nIfBugFV+yTIEGzJ0si77dySxC6uyy3/FIgslePfSClHHsh3W32cZk
 kRXRSqjic5DyceW6/lww2hsnRKttpO1xv4tO3AAEsr10Pu+CBGjVqFMhwQ4zx6UCnI7W1izVx42
 hhQZFUdKQqYu/Ekw5CF9JuDFv7myaizMD4gJ/051arPE8m6IpGQzIXpFdt6iAlSAP3Tkf6BOlyH
 wwnJxsQQ82JQ/3xzZkSUPW1JobCC1RcUBXs0+UY3YcvMvCdvkJdxS/q5VC/gj68zzMOMRZSrfCm
 Yb2DsuejsVHaIQRfjb+PJFbvSVZXMNCYoGK0k5lW7iE8=
X-Google-Smtp-Source: AGHT+IFm+WYJYSwq4c2rAUcbQ2F/KNZWR9BwSob7XbyViDG/2ZPk8mUgh5Tl064VrYT+QsD4SIck7g==
X-Received: by 2002:a17:902:ec88:b0:234:bca7:2920 with SMTP id
 d9443c01a7336-2462ee59196mr54824695ad.24.1755874869794; 
 Fri, 22 Aug 2025 08:01:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed5406e4sm85929495ad.165.2025.08.22.08.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 08:01:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 04/12] semihosting/arm-compat-semi: change
 common_semi_sys_exit_extended
Date: Fri, 22 Aug 2025 08:00:50 -0700
Message-ID: <20250822150058.18692-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

We now check only is sys_exit is extended.
This allows to break dependency to TARGET_SYS_EXIT_EXTENDED which will
not be available anymore from this code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/common-semi-target.h   | 4 ++--
 target/riscv/common-semi-target.h | 4 ++--
 semihosting/arm-compat-semi.c     | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index da51f2d7f54..7bb442f24ca 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -34,9 +34,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     }
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
+    return is_a64(cpu_env(cs));
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7c8a59e0cc3..ba40e794dcc 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,9 +25,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
+    return sizeof(target_ulong) == 8;
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 3f653c6e7a9..1c593d5e0dc 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -755,7 +755,8 @@ void do_common_semihosting(CPUState *cs)
     {
         uint32_t ret;
 
-        if (common_semi_sys_exit_extended(cs, nr)) {
+        if (nr == TARGET_SYS_EXIT_EXTENDED ||
+            common_semi_sys_exit_is_extended(cs)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
-- 
2.47.2


