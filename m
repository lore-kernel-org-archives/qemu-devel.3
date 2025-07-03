Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA5DC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNq7-0008Jw-Sn; Thu, 03 Jul 2025 13:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpq-0007lp-94
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpn-00011o-2Q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso476715e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564093; x=1752168893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFByqr7Cms5SGVD7NbyCQaZxrotjotWJ2e6Ypva9zn4=;
 b=GxoMwtS37dcXwOHB2aMWje67KHLNPvSi/Xk6jbZwsZytiYG0TE+59KkfiZLDtUQjOF
 /k8idkqRq4CIUJcGugI49sVgwoSzSXdK5z8MhT1FR+B1ZvYPpbJPumB3BUO4GqT1Ig5q
 OquorkUitJQ0h9R4+IjIMyWpAjzoR1rhTyKbQz5L6hDgREsoYTzuwkvk57SsP5ANBmD0
 9n0/AccFEY4znKEeIouvyu8kXELtwn5nxUL0UbksFcNntrOqVsy7+IEb9/dK4xqdP5wt
 s6t+gkLODnGnlxWAta15DOa4ssjwerbWPa0KFICPEnk0ymzqRvgxuuJHdUHdItEfwlwI
 GPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564093; x=1752168893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFByqr7Cms5SGVD7NbyCQaZxrotjotWJ2e6Ypva9zn4=;
 b=P2HIQQTXP/KOdrIY7ZC5ZDcND8j5G+Gnuf6DdYM33Yl8CGcw7NOEwwPcwWjKZw6Dmk
 dyEnszDw15j2zruF2euOPWP6MfrCbRr2oxNgyHhFCGpethy/L11Hud6iyAf7gUa6qNhw
 w8Ouqrbr/qdUC7sFxmTGIRGDZtk/Y+maJfihOcOI7jcgUIKeRYjQ7lGQmNSUW9p5lxKo
 mFwDE1Nt/qnppUyeUHcx7NAcWwEsWx8E9gUeWmOUB2mr+mKWN287yxeb5DBajKSAGWh6
 iiBU8YDAaXABYl3OfiNkdg2WHaXK6k67d0+YrjhpWOICaAsiGCff0CSfMDWJOqXCL7VM
 5roA==
X-Gm-Message-State: AOJu0YyWX3z3EuHlTQqHxz5q89xPSzioYuoGZZw5Vij34daku0XOPjlt
 Dm+hTB7n84N9/uCwflLVaJIOJMyKX/QabAv2kxRmsDrNFPtQlXna+MHdEwmLJLOT/G7MMKWHCFF
 hDkuIcbE=
X-Gm-Gg: ASbGncuiFWxymR4PKY15lcDyraX9Q++QwRqL9TqYK/g6T5AgifFkr33E/0+2aHbC2zm
 ibG1DPAo1jJr9ppFAHkTxYDfF3Zy4Ve9yE3/fIPeiTKL/1hyhC+tZ2Lkvi3+OB5B9eukW4IvnXf
 be7wnhOwIAlM3qVmwr0yTJqN/RunNxkIhdNen9je1wWirZ+2m16ZtHCUEyIfzTj8RC1JstCZuc8
 OvME7V/Rsc3MSSlsh5ivm9y1wQVmDnWDuy643P7mAyeItQdMzdTrbjj+1LH8JZCMFKzCE2EG5FK
 c3g2bQ1RRHI10AHIoB+KdBLn2bA9rbDO6AOef46nH+alNOBtk4Ta7z+yFHn2ku2V3rbGrT57MO1
 j0cZGd93fQf9HyAWfq/mc1GfxH5JxG6ZXZx6B
X-Google-Smtp-Source: AGHT+IFurU062a8TA8FJ1pVkJ3/eV1yksSD4KC7strqfPjpmGqQ3cGZlHxYC8CL2Am1OvnemN6BB+g==
X-Received: by 2002:a05:600c:1992:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-454a9cc2141mr57126395e9.16.1751564092976; 
 Thu, 03 Jul 2025 10:34:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c90esm312556f8f.91.2025.07.03.10.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 23/39] accel/system: Document
 cpu_synchronize_state_post_init/reset()
Date: Thu,  3 Jul 2025 19:32:29 +0200
Message-ID: <20250703173248.44995-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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
 include/system/accel-ops.h | 8 ++++++++
 include/system/hw_accel.h  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 6eed1a3cfc8..2075691331c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -39,6 +39,14 @@ struct AccelOpsClass {
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
+    /**
+     * synchronize_post_reset:
+     * synchronize_post_init:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers to the hardware accelerator
+     * (QEMU is the reference).
+     */
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
     /**
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 574c9738408..fa9228d5d2d 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -28,6 +28,14 @@
 void cpu_synchronize_state(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/**
+ * cpu_synchronize_post_reset:
+ * cpu_synchronize_post_init:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers to the hardware accelerator
+ * (QEMU is the reference).
+ */
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
-- 
2.49.0


