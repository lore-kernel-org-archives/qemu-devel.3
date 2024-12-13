Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B24E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1B-0002Qp-T9; Fri, 13 Dec 2024 14:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1A-0002QS-C2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:04 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB17-0006RP-3T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:02 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f304ac59b9so1028155eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116878; x=1734721678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fg83bkK5yDHZA4CF6jEqCNLgZcxdUb+0IUzm0zJzq60=;
 b=yLenxXzWQhLDhPynk8VpDALc6rFiWjmfSifIeS1wa8o+rG4zPmYkeXknqhu4EFuLa0
 2l54WQMoQB3l24CrMyCsi2kKx12pLKEtElJdJGX3jj2dmDJmjUAeDVf01EMltH2DcOgr
 HsI2N6Y0ws8ZRnfuFDE+fTkhMOWCUJ2SEh+6RXke95MlaqS2Ov8M6iGW4WFP7qoNIh2t
 whwn0uYhd6aUcLxpu6kWFw24wN+lS0asP8JprQFx/a0B+kqdvbb8mQp/PxGyzRmRhW/p
 Wd9TVoS57QqZQuUFzkqNGyzMFlL1YSuj1UJgRuzAuSuSO8enwOLSiOBE3khU7brrLTuI
 5Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116878; x=1734721678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fg83bkK5yDHZA4CF6jEqCNLgZcxdUb+0IUzm0zJzq60=;
 b=l5UFDRTYVx2aWHxgboQ8qibl6dNXtH7jA37vqLu+VejoFnNP18XoaYSMjjZdTu4ma1
 ODQzURAzTWvI/t71ibtVp6viBgRkS8LtazObn5prOWiCIpeYKDlN3tZ12VHwTqImAU77
 Ty+FBMB8jLNRSzrJ1OAZmIVO2ZJIU7Bsir2W2a+BtH6OaWw7wO/YC85UCdmz6SafdyLb
 w2v/z3FUS5i32wX0wEuoKd/c/Bi92XdKp6CHPESpkbJ5/TL5y+xO95AOpFLuycmSNAJf
 8y8ZA01vkWrX+c9bIxNZpvMfGMCxGFK7pRUyNo5hE1SiBRQy9Fkjc712V2+lS1AAcyjv
 uDVg==
X-Gm-Message-State: AOJu0YxDZdvTeIQxsHghwWTPrqL9HM3dKT2Ad/rZgXHRCu2TjhPaVpQj
 ViO8THzdcPxENKhtIyBhcyyZk1G4KTtoUNdio3RMaiP6ONYbn1aj2ew0qjS5e2wj1VMEYS5slII
 RAvYNSgF7
X-Gm-Gg: ASbGnct0CCwfJsBc/rU39mivrTcR9UUehXFNUiskA3rH9ettt4adkurXO2WQdeNg3pX
 gjuTWnlmHfnqTD2WSmdVFiTeIw2v9zR53TYtjU6WqBFPOtU279pX0pCpVPTzNJF3aNZ4yHLgwnG
 HIx1vGqNsZpPvZn4nJiOYLDxbSvyzvJ6YYk5ZxDyxifFocbiZpV0YdFdQrDOHfQKY9ZOS30TMYp
 NMVvkrLxRXepAnUuPcDHQq12v0eqsTdpAT0wBSKfUN0obohL4xqS30ds7rQyBtD
X-Google-Smtp-Source: AGHT+IG9mwVMxgF7u9CJXhYmIYbKAqZtEi8lkzzYIBYMlis6b7fu6wuyWXNSxxfv+D1gGuewkW8E5g==
X-Received: by 2002:a05:6830:6f82:b0:718:9f3e:6bcb with SMTP id
 46e09a7af769-71e3b85e5damr2192742a34.10.1734116877764; 
 Fri, 13 Dec 2024 11:07:57 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:07:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wannacu <wannacu2049@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/4] tcg: Reset free_temps before tcg_optimize
Date: Fri, 13 Dec 2024 13:06:32 -0600
Message-ID: <20241213190750.2513964-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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


