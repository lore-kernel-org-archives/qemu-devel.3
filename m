Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47335C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdT5-0008Lk-QJ; Fri, 04 Jul 2025 06:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdT2-0008BM-SI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSz-0006x3-JT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cf214200so5858195e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624182; x=1752228982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MDgreBIe8GH6HfFhheEGkGfr9GGDVllh8tKN5isBeSo=;
 b=Zb2uk7kxywkxi4pQlOIK/9ttnKa7Kg/ilWjXmLK/F7O1/xd0tyxJ3AHBh33MJb34nK
 HvCLB4neBzqygqK8wMxSVN0/sWQ5l0ec3IHuKfqIf26t4ceH6mTFw6eEutgaoHFVodxQ
 rlquBYqIuy/BXfNSW08QReTuBN8yQZKEu91NATm8rnzZ0t7O99xiCzPUX63VC9NrpbNP
 jc+bZFDkDVrKttLA+s1cpOsKpgS3XA3aiwhdSvBqYDw11P0BD5NLeJOtGDlaECI/ID9d
 aYhOxhoQxqPEEULhcG8kZgaQgy/BfY2HannDEjty6Wbpmi52CIRq2za1GyKPZei5t7Dw
 oirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624182; x=1752228982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDgreBIe8GH6HfFhheEGkGfr9GGDVllh8tKN5isBeSo=;
 b=CXAyEH8CgjJPVNV3IHA4UVtPidzpUwSJl0Q5y5OXGBMtKCLbvc6c3ywNMp7qWBkYM+
 MYb0VEZE2Bo0UPPgLxaVovq4x1Gf7F2KdeCD6hjtmQXal1emUJCbUGQSHl5Kjq0LI8b7
 u6mBjVF3DxkmCV7qfnfnivsBqHr+8ElTglJokl6lz5y1wepua3YBLhcawR7cc4XFbOFf
 bISXRxBy7hFYw2RrbVifONnKPUzayuZQUYa64Qqrk0sn1dPgumE3d0u+4OwjhyvmA+Y8
 DnDiKDmxMeaxjkaN63bP6viGhYO0y3/fLIz5zTF9d/SD2bQ14zzmjdNbG9gthU/mH9MP
 fXlQ==
X-Gm-Message-State: AOJu0YwSrgCix2K6DELDjcfuT6O3YV/UrdxUTg/Sqi2bNMBYoded2XMe
 qtfih/7sBrbiBPC9Ytc6VRux/lPJAl/sw4k55Fo4qvR2BHFP5zSlGuDLtr50AaGJQtTkUp08Eo3
 N6FjiLjE=
X-Gm-Gg: ASbGncvv/S+DpHkBLaxj/dZiluPPxI+TaEJZYfTQ/r8ldr1VAfQZNbSQEkWK1glCcKc
 tXU4QsxeXWgtsAnd+jFxJIjVboYWIDTcytKaUwAsXSYGUSWOeEJshExVlpPDovUW9cyxmoco1XB
 M73+ApcW2xxEoTYXx+tmct7PdMkY76Q54qzxfOl7fzE60oWc+2EHN1VxyPwXnjEjOSxD8GdadFM
 eNMizn/ji2TgLofKy0TOk4kfY5JLgabOhCvS+2vf8Xl0fpJjyhqEJGW4pcTdqjsqtd4N/x6nOuI
 OT70DRawnr2EPnb1RXX05F2WMduAyVmYsKmGuqQnMUD7fmsX6aOVNFGuqQ+V2Gh+JdNvF39OjJm
 xyK9oCzgYao5yQlV1f82O4eawt3hNFptBFDIvxu1wTX+jLTM=
X-Google-Smtp-Source: AGHT+IFmKyqYDyPhl6ZNheUuSW+jOyspB6fCGILKZIkiH14wyBKi9FUsbOaT5NcIe83yBUjG1nkW1Q==
X-Received: by 2002:a05:600c:a087:b0:454:ab1a:8c39 with SMTP id
 5b1f17b1804b1-454b310d890mr17562065e9.26.1751624182044; 
 Fri, 04 Jul 2025 03:16:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225b23csm2080587f8f.84.2025.07.04.03.16.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/31] accel: Propagate AccelState to AccelClass::init_machine()
Date: Fri,  4 Jul 2025 12:14:24 +0200
Message-ID: <20250704101433.8813-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
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

In order to avoid init_machine() to call current_accel(),
pass AccelState along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index ddc77e629f5..68f1425fae2 100644
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


