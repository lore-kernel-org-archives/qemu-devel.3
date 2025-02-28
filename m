Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC937C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcM-0004US-Mq; Fri, 28 Feb 2025 05:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbw-0002oz-Vu
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbt-00032P-13
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4NKtcUwg29ndmjYQHYEfuuJNcDoHzb/t4zzP2CEGHw=;
 b=FDN/woTSiqVoY2jbMoieeMAwJaiqTI7hdlDDO3qkIi+ForbdRCm6AAMWopJezvqsdqccHF
 4FEIIhJ7AcX3ri5PniwG+N99JX0ABcw5wCEDnEVUfbIDuqHioUBSxfqLJpobWVl0wo4l7h
 eMc757gt8+PzitsKKMW5genOMYfmNMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-6Akzwd15MWy1nw4fl4M3IA-1; Fri, 28 Feb 2025 05:28:36 -0500
X-MC-Unique: 6Akzwd15MWy1nw4fl4M3IA-1
X-Mimecast-MFC-AGG-ID: 6Akzwd15MWy1nw4fl4M3IA_1740738515
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390ddebcbd1so1142127f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738514; x=1741343314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4NKtcUwg29ndmjYQHYEfuuJNcDoHzb/t4zzP2CEGHw=;
 b=BJZ9fA9GRE4bUXKXybyktnZQ4ZI++JEE+kZMjyZMexR2uxuuXfFUcyyJwWbMxFWNBH
 PwG8058kY3P/qwZt2rx/AsJ5Ur0vJXLpp3zDsc8uuSfmEnfwKVeYRzuZwZMROciUXOoE
 LZ28O6oD/kvsjFVr3JUnRrCloNqAHJ1/wviylGKSw/xNgIDPMAhPXOTNn4gBIx6/T2Bq
 v5gCSPMECuw4Sub5VFeCWRsLPCPdEQoVele356/rskVkwPP6XC3+79SzOwDT/ed+xf/Z
 vDMe5jULbh3tMu6K1P4jEcZKHeq7+tSDlCRjv9SF5f9QCLiN55X7q2f5RhiMDW+uA897
 j5DA==
X-Gm-Message-State: AOJu0YwH3reYoUN5hi6Bzvg00cEgHjniISWt4FoUP76MxIbiHkDYN8zP
 y14hfNo8j6xgunr/0Pp+lXDskU7PDvpRDM80AMKDnqly5yR09oY9fD0kCQoUnguKow8M6fMW52w
 MY65IHhgoZglh0dzJOs2zxHfiEe2SutznjGW5CHejtGwHs7KtB0CBIO1G7GUOAZjL0YFaLweFO3
 gh/rZ3sR6hTN/usg0IJaHppfSqU8X+j7Hx/Cqdokc=
X-Gm-Gg: ASbGncvzzkU1uTpgfI9cDzjzfJWt8Q1CibCEpGP97ajt2Hj0QeUq1bQg9YNtCnqWGnQ
 UwVNho+Xmqs2V8IKtPdzxZch8hI4sqbWJwYsfEpJDU8QFmik6MhAGUBhQlENzeA0LNuJCxmy1CJ
 fzu7UwIPrDcvtexoDFlXXWa81L7ozBhLLhwCBQJpHnfMlIfShrW9+vzs2AFVDSEaaceaXXfnBaV
 CgeR6rUbNrImJEbXxMEbPuF8mmCNRSfN8TCrJWltiv9wn1btulfR6ieKDuLqRaqVQw4ZCK7Zv9z
 eAhoc9ULKyIruWq/qh/S
X-Received: by 2002:a05:6000:1868:b0:38b:d7c3:3768 with SMTP id
 ffacd0b85a97d-390ec7cc8damr1887347f8f.12.1740738514012; 
 Fri, 28 Feb 2025 02:28:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo7QsdJ5mxECXJHKxpsTC8sn5nIQBccUxgpcICBjaHd8oM5efAF0a2F8lY5VH82j8ULxlTzQ==
X-Received: by 2002:a05:6000:1868:b0:38b:d7c3:3768 with SMTP id
 ffacd0b85a97d-390ec7cc8damr1887329f8f.12.1740738513602; 
 Fri, 28 Feb 2025 02:28:33 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba58717esm82552175e9.33.2025.02.28.02.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 20/22] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:44 +0100
Message-ID: <20250228102747.867770-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 52e33905d21..a6c97a43799 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -497,45 +497,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_veyron_v1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_XVentanaCondOps = true;
-
-    cpu->cfg.mvendorid = VEYRON_V1_MVENDORID;
-    cpu->cfg.marchid = VEYRON_V1_MARCHID;
-    cpu->cfg.mimpid = VEYRON_V1_MIMPID;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
-#endif
-}
 
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
@@ -3088,7 +3049,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_zicbom = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_XVentanaCondOps = true,
+
+        .cfg.mvendorid = VEYRON_V1_MVENDORID,
+        .cfg.marchid = VEYRON_V1_MARCHID,
+        .cfg.mimpid = VEYRON_V1_MIMPID,
+
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
-- 
2.48.1


