Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDFFC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTzt-0005y6-Kx; Sun, 23 Mar 2025 18:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzs-0005xQ-71
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzo-000693-TG
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3996af42857so3065906f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769643; x=1743374443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhKX0vmLXuR6wN4mzYTdPit8e/28nQp1dDgh0h4fk/k=;
 b=VBanfnSJMwgvfUJsf7NDjByC2mw8c9ktWIf+o6ljSb7CvRzMQLUwDb1czmZmUnUShl
 U0fKH61HqwmH3NE0cop0TqJxxqeqc2gCQv33hn+m2hMQt0wgB+LpuLJT8NvDOZupV67o
 4jcmaPwnZTNy6JR27EHC7JqSaCylEoiY0pNaNKDKw4sjYf2Y5K6DK9bICYXjgn+7HuGZ
 ZbT63t+6uX3IRMw7E6R2KEkXcTMfTcv4Vo04wucjoA0pKQuU4raYFo5notwY4sbKs7tt
 pmMkiTxRw3VaOQh0BFVqs3Hd8mz6768aQ+geK27VgTxg6CynDIcBFnL0bJtwECrk5aWm
 rhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769643; x=1743374443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhKX0vmLXuR6wN4mzYTdPit8e/28nQp1dDgh0h4fk/k=;
 b=NLu6u4HO7X5arrynuO235Aqa8Rz80v+6JVDwhFgk+Ju3Kt+FvgrO8zefVNHML9WdHs
 cGxv+SClC+IYHO7KUqhmbS7vrR2rDAsCru5jX4MfzbCkVQ19EjdTGhPsBar2ZJScEpjd
 +D/F7sFwY9dnNjqho4lSKMeBOWXkmIecLYNXlGmcQ3WkzErrirdfU/tMhX763e2Ib1wg
 4rS29VV6072BP17xAQ8qTdxgjU8kRJNF2EaT67qnmG88miTzSkE1chwkQLyqIHKfrz5d
 tN9e4HdN4tXqwL1Eqbq6pvW7L2jf4M1m7VRZNclbmakPUQ2X9ZsYlJBhdV/LcS+pBLXt
 6rHw==
X-Gm-Message-State: AOJu0YxPMbvMQCi8ojpJhQRwb7jZg5oKF4/tx4vGDaoOOAc5o0MOQORJ
 roQ1RqExwtkqEsEKrTfys24FnXhEfs83+0YUajdXyAgHI3x3FWRt9niQ4k/lPxSx1s6cv94411w
 2
X-Gm-Gg: ASbGnctsL7B43kgXhV6dj33Lsg2LJoJGpw3Mwc8TUOLo5SCZb3DhAFNbN9TVzIFicwv
 f1dcaxGFDvvZtlsGlemhRFOES9je1X1UF2+xvEQCUzfeaP+wM1UmzNeI5A51oRxq3aWti8kMeyD
 6B6iIh5XbJc+95pnNVR1riR8xLKKEcPN2gyMPsCxM5nJTYqnre/IGnqAB30hYxynLt4zg85h0h7
 j8U9Y6Vv5xOGPrJNglnbYhTZPDW/TPMxL0lWoxMqJbqiFqiMcJWz5+uYriYTQTksHW6H+47993g
 o5tOxQbfpbVqQFg1ORLQrgxkogo34oOK4tLwtg5t4tqvTCoqbUjqAs3bNhk/JeMk0hfOnNUX88J
 C+DYm4ZxUQt5fz5WUaOq9bNpC
X-Google-Smtp-Source: AGHT+IFflsrLMo/UGHQqRRk7o1mTQKQmadLe/rH1dXZf4WUm2XhZjj31meiSClOT8s3tIaqwtD/l0A==
X-Received: by 2002:a5d:5889:0:b0:390:f9d0:5e7 with SMTP id
 ffacd0b85a97d-3997f90f2f2mr10700608f8f.13.1742769642913; 
 Sun, 23 Mar 2025 15:40:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6550sm8950122f8f.78.2025.03.23.15.40.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/6] cpus: Introduce CPUClass::list_cpus() callback
Date: Sun, 23 Mar 2025 23:40:30 +0100
Message-ID: <20250323224035.34698-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Some targets define cpu_list to a method listing their
CPUs on stdout. In order to make list_cpus() generic,
introduce the CPUClass::list_cpus() callback.
When no callback is registered, list_cpus() defaults
to the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 ++
 cpu-target.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..ccfcd3eb3a6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -102,6 +102,7 @@ struct SysemuCPUOps;
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
  *                 instantiatable CPU type.
+ * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @mmu_index: Callback for choosing softmmu mmu index;
@@ -150,6 +151,7 @@ struct CPUClass {
     /*< public >*/
 
     ObjectClass *(*class_by_name)(const char *cpu_model);
+    void (*list_cpus)(void);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     int (*mmu_index)(CPUState *cpu, bool ifetch);
diff --git a/cpu-target.c b/cpu-target.c
index cae77374b38..5947ca31a0a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -98,7 +98,13 @@ static void cpu_list(void)
 
 void list_cpus(void)
 {
-    cpu_list();
+    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+
+    if (cc->list_cpus) {
+        cc->list_cpus();
+    } else {
+        cpu_list();
+    }
 }
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
-- 
2.47.1


