Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A60C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoP-0005B6-G7; Mon, 28 Apr 2025 16:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoL-0005A3-6M
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoI-0000dl-Ho
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso5671521b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871037; x=1746475837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XNduMhf8ZHNDk+adB5LcCHoz6IL/fKj+WRUHTYqzos=;
 b=VP9VrH1B07zmVCzNxKr1nTqAamyyEUhPP1OhN8ceb+pjjl/qjDU4Bo+IED5sh3E8VQ
 ufSqMgbZkXXtUcrO5vLh2zECY/DZqgPyAumr0BJkFrhwE00mfUynn9oClMLF2SJ9EoR/
 f9z5r+zsulc0l5/tzxs98gFPProFBNQpyjPeReVbnecRmKixZEWY1n7b1up1oNJvemPI
 o7xdsAnJzHKS2p9UwPOVLDzm7jeLPh4yxIRj6nYFUwqgnvnBCYrszOdILz5SsejCkYRX
 hYIaCUKAM4iYf+8P60sI5zuEvneHkM6ACm+IVMHlj94O48BJxMO6FfegEeSgt7vDdw7Z
 G/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871037; x=1746475837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XNduMhf8ZHNDk+adB5LcCHoz6IL/fKj+WRUHTYqzos=;
 b=McGA8VSOLZKtdQeGyvp1aZfxtnRPJRYMfFfZpGV3px0jHwqaqgVdouoqIfAoH+CgLI
 5FS4tRlG+yjepXQPI5c6J3injMOVG9TOy3Cq8nbgQFGCDdbaBkNDs0rKUP1fq50eO4/H
 fPF4RT7jy0E0wjZYZySvmuqX9uyWklyHTSnxvx6xQgamE4SNBbR2XgeIZJ6Bm25uOoTP
 A4PF7ggJKR7qIpmwA/3pCjC0vSzrAtAPUFzxvnQHnYxQYeJdmIyT/0F5d9U2xIUI/O7M
 gOMpVKegZ+UU1w04CUkSrJnKPkAzwYy5BqTtIG8NxV3FiXrLzgPSyOgLW+pDH7pMU3Wb
 8eiA==
X-Gm-Message-State: AOJu0Ywh+68hIlm2aRHyzVI0k18dD3mojR9dJggtJHiu/dhKOlbEE3l3
 ZX2llKm8f9mq6ttgw71kk3TWEZwq2iSw7DSuK6I2gnI0+HWYyuTQSW6YMCnA8bVIxFfoOChWCPh
 c
X-Gm-Gg: ASbGncspKMUcNbQNoWYmthFs9WqkxDu7KJlnKLZMuhqWKyJ4fiH/6zTcKMgjc0P/4+b
 hvlSWB3nCGBdOeraMmG5I/sjNcQH7z/jt/erlpoSjek6fqho1K/7M5VXtgN+dnXm0HjfI0ZI2+m
 teRSXyt8Y8/8gUrCAaTDcb8MGRxKxTZXL7kaHeYnl/qx2lRPToE9PZDCjNi45a5ph8m4xtSTBYV
 iRvXvxN1+A/fjblrzVCFhTKSXrz6rEWjYqA6EaMIlhYIuognNlZyGLUbH22qYawNHQpYutkzc0s
 i79Djmc8qAuQBGx21eFxN5hf1dVKWTFCOVR2IuxsZ7Xpahtn8VuZccm2ipKuR4kyEYpJrJNVBkk
 =
X-Google-Smtp-Source: AGHT+IFHyrr1sqadYorjW3TBHACP7etF5MkFOzr87jYG/2z48TEAaVWbnNRMfR/Bh77t8RfhOh6M4Q==
X-Received: by 2002:a05:6a20:394c:b0:1fe:90c5:7d00 with SMTP id
 adf61e73a8af0-2093e120ff8mr1098780637.28.1745871037066; 
 Mon, 28 Apr 2025 13:10:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 10/10] accel/tcg: Compile cpu-exec.c twice
Date: Mon, 28 Apr 2025 13:10:28 -0700
Message-ID: <20250428201028.1699157-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c  | 2 --
 accel/tcg/meson.build | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 985abb1269..47c34cdbd6 100644
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


