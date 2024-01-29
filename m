Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5CDC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUpI-0000oB-8y; Mon, 29 Jan 2024 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUo2-0004DV-Vu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnz-0004e7-MR
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:48:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso738786f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546897; x=1707151697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kk5BhQRPM94EKsRIhVMqYgmcfDsB7owy8rOzxcGC7OQ=;
 b=PUFV4X8ABxoNWqyIf0tWmTXPHI7aKlcRQ0hCDU0MGNLi+HI4imGoXWkTTxvizp8RTP
 JP7bxiNN6Xh0ykr8WMyJEQDEWfW+9zTZJcUrJsHk0kTShXMruLlPi8P4j6gvEmwlCo7l
 AlkOvdvJ+98Q0e7P1nM04niBcyU/+GguFUqtRMXmdaWGbKpVo1jpoL50WsXTciREIqtp
 Zq2+fap1r5MBImJUycAvazyNXt8IvyDtAruXPAXd3r+AzOM3XjdDa4AlhNMATrH5wj0C
 DmC2ih5g3SuXzP6zfcKlz3514qiOOr9SrYBLEh8gIxcQgV5n4SawwSOafOvZDtHjPEVs
 IGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546897; x=1707151697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kk5BhQRPM94EKsRIhVMqYgmcfDsB7owy8rOzxcGC7OQ=;
 b=AqL2zohthewxfh0ImghS81vUscyMXZl3SsBTB6fAxJuu8aDX/RSCdOhqnG9E+9FtNX
 bpOLaG9B9cPyw2wdidcKCGhLQHJQl1J6H1Zlf0fF/D/DVRvRDiRsTMqF/SQ//VNy1x9J
 bSROI9fsKKtkwpqb71OWEIMGBnBLV37/NQ9b7/baiqXKUrmmqCbkLYopHguroboRE4zL
 /vWBPkhd7OCP2B40VMN43tzpoc94F2G6jU8RF44g5s7wyUlFIgMbDviqZAVP4z03aKLX
 Zec0aF7wyW4tDqNwq1GQSPI9Q9f3joj5C32zql2jOMRyViqFcf2jz3nbTwSdZ70gVgmA
 A9HA==
X-Gm-Message-State: AOJu0YwHYs7a46xupJrLeNh5DNT6U74eKf2uRjIb1Sc4WPm33mmC6jGJ
 iUFHFyE2OW5Gu8zXICtNVLtSeqAR8+BM66/EEOsGivIBHDZd7qN1Uytgy14MkEoiqaC/hn6TkUs
 G
X-Google-Smtp-Source: AGHT+IEXA1iompN1/gMqlkZsSEb4uT6I1SbkEs4HXc0WHAilXTqQn4jrwhExiORkNg2dlUXVfvblyw==
X-Received: by 2002:adf:db11:0:b0:337:c91d:e816 with SMTP id
 s17-20020adfdb11000000b00337c91de816mr4734391wri.1.1706546897611; 
 Mon, 29 Jan 2024 08:48:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 ck8-20020a5d5e88000000b003392986585esm8609742wrb.41.2024.01.29.08.48.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:48:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 29/29] user: Prefer fast cpu_env() over slower CPU QOM cast
 macro
Date: Mon, 29 Jan 2024 17:45:11 +0100
Message-ID: <20240129164514.73104-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/signal.c   | 3 +--
 linux-user/signal.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index ca31470772..c6f0b1be38 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -463,14 +463,13 @@ static int fatal_signal(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
     info.si_errno = 0;
     info.si_code = code;
     info.si_addr = addr;
-    queue_signal(env, sig, QEMU_SI_FAULT, &info);
+    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
 }
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c9527adfa3..f78f7fc476 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -623,7 +623,6 @@ void signal_init(void)
 void force_sig(int sig)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
@@ -631,7 +630,7 @@ void force_sig(int sig)
     info.si_code = TARGET_SI_KERNEL;
     info._sifields._kill._pid = 0;
     info._sifields._kill._uid = 0;
-    queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
+    queue_signal(cpu_env(cpu), info.si_signo, QEMU_SI_KILL, &info);
 }
 
 /*
@@ -641,14 +640,13 @@ void force_sig(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
     info.si_errno = 0;
     info.si_code = code;
     info._sifields._sigfault._addr = addr;
-    queue_signal(env, sig, QEMU_SI_FAULT, &info);
+    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);
 }
 
 /* Force a SIGSEGV if we couldn't write to memory trying to set
-- 
2.41.0


