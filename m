Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF60C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hQ-0007yB-MW; Wed, 02 Jul 2025 15:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hN-0007mf-0g
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hH-0003ac-4R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3955767f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482840; x=1752087640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkXbMENLL2/wIEzevGvNzpprsLRrgpl0VsO0QRREPRs=;
 b=sH5xcLOFlQDt67HugS3PpBmK4FcSn0UJJSEMhcgy9/Yivf0cTcD9zHgqGJxgwlrtPQ
 S1iXxFTZsms7RBqRuYBl9E5hOrETUWJhizAbknf7QNnAXyP30AP6pBMu6+ev9i8BALMQ
 wqNZvhDcoQM37AbPA+zEEbwz5YLDuMqIaLjShOSAvi8BuXdXAoh3k2YVT/+xBVFKarEa
 HuaYBpMCgOu0V/aojVr1Txouc7W3omoKC80h4juWnZaIiwalS5Qr7MnMReZXSGOkRX3c
 vqIo/PRPQmxYGTwoZ++szli50PaZAeDStJEOxKT8QKrIuh+7TKMs3DEUdAMLzcYZa1Zy
 9yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482840; x=1752087640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkXbMENLL2/wIEzevGvNzpprsLRrgpl0VsO0QRREPRs=;
 b=UmayiECsncl7LmSKgeq7HRlAMfuzchd+4swpO3Q2CZdIFeMHriOqae1HYI+1RdVYgd
 +Zb3vblNqvkpHrEGB8ozHr7ww1bSLBXmRGK7EXk1o+65G4tJLvD4aHtFnDAePcfwXu8K
 wIz2MJ3LSTYQS/I1CXzJqs6FlphH6VO3UyZxsN1xHTjGAhl6YxLpKaBmYPkMFFxicOAG
 1PxiO59Y0ycqZY2yza50I/MH89Ny3RsSJeELMW8RNRgO1vdCb6qmZT4P7eErjYvVbjxv
 oyKtF1n+CwY0xGcuv9882rCuo1A0D5Prd5R6F/az8egBjcjL3RUVmGI9kUnuP2p5e2Rv
 G0iQ==
X-Gm-Message-State: AOJu0YzMTQQ2AYqq6LOik/4+E9jUYsOK6eIVZpp5Ztu+i6FzTDR1V+gE
 juwhPEEKzt8S+MH4r5vKgx/tPFsXgR15CKNtpRDNpJ7E3Q4Sjg7w9LCWQ9arYrxDCupxNAzCLlp
 Eu0ED
X-Gm-Gg: ASbGncsg/qlgBzqhU4z/j0W3KyBzcyVo2gHVhBF4NBH0WshXyOgoyQ0jM3ZxmnhUKqe
 hXcNwtYuwcgQal6FEQCHgLo+nWmFUlqXcgBXW+y2YyDi5hgf0GPUVvqDTNG/IS9UbeyfU1TG/Kz
 W560gOGswunUZvTE/32cKMq3kMKy2Z49z7pfsvMvCWwLcKtQkrgZllE4Pxg2eJgweoW4RIToa2R
 tK78Rwv83d2tgYIlqqJFxiAer+/RjZ39PNN+CBmtoDAt85O5UrLAEV1gQWbG9dUxrSORRvBqyGj
 KIxQEST1SAjA2ZhLp1PFoMvTuBFH1QQGaKYehFCl8wgtwk20CcuqzQAInZG7ChPAkVePCGvLXBx
 FdH+8RzaN23FD2pncxsHbhRjTfjxp/Qf7rc4se0lLDVIgHrA=
X-Google-Smtp-Source: AGHT+IELGT++1jNUmUBDrBmEnStzKY27FesNm8l/0VyU4bnMTYFsc2ODMv0ihPjQ+IWm1lh2eyEnHQ==
X-Received: by 2002:a5d:64e1:0:b0:3a4:ec32:e4f3 with SMTP id
 ffacd0b85a97d-3b1fe6b69efmr3029463f8f.17.1751482840386; 
 Wed, 02 Jul 2025 12:00:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b6f94sm5577135e9.32.2025.07.02.12.00.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 63/65] accel/tcg: Factor rr_cpu_exec() out
Date: Wed,  2 Jul 2025 20:53:25 +0200
Message-ID: <20250702185332.43650-64-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Altough we aren't going to re-use rr_cpu_exec(), factor
it out to have RR implementation matches with MTTCG one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 9578bc639cb..d976daa7319 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -169,6 +169,25 @@ static int rr_cpu_count(void)
     return cpu_count;
 }
 
+static int rr_cpu_exec(CPUState *cpu, int64_t cpu_budget)
+{
+    int ret;
+
+    bql_unlock();
+    if (icount_enabled()) {
+        icount_prepare_for_run(cpu, cpu_budget);
+    }
+
+    ret = tcg_cpu_exec(cpu);
+
+    if (icount_enabled()) {
+        icount_process_data(cpu);
+    }
+    bql_lock();
+
+    return ret;
+}
+
 /*
  * In the single-threaded case each vCPU is simulated in turn. If
  * there is more than a single vCPU we create a simple timer to kick
@@ -254,17 +273,7 @@ static void *rr_cpu_thread_fn(void *arg)
                               (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
 
             if (cpu_can_run(cpu)) {
-                int r;
-
-                bql_unlock();
-                if (icount_enabled()) {
-                    icount_prepare_for_run(cpu, cpu_budget);
-                }
-                r = tcg_cpu_exec(cpu);
-                if (icount_enabled()) {
-                    icount_process_data(cpu);
-                }
-                bql_lock();
+                int r = rr_cpu_exec(cpu, cpu_budget);
 
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
-- 
2.49.0


