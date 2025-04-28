Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4829C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1Z-0006KK-Du; Mon, 28 Apr 2025 03:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J16-0005ix-Co
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J14-0000xb-JX
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ud5py2rNO88B2JYzzM9hipJgxUtknxMgnGCB/WDq5SY=;
 b=DgsjeUFASS7lbfdgr7nrLbtsF401ory+GHXbhr+lJhLNZ8BaLeyWN9+OtJFiZw+V360wsr
 VMZeTHUFpNdIWx0M/dpMijLD671/qbVJSdRjETc/xFoh3XALoG+MZfRqknv+zWbrQYtq+Q
 TGABqHSjdqYEYM2Xb6JnkyxPvuVWtTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-DXfr9t5IPvGFiXKE3wyC9g-1; Mon, 28 Apr 2025 03:34:59 -0400
X-MC-Unique: DXfr9t5IPvGFiXKE3wyC9g-1
X-Mimecast-MFC-AGG-ID: DXfr9t5IPvGFiXKE3wyC9g_1745825698
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39d8e5ca9c2so2241574f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825697; x=1746430497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ud5py2rNO88B2JYzzM9hipJgxUtknxMgnGCB/WDq5SY=;
 b=EmFFHdgM8deTGS73FFcJAyNO/VhvzxNfAFncrL7Z8pxNQyWzGuh79iDLVO+CRD/F2R
 2HUH4lrV976Edaq1JU+efBv8wl5TpaEC5R43q4j4mmi52paPy8XWP6rb11gfflRAq63v
 Hdn5JrjoJtLl9OUVL+wOOgoZf3wmTsDAP+XQ71W6pfxLb+k5+9rOPxIbs7mpi5IC/c4Q
 7Aa6trTexmPLQ1lzgjN//+rVnbbOuwnwC+t5rdIf6hQjEl+ujFXt5VjhyIcYfWRbAOiD
 ZP3ELj+P5xBovNeMn27br7dsdUnWx6igd+RgivDksW4FiLT1befW+HLc08OtBOgyKlaF
 17+g==
X-Gm-Message-State: AOJu0YzRDMFcF5BvkeKbG7HG59gl08SKLnHcRC6+t3390beOu+GwGMpH
 IWnEBt+ZehigYXAfRa1nrOM4kgU++Yy2G6bW+Es7AUG75yy837CqD3IymAlvkBTmjqeG/C6LZlA
 H4vzPExAnZakf0vuFifUrV5nSWsW7DTccQ/pqixzG4ibHXMZcVjv2Ms6pLZRlRexj3jzy+qHhnu
 7Sw/wZJ68iIMXNA5Y3hEfrF8mxkSEbt6Iux2XQ
X-Gm-Gg: ASbGncuPe8XkXgJlMjwfaylqdKnj2b9+/dsg6aQFp1gtgJ1oPBBrhqOr3iuVO3K6ry+
 YLrhfKhZ74l9VD1T6EjPUMSxvdtSytQqr3/FfQHZmrg4bG12MjkRMri9qpyJ8PIP/aPZwXAYvOV
 +EQdy+zpTIq23F450hLKJPxpE9ZwPDyX+0hlfZMbqczfd6yQiwe5UvYGgbWPZu6iSaZX4ARtaht
 EBHZHSXLooB6fQgYXZC5Ep/rnSaVXAFfKSgJhEbe8bBce/XzQMqhFDQwx2Y1lO6Ns3TQxCSbXvn
 KJwBjbm8vkWeppY=
X-Received: by 2002:a5d:5f8f:0:b0:39c:1efd:ed8f with SMTP id
 ffacd0b85a97d-3a074f66b39mr7043180f8f.50.1745825697211; 
 Mon, 28 Apr 2025 00:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKiWxzddEAI6XUocOgwYpnc41ztCxQpe+7vU+nj4jeihXHC4TrmUz++8GAjRt2Ie4Oijg08Q==
X-Received: by 2002:a5d:5f8f:0:b0:39c:1efd:ed8f with SMTP id
 ffacd0b85a97d-3a074f66b39mr7043155f8f.50.1745825696812; 
 Mon, 28 Apr 2025 00:34:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e351sm10063402f8f.100.2025.04.28.00.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 05/26] target/riscv: remove supported from RISCVSATPMap
Date: Mon, 28 Apr 2025 09:34:20 +0200
Message-ID: <20250428073442.315770-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
index 33a36a24737..43ccea72e8d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,14 +440,27 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
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
@@ -1172,9 +1185,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
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
@@ -1191,9 +1205,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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
@@ -1222,7 +1236,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
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


