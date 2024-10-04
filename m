Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67930CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlDJ-0004Fb-3d; Fri, 04 Oct 2024 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDD-0004CT-AS
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:28 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDA-0005ZR-La
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:31:27 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539908f238fso2742510e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059483; x=1728664283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAoM1TIG4dq1VUGRtKg0GSKBpc95w16YyE/RovaDYeo=;
 b=czLUMgmZg/WkeTEEMbGyhaKZYmhPUsGqIccstZ9kB0xk5mcfGu0povwpqMqZNC/8pa
 PQDvP2CiiYVdPCDJmX6xjCiKCpiy7fyqXaNot1yELmXR/sX5xv5vFQWrZ1UKZkG/Tt6K
 gPBqIRal3rAXeq0DhSRlMnlGRvNeVYBBhExcjtbJr0sLwhoJDOfZ5Fk7AxI1V23AgZJc
 O5+VtNs6yQqV+LFvdkmmZwEYRFE9/+Hhu8MbR+8Dmb8XO1zkDy9yo4vlgbV9UXJQyPXZ
 InxsWje2AmrttMi2mb5jgDJ+D6nzApmg0zjKS14RzCi3n4eWN5tIRyskAhvou/pRSlg2
 cYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059483; x=1728664283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAoM1TIG4dq1VUGRtKg0GSKBpc95w16YyE/RovaDYeo=;
 b=GJ+H76jbs/OxLqaRWEwxgevvDGeNvikDsNqLUafHeXaBo+mdM9GcSm20fhKek1EKsL
 AQkI6pXOYvmV+zgdte5HM7BkbjsV+O7gQ7wSf6Ob5+uHTNVoEY4+59X2XrjSrN63/KUa
 fGzNA8X8hFGBlK6ZFaFnbDx75OLoST1Q1KZ8l0LQSb8PDHiK9r4JPjTWPp02ZiDQPZBK
 NHRdM07iwbPe5sfSFPXCSVShCAvoFUMd1iUGRBm8FN25tbwtXHAdmIX3n7Kt9w/fIIAU
 uA2CMD8VgNg7068LlgzlPH5bVwY5NVa9cJDliLUMcaqP/YZbYtyD++jcLxflUcV7XIwe
 M9fA==
X-Gm-Message-State: AOJu0Yw0yTy52N00BucUXQ1PLvkHs2JdUwluzu1MCjqztG9jTVt3Us+J
 TPMPH0hEh0fvldp+Nk3W3S5u8p4YHfeQy+3lPOfHHaUJinUgSnONRWG6QEN0E+GidHrudPmoB6t
 Wo8svpQ==
X-Google-Smtp-Source: AGHT+IFfOBslwkgwL+4yQuRBLExOXV8a8c828bT7DjbcDxRzT+V2oESEOon5TOz6PKBcbt216VV/dg==
X-Received: by 2002:a05:6512:4007:b0:530:d088:233f with SMTP id
 2adb3069b0e04-539ab9eadeamr2111073e87.40.1728059482649; 
 Fri, 04 Oct 2024 09:31:22 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff23456sm408e87.228.2024.10.04.09.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/25] target/hexagon: Replace ldtul_p() -> ldl_p()
Date: Fri,  4 Oct 2024 13:30:18 -0300
Message-ID: <20241004163042.85922-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

The Hexagon target is only built for 64-bit.
Using ldtul_p() is pointless, replace by ldl_p().

Mechanical change doing:

  $ sed -i -e 's/ldtul_p/ldl_p/' \
      $(git grep -wl ldtul_p target/hexagon/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/gdbstub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 94e1db8ef8d..557b3029785 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -52,7 +52,7 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
-        uint32_t p3_0 = ldtul_p(mem_buf);
+        uint32_t p3_0 = ldl_p(mem_buf);
         for (int i = 0; i < NUM_PREGS; i++) {
             env->pred[i] = extract32(p3_0, i * 8, 8);
         }
@@ -60,14 +60,14 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
-        env->gpr[n] = ldtul_p(mem_buf);
+        env->gpr[n] = ldl_p(mem_buf);
         return sizeof(target_ulong);
     }
 
     n -= TOTAL_PER_THREAD_REGS;
 
     if (n < NUM_PREGS) {
-        env->pred[n] = ldtul_p(mem_buf) & 0xff;
+        env->pred[n] = ldl_p(mem_buf) & 0xff;
         return sizeof(uint8_t);
     }
 
@@ -117,7 +117,7 @@ static int gdb_put_vreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
-        env->VRegs[n].uw[i] = ldtul_p(mem_buf);
+        env->VRegs[n].uw[i] = ldl_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES;
@@ -127,7 +127,7 @@ static int gdb_put_qreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
-        env->QRegs[n].uw[i] = ldtul_p(mem_buf);
+        env->QRegs[n].uw[i] = ldl_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES / 8;
-- 
2.45.2


