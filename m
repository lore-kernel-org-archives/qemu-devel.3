Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38952C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJr-0000Tc-Gq; Fri, 20 Jun 2025 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJh-0000S1-V9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJf-0004CT-3p
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16720075e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439653; x=1751044453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMxJwIcWXQ3jwweGcYvG3qTBSHwSbzC0zNHpXQCHyTA=;
 b=C2zq5pUDOSb6vmfKlIzKEy/tCOXKzAeDXRCRa8z2EGp1mOxNClGjPBd0nxFu3gM+Zs
 Dr2z9sCbElsyUlwDuJryOaxCpw98N2SgBg/6yK4GvngAMbwZ0rK6fdkX65nLq8MygIrx
 vx27jUpuPrKIsMJFgAVMSaHxZjjNS7r8jZpcJeCTxXr6k1ZpH3u7TiJn6p5wA8HyT3Bp
 CzAEGM1OjuTBf0e5fEu/yjZ6GMl79lYYuwhq3UjIo2F/3clJRQDU3odWV4LZTn1Dy1Hd
 fhaOjbEE73Dgqe52Fu3TwOKsNDYdVmL5eoft14QTKcC6hbnqHbGw0ag2Jj0DcjeMlJbV
 tDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439653; x=1751044453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMxJwIcWXQ3jwweGcYvG3qTBSHwSbzC0zNHpXQCHyTA=;
 b=L7XN64wAPoCfoHqveiJEZhTfnN6KvIo+590JTmOjt5hvwmAWXuImgSoXkMr65Kiy2Q
 LMIzqfZBfbcFZiy/z98CJ2rcwqcCY9JW1SOl3XAfYY0soc3VW6iWWez/zZyGeUtUHyb3
 3oP/7G0wPmWrDJTGI49IRDh+GgSLH1sOLVJsKTMUxbKHBDqqMzhQ++Kb8PHwzARCNWS2
 oDySaoi7iyd0xxhSFjf+eA9PO9CFWCxkcgyZBNdIfmSm0sfeysy6q3/OrNQbSTNFzZ3Z
 GgF/znkwD8ZWdnOOJSpd8Lm7h6JlFuJKv9R6GO1F7fn4ywDXRRBiVjBxUxRmtQ0gT+BL
 +a4Q==
X-Gm-Message-State: AOJu0YyBbEn5dEKdqQF5qq8kuGEXCA83AEFpoo+b8u8Rhc7lmi/6cjm3
 Qw4cTBxNCWPKObKustfpmqmStoaU/A87OFwkJcSd8bbmfQ/QduABX0MYMteRi005wNsAK60A3Qz
 tvsSWb1c=
X-Gm-Gg: ASbGncurzTtldjTQ03x3xuoZgAtEbzlfKkdeFF7+OvUzfQJvjPvka4NzrldY1FdjH8A
 LSXCzVQO4WU3TuSdbDlB/1VRi6vGqRWAL5Mo731z3VEaNSS/eTnCUGhqsZy+wq9cll1t4r2Mhbv
 p9pVdAxkemkykMI4NGgD/bXwqHNYjnpgiRAgJEM7o107BeabN1Z/NvC9jMCRNDuIB/3zDMjqbgt
 tP/lXcRSpk0DrMWMT2nGhllXzsIFGJR/N+xO7PO49EiNFi4POPcYD+g8pzEYrcpTcTo5aOrS6zR
 ujxr6APKqAjbdYVMEcouKqbNuj8SqSj4e8K7PhbTQrLJSo1JLVYAYSTJefam3WNePkpNhyqGvJj
 3hnI521BMGL7ykSI6036vvEtQNwgjGmpXLplO
X-Google-Smtp-Source: AGHT+IEv9ypYCgR53RJnax2MBF6pRt8h3mbyGO5nv5eC7ZLaAPczBSvA4qbr42XXKkwjpZIG2J61bQ==
X-Received: by 2002:a05:600c:83c7:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-453655c6169mr42047395e9.17.1750439652737; 
 Fri, 20 Jun 2025 10:14:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188247sm2560739f8f.76.2025.06.20.10.14.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/48] accel: Propagate AccelState to
 AccelClass::init_machine()
Date: Fri, 20 Jun 2025 19:12:59 +0200
Message-ID: <20250620171342.92678-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index 9dea3145429..39b52adc9cb 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -40,7 +40,7 @@ typedef struct AccelClass {
     /* Cached by accel_init_ops_interfaces() when created */
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
index b9511103a75..ec82b79b515 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -321,7 +321,7 @@ static void dummy_signal(int sig)
 
 bool hvf_allowed;
 
-static int hvf_accel_init(MachineState *ms)
+static int hvf_accel_init(MachineState *ms, AccelState *as)
 {
     int x;
     hv_return_t ret;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aeb75e1602c..f19b20c9fdb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2573,7 +2573,7 @@ static int kvm_setup_dirty_ring(KVMState *s)
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


