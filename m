Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA30C35FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpf-0005Gx-AN; Sun, 09 Mar 2025 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpb-0005EB-4a
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpZ-0004rW-IC
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso3865375e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542772; x=1742147572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UZBlo3Xf8l3qExmlz56XofEDvMdC530/ykgDz1o/y/o=;
 b=atZqFkFLZW4jCJfiY3aAQvd7RxhIrS1IQcyXcvRm+Z0QwTmMOwidGqr6BiRpmbbxec
 DQydYc9h+HMkcuOpWN1R2ZkMaKIPe0Iy90aiyaWVAxcfLscdeQPt8mZ/L1PGB1shfGL5
 bdbrVP52G37b0X7iE7KHPNUAshLlL1GYPhW8Npx4DJaSD2fRW3hwla6aufGgDq68263a
 0T4v9WD8ZCpLYpHHAqaRU00UVkKlE8kYAIoLpqvp/HMACQZoTuJgTrCAdoRVLmXxQ1Ad
 2cujadoyI2lIyd9f+wI+Utb5C7xBYUuiRS1dMopHyFaNnXnozISDD91W9wvVlAKAMvHv
 at+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542772; x=1742147572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZBlo3Xf8l3qExmlz56XofEDvMdC530/ykgDz1o/y/o=;
 b=DnzoSZXLKv6IieUkSxu9yol9MF4B9GNmv4cc30hq76SeVgIYwsFkUKl/sdtvvXmHkU
 Mo8g/HNfubRsCnpkrFLdaVmCVMSzA8+D9Gax2aHue28It8M0NtaoZa0gsCM7fxz3LE0x
 qjjj7cW8ETsp/bOKGNuQ18M1HolCrV+FDsYsL2eaBKGcYVHcOTpCVrwLJhGYWEnGOOBG
 1zOVPLo2Qx46h6q952Ne5WFDXOQYzsdOcNxI+kbN34jlSwuWoXydSD7lswAVkdA8kQ0p
 PlxmtazysznopSNohP3h7o1xIHazSmG1UudUxeI8VNhM7Mbj4zLnw1LcZcs7kTHBBWY6
 XHnw==
X-Gm-Message-State: AOJu0Yw8unT+FwRRFw1cKylTguYHk9pDKYyiD9xcs+6tVFW0Zbt/G1rI
 q68LG5uiSyjB9Ku10WejFra+aihFLHvqjf8b/9cwUEQJ0IR9ABZsSqPf0/TylgwDzfT2vrOQS6B
 gIiQ=
X-Gm-Gg: ASbGncvHQ6tG/CG8lDtbTCNoK4Xz+woa9u94yRNRKHeGg9H/4YNsG51MPFYCuiTQe2E
 v7lETb2N2kWOUbfZouVoQBVq6hXFNFW3tKRBn/0ljct4PzZ7zFHgpzH+L7RYW4e9VYPUa7lzH4N
 Zm627mlpxCDpk11nW4yP6Xra+afRw51TESaDKi9ixe/exFpqlTmHKrbEKMemQsQ0og34SKGRXMe
 iuVijmqZPqhkNCam/O6c2L7VP6cn6o30e4c6uoHr+LL7X7xs6Sx8gvwJOzzzuNTrP1OmTekvtpI
 3Q73KxaSl30vLRI3o7hBFNCTQV3ONALFbw3d8v8yiXMhIpzGiwuz8DZsWouH5YiyPilyEXRBRT9
 hSBwH3ejZWfJepUOUfeU=
X-Google-Smtp-Source: AGHT+IG0WTAmRvzCEnNrgpIT1V51UMFeH7qwL6GibWOBEVWhCmibY+3BL2c00wf5qdq8g0l5FxbQeA==
X-Received: by 2002:a05:600c:548e:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43cf70a2d2bmr9313615e9.16.1741542771674; 
 Sun, 09 Mar 2025 10:52:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435cc67sm150369935e9.39.2025.03.09.10.52.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/38] user: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Sun,  9 Mar 2025 18:51:38 +0100
Message-ID: <20250309175207.43828-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-7-philmd@linaro.org>
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
index ab1d9ddd50f..a8cfcca130e 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -1034,7 +1034,7 @@ void process_pending_signals(CPUArchState *env)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -1050,7 +1050,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4799b79dede..4dafc2c3a29 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -753,7 +753,7 @@ void force_sigsegv(int oldsig)
 void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigsegv) {
         tcg_ops->record_sigsegv(cpu, addr, access_type, maperr, ra);
@@ -769,7 +769,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
 void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
-    const TCGCPUOps *tcg_ops = CPU_GET_CLASS(cpu)->tcg_ops;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (tcg_ops->record_sigbus) {
         tcg_ops->record_sigbus(cpu, addr, access_type, ra);
-- 
2.47.1


