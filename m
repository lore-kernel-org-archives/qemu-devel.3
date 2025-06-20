Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA73EC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6e-0005R9-Sn; Fri, 20 Jun 2025 18:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMT-0004Vf-4U
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:17:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMR-0004l3-8t
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:17:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450dd065828so15581025e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439825; x=1751044625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfIXmPf89XXe1HBqtw6MJ15ZCEw8ryCmetzhx/QXCNQ=;
 b=GmnRmlY45cmrflqxTRwEzyPyUzFB8Go2e8Vhu43DScP1BUEWFjGYPhetSx7a2DjJSo
 uzDL0/UZRPEediTDggN2LATsRj9hdkHt+LagiCm932R4usVTHRWA39tQNzj+iaGbzsN6
 xMsSUz+fJbW65AAziCsCNQ7ZP+uLxAH2OTaZtRe5gUBQ9nTCT4EhH4NDdulcBVlS6Zr2
 x3w1iCROIy5f9s2O+42GX6huq8VkCpexx5QJQYGsmsF+ndRajXjifmw/9fjwkhi8zuKD
 uLrP7upDYwLA3S77buRgaJV2JHmosbzMjqAhaS5I5kX7c1aFH1IHKqsb/BCjaiDAf3yZ
 QaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439825; x=1751044625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfIXmPf89XXe1HBqtw6MJ15ZCEw8ryCmetzhx/QXCNQ=;
 b=l54WlzbXOtj1FxFb0fItLz021Tcr33ocCOYBtdfoVMchkFF01/gUjZkH/0wgyaAAfn
 PBAYFnL43fTfeXrrdT0zReL7SyaRPakzOkWv9atR1oy4bdm+cU9z5kYVCdqawlb4w79y
 gtUk6oZNuVqCUpc/YzvnQOhh8x//+lkR3OhZ4DSnps9aKSu2Db2NxiWduok0FWaghbqX
 tfn87ggEOOzgM1dlb5O4Xa0513wNXi1IRj8xJl1SsnmSmzES6NJ2DACwfEJ3Wioi0NCA
 3mAY1lIWXjyCOsrJUHnlOpVXBW4c9WXZAl3/Ql+MoaGcPN1QyDM5XtG61LDrSmjt+3kF
 805A==
X-Gm-Message-State: AOJu0YwTgG81InMv490vrUFXDkCxehgyWqrDYYSJCAoHznwmLbsJmI8x
 Cr3guGH5KIcdb6xavu77xOT7plqNIjprXieskE9y3kBYSjs2rsvCDgiHBfb5cjKX3NzVfauunrf
 qhJ+4Q4Q=
X-Gm-Gg: ASbGncsHQDGosPf3e0rBltIf1Pr/16wGfGAVoZMzRaTC/5CEhGHgRx8c1zBsSyqeZYQ
 Beaf3C9O5dKBjX9rFcWyULIRDqIkdfaioOCIdwpqcrqnk+G2bJGNPFd5CyIwGcsveIbQGk79YHp
 7m4vs+AVrAYFserEWK9x635AWbqxJQsPUYXMhYevS0k6pOagAM3jwn1Zx2K96I3C9+Qe8sxmuJp
 92qnRqMJKUgFu0fm1jEsrakeTx2xCF9ssmdwp93lIqiOItKHX7sMtX/muyLv4Ig4R5btlRiTJRV
 7Y75WJxS6W1YPQjjCBENy6H2i/ay4YA5uq88rS5E+AtZXymeMICqBJRS06vABbFbqoL/0/q3Cfv
 uScQXlkPrQb7ciW6HoxbmcyYAIxU7qxH9lZOd
X-Google-Smtp-Source: AGHT+IEo2tyMIR7s+OdTMnEbfWFPkc3ffkN/QaBBMe04BfCGjvzfXeM1cjC/LJ+nUYNEQUQhg0YHgQ==
X-Received: by 2002:a5d:64e8:0:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a6d129f557mr3718810f8f.14.1750439825397; 
 Fri, 20 Jun 2025 10:17:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f104f6sm2678349f8f.12.2025.06.20.10.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:17:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 41/48] accel/tcg: Factor tcg_vcpu_init() out for re-use
Date: Fri, 20 Jun 2025 19:13:34 +0200
Message-ID: <20250620171342.92678-42-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 accel/tcg/tcg-accel-ops.h       | 2 ++
 accel/tcg/tcg-accel-ops-mttcg.c | 4 +++-
 accel/tcg/tcg-accel-ops-rr.c    | 4 +++-
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 129af89c3e7..1263a666774 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -20,4 +20,6 @@ int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
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
index 4931e536beb..83fb2d1362c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -76,6 +76,13 @@ void tcg_vcpu_thread_precreate(CPUState *cpu)
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


