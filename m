Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF2DC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hW-0008Iq-BQ; Wed, 02 Jul 2025 15:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gt-00073v-GD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gn-0003TR-BL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so32055535e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482810; x=1752087610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MeO0MVHQxtzOMjVIG+Z9L61DD5vh1obKnrosrBS7YI=;
 b=k0jbobU06raNCHiE+i3OnIWECzjZ6GbY7xoghGHh2EJD5m7ZuSg3X6Ya86dcW5Kc5+
 QXGiRKI13lzrASASJKaz2RfzCC8RvPsdhSUP0+k1AlWBdu4GZxBmfTSV5NIXGX208GJ+
 +9/16BCEeLLgF7+yVH4vnwVDNv+4Ucedbqq6T/j7BonX0nbcoxDOMiV1b284oEv2oGZl
 Vu127GXB1HeULLBhs90x87r+xqBtEDSEh6hULvGqx37EiQ36SsP5CGKTCcemh35xnAnS
 cAW8qIxlitwlQs7byTFK9ir364MqY81osmE7RhhxN6gsKeHA9IpSUiNib5hAl+rtMLrL
 N7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482810; x=1752087610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MeO0MVHQxtzOMjVIG+Z9L61DD5vh1obKnrosrBS7YI=;
 b=K3AyR6A9rH/Z9CIXU24XyVX5Q0AfJhPI6RpN/BGVqUZukFhnNivQgFplJof0v16aYV
 3+vnRVCDSOPa0g7U2kHALBe+Xcyhb+pHzVo+UVRxCfBnMA2Isi6PCSTFrnY0i5dp3xyf
 B+uyrt61L3BNVwYpe0uH3rYzOZkRxJN871BwBqMP9+lT9xsjztrx0Bo14peBj8W6DnMw
 XTeGlkyml7zG9o41i+u905Hgm/Lrr1JmuAVy8ZYgKlS5zdLbVD+mYyeBItplwK4wJyJw
 h3jCrKfi0/cegUX2C//bQor41esGBvYQtTtVtEDUf+whuhEGCmObKp7aH2yA+X3ARbX9
 YCKA==
X-Gm-Message-State: AOJu0YxoJGz1CPZBbKHH5Cq407sQYAqFlpfCgKebUu6ZIgg64/mdYhVg
 FFYhn6681HjdZ6W7PkNBg2GtMlGINZlYCUlkAPSTnNR4dmgJ5nA7RaPPr0VQh+245E8knt5idxU
 JXdFo
X-Gm-Gg: ASbGncvxB/+91uPaudihc/omTJ93VZS/UJQIbMEjVJJm1GJh8j6FqYbuSkVFF852i5+
 gE3jyc7NVkCJjOTNiZLOBLaEgdIaF8pZVuwCK+jbaaQJ2d/d1mFd1Ub09z2inCb2Q51PL4FKXoW
 V3IHOebrvO6L23h5jdeWAmMwwKIlYOMqReCadm7xsOLU7rTP78cRqr4hnu/gBFPrkNOHX3ytrP9
 0SruELzQ48fbMOBci0LeTMrVeqpY+q4mQgzWoqTKT1touAMAJJeMQeNZhQ+o0e9P4c3JvmQnpE/
 +Ubw4QHK+TJOB9yqVdVpEpJANH03AAAQ5flnCJDo5o6gCyNogH1Imnmy0HnQnkbQhw92sD8mIXS
 djPpxcumtW1liZSPBb2atI5v14/Ljh+1svb7V
X-Google-Smtp-Source: AGHT+IGAzFYW2tCDZllrD+UyqAdQOcQvAD/ViiyKPGAS9AB0EUk4i5HkuSqBJEdDHxidIq6E8KU+xg==
X-Received: by 2002:a05:6000:4807:b0:3a6:d579:ec21 with SMTP id
 ffacd0b85a97d-3b1fe5beeeemr3514236f8f.12.1751482809769; 
 Wed, 02 Jul 2025 12:00:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e6f23sm17160457f8f.11.2025.07.02.12.00.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 57/65] accel: Always register
 AccelOpsClass::kick_vcpu_thread() handler
Date: Wed,  2 Jul 2025 20:53:19 +0200
Message-ID: <20250702185332.43650-58-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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

In order to dispatch over AccelOpsClass::kick_vcpu_thread(),
we need it always defined, not calling a hidden handler under
the hood. Make AccelOpsClass::kick_vcpu_thread() mandatory.
Register the default cpus_kick_thread() for each accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/kvm/kvm-accel-ops.c  | 1 +
 accel/qtest/qtest.c        | 1 +
 accel/xen/xen-all.c        | 1 +
 system/cpus.c              | 7 ++-----
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index dc8df9ba7dd..e1e6985a27c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,6 +43,7 @@ struct AccelOpsClass {
     void *(*cpu_thread_routine)(void *);
     void (*thread_precreate)(CPUState *cpu);
     void (*create_vcpu_thread)(CPUState *cpu);
+    /* kick_vcpu_thread is mandatory. */
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b79c04b6267..a4bcaa87c8d 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -81,6 +81,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_thread_routine = kvm_vcpu_thread_fn;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 47fa9e38ce3..8e2379d6e37 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -66,6 +66,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index a51f4c5b2ad..18ae0d82db5 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -154,6 +154,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->kick_vcpu_thread = cpus_kick_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index efe1a5e211b..6c64ffccbb3 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -486,11 +486,7 @@ void cpus_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (cpus_accel->kick_vcpu_thread) {
-        cpus_accel->kick_vcpu_thread(cpu);
-    } else { /* default */
-        cpus_kick_thread(cpu);
-    }
+    cpus_accel->kick_vcpu_thread(cpu);
 }
 
 void qemu_cpu_kick_self(void)
@@ -670,6 +666,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
     assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
+    assert(ops->kick_vcpu_thread);
     assert(ops->handle_interrupt);
     cpus_accel = ops;
 }
-- 
2.49.0


