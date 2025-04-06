Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F6C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K32-00039K-Af; Sun, 06 Apr 2025 03:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2z-00036C-Ed
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2x-00024a-Od
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0UpZqu1zAQmZnKFsa02rYtYeJCnPD6+pIcGOpa8DmE=;
 b=aEuJFpCPfzJK727vJgdLx7j1CDIoxd9FlD9w1hTSW7+Wy+5BIYOVUEnGDNOSI2mp2oglsy
 v706+/WM7Kww6IPfDggG8EVOqoIT0ZYdTOLtqPh8yR+62wJ/tGLOEIcpAOUxvH9JFU75xe
 IA14ZCDqmlsTzcggnmsIfW602JLmPrY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-_n613xxgNU2xjmQq6yzVsA-1; Sun, 06 Apr 2025 03:03:56 -0400
X-MC-Unique: _n613xxgNU2xjmQq6yzVsA-1
X-Mimecast-MFC-AGG-ID: _n613xxgNU2xjmQq6yzVsA_1743923035
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso26630035e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923035; x=1744527835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0UpZqu1zAQmZnKFsa02rYtYeJCnPD6+pIcGOpa8DmE=;
 b=rW8X0tLIBxSyvVlmgzlqS6FuLmPDq8YKwTwSX8YQlX/qCso1PXj6rKMgfDzdYOKae7
 r7i9sxmx0is9AjaWMHWL2dZDGwAfclbIlQCVVcWEkdMfLHLAiz/RvDI2+LRZonrAiJG7
 czugfcY0T1sITqDKqGGA3qkMC576x7Ea7v+rTCOS59/k6SlrviWx3jvUsspFmpmYxIRX
 37axl+9OOxWYyoTxwMIxsQN1fDUjhSGBFXdhbbidmpwlnGwLbbD8BNXoUQxvrEEoS7mB
 CGDXCn2L+OD6GQsShrUdVEsCJQrszL/PDXk/T+5POkpfC4nxwJhaMmw2vhiouIaUzEX+
 OuzQ==
X-Gm-Message-State: AOJu0YwKiSd5O/AnWt0jjpsrue/YiHgA1A8BqLW8ZJHIAnCTt/6zyLDf
 t8FGwWAbHfB0d5tj0MddlHuJHk0oz6pWCpF3H+RgAhNVDix69vmk1vtszXTu/lO6XSPBPpN0VAK
 0PpPJth8x5DjB2yWBXnkw0GMAgs68m1cbdrwZO9Nl3hc8m8u1V9EMpvH1JxXgCI7wyeEFY+jsJK
 J7s6s2A0gdr/yu+hyr7+YMGHMLZFKAJ54kwhxr
X-Gm-Gg: ASbGncsdSBBmpx3GYzFJwmT1jCAaj9tG6VRMi5d1wyOH7ag6rvuB2DKRDZXUq9lDWgW
 8+tFk16z0+aaoOLrG24L8Ue51TZ0hGvPWD9pToWqThUYwaVHtU2shyO6kIIfVGlDMAnmbt7Qpof
 vlcpV0054kt/kFERGBzAHhn92P7/pnHpIbUhk/G44oaHGlzyZdDqOlL/dV/5fP7UgnUW+ETx52A
 bpDQMakDxmkqZgUQFUaNexPpklVHtzMtUPsBlPW9CLnYl2oglYmgvm5GXoLMAzDSIeh8zqdgPta
 nu8hUABQ6GDZYDn37Q==
X-Received: by 2002:a5d:64ee:0:b0:391:487f:2828 with SMTP id
 ffacd0b85a97d-39d6fc0c2e6mr3843508f8f.10.1743923034793; 
 Sun, 06 Apr 2025 00:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH70w1fLDoL1snr7c6+Tbh9CWS7/PyL8Jqb1+67YWTAazsU7CBd9JWsWTEzOo2vmb5lyDzumQ==
X-Received: by 2002:a5d:64ee:0:b0:391:487f:2828 with SMTP id
 ffacd0b85a97d-39d6fc0c2e6mr3843476f8f.10.1743923034328; 
 Sun, 06 Apr 2025 00:03:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d661sm8909430f8f.66.2025.04.06.00.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 23/27] target/riscv: convert TT C906 to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:50 +0200
Message-ID: <20250406070254.274797-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9669e9822b2..45bed28ea8a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -500,38 +500,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
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
@@ -3221,7 +3189,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


