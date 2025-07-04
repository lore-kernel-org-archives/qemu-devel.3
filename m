Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557E5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPf-0007oh-EX; Fri, 04 Jul 2025 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPY-0007nP-QE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPW-0004tD-Ia
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453634d8609so6744705e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635499; x=1752240299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SCMlTeCZmv8hvq81RUrV1bgOlAxj1jrgPSQ67QzjBH4=;
 b=GUJOuDsXyYy89zKkkPgIsH7RmnRyTg0mu4PiVPTsSX+95xKtbdNpEqdkpvwRk6HNVp
 CINAnHYAeQHqPFU4cDTF/Cvuy9k07Jm0fkwe1RFFDQhw4NEsdNvxhk2fsnp7lcJDGvZt
 ucJhTtv9kLs+WPgjnJD5lFaZBxBor7Ht5ReDhbSHctZKfvOeBkOkhSd3o4iDQtus5i2i
 VWBadbQTwBqGZBKIiXJd55czBDyffocVxIglMfgPhD5VisHOVJL3f4ZfSz7rH1ClQbSS
 ru2WnlopBvGRMMTNZ4Msc6ewi3RgILUIac+jLCpshMGI8FtneHLEzaea1EprKZA8HPli
 xMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635499; x=1752240299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCMlTeCZmv8hvq81RUrV1bgOlAxj1jrgPSQ67QzjBH4=;
 b=TxG3ZFwNyRQVyf1m4tT07cgWNiMDBCa+nDZqS1cLrDveHqEgWA6E2rhPlFO9iHj6IJ
 Ovh65XN3G3YjiIJUwpKN07lNvzVOwERSpJBrr+tEwF/DqVqWVqbqp0CAAd2MbCTtr/uj
 Su28G/hIH6STScDMmcZUWU5OgGIiwMrO9IAgYQ6weojXxvidhpFvWJANSTgqIx0ZqjsY
 0KPDrcsEVsZzKi1NuQU1rI7Tz7JYc0WdUZFO3gtoI7SGQN+AdyMunN1jVW+fb2x8HMVv
 ODfBPCSk77n657qn66yrXmnq5HuasXLFDLjnf4/a9YalcS20WnRuvAB/Uzd5q1dDkaPJ
 aCQw==
X-Gm-Message-State: AOJu0Yy9z0HAAJFgEnjhgL7g43LsbUibyXyvX1HWUc5OjJuK3z/iHpYY
 5aaMif1KGSp2/aysRkI1ImB+4SSv/7bfodsGWobTLj5NGMA7Rs0Sfeoc9IjIKCF8NwvXM/0j5Yw
 Cm3GH
X-Gm-Gg: ASbGncuEkDNZUTQwVQQ44nLXXd9EB16g7Q2xRvDYuXMe2RCfDnRPn1HCDe1+YT8AUT7
 eIG19Bg3oSeRD1TWmZdN3isx4lO7pjgM5Fzpnn1Y/pB39qmXJRe3A5wfNUM6orryt8IQ8mSb+tf
 XDWGuGYDQnBGXnI0wPAzF2PExGybjIK+V1ofMnAp9giN2UFnknqh4MEqjkInItxJdf+gkOck+fo
 DVm/BL03VhMBY+7NAytbE4+o7tTmdMLU68KJFWer7ad1s5BeA8zHscYCEyme7/MnJKBi3aPZjQ7
 RIDZCoyVcvcHCNu/BF3G8yEA7+um+2WVh/Mx2SiIUL6mh8bR4SXb5KyWqaQcNCQd/0hHu5aHRJE
 Ne9UzhhqRql1L46Nl7W9P1ydsRMLMa2AYmZCj9iNawQ==
X-Google-Smtp-Source: AGHT+IHqULuLZYEFIu4kO2fv1V05Js8alAKi3DNrFKo9qorb04zdVSNRYJXFz7VI/krtPRjHyBKT9Q==
X-Received: by 2002:a05:600c:6295:b0:453:b44:eb71 with SMTP id
 5b1f17b1804b1-454b3102952mr26059135e9.19.1751635499371; 
 Fri, 04 Jul 2025 06:24:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4709c6e28sm2514618f8f.39.2025.07.04.06.24.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:24:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 26/36] accel: Propagate AccelState to
 AccelClass::init_machine()
