Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A1C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1V-0006IE-1P; Mon, 28 Apr 2025 03:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1B-0005oy-5o
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J17-00014e-QJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6Zn8Ycxt9m4HQIPfPPXdLt4ZQlCT8O16LMuUi8rxN0=;
 b=ZtkCnSUVZK4NGCvHvoNd40DABIjFkU/GDzMPf2E1sD3QTVbIh0lKR6K62KACcViLW9cpKt
 TCoZ2zrZEoHMRlkfLkxGDU9tVKEfuCjDa0Yuu7QBkqmhrp869FP86rHtaEvATwKO4I8ji2
 DM8zSt2VPHEStwkXDC4Xr7E2yp53uE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-0Br7sq_COvaGJLQg5ExEVQ-1; Mon, 28 Apr 2025 03:35:02 -0400
X-MC-Unique: 0Br7sq_COvaGJLQg5ExEVQ-1
X-Mimecast-MFC-AGG-ID: 0Br7sq_COvaGJLQg5ExEVQ_1745825701
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so1887362f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825699; x=1746430499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6Zn8Ycxt9m4HQIPfPPXdLt4ZQlCT8O16LMuUi8rxN0=;
 b=TkgSoUblRR7FAZzhMiZSlhh0AiEuHWViCpscdxKXD2vvSiTZ0WSPy7IYVC005jKuXQ
 S6XmsmGao8gYaKYuZeFPYNhKKK7o0Nsosnp/V46g3lnqVrXdXhlZdhmeyJnmQi3xr4zC
 +YnbkF2FHlMq6MXQPYclfriRvqwEPwBrxAR0z5CgTqmVx19Lf9ZUYsbA1Ctn6C9Rfo4Z
 L5XbABnD2VVXTm156Wvr490t/CwPha4hJaMi+bESoBNWQek+MhmbKwqJBF/LehH12V07
 hhuEfchJyVAQOAu0EDwVUYTqB53VFiBLcFXB1fyS32NjxoWTVVFOMtHfz/RJ7T6/+SwX
 jbmA==
X-Gm-Message-State: AOJu0Yzg9+7h8mvAAehheETw/5WtE0Rv3r4f5gs1kq09Hn3Yok09+OsY
 h5qWOBRMF5HHrcoknWdmXRkgDOpc1v0Pan3KnZfsK+EKiCYyvaRguCu5i3zDf1/Gujq1qakujrd
 XfcsqL3QcYqhpZ7QmPoD0sCHM7oFRwnHUkSkp/FgVUzqK35m18BM435fbJagr4QwVIyZLDOjVlb
 zGHNgmPhJTggiKUl8KqTso2qSxJlYSEddNaHL9
X-Gm-Gg: ASbGncubPG0c3uAVHoyY0LZW9s6Kl5L3MwgYYRMlrZNZ2zXVzz4gGO/0XB57WgLY3QN
 oBz/Xl4t7qNe8LOzqd5cjowJnmUyyxaXCUd253oUps3uAuhdA3cNEpNUWNk7IMAMDlaahWqnqch
 uM780TmwftXoYbLkDt1VGch7HGbUoccqn7z7yj2Bl3qUWWVGqAC7gePh5MYve/9/bqF7hcob2pn
 NmQlEBHwiznQo8do+gzPEQWhXDvnXnWfmljbsrNjvoRKsaDfEmFaPyLrazrjn5g4FKEHOYWB1Yt
 Gh5ChCNl6MHsiEc=
X-Received: by 2002:a05:6000:40c7:b0:39f:d13:32a with SMTP id
 ffacd0b85a97d-3a074d4f2c9mr7541152f8f.29.1745825699535; 
 Mon, 28 Apr 2025 00:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnT/KhmWjOxZivM9GeBU+LCLFSK6yzJ8+S5P86UeLyJqhCGBMUZ8aVRBiylSy5bYpP3mUYaQ==
X-Received: by 2002:a05:6000:40c7:b0:39f:d13:32a with SMTP id
 ffacd0b85a97d-3a074d4f2c9mr7541128f8f.29.1745825699142; 
 Mon, 28 Apr 2025 00:34:59 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccb8e1sm10426955f8f.59.2025.04.28.00.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:57 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 06/26] target/riscv: move satp_mode.{map,
 init} out of CPUConfig
