Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150ECC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFB-0005hk-A7; Tue, 01 Jul 2025 10:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEI-0004qA-5b
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEB-0007CB-MP
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so1928946f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381092; x=1751985892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=woKpunhQg33c3UgPrW41r7BatTksnY7Vvk6D4VZ/8wEmwKQKBYLHzpAwcNv2SuILws
 LfKpcTQOoA/hhH2yfo7K7+DGQAC3S0RLfwskFxZj9U7io/3GBgjSoDrfvQjDUtWwykYG
 86JdXYuw4stGWK5V7SrqFFtym4Z1zPe+cQVnojQp52NLDEfWup3+1kkkh376IeEHEi81
 WPhSLpPlVEHCjYgzAk2/ir62ZDoMVtp3hNP20dMIe7IkSyTfjI1pA2qp/ZTrQL7f2q2v
 R603WrOH3SMKpIIjUH/oocqudXLH8xbdSc/+yKAIy1v17eTM9kz/WujAAhH7PPsQNw4X
 lSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381092; x=1751985892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=tQlFZrlbCkJkmAvl/bQdtGaCvs2x0+uj5fO+WQDEzW8bllr8h5A22Kzrwm0u1a0dNA
 u8RPhsAqmyOYYs+Xkjms3QmxfHkb7bZw2Ozb9SMPLIQJnKFoegfYYD+ydXI2vE4JT/pg
 IWEb/ESNYYfx8jphqIWuPoiTawYhae9022tJZA+dIQxzk1+uZ3Fo1uJVrQluYY9fR7mW
 yJxMN+fbX6NDtJcgDchMolt26cg7hS2PZGqik+cAoQPS3ZVBj1ggVMLcv5wze7v93hYF
 iCQxT9wzRcud5lHXQZCcyIF8Buu49iP00d9aQS23yZsI7PL55CgRl6WPWoHCeNybSkcD
 H4yQ==
X-Gm-Message-State: AOJu0Ywsz1v0w4wSXlZFN7YaafoIrRmxkOLoH98WJ8foT76j3aaPZ/J9
 RN5nWNcEvQDjiMVECwBiqbA5AxkpY8r/lx+xQM2b8X9kJxuPdbanIUKXr6qRsKeStLIrPgmd1fJ
 VGigF
X-Gm-Gg: ASbGnct/4xrOIS139ohido21Vh8OAUV6Y6Flo+eeUM9E0XAOwEQYtWhR/NO5bKBa600
 WeKEWxo6NhcXbn9NZpLzlgT3qDaLII3mVA9mF5I49+5jwXGrTTBRfhjh6N49CJ34GxKpofH7S7n
 aMMAJcHoUSpvJtKakfchtx9z3mGA3i1kZUT/BZLzE9SMmU0Y+2BdEa2h2F6yQO7wcX0ZBCnLFQX
 GDqmv4ZSrvPkHYL6WYjqwVf4EOD1y8QvcdSnvhqcpFuAw6Lrk0NcA/wZ1LNBD1EBlcMImCwrjAM
 e/elrLPzRh2xvr1l3x220Gl31IiVgcBjS6AiK/Q7mxH/h6g2yqCkp3d34ZoIg7fw7DXRFtvwWfh
 JrlqnmBBxb91vYKpMXvW5ogMA/qTio7Wu91Xo
X-Google-Smtp-Source: AGHT+IGZdfB0jrQmR1f7YtzeSiD37XoRtjSDw+CYGLsCDTo+akCOhhexdRIE+tD955EvIN1R+c6Oog==
X-Received: by 2002:a05:6000:42c7:b0:3a4:e5bc:9892 with SMTP id
 ffacd0b85a97d-3a8f50cc97cmr12587274f8f.21.1751381092260; 
 Tue, 01 Jul 2025 07:44:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fada5sm13672558f8f.32.2025.07.01.07.44.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 52/68] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:40:00 +0200
Message-ID: <20250701144017.43487-53-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/nvmm/nvmm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 21443078b72..bef6f61b776 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -61,16 +61,6 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void nvmm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 /*
  * Abort the call to run the virtual processor by another thread, and to
  * return the control to that thread.
@@ -85,7 +75,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = nvmm_start_vcpu_thread;
+    ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
-- 
2.49.0


