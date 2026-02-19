Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4093AE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9dr-000169-PU; Thu, 19 Feb 2026 14:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cL-0004GR-Qp
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cH-0008QE-Jx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:16 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so1645968f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528991; x=1772133791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pn9fqagd0imGfD7QUYCUzVToVzciz45s+Cv6BV4kKPU=;
 b=aYLGkrvwDP7tgRau7CXPBusKK/uNAUAXiyBzcclpfc3jEd1Eo1hbLdHnhzwD0udoVb
 4nfrwzv2CFHo/bfkzHdjIV71Md3CkgYukim9TTUrSnvADESIr4D4t6k+DJFZOCL1XtXz
 QyulMfJxr2fiUGQDk6Pd2CxW6671wwCUsAiPKSIgO+N4PS6PVoAPB1EO9kEGe85O5K3t
 ssCXBhrcBO9TLBA+OiNwsX6JDyQGAj5vqKJVv0HV/lDD97mRxlB6/dfwQLgN0KbUIzMx
 NQ0BDMey3vf4DdDfatg6zRGSGi77LnQD416GjR9J+T/Wqc8zVaZmYs3KAwQOAXfkhRSi
 EPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528991; x=1772133791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pn9fqagd0imGfD7QUYCUzVToVzciz45s+Cv6BV4kKPU=;
 b=E/43I+UKqvtmqXG1Jo0ryHDmEcC8ReCEZEcfiiXUEqmuJyA7B+1Da9gVYWGByefA3j
 H2eXfBl9rfp6uGtSh+hZc532VzKIqE0k4NuIjnhFaMQTgm+A/f337c+AClA6pROig5NT
 5q1Uifu2bXkrtVa2tSlUTq4DvQn9QXvfl1SvrhxASHcJ5LD+2SrQ0YFrs/y4vqYZYo11
 HEgNylshtQ8JtzsSATLCOmP7vjTge9eiV2q9Tph6XFnnNzpvjCUh26sUThDOSuE+mXkp
 FIGTz5D4zWpmXb67zZHHLf9TaFPQRvTbm7/uw6WNOZ3aPe69hCQ6l9sI2qlMyOCzfOCn
 PR9g==
X-Gm-Message-State: AOJu0YwTmVcjg62g3nVcrFVNf44xOemfxKXB/duwHeFXuvAYCgAHQzb7
 ShnZcNoIVX+SYmAi+961MqbYwq6a4i7g5gLtaxBMeIDbtnzG5zvydBK6x8j+C26lViR3PoB1qEV
 07PhatiUqWA==
X-Gm-Gg: AZuq6aKmD6pDmcWJ/rPip+Skz5pPzD8aEH2/vXyOK/JyANZf13UrgVNWjhKRukIfPbr
 +D/w7fZ0TJa2LVvdNKFRRTbZNILrqi6uJBRZL6DjHvn0Miwf3doEpBTJrhkz72YA8RVTm3Q5VvE
 1/xKiOj7q+jXsMP+im8tBxgcfyOi7iiPVZBx871bRtff7jQpCcramd+tW+T5w2oMD31GQ+yK4xK
 mlQX/HL5eklC9qdRBfDTJ9eruxwlpccvEKXb7/CyGgxF99KFayiG7Ee+B73ma2S8fyOx8j6UBVb
 isIXKpTpVTipGFTcRarlzT+MoZRCxHvblJIHj+y+no0IXsV6/Z6jZe9sPgAnkK10PJgpgYctRM7
 m02oYO1PlmJVMfRD8RDbMM/GhDLmvbUb842krRInPwCywg+IYSH/i4yk0R9M2baU1UxjsuTseia
 JV+XViAO7MTiHsM+pJPCbvPbfR0pnxW1RZb84mb9ZRr1gjWSG20oV2s0c3AKj6pvxUw2OPriIi
X-Received: by 2002:a05:6000:290c:b0:437:71b2:6f1a with SMTP id
 ffacd0b85a97d-43962540637mr5777238f8f.0.1771528991165; 
 Thu, 19 Feb 2026 11:23:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5b4cdsm54476293f8f.8.2026.02.19.11.23.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 27/50] target/riscv: Replace ldtul_p() -> ldn_p()
Date: Thu, 19 Feb 2026 20:19:29 +0100
Message-ID: <20260219191955.83815-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


