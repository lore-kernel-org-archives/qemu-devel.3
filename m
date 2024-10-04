Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB5ACF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGt-0007SL-8W; Fri, 04 Oct 2024 12:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGH-0006La-2q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:37 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGD-00068c-L1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:36 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so2779778e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059671; x=1728664471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOkCKWbC4XaUTj+zlW7/8n4oz5mVQsEd+mLoNBOmOog=;
 b=J6M9ww9Sx0QfpjWC9+bTOJMJPHFCi3bNw3zSUdIE2/UvH6pm5kYomiUBu/Db2LHeik
 N18JPj+5RgZoDfsuRoU+BLHGn6A0vOPmUpfHCRynRP+sMC0mHUn9Yq3CYVQhTZyrWDGf
 jOHUVM0efRzOygf2lk2OJCVxDSzkii0F/KfUu3MnxLnTrYpPa7wafLLA/u8JV9GAkuMJ
 Dwrj++aLcP8Fp5I8n12ziiAXP7Z6DMXH1nixNTvI0w0s+rF/bjH+z9DdOjzs2UHHEks4
 NL8/TtlMIWrZUtYOYO1oenWy8mNyDf63NTEYYzGV23/H6FsojoNBUSKP6RaEzZqBlnyC
 9f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059671; x=1728664471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOkCKWbC4XaUTj+zlW7/8n4oz5mVQsEd+mLoNBOmOog=;
 b=c6CNDdfY31yPWLqwgueZVZkwqp2GYWiqeSHAJlJMmS9dM2Cyxu0s5fZiAdbSwuzitE
 kJtKNOEGzcUdQxToJpCkDEbsb7nzx2oo/nkrBNCWENnyOABMT68X6gUEDVmaKYRt2+Am
 oEN6k4TQ5/9DSenM9M1jHVfOUfGC6z3WSlFRdS5uHCgQDXiR5hBNPiyv2JTJMr8VwYke
 xX+eVYJBSIpYATO9NziHKs4lD3QYw+Y7XjYLRCnQ2IxY5prX4OkCH+JxB4eZY3/vmWuA
 HSGEfxDAgbsAQZ0ONUVodjdgRdJ5Bt2HcKsajBPNAuWQYIPIbUtcWjkhgmLV2RJ3LSLx
 tLlg==
X-Gm-Message-State: AOJu0Ywk45vt7ZG2ix92kV7Vh4q2/oJK0B56lgAXliybbqTcmmkAWYOw
 MiDzWWoRpk87MV/vRGbwXtTEE2cgetYMSSL16oRq4aDLCDm85A4iIjzUj1VMt2ngCd0CWOw5WHd
 TPkpXtw==
X-Google-Smtp-Source: AGHT+IFypIXsz1g/PCzFyL9iJ3D4FqeWw3/EK9y7qPIrO561yhedYQKflkwOGJ1omPJhZt9CtBuwfQ==
X-Received: by 2002:a05:6512:1382:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-539ab86253bmr2275489e87.5.1728059671349; 
 Fri, 04 Oct 2024 09:34:31 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff1d322sm1096e87.144.2024.10.04.09.34.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/25] target/rx: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:31 -0300
Message-ID: <20241004163042.85922-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

The RX architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/rx/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c     |  2 +-
 target/rx/gdbstub.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 36d2a6f1890..458b8ee072d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -86,7 +86,7 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     resetvec = rom_ptr(0xfffffffc, 4);
     if (resetvec) {
         /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
+        env->pc = ldl_le_p(resetvec);
     }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index f222bf003be..30074c9da7b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -56,7 +56,7 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     uint32_t psw;
     switch (n) {
     case 0 ... 15:
-        env->regs[n] = ldl_p(mem_buf);
+        env->regs[n] = ldl_le_p(mem_buf);
         if (n == 0) {
             if (env->psw_u) {
                 env->usp = env->regs[0];
@@ -66,38 +66,38 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     case 16:
-        env->usp = ldl_p(mem_buf);
+        env->usp = ldl_le_p(mem_buf);
         if (env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 17:
-        env->isp = ldl_p(mem_buf);
+        env->isp = ldl_le_p(mem_buf);
         if (!env->psw_u) {
-            env->regs[0] = ldl_p(mem_buf);
+            env->regs[0] = ldl_le_p(mem_buf);
         }
         break;
     case 18:
-        psw = ldl_p(mem_buf);
+        psw = ldl_le_p(mem_buf);
         rx_cpu_unpack_psw(env, psw, 1);
         break;
     case 19:
-        env->pc = ldl_p(mem_buf);
+        env->pc = ldl_le_p(mem_buf);
         break;
     case 20:
-        env->intb = ldl_p(mem_buf);
+        env->intb = ldl_le_p(mem_buf);
         break;
     case 21:
-        env->bpsw = ldl_p(mem_buf);
+        env->bpsw = ldl_le_p(mem_buf);
         break;
     case 22:
-        env->bpc = ldl_p(mem_buf);
+        env->bpc = ldl_le_p(mem_buf);
         break;
     case 23:
-        env->fintv = ldl_p(mem_buf);
+        env->fintv = ldl_le_p(mem_buf);
         break;
     case 24:
-        env->fpsw = ldl_p(mem_buf);
+        env->fpsw = ldl_le_p(mem_buf);
         break;
     case 25:
         return 8;
-- 
2.45.2


