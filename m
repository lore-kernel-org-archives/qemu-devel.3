Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E88C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTuO-0000PH-1L; Mon, 10 Feb 2025 08:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtN-0008Mb-9s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtL-00069K-Gk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so8022945e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194321; x=1739799121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBCJMHcPe/iIrLZobFxGzbZ4tBIo/mQI53ey/01FGoU=;
 b=NHIEZ1oG9xHQJZvNKfpPFmXvLMKsWjMK6p0klRYQwaCjvJD9FGn84BOj6BEk6VT8vz
 KxSxnqcANMA3xg3vtKYMQzlW380q2FQClUQDAmCsmFoVyD9d+l7p/SQUoza6h/8PAXk1
 xLgPACTWiCKrL0ak4Fr3kzXNa0KjYV1XQlhUq+PozOwyC4yyJZPNOJ9/B26vvXarqCUI
 IoxrI0Hn2SsSyV46KbXRglqs0HVepafF6CLgWvZFiiPjgS1G1FNPKvJ1yqoW+3/yR4rE
 Fu7pyTSr6trFUxHX7TlMklTGNSP+tOzOSnAL0yepETpOX6/7/cMHTgp3m+YYijY8YYI2
 wpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194321; x=1739799121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBCJMHcPe/iIrLZobFxGzbZ4tBIo/mQI53ey/01FGoU=;
 b=XCFNCs7u3m19Rrd8vv0uYSZv9GNwpN9EYv4UL+xen2fbCIj9eNvzxS1/rAV2Whsexf
 dRn87Ud6/MHLry+3ID5lki+O3Tv3OdqRWk1ofAQKDeQfMw0TeRyV2Y7gA+lPeqU6kTau
 8+jfCCjp/V8JzM/3m38E5HMh/YgzRkjwkv8z9hWT3RqV1aNpYO4zDjNR4qZ4WSzlccf4
 fzg9Bmkfip4s3AQwn6htoNajbJLxqv8qJRtAoaa+mX08eeN1EZwmpmstADHKeHHgCROt
 /XlZ6uKq7Ke1zzzubCvVZk1HOjdH0VcS61bTcCzsFHoYyn0Wj5S5k50KAYuhaAduopfY
 Gunw==
X-Gm-Message-State: AOJu0Ywld7kBXZtw2uBTJYqaAMnUAWVqmEHYln3gV/OweMH2RW75xJhT
 ABpNQmpr1dR0f+IuetsrJjBzXw20chnWvdXdksa2bVk7W/cIL4xplwLe/VZivNHSgHh9q5H64Ao
 tBiA=
X-Gm-Gg: ASbGncuAiLBKsOIVTKRAuOb8JNV2ymp2rOcKdDFM/DPYZpacsitHlATEeiVRl3hPcQq
 oEykDy4WC1jnYkUiVBINfh5c+spLBdLcfPDzmhvz3Zaubj6RxpxN39kTbA/WeVsAkyl5tQfDmV+
 fT+/CDLqzcAhPelsbt/a3L3WwT4U9IAvGpdsNH9kV17tCSIEAF82ykXCohg3al/jidZ4+PZQd8u
 5kzKhiKajkQj9kwiA71CqPlcM+S5CGQ2+NaFhuhEfIlHkZJhW4B19IiE9lkXhYZAflxjQAeqcIf
 Bash/xlGoSRdj02nod96l9UMFZe4l6UfAeDhI3D4oRT1mZIgACspgreHsADQ5p8vh8ZFVfo=
X-Google-Smtp-Source: AGHT+IEU5FsNZzQMa2vEa8/c4WEpB801JI1guLIPPGa3a2HkdwMJCJJSBxMEx8juNJgD77WxiYAYHQ==
X-Received: by 2002:a05:600c:3b20:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-439249888aamr119936205e9.10.1739194320884; 
 Mon, 10 Feb 2025 05:32:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d7c7sm179323265e9.14.2025.02.10.05.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 05/11] target/riscv: Convert misa_mxl_max using GLib macros
Date: Mon, 10 Feb 2025 14:31:28 +0100
Message-ID: <20250210133134.90879-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
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

Use GLib conversion macros to pass misa_mxl_max as
riscv_cpu_class_init() class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: qemu-riscv@nongnu.org
---
 target/riscv/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f3ad7f88f0e..9fe1b23a297 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3057,7 +3057,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_CPU,                           \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
@@ -3066,7 +3066,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
@@ -3075,7 +3075,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
@@ -3084,7 +3084,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
@@ -3093,7 +3093,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.47.1


