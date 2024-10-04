Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E41CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlEj-0006hc-9p; Fri, 04 Oct 2024 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlEQ-0006GF-5n
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:44 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlEN-0005mV-FM
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:41 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fac3f1287bso27652161fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059557; x=1728664357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZpimvVQnGecchp1DSJAwynwQ1iesRuTNy8I2ClNlvc=;
 b=Wr03iigyfvI5hDMkTCBshimDW281wdofMt9QlGJ0rkY0WHGDSwZAXhcv/ZO66XSCW4
 NrFq7vGOVDLQ1y+BjyF84sM7SN6p4tY00kEFAhmLcZ9rF0nMS4V3yE9qwiMS8Snc+aQG
 3liULDInWpE5EzlI0oW9vu+lrZ/OyqLNl2ci/wafSl9dAVggVOCg0SBqw3heigfTzUXI
 PP+td8nZj9MdVQMh5sMgZaEUAJqk8QZLQfxxdoC9XVfiReRVLqhkZg16YBed6h4QYVPz
 QzupXQBwyrZRLu7y/7Vm8iZ0ETHMQusZEQGPRh4lXdqaMCSfil1icpZ6rBsZxE8Xnw1a
 8K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059557; x=1728664357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZpimvVQnGecchp1DSJAwynwQ1iesRuTNy8I2ClNlvc=;
 b=jplUEOR+JP69kcdfXEGFP0moSOL3L5pGx4tFABYc6wdjH6tXLSFynWCPlYhRTx3cTU
 OBJ7kK5wVq6liNMs7TzeJUOHmV+QCKPodlQq+8m6WcCKwt480x7M5WifKuOq8mLRH3mb
 6oJJMWPkWo28Nry8Byt9FsT/AoOQvycM+lIXncs1xpse5eQXHryw/eisxpxrMq+huHrp
 jXAMIycY7werQ0H55is3fQInl441R/fZSxL0deQWl+L4mbBkIZI0mgkdQKpqJCh/nW15
 wpKWU3BZB8bRWIjkqAmsYDI7GtqJON6sz5aJMrOHDHQNlUq2qx2K/W7UdPhHkNnTAOiH
 39cA==
X-Gm-Message-State: AOJu0Yw4nSEc85EVCn+kTHgXNO6ETzi+iQAJmwKLCgKZX6xnFQccCO0l
 XXrhH4o/e/m5kfSrrASM6ZLEn29pK/+sK99Ivx+H0FnEocxw/N2uopokHamDHPTxDFq6juSb0Op
 FljQP7A==
X-Google-Smtp-Source: AGHT+IESnbCx3EdGKG1FtJeY8vVI0UmMpyzLTgCEarsQnpb3j/g31sMRPD1Fmkc1iDWQo0CJPCsgag==
X-Received: by 2002:a2e:a58a:0:b0:2f7:64b9:ff90 with SMTP id
 38308e7fff4ca-2faf3c017d0mr17237501fa.9.1728059557389; 
 Fri, 04 Oct 2024 09:32:37 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b3ac99sm189601fa.130.2024.10.04.09.32.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:32:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/25] target/hexagon: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:23 -0300
Message-ID: <20241004163042.85922-8-philmd@linaro.org>
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


