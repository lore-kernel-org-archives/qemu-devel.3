Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A0FFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9K-0004bf-Tm; Wed, 25 Feb 2026 18:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO91-00049l-M9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO90-0003Ay-2i
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso2335045e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061492; x=1772666292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=58SjvSBdSY2N/SByegBRN693qynS9JIU0XpdNhP0eoo=;
 b=jO6waNomeUIib6erL1hNPytYeqyY0+JgL9mxdRhCfsk+DNBJBH/cySSjOaODqDHjaO
 iRAFyl/aXC56fZMtbL7FQiRSn8nF8KZnYcCrNJRiI9eg/LeIwe6vOTKuV3aaxT4QtcAX
 zLiQo5CwWJJd49iooGAu4ItnqWzW8NDsuFqkU6Tbux9FyGcyU2ZQK5MUunVrd7fUjTEl
 w2MeGhEZRyK8yE0DyIIp67Iu0hDk2UiIfwDMmfVVv1XD9j4gyO4yKYjbbHGmFmJDBieb
 ehfgPHU/xaHB2U48vIN0nbDqjCWQYretQO4d4QhLkZ4vX7cy80imOMB/cgHywvY9pqRE
 +K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061492; x=1772666292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=58SjvSBdSY2N/SByegBRN693qynS9JIU0XpdNhP0eoo=;
 b=t2vI/2dA7cyYPX6Sw5SfvnxTaHQ5fqst8/MCN3NXVKb46avQ+O2AXCOrIJVAVbKKKQ
 u95FYTHSXuOgYTAuEOT9KW4oko8t+uqNeJ9g84QQI5P/hsGh+ZAVGPlITZ068K3usDl4
 k8ymVA4BuZtA+AgVABlEENOOHpmuyKRFSk+xz3T4GVlXeo+RupoS68nKTqSdQrYVWG8j
 olYP1WBUHrPA+KYuGWgoDLNKvmCBFxHYmJZ2q0mWrbJq4AZEUAwrUibcyihEPL50/HCP
 duIVSM/iiFmC8hO8oZev+TTnyveHcqqWP0E6RghdcWHvSB7SIhZcI2dW9Wm16hMK1yfj
 wHfA==
X-Gm-Message-State: AOJu0YyTTszSiNypZGzRLLDNCITjTsD58WrsZZfvtUzFihiknNywwfb1
 cEEhlCIm/QkldSHeLW8uSzhEfoMn/Hkp/qOZXoAek1cMoCeZ8RIfENhKx8yV36hcsLNGbOZ+gU1
 Chvgof3E=
X-Gm-Gg: ATEYQzynnj3GegJAyQX+kZKId+l2kmrkMSFc1Il6MAtwf1hZdazGW2rvdqIF4SN55s9
 yhaSHavdBt4sGVREgdcD6eI50ZSwuMVCJXn4PzRs5zFC/0gMAuIYNzFmDDk57w6qI3Xlc/UFCRf
 9aigQKzWS8yYFBn0FYawFVf35+TZ1k6VLoByve6bzJPsEAMEUP+hG2i09pQmsk2QtrLgbgxQbge
 HhA7+gATR3njc6EowkxH+70s5YcHhDYf2tmsTy5WoniOAABLS2aF7la6Sl+zdRwsi5b9hVlzvO0
 qQPK0Bw2KuxpxLcAJcDO3XD/qbI/YtciGRNI1k5LDdQf993VhmmEfZHsqbUS6fkpcbjeD82KP+r
 KAqU0YbTXGNiCYuI1OxykFIItjTXOyb5KGDONTC8cjzVjXg5Jpkf9412GX2PRDqIRUOye3HwXjX
 gRIw6n8tTl4OE9W1SrU0vv8AEnRQ6ai92pMdU9UocTX3KQMval3hjv4J9V0RgKIPjLBabZco9f
X-Received: by 2002:a05:600c:5397:b0:483:56c4:73ac with SMTP id
 5b1f17b1804b1-483c216bf67mr35719615e9.7.1772061491982; 
 Wed, 25 Feb 2026 15:18:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7507adsm109214175e9.9.2026.02.25.15.18.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/70] target/riscv: Replace ldtul_p() -> ldn_p()
Date: Thu, 26 Feb 2026 00:13:35 +0100
Message-ID: <20260225231411.96482-36-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prefer ldn_p(riscv_cpu_is_32bit) over target-specific ldtul_p().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260219191955.83815-28-philmd@linaro.org>
---
 target/riscv/gdbstub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1934f919c01..f89b20ea84a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -191,14 +191,15 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 
     if (n < CSR_TABLE_SIZE) {
-        target_ulong val = ldtul_p(mem_buf);
+        target_ulong val = ldn_p(mem_buf, regsz);
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
         if (result == RISCV_EXCP_NONE) {
-            return sizeof(target_ulong);
+            return regsz;
         }
     }
     return 0;
@@ -225,11 +226,12 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
 static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
 {
     if (n == 0) {
-#ifndef CONFIG_USER_ONLY
         RISCVCPU *cpu = RISCV_CPU(cs);
+        const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
+#ifndef CONFIG_USER_ONLY
         CPURISCVState *env = &cpu->env;
 
-        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
+        target_ulong new_priv = ldn_p(mem_buf, regsz) & 0x3;
         bool new_virt = 0;
 
         if (new_priv == PRV_RESERVED) {
@@ -237,7 +239,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         }
 
         if (new_priv != PRV_M) {
-            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
+            new_virt = (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
         }
 
         if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
@@ -246,7 +248,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
 
         riscv_cpu_set_mode(env, new_priv, new_virt);
 #endif
-        return sizeof(target_ulong);
+        return regsz;
     }
     return 0;
 }
-- 
2.52.0


