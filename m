Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91822C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcH3-0000Lu-ML; Tue, 01 Jul 2025 10:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGA-0007vm-7A
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcG5-0007XJ-Hc
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453066fad06so39234795e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381210; x=1751986010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32sIKa7Y8PNtS8Bgd6Etg2hYgYfsXGy2A3nEDlLpLAs=;
 b=cMYPzPfrWitHywZSbVPdPGJolaLpqGTlQQVYPxU7P1GB9aa/hcEQ1LiyDGy/G2puAM
 utgz4JY9JvwQePg9AqKw0uIMp9NGueTD0Rtx9FRnneSh7bFnX9EanUtE8jUzk/RUrfn8
 9Vn731qoMfR0RM93hUIn/vS/MCWmdadG1ZGKvIe8a+CkX9XZpMwM43HPkya67ShCgTUn
 yMYiPZt0E0XmH7IKOWsTQzdglrnjifwfXnFCVRiXzGZdLSOlm2q/57bDWw7xg32kPah/
 kcFWJ8ue3ViEhNOGm2M9ZxIirdJcYgnf4qJgZl6IPsJvL+Xk4p5V4G2crPytAwiPSLG3
 aL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381210; x=1751986010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32sIKa7Y8PNtS8Bgd6Etg2hYgYfsXGy2A3nEDlLpLAs=;
 b=rNpy4vTBB5sYnhRVaM7QJS45qVF1N9nOjyIV0Kq8OAugNB7txk1pUqotcN60napf43
 kJLt+QbWIAu+ECEI/g5nfOjQimlWuQKFY199QtVad29ec+7l6LcrjgY81QDkvWSPgL8b
 BPxK5JY+yFijH+jpIh5ZkRVP9AqqYZJB239WDRrHJbmDuxejvJg/Vd17yvVNvLXeD1Ri
 kZX6RiXw0fKllxEqdJvh7GfNpssHaTB0fr/J2Yba9+z7hGa1owqvTJ+LQo7V6eMfy9aj
 tHGRkxSE5Ev5xb0coY0BD1VvIvaO68R6Ek+dcGn59NqKMcNYB2FCgCDzgUZ0hEvN6FeX
 RYSw==
X-Gm-Message-State: AOJu0YxrPzYR8pcayUxAFYitC2Di5mWu1blixyWoiZ8ikRIATwpW+OZZ
 C3y+T8Svd3uHUgo3myIK4UbS3/cVC/KrrbdD7uo6Stwg/hCcqa8hXQeSy5u3guImdv5rTbwDezs
 IJlGm
X-Gm-Gg: ASbGncueAwIZnhqiEktJnUydaQge4D01uKUp7vrgBna4fdWYm26X+VdG2wx+nQ5K4PX
 0rjwmYPXTbFsM9VvTf+nPRKGknOokrhvNB16AFucA8xz+Z1wa2tbWZvv3Qpgc8g5lWjK2ePdwd4
 bz6YOr3/s30nwjcx/JWOg8zur4ZryHo6fWWc/xixeZFx0O3LDigNYzJFPKTEQRuRlIMguNqxlhz
 PIDrBjSFOh0HlEJrg9aLxG8FHZ7DGMyMjp+eNiz2NyKM9BypEMttERKUmUfb5NaAsSopX7C3xik
 NgVj/tzqUmjrknp5qe+XDnjm3UGogRPjibrTJtwxC1NEwD2/q/fLROgONz5ObLixjZFC7EE3O0I
 J47Cl9FJywMJDFHyN6xLrDm9SnPdeZ7nkJWc+4shGXRlburU=
X-Google-Smtp-Source: AGHT+IGOS3Pp8BhAxRzra+IEREvLRhuYrwIp3ak858aMQ47FBlqU2sCDfuCBdZRqh2BLL4upavGENQ==
X-Received: by 2002:a05:600c:5392:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-45390bad330mr170129225e9.5.1751381209722; 
 Tue, 01 Jul 2025 07:46:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538f88efffsm140603835e9.17.2025.07.01.07.46.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:46:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 60/68] accel/tcg: Factor rr_cpu_exec() out for re-use
Date: Tue,  1 Jul 2025 16:40:08 +0200
Message-ID: <20250701144017.43487-61-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.h |  2 ++
 accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
index 2a76a296127..a73fe5b94a6 100644
--- a/accel/tcg/tcg-accel-ops-rr.h
+++ b/accel/tcg/tcg-accel-ops-rr.h
@@ -18,4 +18,6 @@ void rr_kick_vcpu_thread(CPUState *unused);
 /* start the round robin vcpu thread */
 void rr_start_vcpu_thread(CPUState *cpu);
 
+int rr_cpu_exec(CPUState *cpu);
+
 #endif /* TCG_ACCEL_OPS_RR_H */
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f5af7818d51..a9150802369 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -169,6 +169,25 @@ static int rr_cpu_count(void)
     return cpu_count;
 }
 
+int rr_cpu_exec(CPUState *cpu)
+{
+    int ret;
+
+    bql_unlock();
+    if (icount_enabled()) {
+        icount_prepare_for_run(cpu);
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
 static void *rr_vcpu_register(CPUState *cpu)
 {
     Notifier *force_rcu = g_new(Notifier, 1);
@@ -269,17 +288,7 @@ static void *rr_cpu_thread_fn(void *arg)
                               (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
 
             if (cpu_can_run(cpu)) {
-                int r;
-
-                bql_unlock();
-                if (icount_enabled()) {
-                    icount_prepare_for_run(cpu);
-                }
-                r = tcg_cpu_exec(cpu);
-                if (icount_enabled()) {
-                    icount_process_data(cpu);
-                }
-                bql_lock();
+                int r = rr_cpu_exec(cpu);
 
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
-- 
2.49.0


