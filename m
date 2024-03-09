Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178EFC54E68
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj3YY-0005sC-KO; Sat, 09 Mar 2024 15:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YW-0005pG-Fa
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rj3YT-0006oz-VG
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:44:32 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e55731af5cso1315564b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710017068; x=1710621868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMn63prcVteRus1yYdprTy/N0umMjC+ArdoC3MJRmKA=;
 b=E/FDpu8QnIq+vmpgBNkwgQBHkfKJKdmGlEx6WUbWqieXHA5Wzf4q4MMPuORYdjZzci
 YMUYSdkQpAUKevDxiBW+vIb279GC4dC3QWbDpnT5wo/RrtJdYYxtZ8RxPBqGf6vkvI2y
 4fVnoIO/kay+mEIKq0yyR7OFlKeQPgpGtlo2ENyq4j8xP97IIycCJCUw0g0GeQbTK2MY
 1yUCiFoL+OODe9SLH8edCmIv/xCz+y+H8bpyaLYodHMGXcU9ClfnDj20X5ScDXsBfpSY
 crU9OSun/LzfypO8JPxoM1uw16BN61jJAN2EQv/wtbS/bzJphAKJyr97jUSgJISInQZK
 1VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710017068; x=1710621868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMn63prcVteRus1yYdprTy/N0umMjC+ArdoC3MJRmKA=;
 b=Vrd4p4KJJ2e6GuZ1xXbt7e43jy6roO64c+TOIE0vnMmUf6xY8fpgMvBuHlDzwFpCZy
 SRICQnXhFIP2zYNq5HlzUKJv/V+UNhf1FkzVCenLj6PwzmRrjlu99bVDmiewe9IXa4Yy
 ox3oJotiJuher0XaVwpTtKcPPu/3qJ8a+35u/3YlfjmQCXf4JN7GaCR7nbPrfFK+7pk3
 Ou997PgJaC+l77ZfbWq/bIUk3jJLE6HzWafFeHoreXlI4zKdvJS4W91H4Yyi3bNV9JOr
 qSFSBxxYH+wrEfhKSwLAfrzIk9d/GoL3ZjfcUyjM65iMvcgR7WeXu+jvXmYT3+hh5zlM
 cvEQ==
X-Gm-Message-State: AOJu0Yxllo0ICKZXYbUZsjnGeo9OiWO+P3EoJpMZN1iEVjZxKicZ9yfL
 +gEdvHpcZs2uZgXYBgR4tzG+RRKKiUOAeZdF4AwIgr52zRls1dG8RNk/SpEp+yt7Xe/+eUuxzST
 l
X-Google-Smtp-Source: AGHT+IGp6Ba4syf9cTtUtqMZdnk67TwHHVABdKWKTPuos8VhML59TOJ/a8xN5TDiuoUhA5cKjetrUA==
X-Received: by 2002:aa7:88cd:0:b0:6e5:561b:4670 with SMTP id
 k13-20020aa788cd000000b006e5561b4670mr3057533pff.30.1710017067977; 
 Sat, 09 Mar 2024 12:44:27 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 ey15-20020a056a0038cf00b006e647716b6esm1656270pfb.149.2024.03.09.12.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 12:44:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 10/10] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Sat,  9 Mar 2024 17:43:45 -0300
Message-ID: <20240309204347.174251-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240309204347.174251-1-dbarboza@ventanamicro.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Change the for loops in ldst helpers to do a single increment in the
counter, and assign it env->vstart, to avoid re-reading from vstart
every time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4fe8752eea..ee57300dc0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -195,7 +195,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
         return;
     }
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -270,7 +270,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     }
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


