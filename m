Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58635C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLW-0004kV-M4; Fri, 17 Jan 2025 00:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLV-0004k5-FL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:41 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLT-0005xX-VG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:41 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2167141dfa1so31193265ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093398; x=1737698198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLnBihuDspGbf8KpDsGSgkbtC/pFV4W4Cyh+WGRIFJc=;
 b=lSWGF7Dota70LREHg8SOR0JVOYx+SPDq9+AW8nhkUt+IwgG+Bu3Ygl8i2GbuSsEznr
 Wim7PGdtAYLnXJQFfUAtkIpF/PIyzJoHMJ/NCQxkkDc+RVqFNY/FztYtVgLgbS3TKevu
 wn+IEHBRJa0XYSC1J8/m5Q+m7dZKBjRxzmp23GBwwzNWElrzFQ3eQ92I1lDAe5k5Mq01
 CkP04leuj/DerEn/6Ewqj2idjuEcHqWUR9WyCoVTG9TT6u38HAKmwjsASGt/Q37Ysrfk
 vXFUTeKEQiQC0luQEqw1PySZ1jJYmlE0kApuWCA6WfD6FY2+8MA47zXeZPvfu637Xdxh
 xygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093398; x=1737698198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLnBihuDspGbf8KpDsGSgkbtC/pFV4W4Cyh+WGRIFJc=;
 b=DskeBM12givJE8NWHHCwGCtTy0duH5m7X1vEwlOZSiqc6Fo5oYTn0uCxJ90k7T4Kf1
 SwvSj+7kwpAd7/8ZhtW+jWAee0e1N1bqY3vFWjOlFBvi/yZeHYDMZbYFVCSMYZN1ckAs
 UiyQ6aMn5mZToi/yqAnmH780uGH8Dzeg0TQsYEr+AyfeOmfxHxiDAs7kfN0iA9ihCgB4
 IM5UoUHxpeWxuBE5lA1CfUgkCLKK/M0zNhsdygkTIkdr1qH1bHECN5souhkvEKO81HJ1
 vzPZKMB27dEba1LQp6ui5zvendXSsaUYXGsFAPY6SUxS/DX/gTZym2Gpom39g0LZ3eK5
 4crQ==
X-Gm-Message-State: AOJu0YzX6QUW64RVFBaXjwVXasMH0J3z/lSwX0oWO6yAFEjW5J0XvaVW
 mfYf4EIKfPWjR876mySjjnKTO5MZGG/S0GX7AQgDYkHpDbVn28GXLJ9UFw==
X-Gm-Gg: ASbGncurN22G+p86c5aoVo4rOMEkY5A8x2nhbe8t6cAZY5oxRk9gjYrDtSAMZCitfTH
 ShuAm7gxsWdikm/n10UPZWednrOfsYw6JUih9te3+BYb02D/z5BEc9W1ZEdRsYrBBPngz+2kFSX
 rDSnRq8ghkvmiWkA0V5BFrLf8PbQMn7k47fA+B0SAuA5qDYppKX5MbamxOqT4KhXwzCMeKUWQOn
 c51HICrONRp3MWS4OeI2fnjLF7qJ21nqUuUHVQZNT0Q7yVhCxz6EpkN3QFQ6P4Jg9XGPEotpg1y
 9PmIpxC40PeNOOirxe2voD5evHOqIYEB2xs7ehus8J7S+BM1OjfGJRWC/mA0
X-Google-Smtp-Source: AGHT+IFc7OgEss2LGhjHII4yj2vqsWeLQ+DaBSwLC5kK3h5wKeMF2Bw/GiHw+dDGMW2hwelTJuf/aA==
X-Received: by 2002:a17:902:cccc:b0:215:44fe:163d with SMTP id
 d9443c01a7336-21c366a67bemr22503445ad.17.1737093398383; 
 Thu, 16 Jan 2025 21:56:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/50] target/riscv: use RISCVException enum in exception
 helpers
Date: Fri, 17 Jan 2025 15:55:13 +1000
Message-ID: <20250117055552.108376-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Do a cosmetic change in riscv_raise_exception() to change 'exception'
type from uint32_t to RISCVException, making it a bit clear that the
arg is directly correlated to the RISCVException enum.

As a side effect, change 'excp' type from int to RISCVException in
generate_exception() to guarantee that all callers of
riscv_raise_exception() will use the enum.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250106173734.412353-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 3 ++-
 target/riscv/op_helper.c | 3 ++-
 target/riscv/translate.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 252fdb8672..3d9c404254 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -606,7 +606,8 @@ void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
 
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      uint32_t exception, uintptr_t pc);
+                                      RISCVException exception,
+                                      uintptr_t pc);
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b..29c104bc23 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -27,7 +27,8 @@
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      uint32_t exception, uintptr_t pc)
+                                      RISCVException exception,
+                                      uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
     cs->exception_index = exception;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a992d4f3c6..f46d76c785 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -245,7 +245,7 @@ static void gen_update_pc(DisasContext *ctx, target_long diff)
     ctx->pc_save = ctx->base.pc_next + diff;
 }
 
-static void generate_exception(DisasContext *ctx, int excp)
+static void generate_exception(DisasContext *ctx, RISCVException excp)
 {
     gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
-- 
2.47.1


