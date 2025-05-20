Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16E1C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKo6-0001dS-OA; Tue, 20 May 2025 07:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo1-0001O2-UC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnz-0003Ki-T0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wr6/aXmZS/WJzFdqxr3n+Ds8ycR5EVa/Shpd3AuylyY=;
 b=UEyBRGwgMZOuMA9uktv07mjoKYEk/ZFELvALLwAjhRCeOIO1YcpfpScjtRdGciQRECrLz4
 f4VDSG/Vuuz03ZAKBaEq8wdI9y5KaA0jnpNRYkW4lMQVTHs1KhF1Rf4HMAn/Z4VK45FxuG
 CFx1JA4/An2Q0ed0JOjvR/uZ+WcG6Q0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-KgnzTWioOaywExRXv-B9pg-1; Tue, 20 May 2025 07:06:41 -0400
X-MC-Unique: KgnzTWioOaywExRXv-B9pg-1
X-Mimecast-MFC-AGG-ID: KgnzTWioOaywExRXv-B9pg_1747739201
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56437a03eso190649866b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739200; x=1748344000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wr6/aXmZS/WJzFdqxr3n+Ds8ycR5EVa/Shpd3AuylyY=;
 b=EiKVTlu0BSu1XTN70VXnxxW65+M8RkATQ6Hq//OGshXjHwpB1+5Mi2usl+/cZlD3xw
 r0Iotag8joigaCKOlNebmsS1mHHTRwkO0RpQAQCXdNyMORNIp5A9CjB79oYvdAFk7ipd
 ag5nwvva02VttPETyy0SrtJX/99di6ucjCcUPvXQQzs92OcFqZ0rT4aWQVRYWVOQXL2H
 XlMz+qp/Hu22X5cWWdkuALinq9PGdxanX5on/Uk1+JnbCtuwC1VyPxy8fnKarVaikjJf
 rhzDIupthLChc5YdGNnE9DZMnqBB6/72xscXbmSKX6bfpS1XfmvTjQEzZPiVnEsO9yng
 rk4g==
X-Gm-Message-State: AOJu0YyGm7KSxgGsSCHacNI1F+b/Xfp+i57HclcCu051tEcCoFjdd+BA
 RxUqz94GUm7TSGORFSSHzSFOGIUaGftYZtjVCY+F/vv8O3RIArbg5e0lhdNPFxO19/DAAfNbpIj
 EUZPopee3AYHi7ua2xXF9GR9n7ZLX7FnQiu5t0QF2k1LHeeKCXA5Yle0hFzplGZJAZYjKu14/xn
 4R6oslsvSUKQgLqJIJtjvZ0xqDVj9mWIth0MI6D/C6
X-Gm-Gg: ASbGnctrGsFLa7QfAZ8lgMtE6TRztZwp0Cqh3k9+YMhny3VpcnEv2aBZo+E8PXW20D/
 9hRyUueZt2ndRSOCt3i8vA2y36lVYV4GSsa9Az7v1iC9ZNpMJr7lXjwIJF7WGbFddADRXZuH2MD
 5xhfOPUCKVX4lBt5ViFz3ZmUY3O70ncKQpFlMXplnATC7f42IFFTHf/Oz9VSNd01qJZsR9++QvO
 T+DR3zmpwIp4mKBp8+2jI14ZAmN/c8m0bosG1cniNMECcAPVfTDVFrvzuiIJ7CFT37/jnKONl+4
 MO/B3bnQ4o0LGg==
X-Received: by 2002:a17:907:1c17:b0:ad5:3504:a5e with SMTP id
 a640c23a62f3a-ad536bcaaa0mr1271958566b.33.1747739199611; 
 Tue, 20 May 2025 04:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMR09Lm2XhQq+/4PfIT3j7yTV5gMtsjfzYIaOkrZhlUAczzmkKWQ3ECbGUcH+EshRAfc3MXQ==
X-Received: by 2002:a17:907:1c17:b0:ad5:3504:a5e with SMTP id
 a640c23a62f3a-ad536bcaaa0mr1271956066b.33.1747739199131; 
 Tue, 20 May 2025 04:06:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04b04esm720954266b.15.2025.05.20.04.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/35] target/riscv: convert THead C906 to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:25 +0200
Message-ID: <20250520110530.366202-31-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 12f4bc41514..5d2ccf647dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -499,38 +499,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
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
@@ -3217,7 +3185,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.49.0


