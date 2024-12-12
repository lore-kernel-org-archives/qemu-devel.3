Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE63BE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6w-0003gw-Vw; Thu, 12 Dec 2024 15:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6o-0003en-V9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:32 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6l-0000w1-6y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:30 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e3284f963so413287a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734036502; x=1734641302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fg83bkK5yDHZA4CF6jEqCNLgZcxdUb+0IUzm0zJzq60=;
 b=Wi/S21PsJjaRbkIyxd8x6B0bFcf8oraokP/GlkXAin1rSI5sw7cxH9x2hpLgpOtk3t
 c2GKFWo43x/WiqoFssKlu2vKHAlRqJyqzPzWnYztNx5+Mg2/t16hxK65LICONyXkdvYB
 lVZ7DkWvbJm/MmHhTqA06FAMBTUAUiIb6IPOKH5oDF0Xo3LvD5WZ0rbl3CFlT78C7YII
 7meZjS/Jr5O5hU9W97s9Vy5aLsw0irE/eMG2jS4YUrBwF5zo7oNI8KKUKCo1w+2SgK6X
 YlsvdCI4bBLvxHi6GE1mpR3S3dEOJkarOxY1S/CXl+IhipSzbzUrhX41RiGRF0faZc+y
 5exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036502; x=1734641302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fg83bkK5yDHZA4CF6jEqCNLgZcxdUb+0IUzm0zJzq60=;
 b=VgmDh4nFosfWng07Rbvux5HMCHbG9QwOvBEbUk5cz1ddF0ZR5FWmYiXg21opNGWDp3
 GZf+iItH2XoBCq8XxioeJLNHC228C8ZWgqReRnok5qAQ+cUeIvM1ufOkfkpf7KU77C3u
 SofYXYKcsinF4IwB9oM6kAMrsY54odE/SKM9YOvqFuD3wDj4JbAY4ySP4fD9v+834MFd
 Nbc53GRBBzN88JlhZHo93eWVnNNETlNawwSpy7DpghrZ2SC8mErhmjjkvZxGCkUiXRm3
 RKKcqlZRBoOON1N9IbmGAqYwsy8xZnCfhea0Al4Qiicv3LndruAreTmtraPIDNYJz7+Y
 R7qw==
X-Gm-Message-State: AOJu0YxkAiuyk7r/xA0Eo46vdI4DPqUrzqP+ny4Lx+bfdLp9tzfuFW56
 lauurXkvmmts2EoK47MC3ROfMjCoDZ11ADxcSQslfaEpbsPCC+6iCoQkLecXbDmFZfMfIHNANIF
 oahp+QuMO
X-Gm-Gg: ASbGncu8GhdrwrTX0keuRZiEuMRcOQ4aq11RDXG4PJrrvRtu3RlFCV6BzkXfgCVOQfB
 SG2TAi3pr/GBgKkf69MF2af1j+BJSgnTG+Dnmz3869RspeOg+hpxgI1pm1K/gVhj4AeKrQy03yV
 YD78P6AE7LxLkUBqRFOY8l3GUrsa1SCH6vc4Q11HEprSjSH/IDXZ9Oo1IVS3+rBE8wAtTVZP7Xa
 qqL7H2Aulg90iU7uB6Yf8UFFfNHofJr7Rwki3kMlE+tvVyJ8nGxk+gaE8paWt/E
X-Google-Smtp-Source: AGHT+IGIjce4gvUhvIil/YheyOAJ3cDNHDx0Cu9v8CsxRmFLmOUxeTrBt4ihrV5uj08AKI6vfRlmAQ==
X-Received: by 2002:a05:6830:3116:b0:718:6cc:b5a2 with SMTP id
 46e09a7af769-71e370bec7bmr1074023a34.20.1734036502447; 
 Thu, 12 Dec 2024 12:48:22 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2b8197b58sm2129758eaf.12.2024.12.12.12.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wannacu <wannacu2049@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/4] tcg: Reset free_temps before tcg_optimize
Date: Thu, 12 Dec 2024 14:48:15 -0600
Message-ID: <20241212204818.2468583-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212204818.2468583-1-richard.henderson@linaro.org>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When allocating new temps during tcg_optmize, do not re-use
any EBB temps that were used within the TB.  We do not have
any idea what span of the TB in which the temp was live.

Introduce tcg_temp_ebb_reset_freed and use before tcg_optimize,
as well as replacing the equivalent in plugin_gen_inject and
tcg_func_start.

Cc: qemu-stable@nongnu.org
Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
Reported-by: wannacu <wannacu2049@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-temp-internal.h | 6 ++++++
 accel/tcg/plugin-gen.c          | 2 +-
 tcg/tcg.c                       | 5 ++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 44192c55a9..98f91e68b7 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -42,4 +42,10 @@ TCGv_i64 tcg_temp_ebb_new_i64(void);
 TCGv_ptr tcg_temp_ebb_new_ptr(void);
 TCGv_i128 tcg_temp_ebb_new_i128(void);
 
+/* Forget all freed EBB temps, so that new allocations produce new temps. */
+static inline void tcg_temp_ebb_reset_freed(TCGContext *s)
+{
+    memset(s->free_temps, 0, sizeof(s->free_temps));
+}
+
 #endif /* TCG_TEMP_FREE_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 0f47bfbb48..1ef075552c 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -275,7 +275,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
      * that might be live within the existing opcode stream.
      * The simplest solution is to release them all and create new.
      */
-    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
+    tcg_temp_ebb_reset_freed(tcg_ctx);
 
     QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
         switch (op->opc) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0babae1b88..4578b185be 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1489,7 +1489,7 @@ void tcg_func_start(TCGContext *s)
     s->nb_temps = s->nb_globals;
 
     /* No temps have been previously allocated for size or locality.  */
-    memset(s->free_temps, 0, sizeof(s->free_temps));
+    tcg_temp_ebb_reset_freed(s);
 
     /* No constant temps have been previously allocated. */
     for (int i = 0; i < TCG_TYPE_COUNT; ++i) {
@@ -6120,6 +6120,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
+    /* Do not reuse any EBB that may be allocated within the TB. */
+    tcg_temp_ebb_reset_freed(s);
+
     tcg_optimize(s);
 
     reachable_code_pass(s);
-- 
2.43.0


