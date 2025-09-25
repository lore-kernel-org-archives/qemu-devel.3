Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32710CAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1d60-0006vp-38; Wed, 24 Sep 2025 23:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d5u-0006sS-7q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d5j-0004qV-Bd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso597479f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 20:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758772578; x=1759377378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4Kz54fWkqf5pJtJ1SLfwRrG3d0pJzn6lKo+AM5mSTg=;
 b=jlS/20RyImzC4CMNXzp7bqRG+odSUGtVIctGHIuoaHVGmtuAQo0rtKEBDNvCX7VLff
 TO3d1GtefAnJmY31AryQzXQx69ZxO6Rgvp/ZtKM17NGq/3cFN51Z3NbiWCW88maPcZxZ
 x7ff2hhLztSAXCuMOEZY9B2J+iSaShFxNOqxp2IKzV9O0c8rPUtkRyJ8L9ishzoRkK2p
 oIT5VbCU1ntCZPuYDzXb8d95syIv0pNYJYfAiBB7XFqbjtsebX3QFnOtdRT9//+fmYE3
 R4KqWhaZ1ouLqMGk917olI5bIKXHR/2ZNKakLxNwmBykd6PHHGjtLi6Oc2IBFWsA7ZRb
 xEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758772578; x=1759377378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4Kz54fWkqf5pJtJ1SLfwRrG3d0pJzn6lKo+AM5mSTg=;
 b=GCRelphtEIlegkxGloY0ivHIfEQPwSzKKeL+Vlt4CMIMVShhhNZq1v8feFEkm6gCZs
 pga3Tzt9eVN0J4MehOI2PrH5VhiLderT8++fBvnoycsKU6e7HoXVJWAconk5a7IWoOBc
 nqRi3/WiXpl9fM8hVvDdDCNjHZYH+ES5pCOIORcyW8GYRBBEarRaAyuQEWhybzxN4Pkr
 v0PGaCCBKBWkBr8Uw4bAXEMt3wTGwNMph6viJp2DsrgL6q8rN6VUoSCIkwccw0ftY+QA
 O37EEjlrR/+xWn2o5bHA40Y8q/THYYsUun3fpZog3U+M+BCxqAwCks/GGfmphpUO9Wmg
 6SUw==
X-Gm-Message-State: AOJu0YyuxcjF0g1o1+9nMLgZO4QMm+oWw0ZzWS/1Q+ZkdbL4BxqeN/yJ
 Nbgep2vfCdTdDwsQdV/RhjmEIXhLYpSfqqCQuIGkZNUILxRcoMFzP3jQi/KHwd+76+jIbfXi2dW
 RbVMDBmcH6g==
X-Gm-Gg: ASbGncu6YzA9+2f/6k6jYABIaAKvyEO57qSCjFyJ4PrRiLSdy4FQ177IrGGlXviN504
 POUAlRgEjt/nmNFYzZ4VB3fnZU5KK/jkEpBK7Iqc6m5Whitbxl/2xh5LbBOzvNz8R45i64u9OWF
 P14mC8hKzOqVRTL+G2oFcb2NlBUMGSkRAopMg009oJJQJIAD8xFkwA98feOz7JgOnK8hCZqwjx/
 HMa+za7hqZKf1JnDEesasM2qnnNAgCBoHEMEIk2tFJvrtsK/yflAA2hPJiK1gCe3y6CQpOJEfBB
 CSgo+ZEz/mhAgR4VBHDgxtZRUMJsDdYTvJJS9d2a/c0Mnj/nwb/iIJ5ynX5FGn1thH6u0Y9wzlh
 dwQOPSVhCVrA0ZelekB4hc3WfcbspYlHMeqPA/fDbuUT6qGDeKITojyJxPQnL41Vl6+XM1BQo
X-Google-Smtp-Source: AGHT+IGp65zrEUiiH4cO1KyAoaaOWVOY/DPoXeRD1OvAOyQHFjwu6tfaKIg1JJEGa4KfAa5oLfz5lA==
X-Received: by 2002:a05:600c:1695:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-46e32a19e88mr13418735e9.31.1758772577877; 
 Wed, 24 Sep 2025 20:56:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm1090481f8f.34.2025.09.24.20.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 20:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] accel/tcg: Trace tb_flush() calls
Date: Thu, 25 Sep 2025 05:56:09 +0200
Message-ID: <20250925035610.80605-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925035610.80605-1-philmd@linaro.org>
References: <20250925035610.80605-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-maint.c   | 3 ++-
 accel/tcg/trace-events | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 5a8d0784e7a..cd7c32361bb 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -40,7 +40,7 @@
 #else
 #include "system/runstate.h"
 #endif
-
+#include "trace.h"
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
 #define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
@@ -771,6 +771,7 @@ void tb_flush__exclusive_or_serial(void)
 {
     CPUState *cpu;
 
+    trace_tb_flush();
     assert(tcg_enabled());
     /* Note that cpu_in_serial_context checks cpu_in_exclusive_context. */
     assert(!runstate_is_running() ||
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 14f638810c6..121d6b5081b 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -24,3 +24,6 @@ store_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIx
 store_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
 store_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
 store_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+
+# tb-maint.c
+tb_flush(void) ""
-- 
2.51.0


