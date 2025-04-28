Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E6AC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J24-0006vt-De; Mon, 28 Apr 2025 03:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1m-0006aM-KC
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1k-0001GW-7h
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AY89dqgFRuZCxKU/NBIyuf7+28vwdLzm/ZlF+t/wXAs=;
 b=Ko/RnumNoCAkDNJy4iqXUQQrUMLl86bqKdZmaiSmnvNL7fVils1dWIfH9tCsbXB3Tmgr7c
 ncmZU1SXj1HsCQ+t6rEtWroQ6Pd35sC0zgUADjV2bEBL14uOoSDZlUuDysgLl0nJ9x00xE
 OPex4ivZPvi1DkrwTfR/+vXJyEX51ys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-5vqhDo3zPxKbI7azfufbsw-1; Mon, 28 Apr 2025 03:35:40 -0400
X-MC-Unique: 5vqhDo3zPxKbI7azfufbsw-1
X-Mimecast-MFC-AGG-ID: 5vqhDo3zPxKbI7azfufbsw_1745825740
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so22180795e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825739; x=1746430539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AY89dqgFRuZCxKU/NBIyuf7+28vwdLzm/ZlF+t/wXAs=;
 b=SG1gLQjOOh+D4bz2d9g5ZQ4Y8VmS2Mm0G6gKjOuSBZqqmuIw9c8fGCJhD9JvsEkkJv
 pnR24sF1gfybIriYR91iD+pyj/2zoBiA5bDS1KcajO9hZ/LjvklAsbNGQLrAYiCMDq/o
 /y4hA+a6PsWHwSwTGbQ8S4JvmYchcNerFW3DJFFZbL6MY0JEaBv0WqajQMsyuucHQmak
 Es4KkkN3PhISTGzqW6FxKpmsg9M3rDigYnSra3i6HJOuBowJ2K8OmyapP4r89s+911hz
 oEJp45pGQ0WHJHCCfFDOZXg76PbPx4bbntWoFBt3U8UWCPolrUYO3wqtbFpuIYU1auvs
 Nhng==
X-Gm-Message-State: AOJu0YzaKaaukcD2yRayG/oEXofJwYoQp/kgtOliNysIKXDwsZlHxJQt
 cUKG3N66WXxTIwxGHm5X/FpQF9taOmigmcJFG1ySwBIDYSHBtb/AqRVoLhkUjPEW5q9nWLaWAyy
 CtbzoNpI60eGUoJKUopoa8Y7VcSnOUlm0HC8MRACuy5jI1WdnHGrOcRx0a6wB3UJnlRvg1/tf/Q
 swwtFIeqTelfMERABcR4Y460X8rXCopfdQktcl
X-Gm-Gg: ASbGnct9vBg5eWEk+QZA6JLH5B6NJgc1a/lk11BNjEs1FJUFVoSLAoBP2WW43l9bNd8
 i1ifF9obmtmqWHJVNcP9H3pwAh1vjq1Y7IWu6raZw/prQUq1JBwGBs+LVbjqBp0B11moH5GiTXI
 BdKEXxxH47yTnb+oWlIb022YlqPSsiDbFMES52dPKg5uwpmQfUSZYgu3AQWl9FHnMOIHBVEkwQF
 gW9CqUx2kYZWh6pTuOQVIgyI1lUiSUpwP+15AUa2UzOCYsgj/Y8aFpuVaenbW9Hk8g5ml5a6Em2
 m+LlcE9cr29tvx4=
X-Received: by 2002:a05:600c:1e29:b0:440:6a1a:d8a0 with SMTP id
 5b1f17b1804b1-440ab7827f3mr60986785e9.7.1745825739164; 
 Mon, 28 Apr 2025 00:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHPLP5Osvhw2u8Qn2QSqnWmojUDqfuPIMO4IbPwvgW5wfMhymVOD5pNqmmj/D8ZtDPb1UVvw==
X-Received: by 2002:a05:600c:1e29:b0:440:6a1a:d8a0 with SMTP id
 5b1f17b1804b1-440ab7827f3mr60986515e9.7.1745825738770; 
 Mon, 28 Apr 2025 00:35:38 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f9c6sm115256955e9.39.2025.04.28.00.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 22/26] target/riscv: convert TT C906 to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:37 +0200
Message-ID: <20250428073442.315770-23-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5045ebc0b70..f3af9643af4 100644
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
@@ -3218,7 +3186,34 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


