Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A36CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vor-0006HP-TA; Tue, 30 Sep 2025 04:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3Vop-0006Gu-30
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v3Vod-0004P5-T6
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:34:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so5809488b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1759221261; x=1759826061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=WB9v1EyMSrB+cW8b0dzIRTdgSG4fnLYyV94vhTE4ilYxHaPov7HE/DNghjFfyUn58o
 XXA9W3fSODfccnlvHQP2YWNhNlRzh4Hes5rIl2euqusajFBWKvVB6XSu2Xase0EhJ+GN
 d1DtB1MkSzAKAdfEeCaJQyFXIsOf/pkmTo1yENocqrc6ZdHwzXx42QtSjKfZJ4GeXkBk
 y3KMHwo5WKGPu/I16r/qKkdUqw/C3q65izIVhVEmr7xBrC7T0Xd2QDAGk+iTMbQqaq4n
 wAMI8LmMdu0gHXR++rDOAX0cd9W5HFbss8fDj95+VCsIyA6TQ3sg1Zt2wi4z+vi0s84P
 msLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221261; x=1759826061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYWfU3Ybv8UMfXDoLYIZExvngPG0XH9qkihRnX+Zfvs=;
 b=toZIuWgIqBV1a6qZCzwyyMrBr9OOa7YKT5rsWGSqdsco9J9osE8001+hEqtPVJnw2M
 BsrGiw+7OGOWlv6EG6AzTAVNL5KihRQXcJhra4p1i1YLaddJXXp6jnFt8YFNPh0jwuKI
 GjRIrF/E73i4QSvzmS9BQbZBWavNre2//groAWG35Vi98hUODw6haNHxkpnW2bcqdFUi
 bz6fcc8Zu3+5Gt025kiXpYSbd5xVRwQXQwF6AXlZjeKD/eaAps1qRSBLmOX4bbw7O2D/
 lDc98QrCEJOxOyDK5FG4aYLWRRz8KnRsh1+EhWDssfXXQLj7PcA5QUGADYXsbcXCo9iC
 H6SQ==
X-Gm-Message-State: AOJu0YyCSlyPeiARJEjIp9Ajt+LLfLIbOQav2HWTgktNZfIDUiPnZdQy
 V/93zqv3wUkkHyYx6FYKsDG+v+895d8JQ+qOanMPtPq/ZwGrgM7TNZoZV6T5aqpIbiRLgewkAU/
 0XcFromBhg0krWg69iH7m0uIWabrQ49ySbCTEeF9wMWowjTCHQ55dOisQ2szqP8Kt/GZBAF6suI
 ElPSRI+HTMjNQ/BzMqxTrqzGUPkTSE0okdUdA2mJ3d
X-Gm-Gg: ASbGncvs2U4DXSLT8iZBwx/rPKFmKRwekehnGSm0Uc0WNQcrB/QbiI/6Eculfg57WlW
 BQKmD17dUEkiaGgnihiKVuhzMPaJAxZeHq6bN6AG8kxBVvpsUDcNx/zfWFSWnqSD891sRSW2aMF
 e8DDnT1/YgRuaIHmhOjVWYCoNgMOJ/cGrI720J5NCzDhAI4uaVNMOsqgtPk/hpeL2YaSH5kfpVC
 yElmMb8xPVHHI2rgGqBxtoWEuTScgH0ynlLU2wEFbG77zw/2bcb9c20pcHD4z69/FdY+Ks576os
 zEFSFGS+hlxkDgJiHss0HeqzrjqkmxGdqYNUkiDWWxFTeGsJFDcejAOvcxKikTSY3DztGXAh8RS
 P3fObVJMjEPO9DBReQlvxSHM9SrMDS4EM1J6yvQOt5YEXMOZ6W8VGD25iTx2yfwHWTiZy4dZZfx
 e41NHJzbvv0826SCj/0nDc
X-Google-Smtp-Source: AGHT+IE0Pm3cld6n7GtH/v3Pr0e5oFX1HPpvIvGf8N9Dk9vKysNenvlvrRJJ1mz/utB0iHYd9T1r3w==
X-Received: by 2002:a05:6a20:7349:b0:2cb:5f15:ebf3 with SMTP id
 adf61e73a8af0-2e7d0daec75mr24610851637.44.1759221260555; 
 Tue, 30 Sep 2025 01:34:20 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b580bd86c4csm10340089a12.14.2025.09.30.01.34.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:34:20 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/2] target/riscv: Make PMP granularity configurable
Date: Tue, 30 Sep 2025 16:33:58 +0800
Message-ID: <20250930083359.27637-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250930083359.27637-1-jay.chang@sifive.com>
References: <20250930083359.27637-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x434.google.com
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
---
 target/riscv/cpu.c                | 39 +++++++++++++++++++++++++++++++
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 3 files changed, 41 insertions(+)

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
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2c2266415e..04711f93a2 100644
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
 
-- 
2.48.1


