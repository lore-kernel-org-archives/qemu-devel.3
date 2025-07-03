Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D003AC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHjh-0006nv-Do; Thu, 03 Jul 2025 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHh5-00017j-7H
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHh3-000450-E9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453608ed113so57086275e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540487; x=1752145287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVv77+T3+ACMfJtq+FwRrQOYxT41VnoDNDgY/IfZvIE=;
 b=hElDjqknTnQez32nl5iy+V+NgIupjVY0fR5/VlthroN5Y1Iwo1jyyoqT95JW3b/Kkn
 qElX3HwOAcDmHi39eN9n56OXoBMsDdk9snr3ypMxbCNy0fXa+rnwnf3GkNo04CyUt+in
 8fSooo+ObpN13Z5f2B6somIjNdFnocz5yfbYwwrBLnP7cSzU2mT3KP7vly73cKxQTyLM
 8lsuQHE5w7RiOdCkvlfV+8gB1yXVMNcjIK6KWx2Xg3uU46QZxcFy2Hh2ShNGIytabkNG
 CSboGaByA5okmOX+z7PCo50/mtNDCl/JRIWdBP0mHNr4OU9i/BrezoxPm3GSlkP9RzJS
 pm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540487; x=1752145287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVv77+T3+ACMfJtq+FwRrQOYxT41VnoDNDgY/IfZvIE=;
 b=C88w770Yf7SE5UVyZYoAkX0kwbQhss4oBMMVOMN05ipsj9Z8vcW0vpZNX99cyXnen0
 qoQJO6yREtG1ygFzYMpLQUFtcGs/xgsHgbB8BUU5rtEqZsj54cDH2DZmrclF6uQIX4qB
 mFLrrLrhK+xZ+M6jEXmpYvYshJDbDTSUVIk+3IhYc3XJJqjaMIufeAXPEomrtCaP0GPB
 cHQIs3RGMtplSozWjRpX6SdP5et/CCtOVttg7JCUTamZQzPgNw15qdIb1Jnj8aeHx+Ug
 mayDpicwQfv5EGT5+OJPbhEdu9zL5RWKOZr8/93Lfz/Im/QhMrnWMKfToOJ9Vc/tjjR+
 AG3w==
X-Gm-Message-State: AOJu0YwGbJLwoX0o2qs56zoKbEjzKQv2z5WikOcN3FDUYcQoXjPy/FBv
 ciuW1CiLXCVVvnUKH0+wfuPJv/Ig+vTZfdNEwy8zvuIqhhau8Ds1NZSS8U6t7/PQQC3aYtOt3uU
 ZiiOdL7M=
X-Gm-Gg: ASbGncuYKLQpkiDz0c8X74cl+25h+R5AjE1p2XgAGHEFDUbIegNveKd+BUAlUpwPHUc
 OHll4h6P8hZmtEgmF/bT0uKN50Xkx6IpJRhEXu3/9xbchPp/72LVPUlENrGUl6sdjZrm0Dv5brb
 ltWtaP2rihU0D0a41+RLd+E1cbSMcjncOd5blSJaK65RiybuvhOZ+/jm3Q+BQR5SYPhFiKaJI4q
 z6VsRsUuvZuxOJLPRz2LpO1dVTeJCF+zHdTE0FI9VK26BTRFMi2tYjceATcvbLG2V3puRbP4VlT
 o909RUx0k4OeoSltYNBSeHfK79UwLL+WIg2YTftVdA1REEYtXlN62AI3CzL3sc3B/C+fSUMCD3q
 zDLiAtiRgu0Q=
X-Google-Smtp-Source: AGHT+IGA9I3qbJr9+lDfQNbKuMpUBqcBmxbud/aj7IOWUecC0jRGcLwEZ5BDaM+WV1v8cJyY9B2alA==
X-Received: by 2002:a05:6000:2184:b0:3b3:e29:bda7 with SMTP id
 ffacd0b85a97d-3b32b14591dmr1811101f8f.9.1751540487431; 
 Thu, 03 Jul 2025 04:01:27 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454adc71a96sm11323625e9.24.2025.07.03.04.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 65/69] accel/tcg: Factor tcg_vcpu_init() out for re-use
Date: Thu,  3 Jul 2025 12:55:31 +0200
Message-ID: <20250703105540.67664-66-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 ++
 accel/tcg/tcg-accel-ops-mttcg.c | 4 +++-
 accel/tcg/tcg-accel-ops-rr.c    | 4 +++-
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 3f8eccb7a7f..a95d97fca29 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -20,4 +20,6 @@ int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
+int tcg_vcpu_init(CPUState *cpu);
+
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 96ce065eb59..4de506a80ca 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -79,8 +79,10 @@ void *mttcg_cpu_thread_routine(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index fc33a13e4e8..9578bc639cb 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -192,7 +192,9 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
+
+    tcg_vcpu_init(cpu);
+
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 780e9debbc4..6823f31d8ad 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -77,6 +77,13 @@ void tcg_vcpu_thread_precreate(CPUState *cpu)
     tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
 }
 
+int tcg_vcpu_init(CPUState *cpu)
+{
+    cpu->neg.can_do_io = true;
+
+    return 0;
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


