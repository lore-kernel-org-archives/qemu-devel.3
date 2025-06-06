Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446EAC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBd-0004eG-Qe; Fri, 06 Jun 2025 12:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBc-0004e4-Dv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBa-0003AQ-BE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a375888297so1491059f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228292; x=1749833092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiFuAm3OZkIEGknbm0ayReT0Cz2T98Om3bMRx4Pxr2U=;
 b=HTYrAL3fb4fBBqaMj4MLPp6DdkvLllCaX8Fj1+ocz0IeEVAK2CqAiT99O0CRuM/Yug
 vrK4BQaAOhdQ1AjmuE70H0eKWwIKBJldwW8VN7muY7T5PeQQgcN1M7+iOs96AHU6osoL
 UKmRvMLrYdnAOW570YMmu9IAzveX0L8zTonEIEhBTqUhmjlBQ6RAw+RCMhVdDkQj4Y+e
 6rJdw0KmzQf9Y/gCD8HdmSee01u5Qls36+YFaArvDT5N8lf2qlJhDRXTVvYJK9WpCu0I
 yuOnJzItkUrrZkw7tekfMTaM+UQ3yfT2aHO113iJi393E6jccWNwOYdZX5rZLkp3omHW
 zRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228292; x=1749833092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiFuAm3OZkIEGknbm0ayReT0Cz2T98Om3bMRx4Pxr2U=;
 b=umRlTaoSF7CyK0qoRly17PK9UYtl7AdRe0vJGGRbWMSd86Mvqbtdxr5RYnfqe8i+Mm
 ms1p83WwsXpYjUTgi4wuPVstJsG7OpVQKpFDrfmhhlRqp/n+uFDBzKrWoL4YSMRjKfX0
 KI1LOOoIB2HYw7edrHtQi4MZ2D4m31+5pelJmYn0QzzS+XU73OnuOcO7hSHIfABQAwo3
 GAonHDGIrXQZsXRLB8r0JUxnJjJVp+p6aMZ8ckzTYp/QXPRPmbiC4jqiY48rxr8VhIo8
 O/4/2oJ4b3w0ROxR3FWarFGW9XZSVAH+BjPSvnN/sKxosjaySZwKF7Au2tMXxrYxon/S
 CTfA==
X-Gm-Message-State: AOJu0Yx33V0GyMFTYFlczH7o2jdFcqGij9ixOI8rGD5Rh3DV/7Vjjv6S
 tmufeDeGGfo1OaS0H+va1aP2QJE74KOTS2QocdOcU3BY51yoW45nTelUrTlKJxQHHMc3YxLxvAh
 s9Wk5cBGSqA==
X-Gm-Gg: ASbGncsjA532a/5QmDDinsFUHnEqjgjdZ065eYi5McsXTprm6x/jeF0Wx3dAfBXGIp6
 0wf/tawKfV3u0IFXKoqgldf/ya5rZQSmaWWoNqHduKSpi7hIrwHyVnV9sDA2gMzI0iVi6i+Vr/A
 wtIOvS1KAOaDE05Ozs6CYBqb5q9KvTqVAxeaGis5dDQADq6Od/zes3LsTGwlTvYG2aFpYWdpBQe
 oLPmg4X57j7PKWczHtyEwb9us44ZtmMr6fNOuQtxwwcPRmAhGKDChWLGrmDVOJDKYwBY/rLWTlC
 1NTItOc6QIyan02zW2o2QLx5ggmgUxGBN4ylEqT+e7MF7ACnk1ovlAgWeOsG8EEVkvQ3jZQllK7
 bkP3x8wUfllJ2TbISQLFAKZyJIw+jEXMZtmrUQDs6bDish4ZY
X-Google-Smtp-Source: AGHT+IG3UTcytprGVaVVRAVZi8092Sr63+QD+q+aenXzhIw1jkvBopJEbU5zpmNx/wqbL0yIinwDqQ==
X-Received: by 2002:a5d:5f88:0:b0:3a4:d79a:3599 with SMTP id
 ffacd0b85a97d-3a53131de7amr4116329f8f.11.1749228292257; 
 Fri, 06 Jun 2025 09:44:52 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229d9ddsm2360075f8f.4.2025.06.06.09.44.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 04/19] accel: Propagate AccelState to
 AccelClass::init_machine()