Date: Fri,  4 Jul 2025 15:24:37 +0200
Message-ID: <20250704132439.25743-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-31-philmd@linaro.org>
---
 include/qemu/accel.h        | 2 +-
 accel/accel-system.c        | 2 +-
 accel/hvf/hvf-all.c         | 2 +-
 accel/kvm/kvm-all.c         | 2 +-
 accel/qtest/qtest.c         | 2 +-
 accel/tcg/tcg-all.c         | 2 +-
 accel/xen/xen-all.c         | 2 +-
 bsd-user/main.c             | 2 +-
 linux-user/main.c           | 2 +-
 target/i386/nvmm/nvmm-all.c | 2 +-
 target/i386/whpx/whpx-all.c | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 9dea3145429..b9a9b3593d8 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -40,7 +40,7 @@ typedef struct AccelClass {
     /* Cached by accel_init_ops_interfaces() when created */
     AccelOpsClass *ops;
 
-    int (*init_machine)(MachineState *ms);
+    int (*init_machine)(AccelState *as, MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 64bc991b1ce..913b7155d77 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -37,7 +37,7 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
-    ret = acc->init_machine(ms);
+    ret = acc->init_machine(accel, ms);
     if (ret < 0) {
         ms->accelerator = NULL;
         *(acc->allowed) = false;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 09fe3f24152..9e4012e2d10 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -247,7 +247,7 @@ static MemoryListener hvf_memory_listener = {
     .log_sync = hvf_log_sync,
 };
 
-static int hvf_accel_init(MachineState *ms)
+static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
     int x;
     hv_return_t ret;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 17235f26464..264f288dc64 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2573,7 +2573,7 @@ static int kvm_setup_dirty_ring(KVMState *s)
     return 0;
 }
 
-static int kvm_init(MachineState *ms)
+static int kvm_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     static const char upgrade_note[] =
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 5474ce73135..2b831260201 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -38,7 +38,7 @@ static void qtest_set_virtual_clock(int64_t count)
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
-static int qtest_init_accel(MachineState *ms)
+static int qtest_init_accel(AccelState *as, MachineState *ms)
 {
     return 0;
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6e5dc333d59..d68fbb23773 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -80,7 +80,7 @@ static void tcg_accel_instance_init(Object *obj)
 
 bool one_insn_per_tb;
 
-static int tcg_init_machine(MachineState *ms)
+static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
     unsigned max_threads = 1;
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index c12c22de785..8279746f115 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -77,7 +77,7 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
     }
 }
 
-static int xen_init(MachineState *ms)
+static int xen_init(AccelState *as, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7c0a059c3ba..d0cc8e0088f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -474,7 +474,7 @@ int main(int argc, char **argv)
                                  opt_one_insn_per_tb, &error_abort);
         object_property_set_int(OBJECT(accel), "tb-size",
                                 opt_tb_size, &error_abort);
-        ac->init_machine(NULL);
+        ac->init_machine(accel, NULL);
     }
 
     /*
diff --git a/linux-user/main.c b/linux-user/main.c
index 5ac5b55dc65..a9142ee7268 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -820,7 +820,7 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         object_property_set_int(OBJECT(accel), "tb-size",
                                 opt_tb_size, &error_abort);
-        ac->init_machine(NULL);
+        ac->init_machine(accel, NULL);
     }
 
     /*
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 2df49d7eeb4..b4a4d50e860 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1152,7 +1152,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
 /* -------------------------------------------------------------------------- */
 
 static int
-nvmm_accel_init(MachineState *ms)
+nvmm_accel_init(AccelState *as, MachineState *ms)
 {
     int ret, err;
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 94fd5fc7849..721c4782b9c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2504,7 +2504,7 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
  * Partition support
  */
 
-static int whpx_accel_init(MachineState *ms)
+static int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
     int ret;
-- 
2.49.0


