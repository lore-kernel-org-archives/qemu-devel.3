Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390A8C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDRx-0007E4-QV; Thu, 06 Mar 2025 10:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRw-0007Cz-48
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRt-0006D0-Vk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso663145f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276068; x=1741880868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ps7cd0cxm4BakNCXqH/ls7rCDQIclvSwSBPha/6qx+g=;
 b=MJR5X6KWHHqFSltW1MnEN6Xd7wOJb1xtwEv3yrZkY+4iSU3atvK1O7uY5wrplQ2bl3
 gAjKHQlp06ZQhcek02Asn4Bjspi8Ac5CsOZqGQEuCxo10+kIq5Dzz/2QVS/9JP9CsbRp
 jRAH42BxkeT3LDKwvM/vicSYjgYCoVzSYHKJmLOqxl6hlfhGg/6oCGvbp34+csRrKTSq
 WBZ3S6B6nAyCE/hgMJdDSgO+LJOevbw6tiuT+1sI1vgmaVTyMfoXnKasqV4vY38cRI5G
 60oB6cnKMMOCs7bwBe1EZ5qMh9vVTw82kH7NDUBMtKRp32UsbLhSW7tXZ8Yh3ve6kVhQ
 Ls3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276068; x=1741880868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ps7cd0cxm4BakNCXqH/ls7rCDQIclvSwSBPha/6qx+g=;
 b=FKITAkjV3TXw7oNAjMZvyB/SPntdgiAtUjucalCIVCjHof44djfAsMGesN1+04PVih
 hH3lrsFw8KyqUqVZJaGobafK2xo8pn8NEfcHvSyGhsSAXqxftgnEtxF8ndJIup2FbdpK
 1PPnJU1LsfBsD67P9znZXGtcem/wyYJOJs68j0bPTITAbf1BIWbj0z9uXpmAEraiwDF1
 zCX115jyD5lcPvbtJ6I/cbbJSiJ1vF+MDsfKY3+ggluGY305ZG4iWwoiBWkktq4hrRdP
 ayWM798s3K1ELqYOCnQWinrizPaFdkww5l+zl3DFDencpaUw2XL9uloxdV0DMXxU0WT+
 tpDA==
X-Gm-Message-State: AOJu0Yza0ulm8arnjGxP1x545coJ9Rj8C/hvF7Jnwil35VnyeokFhd0m
 jaG6kFoV4RWYI9n/PsCYgYYRvxfHxZm2/KhiDUDhabUWyXwvxzQ2XPbl88Hj3DNLJFcvyVy1/p8
 HtCE=
X-Gm-Gg: ASbGncvZ+rg7B80tPrJpmOO80D4TK4LHSiyeDDC9mWSXthTiSki08lodn1tBVmqS+KE
 wG/TzckAkfLmsAKxnjw3wVE6dfVqfRvnCK+JPE3bB2RNeJ4ixc4+TA/5MP2JQQjr+Wzoy2j3sJ5
 c90EDLHtjCja7TNnG8Si3j5hq/kI/mMJr5NJhnHrUYVNyPxJ9jph3DpPRm96oxTaVNYeaXnyJMG
 sprOFzxPwkgNuGc1CWr7BIMXjWDGgxdGfNBkFoxJoJEQ9W78Xh9bTna9xVoRcPBH+ECEsjhi3Ga
 oPoOTNDNYOGwTAQmkOs6NQZZpXQ8xWgz5ZvXldSWmT6531C6yL+beXTOXS41OMo6B0yDbMNDFdo
 AbCKiNpgZ6TYWJ7rq6fU=
X-Google-Smtp-Source: AGHT+IEbtpagiNqwY2dxBTpQiSYGjQmA8ttIT1BJ9tpsIb64z7hkClevq/hj9tW/wURNNY69MesUxA==
X-Received: by 2002:a05:6000:4185:b0:390:e8ef:5e74 with SMTP id
 ffacd0b85a97d-3911f74139emr5094381f8f.15.1741276068066; 
 Thu, 06 Mar 2025 07:47:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c55e6sm53006655e9.23.2025.03.06.07.47.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:47:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/54] gdbstub: Clarify no more than @gdb_num_core_regs can be
 accessed
Date: Thu,  6 Mar 2025 16:46:44 +0100
Message-ID: <20250306154737.70886-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Both CPUClass::gdb_read_register() and CPUClass::gdb_write_register()
handlers are called from common gdbstub code, and won't be called with
register index over CPUClass::gdb_num_core_regs:

  int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
  {
      CPUClass *cc = CPU_GET_CLASS(cpu);

      if (reg < cc->gdb_num_core_regs) {
          return cc->gdb_read_register(cpu, buf, reg);
      }
      ...
  }

  static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
  {
      CPUClass *cc = CPU_GET_CLASS(cpu);

      if (reg < cc->gdb_num_core_regs) {
          return cc->gdb_write_register(cpu, mem_buf, reg);
      }
      ...
  }

Clarify that in CPUClass docstring, and remove unreachable code on
the microblaze and openrisc implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250122093028.52416-3-philmd@linaro.org>
---
 include/hw/core/cpu.h       | 2 ++
 target/microblaze/gdbstub.c | 5 -----
 target/openrisc/gdbstub.c   | 5 -----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc53..7b6b22c431b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -124,7 +124,9 @@ struct SysemuCPUOps;
  * @get_pc: Callback for getting the Program Counter register.
  *       As above, with the semantics of the target architecture.
  * @gdb_read_register: Callback for letting GDB read a register.
+ *                     No more than @gdb_num_core_regs registers can be read.
  * @gdb_write_register: Callback for letting GDB write a register.
+ *                     No more than @gdb_num_core_regs registers can be written.
  * @gdb_adjust_breakpoint: Callback for adjusting the address of a
  *       breakpoint.  Used by AVR to handle a gdb mis-feature with
  *       its Harvard architecture split code and data.
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 09d74e164d0..d493681d38d 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -110,14 +110,9 @@ int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUMBState *env = cpu_env(cs);
     uint32_t tmp;
 
-    if (n > cc->gdb_num_core_regs) {
-        return 0;
-    }
-
     tmp = ldl_p(mem_buf);
 
     switch (n) {
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index c2a77d5d4d5..45bba80d878 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -47,14 +47,9 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
-    if (n > cc->gdb_num_core_regs) {
-        return 0;
-    }
-
     tmp = ldl_p(mem_buf);
 
     if (n < 32) {
-- 
2.47.1


