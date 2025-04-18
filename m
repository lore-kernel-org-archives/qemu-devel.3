Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6F9C369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pYN-0004PH-Vy; Fri, 18 Apr 2025 13:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXq-0002zx-1Z
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pXf-00009v-62
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:30:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1300407f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997416; x=1745602216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhL1v0cmtQmFme3kTdHNuEhx26pxzpv3A7FOxyh5pOk=;
 b=iSJMdVf5l2fSELRIv3d1gitdyxH0NlXGQO/JF7e71j78CM9F5tSdz+y5+aXmESTPOs
 JfuRDQh6PAdXDzPUFJNODla7e6h3uibMLhWuzYYcFzGfpP6fqJ1GDcBJASSOTeYRrgZn
 1qvD5Wl1rfRL9WRDrurVVqN9Cwq8lc+0yQz9z44ZrAhdH8DTUdqJBkkljiH5fFIh7wJI
 bB3v0w4YlnbXSpabyEDNHuUyccYgqGaiBq4YFweYiY0uuSzV+BfEIyeFvAn+4bx3D/PK
 bbzjEIzWazUEZ/Qrsb3a2U+2TCm5Ck//rf/5zBNy6lVMpRxhIAUSgbhCd2ZVLw3UysXA
 rRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997416; x=1745602216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhL1v0cmtQmFme3kTdHNuEhx26pxzpv3A7FOxyh5pOk=;
 b=gSUP/l2IkFwG5uHSPmAvtymPdb7r9KnxraKPQ4Uad40zSObR1Oo1/+4eF0n+j0IUsc
 PhDaMEjBdBtnR/xgIuQlUnJC+2p1v4QxMk1BD03M/vc9qnrepJEGLQibAnPH0xPwsS/M
 imXLZDy5NFF+AvPFFFTTK1I2ivcqUzwISj1uAf+WP/T1hmWZYYvgSHXOoUTPDuajEV1X
 8ml72TOpShGRnH73zsDJfKaqB/hLyJH05m2/wb3qNslfO+DHNa6a/pXvamcOQWque+X3
 EhDyevnJPa6TjAVO2vkjYvCjVGDbSQhvrMp7HodHw8sfjH0Fz7Zq5y8KxMZKZthjILzA
 8iWw==
X-Gm-Message-State: AOJu0YyWjpnfDvqh1CR00aFYdJlC+bqsOx3HqqM//XN7AH2w2fG1EcSt
 D73wKoRHGBIQWEzIoTLg5aoDNI0KM7Zk+D6KlgwsboO5s7AQzHhfVhJL5Pf5APoyU6RXRyh8IAx
 m
X-Gm-Gg: ASbGncutFxaBuIeSNTOp5GZnYsd9SJClp3Bq0ieCLxLxcP8qh71TrfMg+VT8YYLArvL
 hxHWOK63gQMf9AWqpqlPmBvcLRvaXiwfqMS9+kaBvyWNhK8FILUrur6M3nrYGeWmmL7uHzv9YYa
 pcz9tq33sHDOTpcwffZUc4EKTOvuUoSifRqAMxaVP9YZ9YYki9JBymF07YnRQPUWGG3650JeTg6
 WNHx4vf+0Xa4M7equZlhgCt1NOtlxmQ5+dsdhWhq5tST3yN5E2S/F3g+1mMYrjk84JL4n1C6EfR
 J9GCdPTMAxUlen84DtCzT5xxuCBOojV30f8jaiVqRMBUVw93lEaWMiAnno+4kGFfQELYfdy4jYK
 Yn0mf2bPrZPW7IrE=
X-Google-Smtp-Source: AGHT+IFqy0uQxxVMRnG48d+J8HtIoWbMseJQngiGDNYOWd5R+vZ5SPDnaS4wXGObQXgDpy5N/0r55g==
X-Received: by 2002:a5d:6daf:0:b0:391:43cb:43fa with SMTP id
 ffacd0b85a97d-39efbb093a4mr2643544f8f.51.1744997416250; 
 Fri, 18 Apr 2025 10:30:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ca78sm3293378f8f.47.2025.04.18.10.30.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:30:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 14/14] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
Date: Fri, 18 Apr 2025 19:29:08 +0200
Message-ID: <20250418172908.25147-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_aarch64() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
This removes the last TARGET_AARCH64 in hw/arm/.
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 48a0c3588ce..d5bb9cf0e8f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -32,6 +32,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
+#include "qemu/target_info.h"
 #include "monitor/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
@@ -3138,7 +3139,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TCG
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a7"));
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a15"));
-#ifdef TARGET_AARCH64
+    if (target_aarch64()) {
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a35"));
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a55"));
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a72"));
@@ -3148,15 +3149,15 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n1"));
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-v1"));
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n2"));
-#endif /* TARGET_AARCH64 */
+    }
 #endif /* CONFIG_TCG */
-#ifdef TARGET_AARCH64
+    if (target_aarch64()) {
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a53"));
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a57"));
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
         machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
 #endif /* CONFIG_KVM || CONFIG_HVF */
-#endif /* TARGET_AARCH64 */
+    }
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("max"));
 
     mc->init = machvirt_init;
-- 
2.47.1


