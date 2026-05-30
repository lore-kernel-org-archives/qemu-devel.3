Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA20CD6E53
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzg-0005hZ-N6; Sat, 30 May 2026 17:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzU-0005eE-Lf
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzS-0000ma-7O
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c20f0c0aso997275ad.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175584; x=1780780384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyTvLUnnO1vXqEM/LWenPW1IEdmUpPSMFl0cuHem8z4=;
 b=cVjhLiH+2Z3ViqdemRMr7ueaO4+cgxG3DdcDFR8A6h7bnHRkEBm4SbCRA7w2af+ggf
 lGmkr/Vaw2r47V92Yym8GTQQ4xdaHcQsUqON/eH0bpK25CN8dtVVVBsIkxA/yORyanS/
 ESQByiZk1J+UM7uzUTs8s7Ie4PN1JMdBEC52YkFn1LaDcTbm+vSWRBW2j0wW6fAYAewd
 f3r85RIPehy+Uu4gNtAY4gDIjj1ToEHZs+3TU1u02iXVeWdWs7lZe9VlV5Zk8kdIWMiy
 i845lcpUz551s60ex6v98LwipIqKAFuHgafPhQGv8P7uU4bYmomCBOesoTq+qW/RBmCY
 +3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175584; x=1780780384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LyTvLUnnO1vXqEM/LWenPW1IEdmUpPSMFl0cuHem8z4=;
 b=UvS5lOcELiU/RyeU/flltAZvYSsLQgnGiWnE2Jp4d/mjavt88NinVDaEBFmSemEsnr
 CTlpM1Yt4d91SgRq+KFaDmfxCVx0Jr2P+C8g9c88hzXkGNgT+lWI9cd40vuWNWMvwye0
 F3lwA8SvcCis7exEfo8BWA9CGsaUEjqv0ZufpWK4CuFxnItVnVOmrgQFrJsAneOZxDJG
 R4tIUte3sAcpzcKnh0kECuNH81b1dsNE1/lHkWe9Pev5v7bKEmOskc8q1Tm0HNqOorJv
 io79PtH26AnLtegZWwOiQVTTaookfvk9kIV2uCdIiFsRsoRTI6LFm+s+zUoq6/Jx5D3y
 N6fg==
X-Gm-Message-State: AOJu0YyTD7EdGagnGytDNeG7N+UeZiLUPSjVH4v3D3Cw+Hr0RJYUgdjk
 EN5exP/BDX62JOa8NHnQYEozXLXwRQ7vip/oWxhujq/trNB5AgUopgIs3ef3uPAIggAWAK5Gs7s
 izR4vvYk=
X-Gm-Gg: Acq92OGY8vvmQjyT/omhYeUE4YjjXKZbOBNjuHE6WASdimc+v8h9zyrmJD47ClBZ9sr
 QXPWq3aGYmSwiX5/GfJxUOsDyER6Ygst209xGByK3kp9eFEEddi5+nEjza54AUgSKTLs7fW+E8y
 pTidOedUmjBrayQoxo/9Eyc9ZztVBrUC3GhF0PqN1TLfJ8JSkpht5tSU3MOpsJrJ9GrpAHsLLFk
 vMwvfv6v684S7aBVeRqfwVUUgj9q9upKr1tWNU+kbOR268QgLIYDDUyV0XhK5eDYk2zUatPNTj+
 OpCTddbyOQaQUBxCaWPuyubsMF5kDttBvfzWK5+OOY5Ka67lBDnk++w1Fe85vf8s411HHmr03QY
 jVyAKL/SGzRh5QAusbz2STxZTY4pVGRtYv/YoXd7GASFiHh5ikoHO2ve/3kEeBBX74jj4d6MdSp
 FhHq13DsXVNyGT5OKaMh2FHZMhVxe3kiLLh8eOrY8FXnN63VRcTw==
X-Received: by 2002:a17:902:ef4c:b0:2c0:c38d:9d51 with SMTP id
 d9443c01a7336-2c0c38da22dmr6834525ad.21.1780175583742; 
 Sat, 30 May 2026 14:13:03 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 13/13] common-user: Move guest_base,
 have_guest_base to probe-guest-base.c
Date: Sat, 30 May 2026 14:12:47 -0700
Message-ID: <20260530211248.375318-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Unify the definitions of guest_base and have_guest_base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c                | 3 +--
 common-user/probe-guest-base.c | 4 ++++
 linux-user/main.c              | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 772a26199b..3201da2318 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -62,8 +62,7 @@ intptr_t qemu_host_page_mask;
 
 static bool opt_one_insn_per_tb;
 static unsigned long opt_tb_size;
-uintptr_t guest_base;
-bool have_guest_base;
+
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.c
index 77722fe63f..6f1247cf1a 100644
--- a/common-user/probe-guest-base.c
+++ b/common-user/probe-guest-base.c
@@ -7,6 +7,7 @@
 #include "qemu/log.h"
 #include "user/guest-base.h"
 #include "user/mmap-min-addr.h"
+#include "user/guest-base.h"
 #include "user/guest-host.h"
 #include "user/probe-guest-base.h"
 #include "user/selfmap.h"
@@ -18,6 +19,9 @@
 #define MAP_FIXED_NOREPLACE  (MAP_FIXED | MAP_EXCL)
 #endif
 
+uintptr_t guest_base;
+bool have_guest_base;
+
 /**
  * pgb_try_mmap:
  * @addr: host start address
diff --git a/linux-user/main.c b/linux-user/main.c
index 01cf5bf079..60a695b7ca 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -79,8 +79,6 @@ static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
 static const char *seed_optarg;
-uintptr_t guest_base;
-bool have_guest_base;
 
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
-- 
2.43.0