Date: Mon, 28 Apr 2025 09:34:21 +0200
Message-ID: <20250428073442.315770-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Paolo Bonzini <pbonzini@redhat.com>
From:  Paolo Bonzini via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

They are used to provide the nice QOM properties for svNN,
but the canonical source of the CPU configuration is now
cpu->cfg.max_satp_mode.  Store them in the ArchCPU struct.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h     | 14 ++++++++++++++
 target/riscv/cpu_cfg.h | 14 --------------
 target/riscv/cpu.c     | 32 ++++++++++++++++----------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4f3668012de..97dc3ba7811 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -498,6 +498,19 @@ struct CPUArchState {
     uint64_t rnmi_excpvec;
 };
 
+/*
+ * map is a 16-bit bitmap: the most significant set bit in map is the maximum
+ * satp mode that is supported. It may be chosen by the user and must respect
+ * what qemu implements (valid_1_10_32/64) and what the hw is capable of
+ * (supported bitmap below).
+ *
+ * init is a 16-bit bitmap used to make sure the user selected a correct
+ * configuration as per the specification.
+ */
+typedef struct {
+    uint16_t map, init;
+} RISCVSATPModes;
+
 /*
  * RISCVCPU:
  * @env: #CPURISCVState
@@ -514,6 +527,7 @@ struct ArchCPU {
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
+    RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b80e03c9ab..8fa73c8a07d 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -21,19 +21,6 @@
 #ifndef RISCV_CPU_CFG_H
 #define RISCV_CPU_CFG_H
 
-/*
- * map is a 16-bit bitmap: the most significant set bit in map is the maximum
- * satp mode that is supported. It may be chosen by the user and must respect
- * what qemu implements (valid_1_10_32/64) and what the hw is capable of
- * (supported bitmap below).
- *
- * init is a 16-bit bitmap used to make sure the user selected a correct
- * configuration as per the specification.
- */
-typedef struct {
-    uint16_t map, init;
-} RISCVSATPMap;
-
 struct RISCVCPUConfig {
     bool ext_zba;
     bool ext_zbb;
@@ -195,7 +182,6 @@ struct RISCVCPUConfig {
     bool short_isa_string;
 
     int8_t max_satp_mode;
-    RISCVSATPMap satp_mode;
 };
 
 typedef struct RISCVCPUConfig RISCVCPUConfig;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 43ccea72e8d..ab6ee39d304 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1193,8 +1193,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.satp_mode.map == 0) {
-        if (cpu->cfg.satp_mode.init == 0) {
+    if (cpu->satp_modes.map == 0) {
+        if (cpu->satp_modes.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
             set_satp_mode_default_map(cpu);
         } else {
@@ -1204,7 +1204,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              * valid_vm_1_10_32/64.
              */
             for (int i = 1; i < 16; ++i) {
-                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
+                if ((cpu->satp_modes.init & (1 << i)) &&
                     supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (supported & (1 << j)) {
@@ -1218,7 +1218,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    satp_mode_map_max = satp_mode_max_from_map(cpu->satp_modes.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
     if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
@@ -1234,8 +1234,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
      */
     if (!rv32) {
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-            if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
-                (cpu->cfg.satp_mode.init & (1 << i)) &&
+            if (!(cpu->satp_modes.map & (1 << i)) &&
+                (cpu->satp_modes.init & (1 << i)) &&
                 (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
@@ -1323,11 +1323,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
-    value = satp_map->map & (1 << satp);
+    value = satp_modes->map & (1 << satp);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1335,7 +1335,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
@@ -1343,8 +1343,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    satp_map->map = deposit32(satp_map->map, satp, 1, value);
-    satp_map->init |= 1 << satp;
+    satp_modes->map = deposit32(satp_modes->map, satp, 1, value);
+    satp_modes->init |= 1 << satp;
 }
 
 void riscv_add_satp_mode_properties(Object *obj)
@@ -1353,16 +1353,16 @@ void riscv_add_satp_mode_properties(Object *obj)
 
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
         object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
 
-- 
2.49.0


