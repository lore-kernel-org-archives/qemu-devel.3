Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5ADC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcn-0006Em-AQ; Wed, 30 Apr 2025 12:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcX-0005GV-08
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcR-0001vs-2S
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso202914b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031748; x=1746636548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDXEkP41hr8unW2CYQoxGQEU1dZcDdkH6hmvqIdSZek=;
 b=zRdEWEIKd4wk1g3dIyDx+6nLy4mF9ZYIFp+Q1MPLbGdKQkez0DQR8Ak5pOl2B45376
 2nAP2AtPZnidEsjNfCwCeiHBfBxLU625ZPJ/4X8YUbwyvAg1FYYsh7y/xPYk8X1faxr8
 s9YwEAthxyY3MQ4+N7DOjbo/BDH0YVpz4naYBzMJ3/8qBG2kehRkrhJHJeyrewZUb66y
 kYpXXtaxFUCbphcwQVXs03RLxJk7fk9lahmYJVgAn/m6oPiwKDBZfjEnycFsmSoI7eDd
 Ft9/Qw6qtXhQwVVjx3WPQ5Ouee3eU+aACbhO0yCtJzlUa1AD+Y8xZ7r7R1xNshPwckMy
 lrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031748; x=1746636548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDXEkP41hr8unW2CYQoxGQEU1dZcDdkH6hmvqIdSZek=;
 b=Tn5Bnmc3vR+u22mb7gpa7m1i/uuhcT9tqU6Xh7KkRfsluVoTaKtjghDvr/pEpUsD8e
 xcr4cVKLxBr1CS3kHYkg6M+S8sQuca92gnn0o/OCRns994z2KWEMbrviKgmvHQPBhsO4
 IeQepNawmUwMNb3zxY8hpmvXADGbhXkljqNYUL+lbJoedK/8ZIZxIZ9OPCSXHXLbFOrT
 vRj9ndfJTvXc8w/EQCA9g6R4X1IUjLsQd4wo4R+4XYmO2o2Z9+60jeMsaeVfCSum50TT
 pY+3zWKwyjL/uAIAe5MXqNwVb4nwz1DkbBA9pZREH0vHgJ5bUi3avA75jYibwljCa/Yl
 Cvfg==
X-Gm-Message-State: AOJu0Yy3KfWqJajdi/O6Q3s8XAjXtGgALtGLBDZpgYB7UyKghUyQN8VM
 04Ga7MZmD4oZ/2c0lo6ZfDy9dDQXFxK1Bxfd5851XVPuzb2+xKxN7k8unL2soPnI7FEl+BVD14r
 d
X-Gm-Gg: ASbGncvB0asgh0W9KgWt2Y3YFmBLgdT97BEMJvWIyGS2PLoxuknoVEsYeMrIgBglTQK
 OWf/VhoE4bWm2UQnQlEu8ycKIard/INZLJ0utfzkTfhkLNbWwZxGajF59AlTe2Ea38HNZZbqlGs
 jRFwV0P0NNK8kzQOFcqh2YSs3G8eayRBBPv/q7AXZUnFUQ1xIXdLH0ymJg3qPoiMuvSU+d0AcNH
 WMQz/d/5K0lDk4m9YWi8DO6xj/suz/TuAzKfFbH2tHe9//zP8/ltU0+Ty8pl5YGgF3MxrFTWOTi
 0pCb+UBRhWGBaQNj4JIjgA1Gx5qV1Pjoc74SKcskacrRzpfXJBnGJK4nAZr+0VVTbCIs6eVSI/M
 =
X-Google-Smtp-Source: AGHT+IFX4saEsqc4H+VJnoVaR2OP0bDQxkQNsbrJPLFxFxcUE1Cq02AFDk/sP9OwTi2iv82XGY6oPQ==
X-Received: by 2002:a05:6a21:168b:b0:1ee:e24d:8fe3 with SMTP id
 adf61e73a8af0-20a87947e3bmr5794917637.10.1746031748329; 
 Wed, 30 Apr 2025 09:49:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 16/16] accel/tcg: Compile cpu-exec.c twice
Date: Wed, 30 Apr 2025 09:48:54 -0700
Message-ID: <20250430164854.2233995-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c  | 2 --
 accel/tcg/meson.build | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a8fbda31ba..cc5f362305 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,7 +22,6 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
@@ -37,7 +36,6 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#include "cpu.h"
 #include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 3f7b127130..0bb089299b 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -5,6 +5,7 @@ endif
 tcg_ss = ss.source_set()
 
 tcg_ss.add(files(
+  'cpu-exec.c',
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
@@ -21,7 +22,6 @@ libsystem_ss.add_all(tcg_ss)
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
-  'cpu-exec.c',
   'translate-all.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-- 
2.43.0


