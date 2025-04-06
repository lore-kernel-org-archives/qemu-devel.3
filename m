Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF442C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2t-00030d-Ra; Sun, 06 Apr 2025 03:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2p-0002yw-2p
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2n-00023j-LI
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44pTjsqjDy05M6aHRkZV520uvAX9N/n22XhbVd2On2I=;
 b=fVUmP24w0+9kiNrKEPJgAT4O63VCILoBO9EK+8cxHPRjUZ9YolqBSSbOBW03LkWmzB4w8m
 nLrfmRKWgJrBoptbFcEV4FZxt+a43AyZ94Ab+0VZ+igODMDuKwVQXfNm8e8Mr0hM26pLy/
 aBkZrxBKbmsVGt0zny8K24knmoL9/fM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-NoSSS03BM6aIiJS3QOYDCg-1; Sun, 06 Apr 2025 03:03:47 -0400
X-MC-Unique: NoSSS03BM6aIiJS3QOYDCg-1
X-Mimecast-MFC-AGG-ID: NoSSS03BM6aIiJS3QOYDCg_1743923026
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso1350313f8f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923026; x=1744527826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44pTjsqjDy05M6aHRkZV520uvAX9N/n22XhbVd2On2I=;
 b=my5E6BDPTC138Bvj+BkKLNKxRyQIt6XeBKWgVy3mab+fPGDvsRUar+Mi7bqnESMkO5
 83wWXZuaMuVmQ1yLfI0aXJUP3NFG6sgZJMYddZMgFHBitoe/UQ6KlCVJTCXi7rdLVvPV
 ebgcimszcwOrUmDuFGBg4OenfG625vszR5Z9vqVkFhSGbGaK38PtxocR1ZAGQo3o6m/a
 d8KR7GHxgXMjtBbBh+S76JDCuvk0IIMTcFrq1/9KZgLNB8vGlK7XnrlsK0f7vBmSO+X7
 kLoMkk7MaOX043tHZLoFyrVAUZknaE1D39gPDf/yJ1w1MWrPDk1oC42t8757e/gkrNDc
 e5Mg==
X-Gm-Message-State: AOJu0Yy57H9/B8xM+En2haFhHQeoZRSiEu4wgWitgboQunRKBzhkOOEi
 S5kajqXAHUMyHkPBs03AMiq1xiQqE1BS1pFLidQSQNtFMM5ec1n3fL/3hiZI2qge8BzagHDMVsX
 ClHCOV91INY447Bq/ORuwJ1AFJRt1vwV1m5ZmWl305Posey4viudPSEilYHuzfxjACIMCG8tt6l
 6J4cHtZq+fGI2K+9K7GvNmzQjywlA9dNeAJTT+
X-Gm-Gg: ASbGncs0ATLzr6YIjYyvLgMZqnChB0VuxskIvPTCIdL+/rmd9XmAMPCeseeFhw73uLf
 Mhcje2yN0po5M9DIWZKO5R+tRqUnIGjo7kPtvUJILD35zDCQR9Grm9W5QR2F6eoSkMMJUdxtgDd
 l8u1gopGVDWmAmXOEqRRz7rHjCHY6LGAiwgYFrBCds6073WN0xNRJbyqTKgsUAf6lZVjkNAgbm2
 7jv9j+dZE0TKCcG0vd8gBvlNlK4gq0wJfF05XQ0+hvIR/FSWtEtpNx9Lf4nHtGv0ghyJFm9/Rfn
 Z7UjUaaTKoIuwmfSlQ==
X-Received: by 2002:a5d:64ec:0:b0:39c:1efb:ec9a with SMTP id
 ffacd0b85a97d-39d07ad8ab2mr6724750f8f.6.1743923025742; 
 Sun, 06 Apr 2025 00:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYa+CtFLCly8ZwoRJeaA5cr2H/wM8I4sn0aShDVMYxPeYaSYYliczwnwnYHbY+zfLubRFgeQ==
X-Received: by 2002:a5d:64ec:0:b0:39c:1efb:ec9a with SMTP id
 ffacd0b85a97d-39d07ad8ab2mr6724721f8f.6.1743923025343; 
 Sun, 06 Apr 2025 00:03:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226b17sm8790921f8f.92.2025.04.06.00.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 19/27] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:46 +0200
Message-ID: <20250406070254.274797-20-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e72ebdf206a..fe1edf3be97 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -691,28 +691,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
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
@@ -3173,7 +3151,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


