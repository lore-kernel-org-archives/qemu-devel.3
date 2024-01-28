Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2785C4828A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 08:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU0WM-0004Zi-Gt; Sun, 28 Jan 2024 03:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0WJ-0004YA-45
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:28:03 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU0WH-0007FP-JO
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 03:28:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d780a392fdso14068425ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706430480; x=1707035280;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OSaYglwzeOCnqtXdeYAE5QlmXuvdakxdKkKIO+iGRFE=;
 b=X51Xv5y57tG++HSiAxINcm8f8SoZtlhSxmhnvCpHPhbsmvgVrUrVK6CXDjOevkKUHD
 8KGLUJcJG0R3MO4vxcFPyJ+WSteX9NJvWqr5dwIroA17gR5H1WM1B2rD7XXx9LY9pxxM
 2QEslxidSaa9lRl/N5WCqWbPP9iyHtBrG5A6R+e47XSoSfSlvhnHmXMO5C7k97b3TULj
 sXAGCjOKNDpMvBTD7fwjh4KAfvp0wbP3/b2en6tOmDeJ2uyUzuA7K7/4dqGkfla5a5VM
 TWChCHz58xHhNgrcpZahJrxPx8gbJUwvfvhPShC6YNenhSltay592xIslSgPihW6FV4E
 mC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706430480; x=1707035280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSaYglwzeOCnqtXdeYAE5QlmXuvdakxdKkKIO+iGRFE=;
 b=Ckhg16z953V8XPI7mjbpwzYPqjEggzzBHsD1/BgVNjaffJ5zx5qIScI9DFs1F70h/k
 QdpYW56xZeIEP0HAa/xSfyUf+UpxjxYFB0bBC8tjZ+zzNtCejQWC5idUpR8t5cW3eg37
 k53CJ5ap8lOx7Gf/6H1joB9jIrw4SqQu76kjF6gXyHNwEdeQwHbMT7WCJp3a+X8jq5QX
 EKy38C7L5t1wAM7MgAZP/XgUDFFvzamrqKZWjBBXg5izeNN3+gL9cJZeS/kkgLJ2LnFF
 csoKIrRj4csifgX4vfztd58EFlE1hr6T8TIkpRLhh91gYcMDE1qdO2Rqsapayx/b4US4
 pDEw==
X-Gm-Message-State: AOJu0Yydy5INkRvwRceN7f5J2soMxkdLJltl+Z3MQkvQEyn/ZY/Rji4q
 WXiVnnNff0mtQ76lK2jLq/x4rPa6YvUAMXKkI6mKH3zjsAGEfTaurx7OqRDYVS0=
X-Google-Smtp-Source: AGHT+IHxSxY35KYqzbIGm3oyyCwSFXonE+wUMmJdPw6XE+fMG672SGzRgmczGsGDDjYFxp99hlun7A==
X-Received: by 2002:a17:902:c409:b0:1d8:d745:85a8 with SMTP id
 k9-20020a170902c40900b001d8d74585a8mr340089plk.93.1706430480174; 
 Sun, 28 Jan 2024 00:28:00 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 y19-20020a170902ed5300b001d8b0750940sm2129923plb.175.2024.01.28.00.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 00:27:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Jan 2024 17:27:41 +0900
Subject: [PATCH v10 3/3] target/riscv: Validate misa_mxl_max only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-riscv-v10-3-fdbe593976e9@daynix.com>
References: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
In-Reply-To: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

misa_mxl_max is now a class member and initialized only once for each
class. This also moves the initialization of gdb_core_xml_file which
will be referenced before realization in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 21 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4b742901e76e..4425bee1275e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1292,6 +1292,26 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
 };
 
+static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
+{
+    CPUClass *cc = CPU_CLASS(mcc);
+
+    /* Validate that MISA_MXL is set properly. */
+    switch (mcc->misa_mxl_max) {
+#ifdef TARGET_RISCV64
+    case MXL_RV64:
+    case MXL_RV128:
+        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+        break;
+#endif
+    case MXL_RV32:
+        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int riscv_validate_misa_info_idx(uint32_t bit)
 {
     int idx;
@@ -1833,6 +1853,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
     mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    riscv_cpu_validate_misa_mxl(mcc);
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 20062acd0f0b..df198ee3a312 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,27 +268,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-    CPUClass *cc = CPU_CLASS(mcc);
-
-    /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
-#ifdef TARGET_RISCV64
-    case MXL_RV64:
-    case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
-        break;
-#endif
-    case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -935,8 +914,6 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu);
-
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;

-- 
2.43.0


