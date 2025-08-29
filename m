Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNj9-0005tJ-4B; Sat, 30 Aug 2025 11:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WU-0002cN-DF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WS-0002WF-Go
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso2304678b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506278; x=1757111078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOHr0P1cUoVKDM3IaUw7ePoDCqTS/2VdOKzefbBT954=;
 b=YYR9A0Ugg4yy8NEVb621cW/IGPrEBTtHAQi+mQQ3zoSL2jYOKatnlh6JStwRKBrIdT
 RqoLFsGs4IValWU5uJR8GXS0haaraJ6x0eqPzzoCnXKuoqHBErJzNSWx1Xb74+Gm7SRz
 cCARn2hEPqA/6lop7a7d+l9pegd4w1NWnYrDh8h3vgDEDBdVLz5Td/XVYgkOWkGGXevW
 izr90hmcu58uKcIQJa7q4DaZbPeFRSy6CraHouN6TMddaJfrjLKOC3CJMXRI5ht85mjY
 NaUNQaXHm7AhUFjSW74kHhpi/T4Ywzs8vZ9+//XOaYBSEIGzjgkOQG0JMDikoDiaRfPz
 UzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506278; x=1757111078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOHr0P1cUoVKDM3IaUw7ePoDCqTS/2VdOKzefbBT954=;
 b=qkmjOVJ/XrMERF2X8VE8Ky71p9Ly9qT7MDmKw2vos6ZIjGFEhR9k94gdyAoWQd6xvk
 FaW+qA59bkXk9hWLR66xMCYSLqGW4B2ogH9RETqUwjZIMR7oLZWhdCivJVXOnmY44ctY
 JIW6wnaU8v+Z3CXnRZhUVhv4CmaaAFcDUFZrktnfUA9mdb6+LiU+V8M5R48IkS/000mO
 e9d1gEdIE6mkKsptkTUpBPS7Ew3Z3TTFvFi+Kcxs6UURK4MfbQtDfBUYRKhjwfpDjVK/
 95MGtoA8aJzwWBNm6wuCAfDURRa0iGv8UIisVxw94gCVRWiPtENHO5zFYj55Mv3WutE5
 Hs5g==
X-Gm-Message-State: AOJu0Yz89LsGp74KnPgwhrkcna/sE0AgpVaBxD+2Rk7htnvcm9aux21s
 OMUXXccEbsbHgYn4r7Vff8pK9w7ceiHz4eHysME++I4c1s1xL8KH5b3xtiDaSMptUaWn5R1/JWF
 xc7z5jbM=
X-Gm-Gg: ASbGncv6NKyYLZsWdZ778AJsFAQxxjvGZHjrx7AnpMp3qd5445bfJUjv1pJqCGPqCOv
 6cngKU6x7iqgVHVuMpGqoP9ZKoJIqTiBWr1Ax9uwKUggrflZfueQJmv+x0lKXhA65jTqUTWggnp
 w/71YTksK0oY8Vp7QnnLR6PjbBuj1PlmS40TTKDm9CEejeUvyJTGb6g4p0zj/O94dpqMViUQyVr
 gagE25uRxVT/hyEPrT4zuzTR8TQUkfLXoXpx9O70ry8l032B7runAHJejEUSWVVavA8jo1gDgxd
 o9L77S1MYGd7o7pjR6QMQhHMG6tcsgZzP7qZ6eTPtU/a2PRQhdbCi+jo1ZYe0u/KVz05ZNBpCsY
 sfA+k+7Z4v7e81NbUlXyJIcCOIfYk8H3MOFu/SaHjxzP2VjwS09My3CD6RpLB0V7liUvGXgg=
X-Google-Smtp-Source: AGHT+IErdbSLZ6OtWY33IXwOpjTzBfrmEc2yA/O4DYMS5VmcZgingxjFQtO7M2G0FWTphzdgxUcv4g==
X-Received: by 2002:a05:6a00:4b48:b0:772:1a0:f772 with SMTP id
 d2e1a72fcca58-7723e3920c3mr254693b3a.28.1756506278588; 
 Fri, 29 Aug 2025 15:24:38 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/91] hw/core: Use qemu_log_trylock/unlock in
 cpu_common_reset_exit
Date: Sat, 30 Aug 2025 08:22:58 +1000
Message-ID: <20250829222427.289668-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Ensure that the "CPU Reset" message won't be separated
from the cpu_dump_state output.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/cpu-common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 26321be785..259cf2a3c3 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -135,10 +135,15 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 static void cpu_common_reset_exit(Object *obj, ResetType type)
 {
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
-        CPUState *cpu = CPU(obj);
+        FILE *f = qemu_log_trylock();
 
-        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
+        if (f) {
+            CPUState *cpu = CPU(obj);
+
+            fprintf(f, "CPU Reset (CPU %d)\n", cpu->cpu_index);
+            cpu_dump_state(cpu, f, cpu->cc->reset_dump_flags);
+            qemu_log_unlock(f);
+        }
     }
 }
 
-- 
2.43.0


