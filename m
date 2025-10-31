Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F15CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx6-0004vz-Oo; Fri, 31 Oct 2025 14:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtx4-0004ut-68
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwa-0006H0-TO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so19739635e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935621; x=1762540421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k1r0w/d09dhPJfEfi0bI+xoHmlX36d6WOod1Oi7dPps=;
 b=f5jSBYZEkzhGU+IrPWgVJdZF8+OwDzQyDjwOmjsPIKYplbGCc53TG5ftMujcuW644l
 hW7duTCiM32RQGEcoHIs/kLnDde17/ZAT69RBwmN86g0zWzHIBlSn5rhXXEIH1r7be4v
 I1fhZ6lncmhj7Cp60Wk7SfwKuq9W86VwimKaOQmnKXd9SAEn2qCoVofdCyi4cIdneqUh
 QaMVyysjXpO4T0EOs5PbmjRtzTpGNRR2/4SG7xl95z8W1tHVzM/Ptbxkup0gsjasPGmG
 SSqqxqkbiyh2ocSThoMDRFTQZY3Yc8ZapTlmezIxylHUZSHro6hbGXoVyLD+be+rgGJg
 cd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935621; x=1762540421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1r0w/d09dhPJfEfi0bI+xoHmlX36d6WOod1Oi7dPps=;
 b=eoL25yyyu/6n/JdZyV9hvj7pOQFaOH2qvf3IndxlUqTrsfeikvZO/SC/ED10q1GRXk
 pg7U3x96ea9zcD8NMjo4XD/JtH4IJbSPiWEj1OxeEsFd/K631qowJ6Nkj7HzCWGuuY21
 kzQX24BU8qM+ZTX5WNQ3bC63AQAZr8QRZVbiqu+FDTuASNwwH1ciCaaoD+kMmHnejkNO
 SEzckKyBLEGrF2y0DTVbetp/o4L09f3NbOycxmwfdtMYPgGdVtcH6MzxDcTno9OmvlRd
 ihI1BM5/X44KYhssARdcmjYcprihQig38ZznIP9HAYgNmuoUWWFmhnqbPqy/sN6j8Tgs
 KO1Q==
X-Gm-Message-State: AOJu0YzfXpuFPhMEWf/XdkRX118gMZMkpoxU2jZjH8fANrSEUs9/rsBG
 1nmGKVP4cKvTWpzPXE+k6ihbULQYZYgib8mIVwUcJhfssC2Ch/EhDT7jyt+JElCVgmFoHsUyKzp
 anTe6
X-Gm-Gg: ASbGnct4aafBuwnQ7bHgq/9SaVG6SUpetSxubkDOlmqah3GQnpZNkVqpl7hiPjaIPC4
 pZGyI8psphbhFuy95SBbfCbtOE9DjK+EKmI3C7GwVAS4lLUSedM1tJ/frHiJZeETnmDsYhk1bN2
 viyhqTMeQhFlTPs+l4lYbBA79MVmwPCI4jTgaBSTgsa7pIdHmRV0kYVFYZ56/6aFdhYzJcptMIJ
 jKVbCuIPTRksqs3207mp9c0BxmjQIkDHdV0Jf4OfWxzJyLkms8sWUvBdyYUpghS2r/ow9uHGthi
 dI/ZZ2E+anh+segNz1CJinhtq0Yffqm+0o7W/KfOAiySqef+QUO0zOzAsVbQBKrY7P+VpqLmhRp
 XtOzB0ioZkuHOgDvv5eEVsqQ7x7rV7unRhFifaThzA2Tsx3G86X//uEvrWqXGP3Q5iEgEsg9CnF
 bOtfbJzQ==
X-Google-Smtp-Source: AGHT+IEzEMzCbExH/o72cMb7vr+MjGB5MQOv5OXKUze7FrrGu4Jh42Jz3nQLLURZ841Fc2DueuPHiw==
X-Received: by 2002:a05:600c:a08:b0:46f:b43a:aef4 with SMTP id
 5b1f17b1804b1-477308c9f72mr42032085e9.38.1761935620824; 
 Fri, 31 Oct 2025 11:33:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/38] cpus: Trace cpu_exec_start() and cpu_exec_end() calls
Date: Fri, 31 Oct 2025 18:33:01 +0000
Message-ID: <20251031183310.3778349-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


