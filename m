Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDF6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrD-0007eh-Og; Mon, 12 May 2025 05:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqt-0007au-1O
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqq-0000gm-3a
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Pog9+CcCvTaueB7szePLyjoe1mtNsA/WsjKjKhQNgk=;
 b=chmZ9fodT8tWvreT+mrPyZxvq4zieM6cDS8pWz07s0eTq7q7gMGOR3t5QeEOzUQys3Bc1Y
 TDFEeFftZ0F+cO1eZ8+g0XcOuaZm6vgkRaZ5rSm7cLSgc5RVgizBD1jgV8thLPOYdSDmLF
 js91/Vjo6fnML8WAKSpySfxR4ItLzvQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-HhMkKlZBP3CLauDblgNpnQ-1; Mon, 12 May 2025 05:53:29 -0400
X-MC-Unique: HhMkKlZBP3CLauDblgNpnQ-1
X-Mimecast-MFC-AGG-ID: HhMkKlZBP3CLauDblgNpnQ_1747043602
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso331416666b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043601; x=1747648401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Pog9+CcCvTaueB7szePLyjoe1mtNsA/WsjKjKhQNgk=;
 b=ekT3jABsSciwcNzDCnZ9mqJx27yObglbzOByXKdy+/u0k1iHnj8D1FsTmWj1ufGxJM
 qHxphyfnilamtP3TvTe5AKAzZ0q1Btf4grkXFl6+plJuKoJHxvDhx5ozlZ2VCfCd7eHI
 NQZa4N0G1hgy+Xy5tAWSi9ePtB/VRqqTG3bqc7/+tKB38syAh7a94Nle6pisAc9eNd82
 CzfF42Zm9dzi/+FWcAlY4B+gbGzp7/BB0TLddJe4u6leuclR1os49jvpP0sjenYKkCiD
 wXYPW2wHT1rZ33V9FTzx/5zJeCbP4xAFEO6xZL6MD/aLfSBxWsBQkawuS4ZP0Tn658Vw
 sLzw==
X-Gm-Message-State: AOJu0YywsgSc4Ewn6FtouiBNcPCu4A4k+qFZvzEXItlvAFjok06oCvK2
 jhN26ALV/qtZEDBUZVQayzdGQ/GEWdyhYKYUPMIvWMoq/80CUauESuAcPe2TJ0S6om1g1K7XkLy
 WDcn0aeERVQaf0wS8PnHH3dR4kHEw6p9BlA1d6xk8OFDXHbLwtTizhK3NOTFBGj/WbMF+IAklPl
 7iEVC31mF8B8sen7TOLFLB2lZGMOoCoTGyHSVD
X-Gm-Gg: ASbGncsHF2qzL2lFpww4/MVCCucKGcKGGb7XY8yRnn/A6aHOaq90C89pgnfIGeQznPR
 s3rwqxjBuFw80ecNJ7ams5pNbjuIO+rWRVUISXWdKZVuED2Z0P68F21j4rij/c7TsrPuO0JB7iy
 rh9aXaAp+9RRPt8peyUbHnOGwvrgbGfbjzFHEWokn1E/sIIT3AlWg5HuB33vDwrxcBmiOjs6JWh
 AfZSJVLHpypvlRJXvA2DTQhTs1SlUNVgfY0iJq0UqHsMsc5sivVF/yQ+fmnSKxj/az9mQJkdUpC
 MNDDiebp9whw+i8XAoj0n8hwcto6T2MihU1jPyM/9eg1+vs=
X-Received: by 2002:a17:907:dab:b0:ad2:e683:a77d with SMTP id
 a640c23a62f3a-ad2e683b1b1mr169791366b.55.1747043601038; 
 Mon, 12 May 2025 02:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYGBuJMj7t3ta2UPOhlO9jfBXDQDSBlTVM9HlZYb8D1rWlFmLQrlcLzT2RsqDvnP7LbXz7w==
X-Received: by 2002:a17:907:dab:b0:ad2:e683:a77d with SMTP id
 a640c23a62f3a-ad2e683b1b1mr169789566b.55.1747043600540; 
 Mon, 12 May 2025 02:53:20 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad220ff9389sm541482866b.89.2025.05.12.02.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 04/26] target/riscv: remove supported from RISCVSATPMap
Date: Mon, 12 May 2025 11:52:04 +0200
Message-ID: <20250512095226.93621-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"supported" can be computed on the fly based on the max_satp_mode.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h |  4 +---
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c8ea5cdc870..8b80e03c9ab 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -29,11 +29,9 @@
  *
  * init is a 16-bit bitmap used to make sure the user selected a correct
  * configuration as per the specification.
- *
- * supported is a 16-bit bitmap used to reflect the hw capabilities.
  */
 typedef struct {
-    uint16_t map, init, supported;
+    uint16_t map, init;
 } RISCVSATPMap;
 
 struct RISCVCPUConfig {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 48576bff92c..0326cd8e563 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -439,14 +439,27 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
 
-    for (int i = 0; i <= satp_mode; ++i) {
-        if (valid_vm[i]) {
-            cpu->cfg.satp_mode.supported |= (1 << i);
-        }
+    assert(valid_vm[satp_mode]);
+    cpu->cfg.max_satp_mode = satp_mode;
+}
+
+static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
+{
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
+    int satp_mode = cpu->cfg.max_satp_mode;
+
+    if (satp_mode == -1) {
+        return false;
     }
 
-    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
-    cpu->cfg.max_satp_mode = satp_mode;
+    *supported = 0;
+    for (int i = 0; i <= satp_mode; ++i) {
+        if (valid_vm[i]) {
+            *supported |= (1 << i);
+        }
+    }
+    return true;
 }
 
 /* Set the satp mode to the max supported */
@@ -1171,9 +1184,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
+    uint16_t supported;
     uint8_t satp_mode_map_max;
 
-    if (cpu->cfg.max_satp_mode == -1) {
+    if (!get_satp_mode_supported(cpu, &supported)) {
         /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
@@ -1190,9 +1204,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              */
             for (int i = 1; i < 16; ++i) {
                 if ((cpu->cfg.satp_mode.init & (1 << i)) &&
-                    (cpu->cfg.satp_mode.supported & (1 << i))) {
+                    supported & (1 << i)) {
                     for (int j = i - 1; j >= 0; --j) {
-                        if (cpu->cfg.satp_mode.supported & (1 << j)) {
+                        if (supported & (1 << j)) {
                             cpu->cfg.max_satp_mode = j;
                             return;
                         }
@@ -1221,7 +1235,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
             if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
                 (cpu->cfg.satp_mode.init & (1 << i)) &&
-                (cpu->cfg.satp_mode.supported & (1 << i))) {
+                (supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
                            satp_mode_str(satp_mode_map_max, false));
-- 
2.49.0


