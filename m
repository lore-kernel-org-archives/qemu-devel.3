Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0ACF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIS-00026r-5L; Fri, 04 Oct 2024 12:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGe-0006r4-C5
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:02 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlGa-0006Bu-52
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:57 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fac9eaeafcso27611671fa.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059694; x=1728664494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7K2UdhT0lmKAUQ5+UAlf+1d8SHSmOIhciQuHFY8P5Y=;
 b=QPqeOSfcwv1jDxwn/udV857brkXxg6kQbLWXWgDAtLnIoiVcy7g0YCDluulBamH93o
 C5X0PGpEbyVdxNO46soHEzkRFjRk2PC6eTXou3qEb0gOM13YskzGmUHOZzxjCZ+/0Z4T
 2lTCGlMBUdVQbtm3nPABF7SesZ3FmDJ7wJisIpGo6U/27szjmzvHEeJZG5r6G+4XOHuM
 3S9eJ6EdwietkEX8TROANuz45nKrIrsq368mQZvdGWMu8o9NjE4gQRsnN4HYRSeDxFi7
 3sjJUuVk5QmxRa2BxFvsatDoVMz6OSElrStrHYDqREfRMnZvXCc1Ft6iWq/Xj57vxlid
 sYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059694; x=1728664494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7K2UdhT0lmKAUQ5+UAlf+1d8SHSmOIhciQuHFY8P5Y=;
 b=LdOI7nHaoRxi4DKnNd9u1qiZ3XozQiUvmf/A9FOKEd0A74Ji57Ry0nHmdl7dPFemOM
 6V6KpBcx9KV5EJvl2Jh6pwqOTVBWWju/3HTLPZWsxYEucYyY85WR0ct8oKntVB4k/NVo
 +DbHdziW4AWkGDjeiKAdG3TGYlhzia0ukUwtvL+ysmabXKh/HinGoPKMcdxX/Ka4j35L
 khs0pAXUwearoKlaSTviod6lDTvAw3EfXbnsR51qj2ogyNzmSjZzGADqcNTAcY4vbZHH
 KASbNsnpQE7jwbjubXfHFY+0VmmTAiYBlUx3efc1DBP0/tOo/bMLpi4UfSFEeMDB3RNe
 9TZg==
X-Gm-Message-State: AOJu0YzZLy3JEu4FSQtW7mVp0lsG7C/iG/HFWCMI49qgVrlZ3UJEcKT5
 yM07i8YHEzVIl6txLmEy9B9fpqdxEKVJU+OlVNUBsi8U+TI78zN7h2VG3DMYAlyopy0RMWfmGTu
 p/XHm3Q==
X-Google-Smtp-Source: AGHT+IHKa20agFRS0/RoXwo1gRuQeymjsJwVOH9rO7MgcDcdz82bu2Uw2J6Cuwgy3fCCBlYYn2+2rA==
X-Received: by 2002:a05:6512:12c4:b0:539:964c:16d9 with SMTP id
 2adb3069b0e04-539ab9e6f6bmr2435493e87.57.1728059694180; 
 Fri, 04 Oct 2024 09:34:54 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec8276sm2366e87.86.2024.10.04.09.34.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/25] target/riscv: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:32 -0300
Message-ID: <20241004163042.85922-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

The Risc-V architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/riscv/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/gdbstub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1e..2e042f117f3 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -84,15 +84,15 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (mcc->misa_mxl_max) {
     case MXL_RV32:
-        tmp = (int32_t)ldl_p(mem_buf);
+        tmp = (int32_t)ldl_le_p(mem_buf);
         length = 4;
         break;
     case MXL_RV64:
     case MXL_RV128:
         if (env->xl < MXL_RV64) {
-            tmp = (int32_t)ldq_p(mem_buf);
+            tmp = (int32_t)ldq_le_p(mem_buf);
         } else {
-            tmp = ldq_p(mem_buf);
+            tmp = ldq_le_p(mem_buf);
         }
         length = 8;
         break;
@@ -130,7 +130,7 @@ static int riscv_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < 32) {
-        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
+        env->fpr[n] = ldq_le_p(mem_buf); /* always 64-bit */
         return sizeof(uint64_t);
     }
     return 0;
@@ -162,7 +162,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
-            env->vreg[(n * vlenb + i) / 8] = ldq_p(mem_buf + i);
+            env->vreg[(n * vlenb + i) / 8] = ldq_le_p(mem_buf + i);
         }
         return vlenb;
     }
@@ -193,7 +193,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < CSR_TABLE_SIZE) {
-        target_ulong val = ldtul_p(mem_buf);
+        target_ulong val = ldtul_le_p(mem_buf);
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
@@ -226,7 +226,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        env->priv = ldtul_p(mem_buf) & 0x3;
+        env->priv = ldtul_le_p(mem_buf) & 0x3;
         if (env->priv == PRV_RESERVED) {
             env->priv = PRV_S;
         }
-- 
2.45.2


