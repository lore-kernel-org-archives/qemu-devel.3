Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40839C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSH-000472-G5; Tue, 22 Apr 2025 15:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSA-0003yl-Qv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS8-0007Kw-UG
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-227a8cdd241so63320035ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350723; x=1745955523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQn5pEpTklz98PI0kmgU6Xej9Zd0Hkqt6ZpcSg4eg/g=;
 b=kDhRHQWFdzlFFCzHjAAE12DUc5a5lwXo0jH7ogMkNnwGwSUwTxWPQsqKL1EO/a3bXI
 NixGYAAOxeDjZYNlJmjlLhFHPyuepb7cXc9zmF7WMR5gwjbP+sEgWX64e0A+6yyUtCzS
 N7Ol/MqG3p890KdnhGyu4r+4AXDFGMlTJi0joyEf2lms8ebuBM2FjNPiYR7hHxdXJwN9
 m5gg/3+X2PLuCkBRPyC6D67DeHYcUHzjogJuvfMaICYlcD4ruCA/xX+/s832nl3ooGZX
 lzewnIOE4lWyUxGOkAS3TSEQELiGhmQVr8UrP/Rkvg9XYWP2QJdr60CsSp/tS7nH6d8y
 ZBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350723; x=1745955523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQn5pEpTklz98PI0kmgU6Xej9Zd0Hkqt6ZpcSg4eg/g=;
 b=L/wVPNHC3/YhEMVJ1jSaxMqNLDrXQOI3X+oO9IUJyK7jsT5fbGGADojZVtr6YpKpyd
 vohaL85LB6OJvOLTGZOYsSxy+DgS68bAZWaw/FuyJhjtbaSY4vfKAnXweg1mTWpOII1j
 +j1DvTBSkcgSEWKfObdcgUxZO93XKnMBxaiw3xGd8OPywYXFnaelxJlimlJcW/3pWVDv
 kC1Bx54hOWDtMU1laTRxc6YqX8Br1pRSp6ifD68Dj/wmb2g3HHTwR0MM5tQ7RHm37BDe
 2InVBuDQt85BGygM4dzO9e/daVf72ke5W2A1yV11jfk41h6pdm6CszIi9ggtJmcsyaqf
 ByPQ==
X-Gm-Message-State: AOJu0YyUNYcPUy6JdktPu9YFeqlkku0fwYohDQMsE8nSlspKbEqou6em
 XUpfH/XBxf6I395rSu4vQRQHXaHIkvaGHDEpkGGUcwQIGAtHJPAoGMta/iSp0hbY33HMHibvjgk
 D
X-Gm-Gg: ASbGncvARMsQYpwDJStLrHkFWkWFOKnLAbFsjM/cz5u3Z89EFA+HbCOs9xqD28EPz35
 nmA2zPg+V7raKzCubaHnOjpO0ml8123MDmJBFANQQkOX0aIjtTXhbNTJUgrN/Q3ICybnUlLhJqO
 OxDJdr3MVTNG/KDtRPs6zWxgkugoDRH5t07Z9vGqe2Btc2ugFXOtTFqocDw63k8J7WSgHk5ycIS
 yE9QlIEL1efcBSfuWmwaY7Fh4zUl2YgONWmm/2R0JAZr3tnBn9oKS5yYPs4nRzZMCh2tmRsvtqE
 hV2SbSgRkOtHnJHrPkpICsfOH9mwoCCgk4eV2IZbkBpPrLh3KeDTqBy0Ad1IUAV0T+/cODAjw5Y
 =
X-Google-Smtp-Source: AGHT+IF2JV24c5JD8YD5jpxofhhfvh6777+mLtCNprTRjJ/VIMctcf+V8hI20sBFui6VknZ4K6melg==
X-Received: by 2002:a17:902:ce82:b0:223:6455:8752 with SMTP id
 d9443c01a7336-22c536420c6mr235540165ad.43.1745350723615; 
 Tue, 22 Apr 2025 12:38:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 126/147] tcg: Include missing 'cpu.h' in translate-all.c
Date: Tue, 22 Apr 2025 12:27:55 -0700
Message-ID: <20250422192819.302784-127-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

tb_check_watchpoint() calls cpu_get_tb_cpu_state(),
which is declared in each "cpu.h" header. It is indirectly
included via "tcg/insn-start-words.h". Since we want to
rework "tcg/insn-start-words.h", removing "cpu.h" in the
next commit, add the missing header now, otherwise we'd
get:

  accel/tcg/translate-all.c:598:9: error: call to undeclared function 'cpu_get_tb_cpu_state' [-Wimplicit-function-declaration]
  598 |         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
      |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed41fc5d0c..c5590eb695 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -69,6 +69,7 @@
 #include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
+#include "cpu.h"
 
 TBContext tb_ctx;
 
-- 
2.43.0


