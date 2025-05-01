Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62402C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLx-00017T-Nv; Thu, 01 May 2025 17:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLp-000121-T7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLo-0001b2-1F
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2255003f4c6so16096455ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134506; x=1746739306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDXEkP41hr8unW2CYQoxGQEU1dZcDdkH6hmvqIdSZek=;
 b=JnZXALGOLYA9N10v33UAh/UJVJcgGU5ZkgQVm/8bZ3fs23ILewkU1EQ0iL7gZj2Z+a
 cI1lOMOJ0p2vMF5CZTYdFbLuj/iaq4H1K40DUTzcnuutcfXRZvda9l4XW9PPfPbXZaar
 K6a31VHLmlQJZoGUuPlujdW2Y+TxSdh5EKl5lvFyl0MdLqEqKxoBjSfEOS3r+Id1M521
 bkxXZlkJm6JGovZrCSpI/K/2imwlshrIaZkwVphA2w+8dwkrskcP43F0SHB5Sh82z9IG
 R8D8HLIJV9goeKdcuM1yRaM/gE0rfDpQjP/hvbAMJLxFLHuz5e96V6v2U0NA52WU0D9r
 Q1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134506; x=1746739306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDXEkP41hr8unW2CYQoxGQEU1dZcDdkH6hmvqIdSZek=;
 b=dfPJ9oS+dMofmn++pW6jRkdI90LmaoYRxeiboLvcPxwd35IGJdtz6GKU7oarrVbdNK
 GnFne2abaeU8tJ61srwwYweGJRNLH82RWfGAo9Ol27+TN5c7bsmSsWgoge7wtJFn+LpZ
 4m49LMXGtPJMs5PYdsyryzQk7kTTixg64nQXKMaDPn7luENwGCfMfj09QTSt14CazuqV
 sKwDHNymHFYmnOK1/MOq+kuQCAbqMrTlsJ358ZHxqxe619yRdkJPdoeBn4s7qDlxXDnM
 PYiZL4CQayXYqlVvse/zgZZtiUKeRjDfNyLZIuW/SFNj+PTU86VcizIFFkMC4tWHmgAb
 j8tQ==
X-Gm-Message-State: AOJu0YzY0c2DYx5qZIjPFzhlGnzfoem2cFUVfSRdBKWlj6249ZyNtH6o
 vkqZc2/ET/mhqZr4P5wq2U3VRjSawrjvIrNUGHVXMhv1T6nLFeJt8iBxkNgXpiRFaDudPmZKvTD
 M
X-Gm-Gg: ASbGncukrnaLHpQbZjWpR2njVR0rnOCJxrN1XeTyMIa326pwzH7l0fXfp8h9SvKsqK4
 RAXnjA+23ssBUZUrT+vmrB/bs6r+2MuR8l66YdabzVPCvL+Xddvkio84V5Lpv3uywifaZbfV4vg
 aeE1TFCTj+I+35HzBRWIIazySL0xN5p9cTl5LRtHZdFamDsVrnxYmWUxcGJWgofUurbiHBVZ6CM
 6EGHuv3+J8n+YscKs+/0z0i4xTfDNSbQ38qP9Gry3FpwgY2PecSqKM+ohaQqaWRo02J86+Rb5Mf
 gralf+OIHS7uRWlMmAW0TFyiDSf6f/yYjgjVgDtKTQBJKIqCU+DazZ0g6oXjtBiQsCYL/vw2ZLE
 =
X-Google-Smtp-Source: AGHT+IHeR0xu8+Xbo4goc4M+TxcnEyj1ZGJXlJYWxp+aAGGMk12lcVMpmrgPuvrPPu1z826LT7sxuA==
X-Received: by 2002:a17:903:41c4:b0:224:2201:84da with SMTP id
 d9443c01a7336-22e102b8586mr6675695ad.6.1746134506563; 
 Thu, 01 May 2025 14:21:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 39/59] accel/tcg: Compile cpu-exec.c twice
Date: Thu,  1 May 2025 14:20:53 -0700
Message-ID: <20250501212113.2961531-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


