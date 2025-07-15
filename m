Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E31BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublos-0002b6-DE; Tue, 15 Jul 2025 16:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbs-0003Nj-Dw
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbn-0002lY-0E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45600581226so38327185e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608793; x=1753213593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6leM8DQht8TUhHC9NZWiwreTxGLFj7ofFNVivVFo60=;
 b=tT/dMAP7gho8xmRFXjTYxvbOszqSSsMrt8WCbby0Zozj3ATTxsOncwy416ZKeyh9HA
 T0yWOAq+QwRukjWW8qfI6jVnhvmdOuRhmL+s8InogrxxzYa4rndDRNnEQsFDSHBst84q
 OOXccOzgtPQZN9ickZzlnZdW1GluOmzisMWPL47WIQdz0Q+y7RBNmi1/738sLolWch/J
 V26Zn45anJvjxervd5/g6brR/IziwHKRlq+kLuS7zGEYJw303fxWLB1EqPW2sJehliXc
 0ofcd8iNn9JurZz/B1Z8Nx+xYswcG65uIozWuBdB1kGhqGRKC3yeuYGz3IgtcQ0R8jge
 GomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608793; x=1753213593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6leM8DQht8TUhHC9NZWiwreTxGLFj7ofFNVivVFo60=;
 b=gWibTIMW+UqaIa0qFfpqPxgL40ntQ+6nZcU8hecAttQZYhrGdbtYTlHjRjDiBakCdJ
 uph6gym9URO+mSU/RROtGxzSl/UXRmwzl5NNEA4PLCpTWAcE4pOe8w/4qhC1zTmchKCr
 ITYQcQH4f3al33wuihG++13bNmoUMgIgyQNS7KRLcE/vla17AZnbL9N2t/D2yZq+lvo5
 4MH7VakKId3/w+FKnxzNjPUnq3Wdknt6aLDD2WgkZFTSzbvJZrP/qvKvzrp77jI2/pFL
 GkkLHNXpBPF5PEnPNSsr4oLZFRlHRr6TfSVGLaUyeESFheKJ4nYVDseBp9WrmJeT1jPl
 oC8Q==
X-Gm-Message-State: AOJu0YzwPfGUgg07TD0X3aP1dTrqYO1dLNkEUjLUtRJIs+IKm0nQy/+T
 GzrztvhzOJSz+mpNfZXhXxtUbLdy0morG4RmJIOoQlSLBkgZWsAtMrs5MjzL37IPYp7AiW9+hQY
 6tVeR
X-Gm-Gg: ASbGncuvUP4T6Fjngloq08qMVgJdgoTqB1/9A7VJuNdKOhzbwnyyL3z9+mPCk4t0r6G
 Pv7AbWZBUOq7Qg+OE7xShjQ4MOne9ZgWK7hQX3lmQ499TFJHnG1OUG8cPtzQYunjXklgqkiwEBs
 iS7SH0LXg8l2giCNXdCd/NTXeF8Da0SAhBAHOSf61nOp5L38xGySOUHIzqpa1h2egVrNBbvlpNG
 /ZWr+HnMtmmLN7Rid9xw+iJG1orfJGUUpot2T/Yx2GJIE+BvkLcBwD+sjnSN1j/0GbxgZlhlWSp
 rgfUkEL/aNH+qRdr5oPWTkHRGeed70pZzrl93NlY3Earmjm208YOrbS5EFWoclTdrAciCOcKZe4
 8/SckYzThpiORR+giph2SP2GpVrkVWIrN8yeOO3Z96RKdc6NDQfJ9bjiwPyYShmOqbWeVhK1CwU
 58B8xZKNUeTMoO
X-Google-Smtp-Source: AGHT+IH7AG93o0aR0eGIoIMQN8amjwKvqq4YbEP8/szKaTL3/B87hXzNZ5m5SjWkgF70cLQKvetiQA==
X-Received: by 2002:a05:600c:a089:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-4562dfc0150mr2536945e9.0.1752608793014; 
 Tue, 15 Jul 2025 12:46:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456101b60besm96441045e9.1.2025.07.15.12.46.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] accel/hvf: Implement AccelClass::get_vcpu_stats() handler
Date: Tue, 15 Jul 2025 21:45:14 +0200
Message-ID: <20250715194516.91722-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Co-developed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250715104015.72663-8-philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 214454bd0b4..d488d6afbac 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -58,6 +58,7 @@
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include <mach/mach_time.h>
 
 HVFState *hvf_state;
 
@@ -118,6 +119,12 @@ static void dummy_signal(int sig)
 {
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
@@ -347,6 +354,21 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_mach; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_mach));
+
+    mach_timebase_info_data_t timebase;
+    mach_timebase_info(&timebase);
+    uint64_t time_ns = time_mach * timebase.numer / timebase.denom;
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                 time_ns / 1000000000,
+                                (time_ns % 1000000000) / 1000000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -365,7 +387,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
     ops->supports_guest_debug = hvf_arch_supports_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0


