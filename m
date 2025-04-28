Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1063C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J2W-0007HS-5c; Mon, 28 Apr 2025 03:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1o-0006b3-H5
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1m-0001Gl-Ca
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4tLPzniu0oW/9eimWTxQvYod0iWTUxZb1Jgq60Qwvo=;
 b=fRnM92vyDZJudI74mJKF7EqyGbsV0yGiD//dLyvGw38qhadrnMKOr6aIUKPZ5lLeAqJ4iw
 ujG6LqrtLNL9gRWtwhDhTFb0hAbVZ/XFi3x2FahN7QyJ/q0QbnD9aQX3VB9AdZ28dz5+gk
 lO+vFZs/8p11d0y5J8rSBbzTjicyBHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-t9YoaUcsMCOpVkQrItv-Ew-1; Mon, 28 Apr 2025 03:35:43 -0400
X-MC-Unique: t9YoaUcsMCOpVkQrItv-Ew-1
X-Mimecast-MFC-AGG-ID: t9YoaUcsMCOpVkQrItv-Ew_1745825742
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913b2d355fso1148339f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825741; x=1746430541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4tLPzniu0oW/9eimWTxQvYod0iWTUxZb1Jgq60Qwvo=;
 b=lRn4xii5nASOPhwtV7pyx9v3xs3EvgEJLySn/6xC7DKnKR5yAs/ZXKUGFODdlBtieo
 6OKmoTbneysOpgjqxjKzag1GdW4Ftd01lRFTE83kou11OWBDy/pwxHUT8k2OaU+S0Mi0
 lPK84aScPShudFK3GliTmIL+5RKqQscvC8TmXk5lIIP4LS+1sKUDXxJBbcBBgxEMVfCm
 xx1FXQK/CiCYWs3GjAE5N74Z5WMKXLo7mo3Jz8kLXWaXXm7PrPsTOX3tj6qL+gpfOCTD
 saPy3sD7X3Dg7UlS6NgtmMpyVGZDVkgvCFIxhcl1OT1a4vqXOpXKO7vJq0uae+sOz6E5
 B1vQ==
X-Gm-Message-State: AOJu0YzDrAXtvIA8cZJEkG5X0q7RgV/FijQry6xUvG0aZv20MMqJvdkV
 Q8TaOxSYvdO/30BgZNMp0rU4g4AjytkvjJM4bIFqF41oqwWHy3TCZF4emi/oD76YcZvRW/yadJl
 u5icJf6iSSUmJ6nbLTzce8CDyFRwzWFjj/iLmJM8L0o0VWKTAr0GMqHoYV6GPg4oTIu3t93XIhr
 9tSRntWkKVxMejJz6fgtBiJJnZTryqIfDRtJQD
X-Gm-Gg: ASbGncvHkIhmJg59jOLZ+vAJ5XU5u+CJ6jtPGRzoWMSGB2+SF7TK48h4RLpi3RpxHgN
 lZIizb5x03g28dA3TXR8iwNVnr5a/IkvpkTsyXm9MXV8Y5b+4O0TQYZ1Taxbh1b48b06e5bSLTR
 XTpVb7CAHN/o1oipv3ficCZZxZhZHF/3jS5R0u76KHAS5cN1RCOqf/wMkJYEQuX4Ut8ztOEdOXT
 OrA39HJaRIWveMhzZ9qNgKf6bsEbwN+Q5wzRpun+Dbafb2F/tmb+fSpWpe2MSQ/ivLk8NmI3RsJ
 8w9HNQhi3Bqebjo=
X-Received: by 2002:a5d:4c82:0:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-3a07aa6c501mr4687613f8f.25.1745825741563; 
 Mon, 28 Apr 2025 00:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgO3y1iXtYMhGCUn4xi/pez3JYaVXblbISeXiqZ8hHkZbkg16wPBvYReN/pIQwIlRaj6cxJA==
X-Received: by 2002:a5d:4c82:0:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-3a07aa6c501mr4687591f8f.25.1745825741115; 
 Mon, 28 Apr 2025 00:35:41 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538747esm113828275e9.35.2025.04.28.00.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 23/26] target/riscv: convert TT Ascalon to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:38 +0200
Message-ID: <20250428073442.315770-24-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f3af9643af4..20a68ba43c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -540,72 +540,6 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
-/* Tenstorrent Ascalon */
-static void rv64_tt_ascalon_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
-    env->priv_ver = PRIV_VERSION_1_13_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.vlenb = 256 >> 3;
-    cpu->cfg.elen = 64;
-    cpu->env.vext_ver = VEXT_VERSION_1_00_0;
-    cpu->cfg.rvv_ma_all_1s = true;
-    cpu->cfg.rvv_ta_all_1s = true;
-    cpu->cfg.misa_w = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cbop_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zic64b = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.ext_zicbop = true;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_zicntr = true;
-    cpu->cfg.ext_zicond = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zihintntl = true;
-    cpu->cfg.ext_zihintpause = true;
-    cpu->cfg.ext_zihpm = true;
-    cpu->cfg.ext_zimop = true;
-    cpu->cfg.ext_zawrs = true;
-    cpu->cfg.ext_zfa = true;
-    cpu->cfg.ext_zfbfmin = true;
-    cpu->cfg.ext_zfh = true;
-    cpu->cfg.ext_zfhmin = true;
-    cpu->cfg.ext_zcb = true;
-    cpu->cfg.ext_zcmop = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_zkt = true;
-    cpu->cfg.ext_zvbb = true;
-    cpu->cfg.ext_zvbc = true;
-    cpu->cfg.ext_zvfbfmin = true;
-    cpu->cfg.ext_zvfbfwma = true;
-    cpu->cfg.ext_zvfh = true;
-    cpu->cfg.ext_zvfhmin = true;
-    cpu->cfg.ext_zvkng = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svade = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
-#endif
-}
-
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -3214,7 +3148,66 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
+        .priv_spec = PRIV_VERSION_1_13_0,
+        .vext_spec = VEXT_VERSION_1_00_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.vlenb = 256 >> 3,
+        .cfg.elen = 64,
+        .cfg.rvv_ma_all_1s = true,
+        .cfg.rvv_ta_all_1s = true,
+        .cfg.misa_w = true,
+        .cfg.pmp = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cbop_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zic64b = true,
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicond = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zimop = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zfbfmin = true,
+        .cfg.ext_zfh = true,
+        .cfg.ext_zfhmin = true,
+        .cfg.ext_zcb = true,
+        .cfg.ext_zcmop = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_zkt = true,
+        .cfg.ext_zvbb = true,
+        .cfg.ext_zvbc = true,
+        .cfg.ext_zvfbfmin = true,
+        .cfg.ext_zvfbfwma = true,
+        .cfg.ext_zvfh = true,
+        .cfg.ext_zvfhmin = true,
+        .cfg.ext_zvkng = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svade = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
-- 
2.49.0


