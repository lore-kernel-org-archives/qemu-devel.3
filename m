Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FEDCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S7-000449-Bd; Wed, 29 Oct 2025 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S3-00041o-Q7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rv-0002t5-Hb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:06 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so8304066b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753054; x=1762357854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQljybzpHjU4IgUqxQisRNFwaJc4gUeecLRNQGky0zI=;
 b=KghnWP2ojrOPMXKYXFUiu7og/FmXkTJ66FFtINIwnr4McD3zvkfMEZiBulNsEeunTE
 biqk0HgLx+zxBmNMIvxXjHs9tvbrahxQzJIomfktoMI0htsnSNCNexY75TUOPJsxOlIC
 cwdeenQqO3P5AkRpgBGPFRwvUTB7Z6l59ku/QacD1mwoGBed0wStnPigvFuEVzbVgA7R
 NbX8+dEOP88eTjdQyUEE8HllkW3ZYPog5GjZpcemOHT65ViiuIkZTWwQE9962y/lm9Si
 Z8VjfsjH3RsX98C9+L11nuHktZ7a+bwxwX0aFPdqJC4v6RTWZgOOYn/WeYgiRXQIvFNY
 dPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753054; x=1762357854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQljybzpHjU4IgUqxQisRNFwaJc4gUeecLRNQGky0zI=;
 b=NKVjXoOgiCHF/C0wzRhYlI0pwefz/hdZFqiA8Jk994ZVYEv36UHhegoGv5coZ4UAC3
 bgA/QY8LpQLILYQiMfznv/+XPfX/Ws1vpbU0+L+Wgd2fEMCcBBVflbOabTZYbYAUqcrn
 j6SPExZz3Ejh7B12d8MVBFCCjZ3bNKKX2vZgjNTgx594ZLdI/x+VgzOmSC2lMo0BC6UX
 fE5h6fwxOF+JWgeU/gTzoyz6LkijYcfcNm08RlEdPpajzMT3COfX8j6lV4/xO4r2ve1X
 G22je0QvS/RWFsNfLhlQSQKMhNyo16K9+7o982wv6DqODvbis7t+J+gV+sVl83ZOdgjd
 lkRw==
X-Gm-Message-State: AOJu0Yz+HTJgIuLWXiucC8aLBZWRo7OnP0JvCgB/vreu/9GmDkc7lwOg
 wRdeDfpynZZs+JOx+TKClPQzV0q3mOBzS7TvBBHKND87E9KwJwpnA8e8z5zvCUIH6FU=
X-Gm-Gg: ASbGncvneZP4lhDM9MIiA2jImu9puSI9skSSaqsYbQgHiMKHvsq+WlkwJKHw2DkVL4G
 8Q8xXUHcJfbsyrZ5Z7nAWuKwohGEuWSgKgf4+dcqJa0UcA3qDtgTXo+m6KVdmgmwBBOSudYtAHN
 UVbMO4Hcu9k998ck6vDbHiEnOVd3kJjnNWDWKFkWjWdQ3oCxS6KM1ZRuEc87si2IsnnoqhB+HtC
 SBFC2PvZW2jri7sbAMzEfKPIv8a5AbVvrsUkXgxU5d5yVokan+Nvu5h1/EvVesAobjuer1xGvSE
 hugg4dR6r7OibvO3vkllmaemri+NhC8lmz50t6oYY5zfz0x9qMG8Ox6o7FvvAWc8aPznP3LM3Wj
 lJS8APx3DKOpxsVeeP/giE85a/97WjOpae+gGfvKvhjNx2YXrBpAKPy3FPQrk+34oPoR9NgKtKC
 ji
X-Google-Smtp-Source: AGHT+IHZByoB4QQ+8aZ+aYAyf2Abr63lwtoRmvm4xI8rJGNxRYIDrSxIS9uuHQ1FmUuhp772Mg3NOA==
X-Received: by 2002:a17:906:6a0e:b0:b45:1063:fb62 with SMTP id
 a640c23a62f3a-b703d342998mr334718466b.24.1761753054607; 
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853077c7sm1475100366b.7.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A32560F68;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 28/35] target/xtensa: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:37 +0000
Message-ID: <20251029155045.257802-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for xtensa targets.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-29-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index b611c9bf97c..fdc522698dc 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/atomic.h"
+#include "qemu/plugin.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
@@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
+        uint64_t last_pc = env->pc;
+
         qemu_log_mask(CPU_LOG_INT,
                       "%s(EXC_IRQ) level = %d, cintlevel = %d, "
                       "pc = %08x, a0 = %08x, ps = %08x, "
@@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[INTSET], env->sregs[INTENABLE],
                       env->sregs[CCOUNT]);
         handle_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     }
 
     switch (cs->exception_index) {
@@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
             uint32_t vector;
+            uint64_t last_pc = env->pc;
 
             vector = env->config->exception_vector[cs->exception_index];
             env->pc = relocated_vector(env, vector);
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
         } else {
             qemu_log_mask(CPU_LOG_INT,
                           "%s(pc = %08x) bad exception_index: %d\n",
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 552815ebfdb..28dfb29cbd3 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -35,6 +35,7 @@
 #include "system/memory.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/plugin.h"
 
 enum {
     TARGET_SYS_exit = 1,
@@ -197,6 +198,7 @@ void HELPER(simcall)(CPUXtensaState *env)
     CPUState *cs = env_cpu(env);
     AddressSpace *as = cs->as;
     uint32_t *regs = env->regs;
+    uint64_t last_pc = env->pc;
 
     switch (regs[2]) {
     case TARGET_SYS_exit:
@@ -433,4 +435,5 @@ void HELPER(simcall)(CPUXtensaState *env)
         regs[3] = TARGET_ENOSYS;
         break;
     }
+    qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
 }
-- 
2.47.3


