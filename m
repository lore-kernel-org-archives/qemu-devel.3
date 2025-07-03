Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5691AC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHip-0005S6-0Z; Thu, 03 Jul 2025 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhG-0001WS-IP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhE-00046v-9a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so557776f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540498; x=1752145298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlVw0qlAe+vja7bYyOtLn/rW8RkSmVUiIwefJ7c8zZk=;
 b=By9S0ZK9Li5CgPVGrsEQcLSdZ6kqoqwN1e60tzTCkXpBMoCticFM/FKudPwo56QMAO
 +64GtuUsabJLv/9VXyU/iemha0r8tGu1JcQ0isWR4HMZk94rOoUxq9bX1yfERK+rnWH2
 Bs/rlyibHcSnkkDW96B+iJRpP08EDovbArzCZfDC8uShFop3Y66xQJle2et2Iw53LW53
 bECdUbH2IIE26pE+5X36kbQy1Wan6AXTW5enlLyIZe744/c0Tdw0fdgLNdDs7cmD+OFf
 rHbZ+9xThaFGYeJaNWQHIO3iSk711Vbkxpg4bbq+hGCUyqlzEnE7aenMweSTqQOdP57o
 Lg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540498; x=1752145298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlVw0qlAe+vja7bYyOtLn/rW8RkSmVUiIwefJ7c8zZk=;
 b=VYSISEs6lIGiBi+OzcqHkUhMg1NpS2z7aqnl+ApN7sfElMHvqOv5GAHeIf5/bBQBPZ
 H0I3W5Q5adysNo7Y7eBTy+6U++na6y0AbUhLVwUHQQkqCRa8EBdTb8UWosSQ8UHTSFCx
 Lw/0hY1zPJDfbC/76YgL4AJuDLS6oAPO3lE9ZbZ4YKJxzTsnKKrSUqqbfjPajoIlFEO9
 svRAj/rOLCDsufhj9D8ECn72uuYQdvJnzKt0ztmQYJ0FnSlmWwT5U1EIjMaFtUGY1h5J
 p0iLcEJ7BSXUsEqtqXAc5+XySQ5VMsf6TkU2PXQWwcXCEx7BbYdOZ4zFQiqg2xtM43M0
 Nt+A==
X-Gm-Message-State: AOJu0YxJFqf67OjmM1j3EcNeyzbWePbOxkbe70le2hj2prXR19Sv+scO
 r9/9gPrCFoW+IvWEeULc0fYMVe7sXtatmaoBC+bMenuJuVAfSiZP+zJ+QcMnESSIBbOcdYv3pOE
 rDB4w1dY=
X-Gm-Gg: ASbGncv9KWvkJBmhbtDTHWK6k9yTTqIp3OsY3+FeuHPrPEoxHs+zY9XgfE6SxjvPKpO
 l9jviWjd9cxPpxdSApFNfPqDEoF/Yse19N71Y7w0aIFCVdRHUz2yLadfwqeYO6ak6VnLwDci8vJ
 npKcMC5IUOOXzYOauwm9R6D88pOmReHlKCp47GOaPaE2ukKVfd/o3UQDXEc2M5ux7Hro5AG1/c5
 sTlmGXQRW7GyZijYEwKETbyJIgTeLv02ZkoT2Byuu9m0wgowZ2BREmTw0RVrad7WGK1scEwBRPX
 2U+Ur2ModW0mUxjZBpI/3qxyXjMmcj0xZgvY5H/4OkbPWP6mNt/bOPEQChg6x54AJpaojG0okHi
 Xe1a03HqNObc=
X-Google-Smtp-Source: AGHT+IEwu22mbFkl1rhzB3HygZbLt0VI4Bzye/g/jnm9qC1XNkE7RNZ7ayhpruh8WHbzvMo2Ak18vQ==
X-Received: by 2002:a05:6000:200c:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3b343886534mr2079025f8f.16.1751540497685; 
 Thu, 03 Jul 2025 04:01:37 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59aaasm18000178f8f.83.2025.07.03.04.01.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 67/69] accel/tcg: Factor rr_cpu_exec() out
Date: Thu,  3 Jul 2025 12:55:33 +0200
Message-ID: <20250703105540.67664-68-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


