Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0554C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2be-0001oX-1r; Wed, 02 Jul 2025 14:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bb-0001ln-WF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bV-0001lL-JH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so51343835e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482482; x=1752087282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcxyecq1Uca5OV4SmO/+hJU9sxDq9D6xrBJnOg87yRs=;
 b=Natd3EcEDFEPudO0EwWIQB2iRMmb8b4k5VoYIsga3qG/pcJgAQu/Q+javl3OZsQ86V
 4HFXRzpgcTCML/rw0TNn4W9CtqlNJ51Q8UV2an1WhEi9nE9c41tZU2jvrRonDUbf1T2Q
 ghaVzoW50qZsKC8hTQgk1v74NZ2ya7HQ3czg9eTP3iSVDg8P4CHuuQNB8+sF+IqYJNVM
 aopXZr8ldSElF8JpkUGhjJeC+8oqOge/pqzzxD6DnjIYjymZ1vjh9DuUQaMerqUFTw0t
 Tm5V5MJpM+arFq1bIl2XF8whFPqhMQsXs9UARXS6qsLYbOHieinPLBERK9GvJvn2Xu8e
 NztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482482; x=1752087282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcxyecq1Uca5OV4SmO/+hJU9sxDq9D6xrBJnOg87yRs=;
 b=X+bfHPdAby75/oPoyjtR1xufFn9oL8KjpweaPVq7IpFvFmGrzSqbcjD/MI83W/6nQ+
 repHVFgDlvdb2ovCZl9Z+a3EDoT5E9+Fqx8bJ8orq9qLRe/8BhiLcDG061URNPjUMVZ3
 DcphXz034u4w7q2Bdtzuq+6TNQyqcieSxFXWfXqYdprWH3rnMDg7BBxIAyVmhAVvTVKO
 GYW3VDsVGNpb/aLssoN9U2fospwqbSXnkplaqJNKA75Al6zDx8BxDw1KhGTdYhasOAzf
 BZh99DURGBmCumknBSWlJUvL7zIkgBWd0B4akHOt9e7HqhwPbBmU4/lmCwIGo1cZrgWv
 aMhQ==
X-Gm-Message-State: AOJu0Yxjf83Rdhvd04O2l+TcZFh1nVZxm0XiDFWBtRSMicJf/Si15I6g
 OgODjlgs1aYvppxJZUGQczgmH0Cdaf8hh+/Seva/hv4r9cLhbxPo9b8XMGWdTRZo/Ss2wiOwo5c
 aXZgX
X-Gm-Gg: ASbGnctuCyJtFw+3xjyI6id6HGPChfYkWI3kaMv+l9Ife6UpG0j2E5H8rjrt3UUGeG7
 nwjH9eanQdzPILWgLSvAOy+Cy0WltjVnjwMZNjT+fLjEgn/xHAw00AzzIYi5VFFfadvmSuuGkcq
 +xZzd6Yf1/e35BjbA3txyFyJGGzlMQW99c01oCyneeUU60VSh5S0Z4vuIC1HVndsumtnszGe+U+
 d/3ouVZtlyJKztfYrhX76Ia1QInSUrxkGql59qZ6v1Q9VIfwTqFIZ8pBNpSjikKKo1bXWbGI348
 RvWq1o0Ld+6nZnKrSYv9dQ80aoEM+Hk0/vD9WFavaUL7n5MdxrF5wSUdmhwQ/+xxHZYB4O/6nyk
 xGEw/U/oA+I9u+XFfzGKZss/MWn+tPQ1YurWAjqM5gdtVvDA=
X-Google-Smtp-Source: AGHT+IG2xbJ0vrnlKXjnJOXC1pKqbgrk71RyrOx0GBs5KhAxvWN6hGdVgbklFARA84XuaOzPgh1qcg==
X-Received: by 2002:a05:600c:3b07:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-454a3704fd2mr40210905e9.19.1751482481564; 
 Wed, 02 Jul 2025 11:54:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9966a00sm5940465e9.3.2025.07.02.11.54.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 09/65] accel: Propagate AccelState to
 AccelClass::init_machine()
Date: Wed,  2 Jul 2025 20:52:31 +0200
Message-ID: <20250702185332.43650-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b9511103a75..6af849450e1 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -321,7 +321,7 @@ static void dummy_signal(int sig)
 
 bool hvf_allowed;
 
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
index 92bed9264ce..8b109d4c03b 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -37,7 +37,7 @@ static void qtest_set_virtual_clock(int64_t count)
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
index de52a8f882a..1117f52bef0 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -76,7 +76,7 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
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
index f1c6120ccf1..eaae175aa5d 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
 /* -------------------------------------------------------------------------- */
 
 static int
-nvmm_accel_init(MachineState *ms)
+nvmm_accel_init(AccelState *as, MachineState *ms)
 {
     int ret, err;
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cf6d3e4cdd4..f0be840b7db 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2505,7 +2505,7 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
  * Partition support
  */
 
-static int whpx_accel_init(MachineState *ms)
+static int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
     int ret;
-- 
2.49.0


