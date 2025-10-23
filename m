Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B727FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC58T-0005AH-AN; Thu, 23 Oct 2025 19:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58R-00059t-F4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC58P-00083Y-OA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:54:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-273a0aeed57so31182125ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263660; x=1761868460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4kt999Rj3wH++qWMTPygGhomVBAKD/G/hJMFgOA/vI=;
 b=Tc9VTZOkh43zd2zGeTHTUozp72Q6LvQW7lF7sNLX0H0oSoA+48txlEX7EndGOqB1BX
 hmGTqMZRDDj7a/lNj7fyoJg1fxdhCnFr7e2aV6F4Z3vZOgXMcc3evN94DYIYr1KOtr4p
 1Hly+1SDz4niwEpsDgewu+5AwkLCzEQ7ZRWW7vHNYCO6EeMLGgVqwVPnQ2NbQ4Q7XzAF
 S/wfV4yhhqGMeW9VzG01TMYL788RGNW5V8+2TQe0VKqbgKuredIYWem3IBP/11fcE2BM
 ccmnnxtiaIlhTRFFauxM0PoIihXvtMhbzoLdApBrvjRWV+p0+I1/W69UcCLUquyrbeEk
 hyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263660; x=1761868460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4kt999Rj3wH++qWMTPygGhomVBAKD/G/hJMFgOA/vI=;
 b=GDffnh8/gKVa+JjEBmOc874cCiVspjyf1lBAv05UENnasQhZvKxuSZ1q9tYbD/RJG3
 Ad//9JdakcYgeqgqcK1DE0GcAB6XLuHpxkKs03y0zz0viqXLdCj5yIjzugld01PJk3lj
 4vn61E92rr+Nz6IQfel9ZyQ3nDTZm74VLwCTGFe67GDYczHmx8nJ/s+FFRwfRpkGWmAZ
 u57BWtSDqfwQVAXZOYPQvPWI7eIJHkDA0vhrZvbMSDpk8S5O3O4wWbkNioq4rahIbTps
 NOg9IaHqqXJbSb/G73PskiKwd38vrr6PaQHFyf0E6MaIPlCi0vk82cvF5TLBL0gFAZzM
 6mNQ==
X-Gm-Message-State: AOJu0YzHySvnOYi8SjkqbS7YjilyI1Clc7Q8on/W3vIQJjBeaWHICuwK
 4w5wrfGOgh1nT9Koi9U9VtlIotve6zis/AweVsLp7DYfHEZ6uNLD9gZwCHQOJA==
X-Gm-Gg: ASbGncukaWA1PA8L7qm4I2cl/Cd/ejnaNgaWSK77fsz+maOm5DQFlzos4JWIK0LomJ8
 phO0jyhvb5SiuYJHKyLO+Z7cLm9snYDxV9rIw/UvbIYgnzm9XiLgLNnXyBfCcTcnE11e7N/Tf+L
 j3rCoj54NaJ6byvyV7106/KTu37/NwDL2DX6JIO9MtDjnKIFt9LY9q9hs9V9egJ/wt+HsgahxtX
 6w4GhvhW7mRS2aT2TCBaa86q8bP3xA2F1zNMXBxDJYwtvI6kNf8M7oH+t9n3/gkL3zWqvoa9qp8
 iYHXPaGnW0A1iLCmVV5ci5G/d6s/NgImbcY+dcUSwvlP6pjevXJRgiwxo82+X6q1HPpktKHqc6w
 hM8keYx7SExBZ0wTdyP4M1bpqXlDrNJuOBWoJLa466yLcsHpj3XklMkQypmSFOkS3A+9x04oHYR
 SN0Ox6XsfhzVotzdLXs/6/dRGiyiDjX6C/cHDzH8VL4KXHUEA8IP1ypt7S1Gh25k9dUTNMR2Se/
 9fLgaLeZ3vgHfy/XMM=
X-Google-Smtp-Source: AGHT+IEuLkaG+cnfvKMY9CGi2aGlZad+gNc+5sxwqBolVyvUGt3E+daI+B3EetVp7A3CnZW3mhHEaA==
X-Received: by 2002:a17:902:ea09:b0:281:fd60:807d with SMTP id
 d9443c01a7336-29489db6849mr7480165ad.2.1761263659813; 
 Thu, 23 Oct 2025 16:54:19 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dda7949sm36542295ad.3.2025.10.23.16.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:54:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 24/25] target/riscv: Make PMP granularity configurable
Date: Fri, 24 Oct 2025 09:54:04 +1000
Message-ID: <20251023235405.1865337-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023235405.1865337-1-alistair.francis@wdc.com>
References: <20251023235405.1865337-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jay Chang <jay.chang@sifive.com>

Previously, the PMP granularity in qemu always used a minimum
granularity of 4 bytes, this patch add pmp-granularity to allow
platforms to configure the value.

A new CPU parameter pmp-granularity has been introduced to the QEMU
command line. For example:

        -cpu rv64, g=true, c=true, pmp=true, pmp-granularity=1024

If no specific value is provided, the default value is 4 bytes.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022024141.42178-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu.c                | 39 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c13012442..36e7f10037 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -176,6 +176,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MAX_RISCV_PMPS (64)
 #define OLD_MAX_RISCV_PMPS (16)
+#define MIN_RISCV_PMP_GRANULARITY 4
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..a154ecdc79 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -166,6 +166,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 TYPED_FIELD(uint8_t,  pmp_regions, 0)
+TYPED_FIELD(uint32_t, pmp_granularity, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a877018ab0..73d4280d7c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1121,6 +1121,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
+    cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1606,6 +1607,43 @@ static const PropertyInfo prop_num_pmp_regions = {
     .set = prop_num_pmp_regions_set,
 };
 
+static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+
+    if ((value < MIN_RISCV_PMP_GRANULARITY) && (value & (value - 1))) {
+        error_setg(errp, "PMP granularity must be a power of 2 and at least %d",
+                   MIN_RISCV_PMP_GRANULARITY);
+        return;
+    }
+
+    if (cpu->cfg.pmp_granularity != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmp_granularity = value;
+}
+
+static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint32_t value = RISCV_CPU(obj)->cfg.pmp_granularity;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_pmp_granularity = {
+    .description = "pmp-granularity",
+    .get = prop_pmp_granularity_get,
+    .set = prop_pmp_granularity_set,
+};
+
 static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
@@ -2606,6 +2644,7 @@ static const Property riscv_cpu_properties[] = {
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
+    {.name = "pmp-granularity", .info = &prop_pmp_granularity},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
-- 
2.51.0


