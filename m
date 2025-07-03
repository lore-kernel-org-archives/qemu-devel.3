Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFA4C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiQ-0003G4-Af; Thu, 03 Jul 2025 07:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgA-0007RB-V9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHg7-0003su-KR
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so57646875e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540427; x=1752145227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=Ap/QrKz1AN7lIN8RZST25TlGrg4qEfCx2XZ1yFQoiZCgh5+4GBOllK1RXdeHEjVNqz
 3R5aqJrbm8FyxRuukBd/tmcBruRBt/MS8ReC6BgnW+1ppyJxPNPSPlawvUOZW3tcv6yp
 ivCwYuzq2TUHGbRjh5vNUNTpOxJUQmdg5kgd5p1+LnoaCAQR3pZSWEP131i2SSLviMI3
 X3rQpONW1w62EKAaKU88xzKmRnHatCoQxtjnCrxRoWG4AIHRzAZ5acgrHSjRHvPWsCjk
 mErcpQB7nxHsKrFxqwi4QGqUba941CFVwJSuM4CbdQ0HjdwHkiL6zRIyxVfjsC84qYMU
 zGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540427; x=1752145227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=tgG6lFvG+DAikuAZf1U+oR+3PtS2A9Xs4IznLqWrYs9N6GqBmd6B+BXDbkCfb7Y0+F
 yq1CSleP7Zk+KBorSfr4Pe0eMtvMg0j0zG7gyAUb0TttL2pSBBgvc8Otv+UmYHFCWAjI
 I19wqFcLSIPVHcIsKAoPapxU35fNgmbLoTrRRdtVNcLrcBSpxKTAhNriZfNrO3Iy3xPQ
 i6bXwvcC/a+DtTRo5guP6AcvdNtyd0JPQ2jiSepVx9fC0+S4HKXHw5PpdtEeY7lZAMNP
 bkRYXeLHHcXTCvyJgDN32Q3AOVjAmp3Qp1aDr56wTFnqUsEqGsCexPeroV/Xn4WkU4Bf
 vVxA==
X-Gm-Message-State: AOJu0YxKRuF1wX1tOXluxOKShw6xtNX0ekHLB0EjHWt7WoAOOQW8EPoW
 tT0/KH4MocLT9QgBing4hPRn30DeCLwTy+DSlwP22rvY7fDTdygsZ+0/7PvlhNF4cJVwp649pLR
 89PHZzBg=
X-Gm-Gg: ASbGncshqv3h2gEH5b+HVb34esukRAuEd2/E+q+GRjizCpS2yRNsChuFeEiHmpUWGG1
 boM39KQkbC6NR/zQeYQpgyj9Q7Dnz5dKnCW6kmOihE2xJTghcfURsWzgszCRQGEdBjt3izlyO8B
 tPBdyAHwpRRbYoIrtPjj5YE9j/dzlzwQYnsG6YdIiqGDNhN/QC+EhN/H3di41+N8AF7V5lrrb9n
 LeOxA640SW54E/otpFExynV9KMaMiHImq29xmLSb5rOexS3STBLoRWklr8zI1Z6rxH/QDat89T3
 ILmlddPIafDFuzN65xCXLPhy4lgNWIBw3ENCYJd51WFoXHyia6kQGhLSS+JZu0qdA4AhILk7GCe
 6+9aolktVeAM=
X-Google-Smtp-Source: AGHT+IF9CCc+1SyfWjqrX0exoaFSuCvbstf/am9lDh22OfJZZiZvFa6b7FpHEQAXT3qDpYBDuEUQAw==
X-Received: by 2002:a05:600c:3509:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-454a9c6fe94mr37610555e9.12.1751540427223; 
 Thu, 03 Jul 2025 04:00:27 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9967ee7sm24187515e9.8.2025.07.03.04.00.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 54/69] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:20 +0200
Message-ID: <20250703105540.67664-55-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
 accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
 accel/tcg/tcg-accel-ops.c       |  3 ++-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..8bf2452c886 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -13,7 +13,6 @@
 /* kick MTTCG vCPU thread */
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
-/* start an mttcg vCPU thread */
-void mttcg_start_vcpu_thread(CPUState *cpu);
+void *mttcg_cpu_thread_routine(void *arg);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 462be7596b9..96ce065eb59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -61,7 +61,7 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
  * current CPUState for a given thread.
  */
 
-static void *mttcg_cpu_thread_fn(void *arg)
+void *mttcg_cpu_thread_routine(void *arg)
 {
     MttcgForceRcuNotifier force_rcu;
     CPUState *cpu = arg;
@@ -128,17 +128,3 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
-
-void mttcg_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    tcg_vcpu_thread_precreate(cpu);
-
-    /* create a thread per vCPU with TCG (MTTCG) */
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-             cpu->cpu_index);
-
-    qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 861996649b7..4931e536beb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -204,7 +204,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     AccelOpsClass *ops = ac->ops;
 
     if (qemu_tcg_mttcg_enabled()) {
-        ops->create_vcpu_thread = mttcg_start_vcpu_thread;
+        ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
@@ -222,6 +222,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     ops->cpu_common_realize = tcg_exec_realizefn;
     ops->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ops->thread_precreate = tcg_vcpu_thread_precreate;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
-- 
2.49.0


