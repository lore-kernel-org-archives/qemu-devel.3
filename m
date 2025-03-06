Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC6C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVv-00055C-5P; Thu, 06 Mar 2025 10:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVd-0004Yj-LB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVO-0006m6-9I
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bdf0cbb6bso4720465e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276284; x=1741881084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJRJRFRnJa+ZW9IwcRJGqVmfoDv1z7czBgbZuXOAeZE=;
 b=jsMDJvmppOvm+u/G4wCcw21Iu/XWMJXC/DQK/cLZHVn5nNaGmTCdFJp62xBHvq7JMZ
 7RMkWtcwsoq/Y/b8813u8Cv2Uz9UtxfrW7nBZJw72lHwYHUmyElFpsLLju6uQBKu5idr
 gfhDbIL4BtC1Luys2k5tnlSNqSWl9+delSJi7J7bS/mzgu7Oi4DCohf4bRkFlOLci+6T
 PoVydGiFxEU01S/rP4WZU1ETALj0jwOh8Pf8FBpE2Rir+RjwKuW6enluf0GvzOlUhqzF
 K1Dsbco6WB3uq1Xp1hXUb1gw3OTD9F9CEpDuQqU0Q0IOjkB+b848ceQLBlm1wKavh7Ai
 pQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276284; x=1741881084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJRJRFRnJa+ZW9IwcRJGqVmfoDv1z7czBgbZuXOAeZE=;
 b=Uj70dkcEDzOPKsd8HnSqzd0DTUpx0Q7yevSODfsE3xUiWHWAtib2Zp//HOV2NLjw7R
 ny6lyCRpqZWV+DNERPbbPMe+gQj1i5Rg0JZPUDjJrMUW/6+vGu48STZEZMKzQAM2kXPf
 Ebyl4d857ihl7XIYecmpTSWJkFjn96LCdCZRbSa4RGEKWSuL541JLtmaneWHoCikILQD
 newKoKnxAbNjNEb75t/TvHBswTyxQjuR9KebB4l20fv10YF4OtKtDYFdlyfSZHvyZFXz
 ujJkDsckXqDgz8wf4xft5CTSXnF2065+VLBRLo3rLeLiE49LYQEPEtdrBtkdPHcIilDK
 ENUA==
X-Gm-Message-State: AOJu0Yz6LOT/ECxnCULVRvgMD5aFrZxmSCa21+Tx/C7aymVOmlqft/7K
 w7l8uonNBbx4BYHvkvLjgj0o9kyh2mQUnfIZalUe75OaFq7kr3k6f7WCyCU7yAXe34AackozxiK
 BcVk=
X-Gm-Gg: ASbGnctQPunv1kkl2wMMI6SjydVkR8qZHbFJyAew1sC/7kKPi728s0diJuPaGxACOzx
 0I0TgcwvqC7fKWloU8Bmbm8Wqat02FSV4wdiIKXj1Tpsd1gmF3Hh2zcFQCB27i/6qIqG/15Wd/a
 i1T6Fi6Io/i2+5vizk7WI0wNhymSSBhe/9a6maLDAKHdxFRr+BTWYEtJA/P5hDEcwbVM0nAz+L8
 uOiOQ9hHpwEpFIAABAuGJFEtPEJcoy8fjZb/tyK1c5ei+Zra5KxChHHRaHIZ8pi4kGYQwuBOy+5
 tfd4qBbo4gA+yaNwXcQZm/Kumyqx50T8CEUnd55Hpv6oZWpFcNpHeahmR1OkQ+6i+OQGBOLZ9TO
 LS6VUPdidai4yOcugbAc=
X-Google-Smtp-Source: AGHT+IGt+K9pt8CaHDgzW8PJDc9ps+vTGPmB2kt48Xx5Y7VDF2v7XohqSfreBcNwYGZiqCMzSm2n2g==
X-Received: by 2002:a05:600c:35ce:b0:43b:cb06:d768 with SMTP id
 5b1f17b1804b1-43bd29b3b78mr53677215e9.20.1741276284404; 
 Thu, 06 Mar 2025 07:51:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c019557sm2508708f8f.50.2025.03.06.07.51.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/54] target/riscv: Convert misa_mxl_max using GLib macros
Date: Thu,  6 Mar 2025 16:47:32 +0100
Message-ID: <20250306154737.70886-51-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Use GLib conversion macros to pass misa_mxl_max as
riscv_cpu_class_init() class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210133134.90879-6-philmd@linaro.org>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d4f01965dfa..6db2252aac7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3056,7 +3056,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3158,7 +3158,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
@@ -3167,7 +3167,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
@@ -3176,7 +3176,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
@@ -3185,7 +3185,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.47.1


