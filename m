Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D57C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDm-0003kx-0b; Tue, 01 Jul 2025 10:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDh-0003b6-V8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDf-00079l-C0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so36179275e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381061; x=1751985861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PiZmePp4Q2ULFa8bxVETShJ01u1/3P2ll+6TWji4NI=;
 b=krWJAsFCF5sp+rCK6RbYwnr6Ng0s+mDJM3fWZTwHJblPG2URdP1Jor15VnTYR6cqmc
 35e04bMlioJd/EVsmv4z4AY4K9rsCdnLryudO7c/Ll/C8J4euhdwpyGV5ivhUntWitvA
 oT7gkKqEMz5zFC7MDZxwML9gUvIlWj3Y5661KSFuQb5RpwhIZndeuqIctY3L5Gzxaeby
 uYPMMw+iBqUzFee80x3zcwKFoY2ZsGeyd6ACcqjLlX660EeJbJFpcFNxU8co1eDC2nO/
 Pddy7DjOcdzZzp/ZgUc9HqPezujKUc2/IB3e3F51g/sW4+qGmxC9baQGk5JUbVgRWaft
 Z7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381061; x=1751985861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PiZmePp4Q2ULFa8bxVETShJ01u1/3P2ll+6TWji4NI=;
 b=KTajWmFUr9ggX52I1PI6s6KZpOcOuaqKrLFf1Cm4cDZY2Ok2W6XOs7GtsPACh3KxDl
 gLSgCjr3Z9xto5xbCL5KwMBvTo0+C8Mfc9LNSb2AWXBvFtJUoG/UxH4kawCw9FSxA91Z
 hBOCbWfKP4BwOwUhgHgQuf5WJ2YzUTtRRI1qI0rkyFHM24yMMZ2aWGK10npBYEjBiO9R
 YODS9RNY5G8oBnd5oolGrVvCrxC4nC81kVsNozxgIb1fQg1BbqfZo3lrZrihvyWp4fl6
 LRogzvAGDK41L7hrDBbsHWgzKPJasks/xgvuL+2jW3nRpoxZ7fgsaYTtq0KOrLhc6ztY
 n1WQ==
X-Gm-Message-State: AOJu0Yy/Q6gPEQaQEA/AXQDeIPfpJdyiv3no2CF9lCJJeZFejp216QQk
 Uiik6gn/rRnfKhPEjTmwCv6yebh1nEvoFpdO0GjstWozxpPA8wDz1KDlAabV9XEfcBEGULufIbb
 DD/Bj
X-Gm-Gg: ASbGncuasjJQXbayrcVtbPO0lSPM6AgKKtpCugNGTa7wdOIgaPPlS6IjjYycErwP25G
 bvnXpWLmJBd0vZiXo+GYt3dBGjaQgQ7Wh7XvifZIGB8tKo0M+Y5mtYg2Zb6YgnA6I+rqSfUy17O
 u04gqFrOeR0jlwMAkzRGs7xsyjChZ4FqFRrw5zbM+b94lnemD4kL7NMVtIW5TtyqIUD6+ToenHx
 iHK+mwAHnxyMe3GzEOAA8uQsQ7hqF0eR9dga0nWGwmpay2HrOilnimlKUUNYZsac5Mhi0JT8BMD
 2paqeTtAzsFeMz3VtVsWckPrKOc8tcG0YXfk6ZtUjIq32+oNw7xlK+56rYMZAM+HSIaHAx/LSe/
 u7732VzOIZ3pUX+qDdycQvmk38d4kxOGumC8F
X-Google-Smtp-Source: AGHT+IH5xRZTEk6SYVOUrq5Wk9eWq6tVEhD6l9PQUHEXaja8lCgysEKmDVUTXYXCLbsAayYR/FRO0g==
X-Received: by 2002:a05:600c:a08e:b0:450:cf42:7565 with SMTP id
 5b1f17b1804b1-453a33d6eacmr60601895e9.23.1751381061057; 
 Tue, 01 Jul 2025 07:44:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad247sm204908865e9.26.2025.07.01.07.44.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 46/68] accel: Factor accel_create_vcpu_thread() out
Date: Tue,  1 Jul 2025 16:39:54 +0200
Message-ID: <20250701144017.43487-47-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Factor accel_create_vcpu_thread() out of system/cpus.c
to be able to access accel/ internal definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 19 +++++++++++++++++++
 system/cpus.c        |  4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 80bfe3c4d0f..be94b138346 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -96,6 +96,8 @@ void accel_pre_resume(MachineState *ms, bool step_pending);
  */
 void accel_cpu_instance_init(CPUState *cpu);
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d1a5f3ca3df..d719917063e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -89,6 +89,25 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
+{
+    AccelClass *ac;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    ac = ACCEL_GET_CLASS(accel);
+
+    /* accelerators all implement the AccelOpsClass */
+    g_assert(ac->ops);
+
+    if (ac->ops->create_vcpu_thread != NULL) {
+        ac->ops->create_vcpu_thread(cpu);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 2c3759ea9be..6055f7c1c5f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -698,9 +698,7 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    /* accelerators all implement the AccelOpsClass */
-    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
-    cpus_accel->create_vcpu_thread(cpu);
+    accel_create_vcpu_thread(NULL, cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &bql);
-- 
2.49.0


