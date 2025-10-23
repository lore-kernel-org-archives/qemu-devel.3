Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CE6CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn46-00048p-1h; Thu, 23 Oct 2025 00:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn44-00045L-2r
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:40 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3v-0001dF-8u
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:39 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso227790a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194185; x=1761798985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtMz//IUF4vYwJZ5SQ+VGQMEdxPCQofn5TrUJkk623U=;
 b=Io2ntmKFlMZr7PW/+GRcsw8fGpLn4hbLpp8ALCVNfsRpKDkudTbJs+QWcqKvVt4r9E
 /E8JpZcAm2qCLF8SE8bW+UCg8YwGGjvLu6TUmOaB7TpeBHuhtkCjXka53l7fZ2Qor7SM
 rdZ4IOzmSq1zeSELfTHb3+3Ci3F9BAIV9VVfpZfO28b8XZ7C80w7vzMDY5nvN8sXiuJe
 G774SrtLUbosAhiuvXInikDdd5IVjDFKIngdhjkEzcC0jLiGpjL3ytK8GrISFD6ue9DW
 Q4qO8sMsU/U0Y4KbS/jGTWWrdgtqflr4unwRrAtzSriWn0HEVS5g8nDkBxOBIdRDFZWX
 v10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194185; x=1761798985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtMz//IUF4vYwJZ5SQ+VGQMEdxPCQofn5TrUJkk623U=;
 b=HRKl+7plBgHbi0uejHGxI7GvvzBFPoT3DjHuQ0UOLAmi0+37lQ9YDrDVEKv422w9JG
 Mg1R+YSyUB6Pdf3j4/zIzdLYG0jmB1bfC8hAHRcpz9WropmzRNQcmlE28ekbsOFNkprD
 9pDF+PyMYtcPMxb7qVN+V7jA8o6eWKwRzgDbGwXQPbIp6Kd9cuciamrAFPQ4rj6LCOFQ
 bjojIPSGqVvSBoraXZTYbR1pXTIFeOHVDcNA7FYroDAllm5sArF2B+icDStA9VIQ3//4
 pns5fBijeRRY6hPVDeCAvPvOYNY4lx3X0M9zfZKAXptThKibaTB6m6S9SdRbbaFy3JrD
 qN9g==
X-Gm-Message-State: AOJu0YzGxzOMKVEoeOHvar1nr+jfKC/udcter8uzhdlMCMSZ8EfMy0Hz
 ewqGidMJJfgQ+G5EptIKTCt+sRsP4pir04n2JSf3OVmbLlvSM005ub+EOZ7tRQ==
X-Gm-Gg: ASbGncvEBQQEPvY6sAzVtfOLINVf9udP/nKuGoE+F8v3FFqsEcXBRqExGqeYdZ7kSoS
 1n4/LcFAN9UPnN/0FRIvxwI7jzLW5ZkR1Bs8HMJg5YU8ppfiBkIS+T0ZfY8xAzBahcTTTpvLtud
 rz5T1pfNU3q84bvfuEbYSe7kgsge2tI+haDGIb1mzRCcoLr5y+0nKoHquiix7L0J4zzIVu4aPMj
 G3hgAV1gMpk/KmoyLQlocu/aAuTx8DwMQhNwFmYVMVLOLHisUNofWbAqwTqnxdyeQHnPO4vzMy0
 usVAICM40jKOjO5979rGC0QeMzXQGxgiLIMQ0gjo8lQeWfyhncapPbd7IOmz9YfL3mb9oKQorOu
 SekfjCjJYmn1TTw0zecRd680AOOnjB8mWRMIcIFPmloQYWuH3NjWvOFUeH5y31DFB776BWrDsCn
 jLbrZFn7OfWvh/AwlvavzQFLEKOtQr1YxVsHX7LXglB3auzuqYPk7/j1PpZTioDyD4h1ZmwSeQv
 capgeWEVQIdEvWILkuBHDVZJFOK3g==
X-Google-Smtp-Source: AGHT+IEHxKsqT2PwXsTKrV9Zn3CYlwhPS2pQdPLLbgdFFwt6nGIxPXlOkgWPhlcvylpXhfyL9PYe9Q==
X-Received: by 2002:a17:902:e74a:b0:267:776b:a315 with SMTP id
 d9443c01a7336-290caf844ddmr292613945ad.32.1761194185270; 
 Wed, 22 Oct 2025 21:36:25 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/37] target/riscv: Make PMP granularity configurable
Date: Thu, 23 Oct 2025 14:35:19 +1000
Message-ID: <20251023043520.1777130-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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
index 00ac947772..44f173b84e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -176,6 +176,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MAX_RISCV_PMPS (64)
 #define OLD_MAX_RISCV_PMPS (16)
+#define MIN_RISCV_PMP_GRANULARITY 4
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 7c624ab677..7729fef3a8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -169,6 +169,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 TYPED_FIELD(uint8_t,  pmp_regions, 0)
+TYPED_FIELD(uint32_t, pmp_granularity, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 77388ac76e..5f63494d07 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1140,6 +1140,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
+    cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1628,6 +1629,43 @@ static const PropertyInfo prop_num_pmp_regions = {
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
@@ -2628,6 +2666,7 @@ static const Property riscv_cpu_properties[] = {
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
+    {.name = "pmp-granularity", .info = &prop_pmp_granularity},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
-- 
2.51.0


