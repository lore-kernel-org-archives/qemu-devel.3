Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1bi-0004oz-TT; Tue, 10 Dec 2024 09:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL1bh-0004oj-UN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:53:01 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL1bg-0004n0-AV
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:53:01 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71de29ea79aso1407920a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733842377; x=1734447177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qKF8Cx1znqw8VyDBmjR1MhKUokoIuJikDCmORwXERYk=;
 b=ASDkx5yv+S9GrC+4k/RNLByls9JJH5VfBzdc4g9fc7hniV2o8i9hbZ6m7Oq8Ln3h0K
 37j+K22fvL2UXKz43rjqbYPQKTgUSCvm421s5NRVCEMVgIchlycq5D4rbWG+2rlMc5um
 m0KU16rlFcq8xU29HfhpSXqfM1QMs3q8/BgGzTyCPhwI/xz19a+OSzIRYkU+s3pTIfV+
 zsRj2R6S3i/H+ACyVN5P3iKs/9C1ZuiwH+A8eTo+2IADX2bPvhI9BVRSk2OQpcdX1sOv
 6jgvolER8tjqPj4UdvsH+N7cedoreXz96u5wSUsy9YOwtXny4Qb7FKJ7pH8COBpA30uT
 gP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733842377; x=1734447177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKF8Cx1znqw8VyDBmjR1MhKUokoIuJikDCmORwXERYk=;
 b=sseSV9ZnxDzlRq+pJoUsBHfhIZfjn4szPPIlELSICeW3383exl7/ptV3U2wiO7b2yU
 x0Bk1sD/Whu6w3OuEobFle3K99L5BqHOYxScepY1eoeaKbe/qiV0wuAQOm3yrtxUV+xa
 wWSAVVaCfC17C6Qv57Mw7peTrDZ3NazDZeX5ayzmWEZPd8S8DM1RXPaHaOyB0GgiDHn/
 tKbP2KCKB7zha59ytRde5+Z26GuF9TXB2xjgd3HFirrbDi/pGjQSCjBaEF1uqDIyW2DZ
 8WTamcxvRXEyqUXrdpi21eU2Y0YouSOmHr3lxe7EwL4Gql+KswFlMs0HVMfZ6sOVxM/8
 LNCg==
X-Gm-Message-State: AOJu0YxE0hDx5KorqqBo+W4wgKgnXGaQ72RuO/8+fO7KZR/vedzUHjzR
 l5pFQLLrBa7Rr4Bp0OPSLZCinZ4d0Uz7Q2wOlZ9Ji+twSwdtloPjZBdSHYn222wu/LV0DCMWcIN
 sRxRvXCpM
X-Gm-Gg: ASbGncuRFsgVCwHuIhRKcEJ/bvvg+KdO+6AlAw95uf5ZtdQ3+7raFCudsnWZnJDhqcl
 N8MYts9kFEQS/UVLHJoruwW4PM55OE4pyPCL7W/0Ea0niBwdnYHm9FScyg9Kh9n+mNI1F63weFf
 G/E7xqCRa99PKxYbzCPhdbxhLiLTsPEH1qP6QGpLvRg/ESZJJGiAXj2DxHSP1KJv/UTvclkSv/F
 UDUOpj6t6aGx3UxRHTqLmP4lR0dH6FOVRorOk3kUqHyassMOHtUheN7QT7usS6x/R0kXXEImoVE
 xlDgznLFoqn7+fRnWEGKGg18S6Qj/a79WeIvZPgO
X-Google-Smtp-Source: AGHT+IHFgPX7S5UcE8a7yFvKxXxH4NTbziNt5m17Z2ZsrLZUjvxhmE3r4q6w6WtriFSiCDMPKJJeBA==
X-Received: by 2002:a05:6830:700f:b0:71d:fdce:79eb with SMTP id
 46e09a7af769-71dfdce85c3mr3855990a34.30.1733842376056; 
 Tue, 10 Dec 2024 06:52:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e09ff03f2sm153291a34.24.2024.12.10.06.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 06:52:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-stable@nongnu.org, wannacu <wannacu2049@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] tcg: Reset free_temps before tcg_optimize
Date: Tue, 10 Dec 2024 08:52:53 -0600
Message-ID: <20241210145253.1822737-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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


