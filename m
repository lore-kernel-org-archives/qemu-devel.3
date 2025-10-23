Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C816CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwLI-00023V-B0; Thu, 23 Oct 2025 10:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLG-0001yu-Pn
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLE-0001pF-QR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-427015003eeso871554f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229858; x=1761834658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3asS+wXSq9uXqx9Uo0sg1PGthTH+0LCho3xSIRojV0=;
 b=sCSsVL88yvXQg3Rb+fraQGP96heFco3YXo2KWh8in54YgGs4eHkRO1TlbYlJKEnok5
 ZDi+g7Yb8Hrrs3MLg4sWkSGs66r+8gQPGFcdPWeFKwC7cxpBI25FpIBGQk06N3IFGLgb
 iJX7MsRmVEigvH3iEMyG3Hy979dDnVky9Fo8Tleiq9iEx1YcJKyy5cIG7dEueJP4phb/
 mdiYBN051FuRgv3veDz6bLOcRzu+sUXYeIg0nQh6c0SyfEjBZCQI7Kj2/s2tDjkgZStw
 JUwIkvdhxGyWKcT8sFJb8Up8xmr7l0jagOKvkWDnq4aFyc/MFO/24zujMPipaOpf9V+9
 SuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229858; x=1761834658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3asS+wXSq9uXqx9Uo0sg1PGthTH+0LCho3xSIRojV0=;
 b=sCAF0O/z5WnqtzHNIQRA/nOOVbJhrx1gJaJB25lgahX0IzFReWB1ocgJdpbSpW8TXO
 UQhzq2vU4b5t983gHWeLdUSRMfaHQH12JgXzl+cad1TvWTahopcoCq0zhR9eeBNob1gk
 neDzlWq1bntrSrhNLNe8/FEQu2YX/q7IdBWaTvO0eTxk15kGV/oRQEEEzlGF3/BfYv5Z
 UGQC4yvdCmSidpPf5e9jxw7pR2aKBLoJsB2tw1fc0N2eJW6avik5TlPyRSOICBOnIz+y
 nHXCAKXszsPauIGyKNCCKLS8REKl/dlktJScSAURPJkGl+BCgrNxXl8st+LJVCjGH9pZ
 gkNg==
X-Gm-Message-State: AOJu0Yw21/AhIUZR1fuTxR58TcSXOdiRvZz3vykgA9rQMTzsJJxQrwox
 PuofMRQqOcjyFXXaU0EP5dPrV+cwqSIZjYTbxZU+a4ZcQIF6z8knC0//HhDLLSB5Moj7DfXOGnW
 KEZK+cjo=
X-Gm-Gg: ASbGncuYG2pOyDFzdjPwU+Dj531XODOqcaPns+VsrdHhsLxi81Hzp9rLxaOlewcL9mF
 eanQrHT9+Hg88Mu9ENxpC6ft47vYcVaINqeLyH3AZ7nuCjTG12814R/umgk7jUrD3pI3HKCMQQQ
 9n3z1AZ7NIakBlIER+IJfmXsuwvO4RKYHvasIFWeC2DRskbfL4Me68Spbr3lQXnmfa/AtTYq3QG
 J7cABwZw1QBEgAUgBuIO3oszTsebwsMMwoZdVKFjnFp6hwwxz/9My11+JZJzmkNHlxBOEHBfO2k
 rVcpHSSOzUeX4xYXmQ0k91HSwlDhEYQoyS8zdQaYqwtp3tcHHCyK/vO2IixOPzavkR59GZmZzNB
 lxiL45ruW4ZqREA3vwLuWuaIme9KXjx5YnaUOckXDaDmjETY98oxCouieRHCjZs4ijGIqGzqhhv
 lzP0/Wni+8ElfWE9jOfRQ2++dB8pjIX4PZBmVXmC0O7Pu/QZ8mAA==
X-Google-Smtp-Source: AGHT+IGoiG1ypgp6u0o2eygJfvnSdOL16Gmj8TSbis2d0fZH1lLt6/otLz3iJWWC4wjzu4wj9fwj7w==
X-Received: by 2002:a05:6000:2884:b0:428:3f70:4b3 with SMTP id
 ffacd0b85a97d-4283f7007b9mr13762176f8f.59.1761229858242; 
 Thu, 23 Oct 2025 07:30:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff371sm4293487f8f.21.2025.10.23.07.30.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:30:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 21/58] cpus: Trace cpu_exec_start() and cpu_exec_end() calls
Date: Thu, 23 Oct 2025 16:30:42 +0200
Message-ID: <20251023143051.11195-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-common.c | 3 +++
 trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 0eb5c7b8f24..988d057d844 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -249,6 +249,8 @@ void end_exclusive(void)
 /* Wait for exclusive ops to finish, and begin cpu execution.  */
 void cpu_exec_start(CPUState *cpu)
 {
+    trace_cpu_exec_start(cpu->cpu_index);
+
     qatomic_set(&cpu->running, true);
 
     /* Write cpu->running before reading pending_cpus.  */
@@ -319,6 +321,7 @@ void cpu_exec_end(CPUState *cpu)
             }
         }
     }
+    trace_cpu_exec_end(cpu->cpu_index);
 }
 
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
diff --git a/trace-events b/trace-events
index 3ec8a6c7202..faeba6242fa 100644
--- a/trace-events
+++ b/trace-events
@@ -29,6 +29,8 @@
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_exec_start(int cpu_index) "cpu=%d"
+cpu_exec_end(int cpu_index) "cpu=%d"
 
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
-- 
2.51.0


