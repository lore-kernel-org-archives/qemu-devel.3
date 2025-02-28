Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DE1C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxc8-0003IA-UD; Fri, 28 Feb 2025 05:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbt-0002lV-8L
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbd-000322-H0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iep8pZGiDzI7IY07IUsRT9A7+I13meiftaMonL8dD9Q=;
 b=cfX9yMpCFlTDZodoO8O5Whp02Usmw/Nb1raKCSL32+nk6MET9TrY/v6X4D/QtJ29iXeR8+
 6Ynvv1jQqZ1pldwwVKiXYYHVduURChCzeuXQG2RdIgwrwnEbX2wcfBWEZGQ4l6X/qL3Jh0
 NXxDcwifc2KdzVCDZ+AUnPHxEh4M6bI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-YhlD5xSgM0uIufruDGx6qg-1; Fri, 28 Feb 2025 05:28:31 -0500
X-MC-Unique: YhlD5xSgM0uIufruDGx6qg-1
X-Mimecast-MFC-AGG-ID: YhlD5xSgM0uIufruDGx6qg_1740738510
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ab456333aso19069335e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738509; x=1741343309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iep8pZGiDzI7IY07IUsRT9A7+I13meiftaMonL8dD9Q=;
 b=c1nWOQrOLOjVM/7cwNbZlfGvk+R7Yu8ES+wDDF/aLEjlazAtBPxp7NQiWfc0AddkrT
 VjG9vBOf3uhm4TUYfybtGJUgb7EWOEDMNjo+IUqhNMQr9DReMUL7hTsGyoCF8RKaGxuN
 ToYKb6MiviL04ojb9vRoLfRU7Jqo3Eifpnvsl8i0RvrrImwhrgcHN65F2IneUyirdo71
 nFokSbgrY5Dtpmu6Wdro7nNtoeH/pYbNORDCpY1OrByTA1wPxMqYpmdk6nGaxhHJaXyO
 2tenQkKQgWUiOOBpYplLubxTV2HU3SaCUnL0B+DucX1nL2ENc2kT5eFEsPzn0fw11OfD
 E5RQ==
X-Gm-Message-State: AOJu0YzHARPPsi7+eLhbo21uC7Z0Qd23fqmOMSJaoQlzpsdg0zjNp6wS
 MCN7NILylu6i4wJ+Ney9L7PgEpEI83GTejqY2YEWL1oShelt0j8BNPEjeT5JfF1kYFiz1WyeBF7
 8T0YtQSrp7Sb1A2xA7mwqUSM2jA/Dps1FJthdBjRKKzszSi9KKIDSe4ZanREuht28/QzvIXkuHN
 yJo1QlA1dtxt6zcO66El0wzUsAM+uzfWun0InAqTQ=
X-Gm-Gg: ASbGncuRRu/rooIoYRyWLnHVhx+5rLRqyqDalSlftknnr6r56y6s8ulOFyAIhgRh3fD
 IzD7tZU/IwiRK1PeNSM6Qlm9NWwXkoKMW3CUrxFVcb4EHU7O6mRxdDens8LGbNTYktkwyKPj6GF
 q7HQoApdraQ4t6awsbe7C+frbO0FRRY+TI5HKXykHbJ3VkzcguwlbOEJKgF7xwUPJX3dyqdQ8Qn
 3sEcZJ+X3XuES5Nbtd/cXss0UOKCBKZ0qyhEeDMVs+DevSqUAGYe6HFHzRbg23+P0DrPvF00scy
 WPRIl1c/WtWtfMF/Y2w1
X-Received: by 2002:a05:600c:5014:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43ba730d5b6mr23207145e9.10.1740738509308; 
 Fri, 28 Feb 2025 02:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0GQqi59HJ9fjy4gcPVmh44+gEekIwFyQcURJVa/aPff8jGhP82V5YIMcfLo1MrpyxByYcJw==
X-Received: by 2002:a05:600c:5014:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43ba730d5b6mr23206885e9.10.1740738508924; 
 Fri, 28 Feb 2025 02:28:28 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d8e4sm4660228f8f.85.2025.02.28.02.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 18/22] target/riscv: convert TT C906 to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:42 +0100
Message-ID: <20250228102747.867770-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4d6756a97ce..a249e48da6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -497,38 +497,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_thead_c906_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_11_0;
-
-    cpu->cfg.ext_zfa = true;
-    cpu->cfg.ext_zfh = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.ext_xtheadba = true;
-    cpu->cfg.ext_xtheadbb = true;
-    cpu->cfg.ext_xtheadbs = true;
-    cpu->cfg.ext_xtheadcmo = true;
-    cpu->cfg.ext_xtheadcondmov = true;
-    cpu->cfg.ext_xtheadfmemidx = true;
-    cpu->cfg.ext_xtheadmac = true;
-    cpu->cfg.ext_xtheadmemidx = true;
-    cpu->cfg.ext_xtheadmempair = true;
-    cpu->cfg.ext_xtheadsync = true;
-
-    cpu->cfg.mvendorid = THEAD_VENDOR_ID;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    riscv_register_custom_csrs(cpu, th_csr_list);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_veyron_v1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -3098,7 +3066,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_11_0,
+
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfh = true,
+        .cfg.mmu = true,
+        .cfg.ext_xtheadba = true,
+        .cfg.ext_xtheadbb = true,
+        .cfg.ext_xtheadbs = true,
+        .cfg.ext_xtheadcmo = true,
+        .cfg.ext_xtheadcondmov = true,
+        .cfg.ext_xtheadfmemidx = true,
+        .cfg.ext_xtheadmac = true,
+        .cfg.ext_xtheadmemidx = true,
+        .cfg.ext_xtheadmempair = true,
+        .cfg.ext_xtheadsync = true,
+        .cfg.pmp = true,
+
+        .cfg.mvendorid = THEAD_VENDOR_ID,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = th_csr_list,
+#endif
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-- 
2.48.1


