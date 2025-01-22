Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F05C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4Z-0001JO-HO; Wed, 22 Jan 2025 04:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4S-0001DO-9d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:49 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4L-0003Cn-R7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:30:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso68496625e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538240; x=1738143040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Exwv2SUshKwTjHy8msyqoapLFQlZN2ZYaumIRAoksx4=;
 b=B1uWhsUUirJqiJilOepJQOlg7boSiweOkSghn3oQgmW9JtU97oDI1cItnVqnQETQDk
 I3A76BEv19VAc/qvdzpu3ktDh2psEaXAdfsDB5LgTblxJgQSHmfe2vNs2tOu60v7mV0R
 gUbs2VppR2m+l7S7XvapLgWCbFlEQRFy5ZV9v5Qd3JxsQzUP8AWcZ4669YUs1YK3VRnO
 9yQ98+471ewyNTmFqHf447h+7AkuP63rirubYaHuHMZVbKfeszDCQrNivCbBWx+EukX4
 VsFqxi4olRm/zdNQYoIIJeo78NEFVlcg6vhhvMF3aKKCKNAKA+iW1mDcSjqFf08/D7PL
 z50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538240; x=1738143040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Exwv2SUshKwTjHy8msyqoapLFQlZN2ZYaumIRAoksx4=;
 b=Cn27QaeE2TyF4kPPEWDZ0oT+N/zLI15cOnzH1OD+PNnyRvFS2DDEYDFUTzK4zF3Udd
 j/lhKPTMVsQNnflPypfMu0yMWS4ysLinLLUojNJdM8eQgp55+IyaP5sAlCz91f2RY8UM
 vtym9qP4pZNdYvEWh+SO2O8qYi4yblaV6vV18lnrguXUBfYhur6qheiClGwmynXt49mv
 3gEebzz6AEnCgOsffdEmIeEUZUO9uVXKOptPEbA699bxcK7yWbe3OixHvCykNpIoctp+
 uSE/ta7j8461YjBwfpd3PaKyngTwTSLp7/zAcTtTZ4qrIEJaJtcugvjme6vWH7DMx0OL
 ilRg==
X-Gm-Message-State: AOJu0Yx5+Bs5wPVKRLrrqbUpdhXdA38FUBoAko0mZoT+hkkcaxVpVgJC
 3WBZhbdKPdFaH8cTvItt6IAIHV8XZ7lP5JrJOw2MUzYwMp+RkmjHHAw4W1GSu2WavaNNAs7saYf
 ocZI=
X-Gm-Gg: ASbGnct2+b34Ok4VYqbiRkHWYACL1YzoNYh/n5k7bLDVgupW2fCCj6TqFozgcsX2di+
 x7/Y9nwtwO4SdtdBvbw+2OUXPftYFywE2Ta87lFcl6xlKYE8LHVPwI0X/87n7HVrM5wmplUBz1c
 8jLZ3grN2AYyjJiXJ75mOD8x8QMJJUGQKjRmqBtXcS6B+LcO+9qCCl4EtYiRIX5B0l2+xuEAzwN
 2IZklNHfPHBDWEjlB1HG4/srWgqZLRGQdqfYEsbD2psI5kFDy1YN5FOQYqAI4wUxfQ7GedQkhYs
 nxO1q9xiCrSd7lyc07jz7k3jO4mVzsUqpQebzx58kCYj
X-Google-Smtp-Source: AGHT+IEZYV0UXoFjfU+tl1VOkpos+WFwna6iC8gUcKm8PVyAYHRasOGF7v+cm7JbdRsSBECp5+5ksg==
X-Received: by 2002:a05:600c:ccc:b0:436:1bbe:f686 with SMTP id
 5b1f17b1804b1-4389141c073mr153240065e9.21.1737538239766; 
 Wed, 22 Jan 2025 01:30:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31afb70sm17224715e9.19.2025.01.22.01.30.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/10] gdbstub: Clarify no more than @gdb_num_core_regs can
 be accessed
Date: Wed, 22 Jan 2025 10:30:20 +0100
Message-ID: <20250122093028.52416-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
the microblaze and tricore implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


