Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C6D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jkt-0001oI-9r; Tue, 15 Oct 2024 11:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jk3-0000gl-Ve
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jk1-0000mE-5f
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-207115e3056so45657745ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007143; x=1729611943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Tb1VVkfaxmHhJ+SeH6xxxqxEejCKf+mIQBUt9d+dxc=;
 b=oZRiD7ZOco4hqegh9q57m3e+tEHsWEEHcrv+ZYw7vveCPX84D0s2ifC8QD/yoBMtzE
 EfJtDQTSwLUs1OA3P1GNUKBhBBqeT8mK8VS1UPuUZw5Mi/bWwmU0DjNF6NpQwJWKsTQV
 F2kj2xlcJF31BOmsATI0GoH6ggJOo5kol0/6B/Q5USt5VAIq8061T/Dt+72P0K2w5lj3
 0At/EupgzMQL5fsr9cuvG6vDdMTnAV0ucvDSQ0Y0tyIeAeZ0uOWp42Rv+kpELy93AxxV
 GA3Iu8JCXu3iQajX/3+BXx7tkU7ilpkHi2R+bF2tMULJmE5919MUEwOnloYPFQElzJnX
 Ax9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007143; x=1729611943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Tb1VVkfaxmHhJ+SeH6xxxqxEejCKf+mIQBUt9d+dxc=;
 b=G2j6WRg5FBPexElJ2zmCU9zJ9KlSMrSIlyqwMj8ca9LztcXZB/tRorz25MykPT7sZ1
 fiI1hS2x4GKcHZJ35z1GbUmwf3sLuiB22ZzuNhFH5ZeyD88DJdcohduLBRcUYEmaDvsc
 qtYESL2Lxx59C736eor4owRXIH189IYCZAf2qPjB1N/TJHfW8sukSHlbfmAhDlTZUVYf
 X1m3wXCyUScJN/9CpWdf/RHSJj+bBZczsm5VDfmdFqK5FjM+IRbVfYOIteJDzR/TZK1z
 oFlO3GCKW/g+rHhiYh88U4IeVBQSZ5s3pSPSdZbtbsvOtwZ8PN+uJ5Vr7YKM49Yc526C
 1gcQ==
X-Gm-Message-State: AOJu0Yzpo6HqTrpH5wwxQfgLlJQeFwElhUidiSwrflLBI71mcQnj+0PD
 4Zdcuscx5xi2DI7EGiBuMxFNt2xWgMINNjBmsQcmefybQhBqIQ9CcgO+fris+JS+wQJCr96FXho
 R
X-Google-Smtp-Source: AGHT+IGoJGc7Q5yk3RZ6evJdmqlw5meICqDdRbnm10rTD7MVvrMLmxZfe7wHvJ5bK9vpf7E03pKpjw==
X-Received: by 2002:a17:90a:3ea7:b0:2e2:d197:40f3 with SMTP id
 98e67ed59e1d1-2e3ab8e7b46mr685667a91.35.1729007143046; 
 Tue, 15 Oct 2024 08:45:43 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392ed3704sm1985536a91.20.2024.10.15.08.45.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/33] target/hexagon: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:17 -0300
Message-ID: <20241015154443.71763-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Hexagon architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hexagon/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-8-philmd@linaro.org>
---
 target/hexagon/gdbstub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 557b3029785..12d6b3bbcbb 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -52,7 +52,7 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
-        uint32_t p3_0 = ldl_p(mem_buf);
+        uint32_t p3_0 = ldl_le_p(mem_buf);
         for (int i = 0; i < NUM_PREGS; i++) {
             env->pred[i] = extract32(p3_0, i * 8, 8);
         }
@@ -60,14 +60,14 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
-        env->gpr[n] = ldl_p(mem_buf);
+        env->gpr[n] = ldl_le_p(mem_buf);
         return sizeof(target_ulong);
     }
 
     n -= TOTAL_PER_THREAD_REGS;
 
     if (n < NUM_PREGS) {
-        env->pred[n] = ldl_p(mem_buf) & 0xff;
+        env->pred[n] = ldl_le_p(mem_buf) & 0xff;
         return sizeof(uint8_t);
     }
 
@@ -117,7 +117,7 @@ static int gdb_put_vreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
-        env->VRegs[n].uw[i] = ldl_p(mem_buf);
+        env->VRegs[n].uw[i] = ldl_le_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES;
@@ -127,7 +127,7 @@ static int gdb_put_qreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
-        env->QRegs[n].uw[i] = ldl_p(mem_buf);
+        env->QRegs[n].uw[i] = ldl_le_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES / 8;
-- 
2.45.2


