Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B4BC47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKG-0003tu-7w; Wed, 24 Jan 2024 05:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaK2-0003SI-Mq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:36 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaK0-0003qp-FA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:30 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50eac018059so7354495e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091446; x=1706696246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Am9lbFOfXcPiDrwnR+bkztaDbspfqwYjvrmc5JlSn2c=;
 b=vF5HjYUhFRqo+nUDh6iMa6JuEAek56ZT22nnNj2rBAFQ1+t1IGfEPKhlASRNo7H6rM
 AZ5vT1QGztdH0bRjZE1sTMvW78ilTMW4EIiSUVGv9uwC7GKUuBkesWzubUVhUepLEDqG
 wEr8L5WHSDEMK0asNrTy2DVr7vrbsezzGOY+OXVA5zAORDMkxLMxDd6fZF8Voxq038Q3
 YxLXEoaRR6TZ71GJxHl3SZjILYb4iJM548F8GA6kTllkCP+LvDINghkf5fsDTyEiqdM+
 0ocAvyq3ahnBF3DqLEGV69kzb7gVVSvVlCKgVNQaMePBlMY6M5lK/TXfxLTYvu9BQQY7
 768w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091446; x=1706696246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Am9lbFOfXcPiDrwnR+bkztaDbspfqwYjvrmc5JlSn2c=;
 b=Nxlz4NIMA9jTsVsim1bysPvi6btjRNpS4IECCp+DRbfL+XnbDj2QsG+1b2hf6pVI/q
 x38Ptb15dVX6MmhHD6zgN+tovWYWdHd65DhmSPjn8ZwVrBf7sjY29PDw1uCkDrDHh75z
 XUGZHzt92GooIoVN/5hcfLBHBXgxJbhV4Pd0QXlzESzZe/cwE0+RqOcsOML4Xnax4gLH
 DbO+osYeTwbHSQTMdg6VLQBvb4iaP0VzEZvkMhcCtbgxnv/O0rRDzka62FM5xwNl78eW
 /kySI6XulJBiwyN0QSzQNbM7v46Jlbvw0EgJOGul/7HzSSs7mRIQCwzLpfLitH0GY+Bf
 mffQ==
X-Gm-Message-State: AOJu0YyeNw4XW8Bnyfac9903EYynqNEZgY4vOQPRUSHlIUmiMjUiFaLH
 t4I7S8mc/VZ0VJwt42BpJ191rhTKGqwofM+rLjPt9y25MuICvdyg5BDTj0haozc=
X-Google-Smtp-Source: AGHT+IFgUbTQFWpKFYBz920IezFeznw97CB8BwTvyN0wNYTJZ+6PdxbitusY+bAyH2on8H3il4xlTQ==
X-Received: by 2002:ac2:5b5e:0:b0:510:ab6:e418 with SMTP id
 i30-20020ac25b5e000000b005100ab6e418mr1156806lfp.33.1706091445750; 
 Wed, 24 Jan 2024 02:17:25 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 t19-20020a1709067c1300b00a2cab4514a2sm14281787ejo.133.2024.01.24.02.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 7/9] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
Date: Wed, 24 Jan 2024 11:16:37 +0100
Message-ID: <20240124101639.30056-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move this x86-specific code out of the generic accel/tcg/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 accel/tcg/cpu-exec.c                |  9 ---------
 target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
 target/i386/tcg/tcg-cpu.c           |  1 +
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index ce34b737bb..253b1f561e 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4ab7d6c896..5a978a9e72 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -768,21 +768,12 @@ static inline bool cpu_handle_exception(CPUClass *cc, CPUState *cpu, int *ret)
 }
 
 #ifndef CONFIG_USER_ONLY
-/*
- * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
- * "real" interrupt event later. It does not need to be recorded for
- * replay purposes.
- */
 static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
 {
-#if defined(TARGET_I386)
-    return !(interrupt_request & CPU_INTERRUPT_POLL);
-#else
     if (!cc->tcg_ops->need_replay_interrupt) {
         return true;
     }
     return cc->tcg_ops->need_replay_interrupt(interrupt_request);
-#endif
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 1cb5a0db45..e6f42282bb 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -127,6 +127,16 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
+bool x86_need_replay_interrupt(int interrupt_request)
+{
+    /*
+     * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
+     * "real" interrupt event later. It does not need to be recorded for
+     * replay purposes.
+     */
+    return !(interrupt_request & CPU_INTERRUPT_POLL);
+}
+
 bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index e1405b7be9..255d56d4c3 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -123,6 +123,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
+    .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.41.0


