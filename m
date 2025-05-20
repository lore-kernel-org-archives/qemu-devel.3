Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2EFC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKo2-0001On-Tg; Tue, 20 May 2025 07:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnt-0000pA-7Q
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnr-0003I0-BJ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+ysdJnjVluo6jSebuS5er9F+Pln3PK7sOvJMqbaJlM=;
 b=C4p0GgsTzw0G7Ya3Gqs0P8xw/X68XDkWOW3nIccdFQGzR1BvyiuPqeBiJTZLzTObsx7cuA
 iWyXyhzZKOpHsfmhARbXAA/IMUjLDljmasdWQYWZqAuGNQrR0SLDN7X2GV9m3aM+Av4pt1
 MumrLdNfUBfBAyLIMFALP0rvR2Wssm0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-gMn3RLEePbWTlp8F225_9Q-1; Tue, 20 May 2025 07:06:33 -0400
X-MC-Unique: gMn3RLEePbWTlp8F225_9Q-1
X-Mimecast-MFC-AGG-ID: gMn3RLEePbWTlp8F225_9Q_1747739192
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7859so1546461a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739191; x=1748343991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+ysdJnjVluo6jSebuS5er9F+Pln3PK7sOvJMqbaJlM=;
 b=UaeFbtQDMQ2ifvRNTgbRbqfJq+StWU2Nx/J/5Ndgzl+0FhhN53hsppA5sLzbHpSkmS
 EQTe/hWnQvUsUls3c/CsdxO8pE6/2qQ/AV3NmThCKHbaLbM9VYdhgIAyuWVTnQDhRpar
 FMlwi1qC7+7d1mfbH0HDMSBtjK7yU1dF0Bxh1yxiGWoX5GOUMVw9agveX5UpMkQRshs0
 XOUAtuHz2SjVIvwbtdJBLRvi7sIqR6AbRMUwRX0o8mjIP31tXkYy6qi30hXykBgal+70
 w5Ak5a81smlrXiT5G/8PlohRGR8PJpgIRXvDHIT6ivYLhLKruANcXEyRg9Yexcdf+vQT
 OZfQ==
X-Gm-Message-State: AOJu0YyieOs4tdGDIEC3vsL+2dGlYAQC8CKc/MJTpbBzW4BZoatrQbUQ
 M+R9dlt4OviqtvYgGxDAbZL4oXM6puzbRTlpkd+wyPhkDadSdCdJVea3sQDOqdEsCMSsBwdb0gj
 mxy1yPdmgd+0wqX8/VKmC657epdnuQylOyKa81i82DergHrqhb6ioDTJLjk76VO5inl7rrfP5tc
 REMt6id5pdKPVFBZi0gIquGA7ku9ckSe1MCw6ymHJz
X-Gm-Gg: ASbGncurLV4ltpxf1s4eAAFBj0nkOzcVWSybDHyLeTqIpkad3hZM0azC+yc2kA6eB9A
 bEW/d55d2Tz/lAbngEIWoJ7Wu9h+yHhxLIH4g6RPPRwlUBfElcNjgeI6lhj7lzqSpe2f3EDTNg3
 X5Twwrcav1duRxKlJeS8Y0PYQtMwyhYArySI/mzc1Ywvf2H0MjGjAj+4II1tIX6w3xCjKGdEv2/
 zAtQVUnOgxnO11HARRc4V7aUSwKeJS+Z3MaWACzlu0llqFErZYrIzxHuVXqrRwIoHuJaa4AyvAY
 2+5FZffUVPG1SQ==
X-Received: by 2002:a17:907:1b02:b0:ad5:3504:a6d with SMTP id
 a640c23a62f3a-ad536ddeb5bmr1335953566b.47.1747739191232; 
 Tue, 20 May 2025 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE89vo4xSX4+K4YhVeAXV07upmmA17APg/BFZ8fw3rbsDMfq5N6SyLjljasnYNCeWGZosB7gw==
X-Received: by 2002:a17:907:1b02:b0:ad5:3504:a6d with SMTP id
 a640c23a62f3a-ad536ddeb5bmr1335949866b.47.1747739190663; 
 Tue, 20 May 2025 04:06:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca827sm707166166b.163.2025.05.20.04.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/35] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:21 +0200
Message-ID: <20250520110530.366202-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 17ad8b2ca1f..689c33916e0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -690,28 +690,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32_ibex_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_smepmp = true;
-
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3169,7 +3147,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_smepmp = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-- 
2.49.0


