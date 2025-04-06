Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57734C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K3A-0003R4-Fe; Sun, 06 Apr 2025 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K34-0003Fa-W9
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2y-00024g-VW
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcJC7ZDFBoqwMYDErCmm3//66Ko1R5XRie4/O9+IKio=;
 b=eb5Gk/bsry76eNhRgprukbTDqmjCy2/YnrCZ5NNGmzLHIMfdECeGbxcNLNDSrVGraEETwG
 X9qFChPTdoyZMbDvdq/BTJCfXoh2PI4JjkzpQGuRZ9/pTawnTnkdxC+TS0axJqqGZbem6R
 PcvhOt3/xNHKCGa0ZHAR+ey0Ef4Kot8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-vu7gI3xePJGGSRS7F2fS8A-1; Sun, 06 Apr 2025 03:03:58 -0400
X-MC-Unique: vu7gI3xePJGGSRS7F2fS8A-1
X-Mimecast-MFC-AGG-ID: vu7gI3xePJGGSRS7F2fS8A_1743923037
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-399744f742bso982532f8f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923037; x=1744527837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcJC7ZDFBoqwMYDErCmm3//66Ko1R5XRie4/O9+IKio=;
 b=j8jMuQc78bYhE4tJeLu1zjXJsmA1+zl/a29wKvODtPEeDDDm7sOjxyyBYLWmdnPivk
 XQuwYruBfMr3ZZYRdwzyeSuipoDKbj77319FG1jTPXM0/p2wTFtIMY8deARO6ch9vhy3
 4ZctcBpcuVJhuVAKyXZjSSHohlMkQYQQ6qiD86FZH2t6iqTkFMvkLtjpDo3tRISY91MF
 7Q+WZRAGbwmb/zuVZd76IDQ2+OCTBltXAAlmDqqqTa1NlkSB4eOlpkKnCrEDAkTvGy07
 xgSMqnFYU/bKCkfa4EIt/CfbPV6ulxliBobOESb0VDbjTNZ+oULbLF9M+SIlZbIPc3bQ
 iUoA==
X-Gm-Message-State: AOJu0Yy33OA4c9bXv3mqFH9/1VTRQjGL+LfCNPa8C+7j6CraKtoYfvj4
 VEvbrt8qqazgVWzlXqAXtkZSLvGwQ2cmI27nlltDLpHshEjaoirq4IJ+JyYiGVNettnLrxtL/I4
 Qeatux+8tGR/p/G1U/HljAhRfNCk+H41bXSuouMYt2G28EUaf3q55nyD9I13H5ns0XMyJxt6zN+
 t+yMQfk5SrhDt5KpEd8dlBNv2B3VgyCDPjXTCN
X-Gm-Gg: ASbGncutFDCxmTnl2ybVGV82hALtzsTKe3HlvwL2JNaretONHp9PRS7FFrwcIn70rUG
 KopGGj2akpgoN1L2txLHRUOUZuG1OBy4ZfmVfmZOu7VxKNXh0q1BnzfKqMZSdYGSoEZjQ4tXPJU
 BW4BJpS8B7zPKjEi/7zXsHcGNsMg+YlDGh2uq5JsPGMoNvlr2UYMMofyOOm/d9/O47snMdSnqv2
 jj7Vet5w8akDKPlnciyhozPQzw+/u6jTQXoMHBhV+lguuiOX6GrSTXdNiDuQzIDMrBWFJcL/NEa
 RYZyRs5b/QUZxmg0pQ==
X-Received: by 2002:a05:6000:2410:b0:391:4389:f36a with SMTP id
 ffacd0b85a97d-39d6fd0229bmr3471429f8f.48.1743923036710; 
 Sun, 06 Apr 2025 00:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA9bhlbS5+wdnK6PS/NxVGNi+oLDn/o9APS6bCeK7RtqMBiYsy9QaMhhmdVox40Jwu7LU+JQ==
X-Received: by 2002:a05:6000:2410:b0:391:4389:f36a with SMTP id
 ffacd0b85a97d-39d6fd0229bmr3471409f8f.48.1743923036328; 
 Sun, 06 Apr 2025 00:03:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226b39sm8526124f8f.85.2025.04.06.00.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 24/27] target/riscv: convert TT Ascalon to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:51 +0200
Message-ID: <20250406070254.274797-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
 target/riscv/cpu.c | 127 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 45bed28ea8a..616d89be17e 100644
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
@@ -3217,7 +3151,66 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


