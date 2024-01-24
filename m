Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099C3C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKH-00041Z-A5; Wed, 24 Jan 2024 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaK7-0003cC-TO
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:38 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaK6-0003rF-7U
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:35 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so9562604a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091451; x=1706696251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X94AmIL+mNsGxo00rh8nsvmtFlP/7iCFJPTsu1PEIEI=;
 b=OZpQtAtAucMqQuCNBUkJge29NiCtNb3k7ii9ODvmv72snZiuYg4U1UDBSBF3Cac7jQ
 YjAGLYeeD0O8LK87QayTdTVpJNT21ekY7aU2XiDsbh1TQlrfVExGRLPebJp8NsbDHv2n
 fz6L6fqC0JqzzTrUoN8Z0k20jQCoekU7SKLetnHtUKj1kyyV679WnQA0Y3gt+WowqO0O
 uIZmjCLxzVG9SfJkWKdThYNU+HrdxH99L+kaHT5qOLBe+c12iRBeWugG15Jx404oqZVL
 CSCqZD0ZQhqOVfu9erKwqoXHBHwOCdhnrOjgosfW8mhuCd3Fr+atlrjql0Fpe/u5aWMV
 nYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091451; x=1706696251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X94AmIL+mNsGxo00rh8nsvmtFlP/7iCFJPTsu1PEIEI=;
 b=wgYkKYjqfj1AoJS4NFCGBOF3rL2kUXEPiLf9Ik57VBKDgVAvuVI1LgapI1Xr5ti5xu
 fzmGQkYgrdWif+HGecYbX2Fob2tvczwNeRnCzAcEK90aG4GCLqMiKC3DLkTcZOH7AvI+
 /MqghashjR3YHPTFaPaZw48VU0t7btxswPy33rR+Xtv/6c+RwvXoh+Nk4HbDPUlKLtik
 0YdPYJwl7cyUKTFo2zQkh0qCQzD9glYFP/vkR1dhBG9XGVWcLSzFTjkSzV9TIw/j6Dhg
 6uG/yKwnNeVkbBtjyD8QbEI8r5QOfGJvQHgyZQ38UvZ9rOkR4N/d8X5nN1Jy7xILdT0m
 Uo3w==
X-Gm-Message-State: AOJu0YxJzeQ4hq336w8da7kBwBUlW5udy97F02zOxNZxiZcKF/KyFOQm
 gvsxyQErpRNrzWAclUeCNcpWu+nhpTCeBgc+l5M43eYa2g2xelWi7E8u9sec6KU=
X-Google-Smtp-Source: AGHT+IHEZ2Xnctj0Ypz0sXKJndqrCnF8cX6WEK/A2zQJz49zqqAFc/OtE0tBaogsHCqJdSK1fX/MGQ==
X-Received: by 2002:aa7:d3c8:0:b0:55c:8d17:1bea with SMTP id
 o8-20020aa7d3c8000000b0055c8d171beamr1038023edr.17.1706091451682; 
 Wed, 24 Jan 2024 02:17:31 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 e9-20020a056402104900b0055c15c5919csm4080051edu.86.2024.01.24.02.17.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
Date: Wed, 24 Jan 2024 11:16:38 +0100
Message-ID: <20240124101639.30056-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

In order to make accel/tcg/ target agnostic,
introduce the cpu_exec_halt() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 2 ++
 accel/tcg/cpu-exec.c          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 2fae3ac70f..3307338c80 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -114,6 +114,8 @@ struct TCGCPUOps {
     void (*record_sigbus)(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra);
 #else
+    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
+    void (*cpu_exec_halt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5a978a9e72..390a9644da 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -681,6 +681,9 @@ static inline bool cpu_handle_halt(CPUClass *cc, CPUState *cpu)
             bql_unlock();
         }
 #endif /* TARGET_I386 */
+        if (cc->tcg_ops->cpu_exec_halt) {
+            cc->tcg_ops->cpu_exec_halt(cpu);
+        }
         if (!cpu_has_work(cpu)) {
             return true;
         }
-- 
2.41.0


