Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC3C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMO-00034W-Ml; Wed, 12 Feb 2025 16:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKML-00033L-8d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMJ-0000WC-H6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43956e3863eso1882075e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396005; x=1740000805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQTyyvM1Ut/4hxqH2Y3t7FYtP781gxP4U1LmrtAk4dw=;
 b=cLhJzJL735ge8XUXbknOn8J0mhEoSumK9p9Pn+8tvlArM8i/HDOTpjbGwN17cjx8Qj
 23TpxyEer0hY1x5/YbL8lQznshno0FaOEr5/RcjL4XCzAaz3v7uYNLlhMXqflYqwIgVU
 jWKN42mKPS1epmhAJ/S3Okw4CbZNLWXAZ7WZDAG4DAnrR31RZ+4heTPaI3CfESCqqFal
 AFb9Cw26JUvJYjd7Vm0Jo+xQE/P7QpWkNQEKGIrYaswqIaVeDxRcxhvMCvJXFwPkbkEf
 SRIaQayXULkmoncSxX5WP+34DzHovIC8a8n1QVPDGigsvvnZBFWv2TBGCr8zctH+9RAE
 k2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396005; x=1740000805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQTyyvM1Ut/4hxqH2Y3t7FYtP781gxP4U1LmrtAk4dw=;
 b=F+JIcMCaqHHM9In0yceNAfc11Gnm7QYwa0p0Pec47+QPxW0Yvdyy8b6M1oetIQANRa
 IGjH3zGVE+ig89wqoKKXOkHE/OWCQbdF90W3iuaQWY0tQO5iec2/4bu8dLd0yjvuNqYa
 wCb5bw7hjwJYeB0/NMBpCdTVylacGwPQjZNNuV0794WrX6wXu5rI8aSV+2InwOJFT5R5
 rKXx4wn/fWqvwR9fJq8Jh0wY5zqcb5mofSWkrZuAzpFwouroANso0oAx6xN9zjXLDZEz
 /5XEme323jOR2lTI2qAq0yvYrKj/Won+uO1Ob2PMlWFF1raqNr4KskiItGoez74xkOQx
 QWSA==
X-Gm-Message-State: AOJu0YyWZ60UZdzkuXHhvwHnrsnpgjq1BzsWkcmIuuzP94anryn9AKxL
 5k8qMQF1o8eNTWDLb7LyD3E7BI3m+UNpqR/HLMKCkTpgVW3pmKsMFUtBUah0TXVveStyTX/zriJ
 CyAE=
X-Gm-Gg: ASbGncstILCx3gjUpMEEaEGib9WX9bXRMQNKGRDUOBEqLrNM/us3hMtlkPf6oJd76Bm
 U04jcKLY3dksw1NRxZsXtHspt/WZ5WMNFC4eP0S2v1Twfjfye+T/LLyyTJ/5DIqPgfsr+z7zn5f
 EXO6IYScaR6CYmjMbsoxnnbuVDx1oYaex2a9cGOR3F0UiU6TrV0xYOMJ5xO2JkupufGIUl2qZM2
 DsB2Mf7Ad/No9Uu+5ukdE5szMmYWjM6/eul+Kuj6WnF8/x/Y1BUPGkEdI/72i0U9Cn1Djw9a48H
 V+xVzMaAQ2hqdfKU4w8jQZQpNH/YEHlt9qi/yi9QxWWbYmbBniKP3M4FVsPrEDjNEQ==
X-Google-Smtp-Source: AGHT+IHS58kwk3oWB/IegAxEQVFIQnKW/mF08yBPC1PsW5/x3xsIFn7Y0QyCV5m7ILTw+xOeGiuTqA==
X-Received: by 2002:a05:600c:3d99:b0:439:614b:1c15 with SMTP id
 5b1f17b1804b1-439614b1f2emr431715e9.13.1739396005610; 
 Wed, 12 Feb 2025 13:33:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a053fb3sm31371155e9.16.2025.02.12.13.33.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/19] target/riscv: Convert misa_mxl_max using GLib macros
Date: Wed, 12 Feb 2025 22:32:37 +0100
Message-ID: <20250212213249.45574-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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


