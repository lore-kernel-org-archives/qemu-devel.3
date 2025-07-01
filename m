Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75566C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCI-0000a2-Fo; Tue, 01 Jul 2025 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBs-0008JA-IE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBe-0006zL-Bk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so36151575e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380935; x=1751985735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIAleiBBdRo51bhet36WmYxY2vl2Zoe+P6XPtSaFgX0=;
 b=yliDx/ND+KBI6+oroVo5sy3tzUC2ymx8kSrRck2bXw51oS6ZckAyFvaBOeNtEEnPO2
 QAaeYJtjc5vqQgcgBNk+z5E+VJFArGbSNWM3rjn2eVp4zuCnM+NR2XHqHaWPBFj76ceQ
 eaAfYXTNwbBAwewVYYGi1rhcxHt14wFrNDKNfvVlqDRcv7rNtb5nlX/vDEQpzqI4S1Dx
 hBAWTKv3PSVaXBOLeNqa8EGKGn45aJch6YEwUYFQC8g6DhhxmAEb5tJStTO87CNBa9y4
 g3/a31HM3gfFRTHmdd2Ya30zLQQHpXqsfDFTvuKA19tXSrw9HZSGhHORbmFRJBjX4XAP
 v/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380935; x=1751985735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIAleiBBdRo51bhet36WmYxY2vl2Zoe+P6XPtSaFgX0=;
 b=Z5Yltp8KcANV0hylllk8H/uYg/YeJUklcKUJUzosY7f6maBDFjDlXhKYXXb9JzwN5P
 hcbzrprSBBaQD8jzaS3d328FwMwGXYqbuWMyvjugsJQfZ5JQhLDudXeITZfPeJyYtfRf
 Z2rvrcmF5r0FgFE0Ih45SdWwMnP3AFfYjh9rPBo7xfrBZpwbcG6Qte+apwdUzquif1vI
 zn+B8XQon765TcQPAjEkDvgV4gpRrRhWuCpOVEQW8o+T6Lm/1Z0qYT1uMNFkMt6d1Ppc
 fJoVPZB9NtZhYzxvGJjMqHLec/4r/fcoaNgOfVZ7sVCXhbvoIJSyQtWXyGDrAZIQ+TPI
 zSaQ==
X-Gm-Message-State: AOJu0YzQ2KMQdizl7hDF+ZRaRs+jVSuwlXmwJR84zuEFgTpy7/tFef6s
 JnbTcnaNMTg1LvtJCFP5c+F3svpIJjLx5IpSIkP7Zn2txjkNkyKHFyCoRLLNsPI7+f5MxJ5QwzN
 Nsnup
X-Gm-Gg: ASbGncvTf+zDGo/ePyQQRbryR7x70/AmGp5V/5EGwbbD0DZ532wSMT16GVjw1tO597c
 03NwfhjcLtYPr/t67bmb2A0tawclk6ybeRRC7PiAcMqc24XAwrzonT/xme3J6hxSDKpox4CTq9n
 LkCSCWvOqrdxfltMzvKDvASdPTGpyIow84r6JqbX4t+PMFsgmMFwWq6dOf9PERqFQcrXfff3JOn
 IyGd5P9JZqyXk3r4HaVJoM5dUufDSvVOTAL0+q1A1cIx3jJ56tJWzE/9L/GFzRLjxyZyTZDPyfp
 P5ESUSBpImoKOHa/OkXvHGmJZjjMH5ndUrAuNeySe/Icmb9WQAubQtAsqa9V0um+u4bLlv0Cgnh
 0ICn7Y1oH1zHAyqiQRjULMs4R9jbvz92dznBQ
X-Google-Smtp-Source: AGHT+IEqQJLJDybRM8jlFo2oCKMQcM90zvhxXi+XeLAeLmth4ftJBkyu/AfzJgqGPSiTkMS0HzU7gw==
X-Received: by 2002:a05:600c:4e01:b0:453:6146:1172 with SMTP id
 5b1f17b1804b1-4538ee4f7cfmr201697325e9.3.1751380935224; 
 Tue, 01 Jul 2025 07:42:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c3c7csm197370415e9.36.2025.07.01.07.42.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 21/68] accel/whpx: Convert ops::synchronize_pre_resume() ->
 pre_resume_vm()
Date: Tue,  1 Jul 2025 16:39:29 +0200
Message-ID: <20250701144017.43487-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 target/i386/whpx/whpx-accel-ops.h | 1 -
 target/i386/whpx/whpx-accel-ops.c | 1 -
 target/i386/whpx/whpx-all.c       | 3 ++-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-accel-ops.h b/target/i386/whpx/whpx-accel-ops.h
index e6cf15511d4..54cfc25a147 100644
--- a/target/i386/whpx/whpx-accel-ops.h
+++ b/target/i386/whpx/whpx-accel-ops.h
@@ -21,7 +21,6 @@ void whpx_cpu_synchronize_state(CPUState *cpu);
 void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
-void whpx_cpu_synchronize_pre_resume(bool step_pending);
 
 /* state subset only touched by the VCPU itself during runtime */
 #define WHPX_SET_RUNTIME_STATE   1
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index b8bebe403c9..011810b5e50 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -95,7 +95,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
-    ops->synchronize_pre_resume = whpx_cpu_synchronize_pre_resume;
 }
 
 static const TypeInfo whpx_accel_ops_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f0be840b7db..821167a2a77 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2106,7 +2106,7 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_whpx_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
 }
 
-void whpx_cpu_synchronize_pre_resume(bool step_pending)
+static void whpx_pre_resume_vm(AccelState *as, bool step_pending)
 {
     whpx_global.step_pending = step_pending;
 }
@@ -2703,6 +2703,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "WHPX";
     ac->init_machine = whpx_accel_init;
+    ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-- 
2.49.0


