Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD4C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4i-0001dP-IM; Wed, 22 Jan 2025 04:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4g-0001UN-6h
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4e-0003HO-4Y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43618283dedso68310165e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538258; x=1738143058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFH8+KHnxWyy8fn4eViNDfLZ8hXpurTe6Lr7eVv7UPs=;
 b=OuzfUUaelBM2OjtE+MhF6GVWQrabhjS7YpkaGAkJt0lXmqiylMY0FOWGQOOMbYcUxv
 sEV3sRiwsbcIKQJQRK1f0uEhYzc8MKAPM8RbXs5QCRb77+hJtKDPs6xytOws2Su4Djko
 Q9Fu6rLJkoLiXNY65w128pp5wl91aExyKn1grLQtyoOdqFWbOsF+uDkgVKqgNKs+EUxQ
 GUPHp1PoPqC1cLtf7XkfQURExCDSomgnjklEUN7luASNbWFQBcYQr3MiuVxByZa6VrH2
 2X1fpFmaj0RiKTtDrAQtdZlXG9MPsr9jY2Kdf7PQu+rhKEpUGx6WBFJO2lc89EasZVe+
 OLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538258; x=1738143058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFH8+KHnxWyy8fn4eViNDfLZ8hXpurTe6Lr7eVv7UPs=;
 b=j9NiUD4M16so/jSWNVvWJ4qrQEoYfnj3ibousRSg99p0dYpQklASN0pSNT6E4s88Gw
 xwf3nX6EqfMXiuztelcyoNcBglp9ifRX9H8ea6Y76Q/NNGHLaV2O0N0SjL7VPXq+7M6N
 ze2yzi13MCoFTQ2+fnnKitP3a8zNZxu33shTC24B+/6KPKI2g+kZ2jVAAECB5arPqHHb
 2DZi3hkwW+5HMi85TxVqO9/YF0KttAw2vnfWRPY4qo7KMVA5aQsfq+QFbElThlnoTTNf
 c3nSGqBZAVTLFc5gCtF5z/7x4bQYh8+LTpgE9+YCkTRWmwGG3kj215fE8DgI8Lf5C9SX
 tpUw==
X-Gm-Message-State: AOJu0Yz+91FqjACcq0o9ZrTB21JC2b9rlpv5fkzwZsbxaJ3JEntoKcOB
 Lf2MtgLvzjSqwq1wnkLTwGO/mlHGyxNgSwZF7H1sFTmOQkau58Nn/P3aVWPAtx7EqZgbDWqDRkj
 BiTE=
X-Gm-Gg: ASbGncuuKiEeU0+9UrHKkdqAqPvo3BJOBelhQqKszD1UQtepC0VZkyPQzszS4wZSbbA
 EmMpIDENeAWhk3bdcmsq9mteEyMExv45UE1Q7GvFZ/Yfl0fzumnT+rICoxrhfnc/Lom7bxR73dX
 SRi6wnsuqTmW5Mb0AASgtO5cxsBlZi5POVaPbiKdHJRkqQCC343ggbYlIqSR5SMhEanAruh4qvL
 heb8wrOUwcRSrQkZfcNAZ7eMxUJG1HfBZwO3NQMfOvgbnVSUJRU8ZHEIGglCDAKzlgbefTNoGUW
 h2Aqok24MbZ16fS9dLAOn8S+3KG4Wok+Gll4ezjCdCPY
X-Google-Smtp-Source: AGHT+IEhxajtTv3CRYfRljbKHFWTclhTo/t8qNAC8SrmWIAElc8vVmVt/qK+Dowl1CkKINeDdp8Lgg==
X-Received: by 2002:a05:600c:4743:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-438914309a8mr154805895e9.26.1737538258152; 
 Wed, 22 Jan 2025 01:30:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c004sm17475455e9.4.2025.01.22.01.30.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:30:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10] user: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:24 +0100
Message-ID: <20250122093028.52416-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_proc.h | 2 +-
 bsd-user/signal.c              | 4 ++--
 linux-user/signal.c            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index dac37dffc9d..da437ee0e56 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -15,7 +15,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
     const char *p, *q;
     int t;
 
-    p = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env))));
+    p = object_class_get_name(OBJECT_CLASS(env_cpu(cpu_env)->cc));
     q = strchr(p, '-');
     t = q - p;
     assert(t < sizeof(model));
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b4e1458237a..4e32cd64f18 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -1021,7 +1021,7 @@ void process_pending_signals(CPUArchState *env)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -1037,7 +1037,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 087c4d270e4..53b40e82261 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -743,7 +743,7 @@ void force_sigsegv(int oldsig)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -759,7 +759,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
-- 
2.47.1


