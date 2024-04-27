Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BCC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRU-0003Dw-5H; Sat, 27 Apr 2024 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRS-0003D2-6J
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:22 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRQ-0005a0-KY
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:21 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8b2389e73so37450041fa.3
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233498; x=1714838298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1+Wv8QB/miGw++EL4p3GyCE2nTTIsU/1KJBEYJal40=;
 b=j+pfFeJlXFntuCsnHRy1Luvtyy5r5iSR0KlmkiFxTajTV/NtiZkzPr3/gY5FW2QbWQ
 IGzzZbuYipyV/jIkvaoNdIiIdWa7VeCURZTVTZcw9SJL7FoVI8ajAcKZ6IeeMU4G8dej
 r7TaJDSvPNkx5rV3R4yLMRJH1a/YJEBspFqAs/ZcPPrnAWmXHBsvZUg85tnNrJmpWnLA
 rJQBLzwfL/kgDX7oTKfAWpMxVii5YilchhEM/AsKWfkoDiEpyJ9dIm3v4Sx1WV9oyTxh
 SYXeeXAOh6AyvaBNHXupmHxzSK05AGvU4vanci5mwvMuaKzTCUM2wJpuPxLYOxqPndDW
 WS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233498; x=1714838298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1+Wv8QB/miGw++EL4p3GyCE2nTTIsU/1KJBEYJal40=;
 b=LUIdjP2nfgQmRoUWw/xE7qyRhOqRWwGsMDFYmdPBkzoiBNIpHTreNL5AqbHli7yABp
 z1KJnnidRweRdklAK6TLudmz71ecEV7ehI8KcxdgMkJWgjFaTIleH6dqJ4amFCdVsdo5
 U9qThfsLnTzFWHbRIRbPLDEMfRxlUHsNYtEDpGC/k4kZVqOsEGc2mVghpOGNo56DRtUE
 recG7yhYf95PxKBudXnxwhFef5LqpKokMS5INZSGUJOctrr8FyIwqtCWIZUDtJylTojO
 AQPRQnWBFpom1xVLqAPXiXHqun26p4vzBYQyKgLUETDpGZbMEe76xptzvDp9KdgelPTN
 hhnQ==
X-Gm-Message-State: AOJu0Yz+l3abG7H9UwFceNKo+YTW64ul51wp+hgzEnBDqPtsCbGaQD9B
 qwT2WumD8Oi6KtiyYjXpSPZBZsyK9xvc6gZDxWSM5JMoG4mDPYCX9Cv9rcV6VvBqYDV3iMPyBIx
 A20A=
X-Google-Smtp-Source: AGHT+IHx/07HVOwkILCHRASibA/W9yK6l/mJ/pDLQLSIttEgSmHWJu70KQdcdPGlJAGFAp0IUPB1lg==
X-Received: by 2002:a2e:9110:0:b0:2de:d4df:4e75 with SMTP id
 m16-20020a2e9110000000b002ded4df4e75mr3275932ljg.17.1714233497868; 
 Sat, 27 Apr 2024 08:58:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c450b00b0041befc2652csm1499073wmo.31.2024.04.27.08.58.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/14] accel/tcg: Use cpu_loop_exit_requested() in
 cpu_loop_exec_tb()
Date: Sat, 27 Apr 2024 17:57:11 +0200
Message-ID: <20240427155714.53669-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Do not open-code cpu_loop_exit_requested().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..0329c6423e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -900,8 +900,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                     vaddr pc, TranslationBlock **last_tb,
                                     int *tb_exit)
 {
-    int32_t insns_left;
-
     trace_exec_tb(tb, pc);
     tb = cpu_tb_exec(cpu, tb, tb_exit);
     if (*tb_exit != TB_EXIT_REQUESTED) {
@@ -910,8 +908,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = qatomic_read(&cpu->neg.icount_decr.u32);
-    if (insns_left < 0) {
+    if (cpu_loop_exit_requested(cpu)) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
          * will also have set something else (eg exit_request or
@@ -925,6 +922,8 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Instruction counter expired.  */
     assert(icount_enabled());
 #ifndef CONFIG_USER_ONLY
+    int32_t insns_left;
+
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-- 
2.41.0


