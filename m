Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D321CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqT-000416-SK; Thu, 18 Jun 2026 15:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIqG-0003w1-Ac
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:56:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIqE-00082Y-2m
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6ec0af575so8266725ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812557; x=1782417357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T01hsQsKs98UkflLhLrhZujUy9/6glB8JiaSx+gv5C8=;
 b=HSBqKS06SZiDwkkRpFvxzKcXko/JkKAeqyI1hEts68VtvwBCDgJHIR9qInDQhLlz3D
 Vc3ppnSKONyr4w9wMPyrBkly6+doZ61nFcDezeY0k00Ne6IgNaM5AWoc+l+sD0+nKDqJ
 uIKYIoH5SJeOQdgsgjMfojnlez7CQd3S0sbHYDPES/2azbcYqD3eIlZ3ESwnPfBpgQxS
 Zj06KqWhGpphIH8tMW93z3HytXeSwC2DpPEj6+19X41dGsru0p4FdAPdDnF2bPo9+7QT
 cg6XgE/rlumZ/eDF1Vwmz5ixU+jLZ/+KiLo97Y6hlu24zhf6JznrWH0RXzmXFsYy4CLM
 K+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812557; x=1782417357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T01hsQsKs98UkflLhLrhZujUy9/6glB8JiaSx+gv5C8=;
 b=LlSQjTBxzvIp+5zQ2lfZC2m582+tO31HK6xvL9FUueum2+F4TmUu46s4w7V3e0q7f5
 I0hAXeySTMceFzIdAi5XHJQHe7276KFVyIVEQq3H0YPT6H/oi+ERjyRxzL8kHINx4SK3
 3BUvMkIePaTX43BF0Fg+p0WSANdIs2CkRanIdWNJDQDylVi4NhphKRxpricE1VDThrXM
 nsnVYzTtIfY6e4+tk+OKZp+b2d8/YeInZGs/BMZdVnGLMy0E1ISG8DSqh/OnLpsF7OXt
 1qSUDVpojVYcl8SieH1TO1OZrJsKuHFIOpovPDccYmIO1V6HECT6JWfhIoqfnuJfZ8wR
 cKyw==
X-Gm-Message-State: AOJu0Ywv4CH4HsaUzVuDezSsAahZkq9mbAin/3PYcqmvLyJRABdJ8CvS
 vGn356h0F7fnIHtl+yjBjK96MkZie7ICXqTu0pvxgSsSG7WGDizmNQO5utYSx/3jEazGk3NszUs
 TkfIH
X-Gm-Gg: AfdE7ckRZwxkrLZ2OG+LYM1b09n96UPMeg945KCUFpAKu1/52qEWtVytJ/MiYZT6JiY
 IhGlv0P6XBRKmSlQAZYNwLcepHpOjyUletpe0mtS6PwsXW2a6wrH4bdeB0YvwYWnemeoO9InM5K
 QiznMRY4kElnmmXr9MQW3LwxG6ikSd4rwTAEfjDCGbUSdSSB0cOv5yk9B56JcAOmAormll2fd91
 pJ1FnyG0onjmdLyBor7XJjfT5Brkj/ZdxdtjicewytgFWb3I4vRuJNTSW0ZqY8K57D+n2Bny8/r
 oIpTQLZW7vQULT4tzrXj3kg4c72zJKdnyUXxutQRvgqkA4o+ntX9YMMG9HXa6YK3EuA7yERoDcL
 6Al0RP9er9Vcad0/vojjoDq40X5Bq0x8WIR9rk2Erq2put3KV+btpRDMLHA5larlUrf/Dz4lqx0
 MmfQbV+QM6SYs6UmxXptZCycfPw9mfgQKm8dxEH2oNtzS9vV3jIoMDNFBTNuTz
X-Received: by 2002:a17:903:2ec7:b0:2c0:3400:5c34 with SMTP id
 d9443c01a7336-2c718c879fbmr7348815ad.3.1781812556454; 
 Thu, 18 Jun 2026 12:55:56 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 13/13] common-user: Move guest_base,
 have_guest_base to probe-guest-base.c
Date: Thu, 18 Jun 2026 12:55:19 -0700
Message-ID: <20260618195520.589907-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


