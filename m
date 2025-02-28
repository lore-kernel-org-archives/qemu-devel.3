Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcF-0003dM-N4; Fri, 28 Feb 2025 05:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbX-0002TH-3Y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbU-00030p-Hk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ibPPUtTyqkYOIjh87viwYNA9Arn8Lfk3p+vHSgykIg=;
 b=LCg6JpusDDf0IgscEPAKt51cQXDCxyA5fNpMZC5+/NC8aYzZpxPB5qdfRG42BAQLyYdoI4
 +uNtI9nOWMyiuKAYJz54FlFTsJK9r8lr4mobNBjJm2LFd6d8aPV0hcPNMOxUoo27Ss8ha1
 JYsORWZgUjQvMq8KZ/ie2Z/LCJvX/3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-aLBKL-xmOZKGr-szHbFzhQ-1; Fri, 28 Feb 2025 05:28:22 -0500
X-MC-Unique: aLBKL-xmOZKGr-szHbFzhQ-1
X-Mimecast-MFC-AGG-ID: aLBKL-xmOZKGr-szHbFzhQ_1740738501
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso1118345f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738500; x=1741343300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ibPPUtTyqkYOIjh87viwYNA9Arn8Lfk3p+vHSgykIg=;
 b=JtZTVPY2AmOtdGIAMk8DIorJrPFsb4aOKge63Ypn8psnCVOci9eFtD0vPUBFFfx/m7
 MPnZzkUyOTZFXOMTH9yeHZVvdWWpw+RUaQ9NkwVTqfd+IS3pFR/J1oCHtnJyLPfzFbfU
 B6p7m6Xg1SHpbs6DJgFUZ9ANY8e3ceDecv+O5dwswSjTzF1tywUSqhBc3gVVD+vNBIh5
 VG147XiBc8jnDAGrWmRGB2iY4xneqa8oRf1uYv1aHNI/vnNf/kh3jFfuvhx/ptQSJdbc
 uB1N3rJ/mxSY4akOrCwgflL7QqAmfaGRIMg6GBkgoAfSCGhk4UyuvTaylTtHCH3hNGiV
 pJiA==
X-Gm-Message-State: AOJu0Yy7WoqRSXJpd5iG2lq05xUfYTBYzOIW/G/JfCOId7Yl5JfG9Jc+
 gGnrfBsYWvvKi6kjjpk1lZOmvtGoncHE/UIn9lfNcrpiflXm4kTYPme4eCRfcCv29H931Xxojwm
 3PYlGXnCGG5YoJ+quZR+J3nv5h8sQ12Xeif0XILu3BrBpUNm4GonkwQkw2F/WpHgQnAzVff6saO
 MBUmqJ73exoseLpZS0ejG0R7DnxH0AGl1cwO7QMhA=
X-Gm-Gg: ASbGncuI0kjIsB4HS7J8yffKzqa7myhbanvDN9H/R39uAvnECVW96WOzXtVRWvBIhJw
 shgQtuY9YI1UATROBMrsQH8iuNkwOr3D+pwCWEYrDhHq8q15FS9XIxY8JIzfruxWeYsw1pfOtoS
 qtTzWEzUdZKTmukRaX6MDWIseQYZPsLUWI5kAb7Hc/YoHx9plWALdgAcVUdCbnKWOpkkq6AseoO
 7aG1OtZQ7kYttHFaaBa92D35gXxUeV5WLZA9z7hYW2eMPDAu1jUkJfyYb80cmJqksudE+7KA5zO
 n/XqNb45ENdQC8opqtMw
X-Received: by 2002:a5d:5f84:0:b0:38f:32ac:7e69 with SMTP id
 ffacd0b85a97d-390eca27969mr2211792f8f.41.1740738500313; 
 Fri, 28 Feb 2025 02:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9PaJRqLtfRAAuu+Ge3bq16iHWNUbR7XzCvbAeRbUhrusOqPTC340g7tCHvtPF1vIyv49UYw==
X-Received: by 2002:a5d:5f84:0:b0:38f:32ac:7e69 with SMTP id
 ffacd0b85a97d-390eca27969mr2211773f8f.41.1740738499933; 
 Fri, 28 Feb 2025 02:28:19 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844a38sm4788334f8f.75.2025.02.28.02.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 14/22] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:38 +0100
Message-ID: <20250228102747.867770-15-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 049d3f90f47..fc5bf6def8c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -688,28 +688,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
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
@@ -3050,7 +3028,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1