Date: Fri,  6 Jun 2025 18:44:03 +0200
Message-ID: <20250606164418.98655-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In order to avoid init_machine() to call current_accel(),
pass AccelState along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h        | 2 +-
 accel/accel-system.c        | 2 +-
 accel/hvf/hvf-accel-ops.c   | 2 +-
 accel/kvm/kvm-all.c         | 2 +-
 accel/qtest/qtest.c         | 2 +-
 accel/tcg/tcg-all.c         | 2 +-
 bsd-user/main.c             | 2 +-
 linux-user/main.c           | 2 +-
 target/i386/nvmm/nvmm-all.c | 2 +-
 target/i386/whpx/whpx-all.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 23c62cbeb07..c660c5f4b11 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -39,7 +39,7 @@ typedef struct AccelClass {
     const char *name;
     AccelOpsClass *ops;
 
-    int (*init_machine)(MachineState *ms);
+    int (*init_machine)(MachineState *ms, AccelState *as);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 64bc991b1ce..68d2f28388b 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -37,7 +37,7 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
-    ret = acc->init_machine(ms);
+    ret = acc->init_machine(ms, accel);
     if (ret < 0) {
         ms->accelerator = NULL;
         *(acc->allowed) = false;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b8b6116bc84..3dd9de26dbb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -315,7 +315,7 @@ static void dummy_signal(int sig)
 
 bool hvf_allowed;
 
-static int hvf_accel_init(MachineState *ms)
+static int hvf_accel_init(MachineState *ms, AccelState *as)
 {
     int x;
     hv_return_t ret;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a31778341c2..5b28b15ccec 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2567,7 +2567,7 @@ static int kvm_setup_dirty_ring(KVMState *s)
     return 0;
 }
 
-static int kvm_init(MachineState *ms)
+static int kvm_init(MachineState *ms, AccelState *as)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     static const char upgrade_note[] =
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 92bed9264ce..c5a53ecb6dd 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -37,7 +37,7 @@ static void qtest_set_virtual_clock(int64_t count)
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
-static int qtest_init_accel(MachineState *ms)
+static int qtest_init_accel(MachineState *ms, AccelState *as)
 {
     return 0;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6e5dc333d59..6c5979861cf 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -80,7 +80,7 @@ static void tcg_accel_instance_init(Object *obj)
 
 bool one_insn_per_tb;
 
-static int tcg_init_machine(MachineState *ms)
+static int tcg_init_machine(MachineState *ms, AccelState *as)
 {
     TCGState *s = TCG_STATE(current_accel());
     unsigned max_threads = 1;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7c0a059c3ba..ad2032a8b01 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -474,7 +474,7 @@ int main(int argc, char **argv)
                                  opt_one_insn_per_tb, &error_abort);
         object_property_set_int(OBJECT(accel), "tb-size",
                                 opt_tb_size, &error_abort);
-        ac->init_machine(NULL);
+        ac->init_machine(NULL, accel);
     }
 
     /*
diff --git a/linux-user/main.c b/linux-user/main.c
index 5ac5b55dc65..2441e6edc71 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -820,7 +820,7 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         object_property_set_int(OBJECT(accel), "tb-size",
                                 opt_tb_size, &error_abort);
-        ac->init_machine(NULL);
+        ac->init_machine(NULL, accel);
     }
 
     /*
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f1c6120ccf1..887534d4ca6 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
 /* -------------------------------------------------------------------------- */
 
 static int
-nvmm_accel_init(MachineState *ms)
+nvmm_accel_init(MachineState *ms, AccelState *as)
 {
     int ret, err;
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cf6d3e4cdd4..238c3b95c6f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2505,7 +2505,7 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
  * Partition support
  */
 
-static int whpx_accel_init(MachineState *ms)
+static int whpx_accel_init(MachineState *ms, AccelState *as)
 {
     struct whpx_state *whpx;
     int ret;
-- 
2.49.0


