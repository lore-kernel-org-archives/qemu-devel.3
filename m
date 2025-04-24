Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099DC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kva-0001oG-4D; Wed, 23 Apr 2025 20:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-0005ul-M4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:57 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktX-00057A-2N
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so333941b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456209; x=1746061009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgalV7HruJEO8qZACAhRIvHXd09mMPeIqD7Z/pvVOVM=;
 b=miipDs6Rjee+dibWnnTd/dmElbmRIPLfsOgZCQQxLEq0YnJoynYEq0WAP+zAuXeaYI
 P83dhlxPgSqcniC7ewVvcQlfE1D+4daABF9hqMvBqMPZhNqGTlZEmbpzgNwTBBEBiy/j
 cflQq+PuY51HdUtq161UKLG9CHsyWER7c1Ef6Vb0ZdRcxUQFvoUatNpIKLQnP/N5fU+g
 B6zrBVJVCMYz6dyc/0LYJOM3Rynf/cuGxWsirORhra9XTWzCp6qAXjL6Uxn9tya4IkY+
 nutP52w8seIqjA/mPQGuAqnt5YGf3JjiEQEAkMX/fWeosBuNxl73s++UIhIFLt2Cdudn
 8uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456209; x=1746061009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgalV7HruJEO8qZACAhRIvHXd09mMPeIqD7Z/pvVOVM=;
 b=U7Kn1amEYHPJphogolF5S5R7hO63XGS7MXAydrzgiu5M7SfD6QETWKOs9rILADrodA
 d1Q631IEdAxKpBJeI82AFYV91XTfIEO1nb9NOueiNW4QcayplGVoO8iZsqwF32KcQM0t
 YfKfLzhfrB6WfUHsaunaKfwQa18s0Y6L1grgr/9l3IRI3IjdMzUYhxMJDI6p1zQjzdZ0
 7rdnmFCZ91ZzN/i2sC0lDoGMyKDPxckKb03H+zU7q1pTXi34D+Yuzewbd4N3XIymKQ1D
 jsWPuSeXWv9xxezK7UMlUFAHT8z8Ca5OwfFVCTFYyKHV2EDkhx+D5lUD0XnwXJ//DXY7
 7TGw==
X-Gm-Message-State: AOJu0Yz8N25oGClzlxM8eazVyxyPq6w//dRWIZExsoIV32HkXvXBbYJv
 WcVYvswhehBIA7Uday6AznY+8Zq4KqgE+K/7fYjQqLuI44p1SChmOmT/qGHpvC3ms/us0ip9W4r
 o
X-Gm-Gg: ASbGncsszC0ld6uFwfeU/ch9QokgSxHw7vn3bKcNQSKSjq6BJp9voECTe3T8CdVLpx4
 Es7jpsMyjz0Hbd3nHoflSS8PHlR53tU/AFvwD1KorwFLA5IgFLiGy7i1Is1V4bIpxUU4URR88JO
 lWNLWTUKW3P05/y6hKoST1INoK0njKVn9Tk/ne7ApzIARMzLdL+jhPktuovTSoMKNbsWWfJuNxy
 3S25pvH79qKMm5ikbBdJjXYJixZkzSkSj4zhNeL+qskQsbjcOH0EBeyG7pQT0mBkFEyeCmcu2+2
 5+NcmkTzfkXNOtnTPK7DWlidx70bor9UbzMcm0es0XMziMzcfKuSbeeb4J4teK5rKsacGNgmRn9
 UUb4bD9mu4A==
X-Google-Smtp-Source: AGHT+IGOZAAGWaunYX3QMFDZRVlVUQBD4w4mBpl74MRWUb0/XVWf1wJKXl9s8UxYLi/UHUTCUGdvIQ==
X-Received: by 2002:a05:6a21:1510:b0:1fd:ecfa:b6d7 with SMTP id
 adf61e73a8af0-20444f2e8cdmr925517637.28.1745456209674; 
 Wed, 23 Apr 2025 17:56:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 102/148] include/exec/cpu-all: move compile time check for
 CPUArchState to cpu-target.c
Date: Wed, 23 Apr 2025 17:48:47 -0700
Message-ID: <20250424004934.598783-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-4-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 cpu-target.c           | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 2aaaf0548d..be462c4410 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -33,8 +33,4 @@
 
 #include "cpu.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 #endif /* CPU_ALL_H */
diff --git a/cpu-target.c b/cpu-target.c
index 519b0f8900..7f3b244ed1 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
@@ -29,6 +30,10 @@
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 char *cpu_model_from_type(const char *typename)
 {
     const char *suffix = "-" CPU_RESOLVING_TYPE;
-- 
2.43.0


