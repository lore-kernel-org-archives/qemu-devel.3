Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66155C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNq4-0007zk-2H; Thu, 03 Jul 2025 13:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpl-0007l8-UZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpk-0000yl-7t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so640985e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564088; x=1752168888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ro5ctCwhGdmPqwtlx9sII1oT9bNsCF22mscjy/dvrsM=;
 b=HiM7u4/ZYSFoVex2v0QUmOFg+3WXyS/+UeDxi36vaMR56K9xrF9HRZqcksQqWadza0
 GdhrEW1//tAKEUqTl862Pdx1G7DyubEpg1EsbVBf5b8TA3jGjA5C41rUsv7BVnHRBVyj
 XNDpZgNitomNLKtfwt+XJVS57HycvlXDpmIPC43VL+6J0jYTdaADEWhcHyue5K1DFidS
 FwSN26srNuGcDTkwbi6Q6WCeq1vgUH90oSj4KX0bjudPmXZAJisu844oNZAH39AGRyhe
 8urFWcMPdKZr8KlTNYCQmAN/M+X8vsq2wwNUgBYfuBJWyjs8ye5s1G38UixnSs4vgTwf
 vtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564088; x=1752168888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ro5ctCwhGdmPqwtlx9sII1oT9bNsCF22mscjy/dvrsM=;
 b=qdShmC5uSoowO0riZ5wqeAzn20Sw3e8yf8aY5XkECnbgjFnF0bkeIhT5lvSd/S3Q6s
 inTxZKxiMqyGgeNq4piAU/z+H/iY/EiiZBnNpxSZm7Sncaz3tRUVInFkjcujGSw5BEWh
 xt81AVTGitwdvQvJMPnV1z9wZKWGqKupM9ZSy9wYKpJbVtRaMMFuvp5FbaUs+P+HJvpK
 t58ipn9TGP2q50pf6sZ+65CYqk3QLlQvBFIaZw2fPUTbXz5oKzHHhFwoZVn51TQM5sku
 WctEnZc4Qv1ahzmxC0hUeHukt1WhojdfPO/4IJOdEUdqTCf/DAf7j0MjIlqRVGBR1/pR
 cCqg==
X-Gm-Message-State: AOJu0Yz7MD5EesadgkxJp9NHvGvpUWMsg7MyssMW3TTrZswXtWBGd6vF
 c3HimLsdtLPc0e6DpSAUWs62W8A5/AWI0hIWGOTl4wFjC5c52Q5hC/uvBJas88HMrFMNnns4HTW
 knaAYV9U=
X-Gm-Gg: ASbGncs0fdQz1mjEj6e73bfG16TGmdLTnCr9JrqO1kTq2kgVKifGlafNoxUIV8JsAJn
 +mb/jJWUC08SY3x8b9wUOqWKgUxe9c/uAG2W6exiZRS0SCTIgB9yjXyGk0msGICfeMYqMLbXhS2
 GPE4fsK5eDPpccKTEsLuczCMWK3p3lQIRBtvZWSmbPIpz6eIhxEDe0aYCAtW7j9ZDa1xRRQ+mPA
 Vq9tZo55B1WZBnv2Ka+ey/qqrm+WpTfXtqeTzvaaHJ7hMgBeCbGwfpzcfrLs6XgP+RBH7JkXJBI
 9SmNp6/PVK4IXUgUsRbGVnP1mE66fbyfwWYrp1G/gHDu/1tlTcI65IgFF9oXMHoyCZlmSr+xSRn
 DszyO/hC2bTXaOkkvzUT8aaxpTj5JI92nsaLG
X-Google-Smtp-Source: AGHT+IFGjwTcI9fk7y3VA2kN2LZX02MW3Bm+zUvIkhzMam+WVG6h8xwUqOmOMMDndPlvjdSluq+agQ==
X-Received: by 2002:a05:600c:540e:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-454adabf504mr29483255e9.28.1751564088090; 
 Thu, 03 Jul 2025 10:34:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1628ebcsm3577095e9.14.2025.07.03.10.34.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 22/39] accel/system: Document cpu_synchronize_state()
Date: Thu,  3 Jul 2025 19:32:28 +0200
Message-ID: <20250703173248.44995-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 include/system/accel-ops.h |  8 ++++++++
 include/system/hw_accel.h  | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index f19245d0a0e..6eed1a3cfc8 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -41,6 +41,14 @@ struct AccelOpsClass {
 
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
+    /**
+     * synchronize_state:
+     * synchronize_pre_loadvm:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers from the hardware accelerator
+     * (the hardware accelerator is the reference).
+     */
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 380e9e640b6..574c9738408 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -17,9 +17,18 @@
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
+/**
+ * cpu_synchronize_state:
+ * cpu_synchronize_pre_loadvm:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers from the hardware accelerator
+ * (the hardware accelerator is the reference).
+ */
 void cpu_synchronize_state(CPUState *cpu);
-void cpu_synchronize_post_reset(CPUState *cpu);
-void cpu_synchronize_post_init(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


