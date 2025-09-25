Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82422CAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aPk-0006lp-J6; Wed, 24 Sep 2025 21:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aPh-0006la-5k
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:04:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aPd-0006OT-Pd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:04:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so369652f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758762281; x=1759367081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZMMGDklz6fqAGv14RaNlRfNO0vD6ThQ5dgVd4PnFxg=;
 b=FvCHflLjEsBiu4s4/qjoGHMIfCFTwn2/FDdWZaMBcmxaaDSBEDuBKgMh1n9rESa5UF
 dFdiq5o9ArmycwlPUKtUqleROxyosZK0YCUovs9kd21YsQmSVB+HRwI84KGDjK7GW6iI
 HjK0dtTJ5tf/1JZAwlDVy0qNcLFsmcqfpehOv/E5TJ9Cx65Ddq4szZ97SEdrALUSwlby
 v/sJ3uWLVksTrt2GhZVqUXkxWjbWDYSoDWdfPbFNdaD1S/jnm15QV9jkwvApm/KSRVgx
 9Jld7tR3dlBF6ifIG5nHLSIqS7XKYUHz47pz0tXunOsxuL5Ho5dxuz2bYiKOpTsN8fFp
 ECSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762281; x=1759367081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZMMGDklz6fqAGv14RaNlRfNO0vD6ThQ5dgVd4PnFxg=;
 b=cEXTlWKZdEbkzqUeC3iGRWk0BE7QyfLVvJQgZ6tHg5Dv+VghlDljGwSSF4rY8idagT
 5h+pPhEtvjU307loNMPcKx6hugEFKzoM1DB8Oj+g3rNEE6hJt/zUCAg4kx6GkucPn4Wj
 0ypxMXg+Lnq2LSzcIJ8Q4FPYgnGWdTCKoAJBzURbVktfJXo2Zt5aMLPUA+Om4ZkF8GrW
 pz9IZq4jnpM4ESJ4QokF9+R9WPAiDZDGyY8gOXbZ+WWcuGP6gPbRJu8Hjw+F6q+f4w2k
 kT4ZjE8dNWXpY+oH17GFWkTxqy1KLxM8+I8GaW+krUOjbO9eJ0A8e2EcGLlKFs5GisbU
 yNjw==
X-Gm-Message-State: AOJu0Yy4RoGjEc8GYsFtZt6zaU0ketfcjfESDoXk0m/KFFLk7cuI5icm
 5x1Tz/8xIHnD4PyjQdC7sE6wvj6SBu3MFnMx6xs7HgYJcKFFVO/5zj0YNQqG3Xaheww4PuuIzDz
 NY0JknVqj6A==
X-Gm-Gg: ASbGncvhC843fSwFqxg0rS5Vb2x69jC1fD2aPVZ0iiUxdHFzJxN2dcNHAUy8Mh/tE0L
 FTNdvJx6HpJaRw7XhW0RWLupw9PZNcaLTzA2C6eqVMFrhRm4QiGUmSQq96toaxD6vVi9diM6eGT
 v2RTm9zxcblezYzYsVEIaBDnvxoV4RUMnQVIf4/5lcYuEPKKeaTzYwJNbnPiHSaM3Ayaf8rERBd
 eWUIN1UrsK+pTdbxgPjYVUYURLfzs3RWSV8EwR1PAoND/oZSiuIo+W6SEypc1EMpkJvEcRy3I7e
 nHGRuoZz+lZmQMkfysYwQJ8TxGRW4ONnhmDuSo8AbcP8qa+6SzLHtDTfSFN8vLkckgLMHBcfDUM
 wZZgQDTVu4mW/Ns2ubygfMl6Zu7zv1GIXOBe8OhkgWfRq9s42moBG0YC+RZB0DLO4ZztKZNus
X-Google-Smtp-Source: AGHT+IHt96m2X/Xqcun+u7z38gWKeAx2aC1+2c+6APkB0TNk8jZKZmdQ0JgyJ+uPDJaCmS7NErGdwA==
X-Received: by 2002:a05:6000:2287:b0:3f2:dc6e:6a89 with SMTP id
 ffacd0b85a97d-40e4accc7e1mr1240532f8f.57.1758762281274; 
 Wed, 24 Sep 2025 18:04:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602f15sm624274f8f.39.2025.09.24.18.04.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 18:04:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/alpha: Access CPUState::cpu_index via helper
Date: Thu, 25 Sep 2025 03:04:38 +0200
Message-ID: <20250925010438.59755-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

CPUState::cpu_index is a target agnostic field, meant
for common code (i.e. accel/ and system/ folders).

Target specific code should use the CPUClass::get_arch_id()
helper, even if there is a 1:1 mapping.

In preparation of generic changes around CPU indexing,
introduce the whoami helper to access the generic
CPUState::cpu_index field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.h     | 1 +
 target/alpha/sys_helper.c | 5 +++++
 target/alpha/translate.c  | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index d60f2087031..be7c8c5b8a7 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -93,6 +93,7 @@ DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(halt, void, i64)
+DEF_HELPER_1(whami, i64, env)
 
 DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
 DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 51e32544287..abd80532483 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -73,3 +73,8 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
         timer_del(cpu->alarm_timer);
     }
 }
+
+uint64_t HELPER(whami)(CPUAlphaState *env)
+{
+    return env_cpu(env)->cpu_index;
+}
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index cebab0318cf..8a68b90141f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1128,8 +1128,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             break;
         case 0x3C:
             /* WHAMI */
-            tcg_gen_ld32s_i64(ctx->ir[IR_V0], tcg_env,
-                -offsetof(AlphaCPU, env) + offsetof(CPUState, cpu_index));
+            gen_helper_whami(ctx->ir[IR_V0], tcg_env);
             break;
 
         case 0x3E:
-- 
2.51.0


