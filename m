Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A570FC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J24-0006wM-H4; Mon, 28 Apr 2025 03:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1t-0006bp-Ja
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1s-0001Hg-0b
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odGwGJTkN5rT0dzaXsoDNbESsdKEm89dQk/J1U/878k=;
 b=ImzdfwbLP6pzvrmem3MQLMV419jubF8z2fUfhUZ/VYXUAevblqEcvfqt78fCrxMRdof+ey
 ZjIHKcCTvYYSuiw9k4qp0BzLsRPFdcofnsNm6EXKitZshpmJ9xvcmpHfc6E83KqFmymNBG
 izRR+GWxP8Fe2ZM3qxaqTY9EAVNKQKY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-SMkVph5MMNqkcUwxerI_jw-1; Mon, 28 Apr 2025 03:35:47 -0400
X-MC-Unique: SMkVph5MMNqkcUwxerI_jw-1
X-Mimecast-MFC-AGG-ID: SMkVph5MMNqkcUwxerI_jw_1745825746
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so23415955e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825746; x=1746430546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odGwGJTkN5rT0dzaXsoDNbESsdKEm89dQk/J1U/878k=;
 b=u/OqPvGeK0Q6szN5utYTZ+n8kga0Pt8sW/qOyPRzqysBj0g0gRIrwlKJTIIlJ1mcnQ
 +84SjTw89EE5qdHFuQUSpN93BeguyPpzhKfTEqq+tJCXnkMRI6buis6HZD19gzVoTnlz
 TEfIcuEmQbWdhkdURhEpYbFU8hSy3K7XAwH6d76KJg/lu27bWjfkf4ajCTgaWxNl/f+S
 efzBWcCwdx+3v5lL08bW0OsAkfaF0QJJTJys3gNm6Y8/QVFQrjZFX8lhTE2rSf3Tsx0u
 qTs9iI9hic4oWc3rm/gRgE35H5Ij0CfBIRkSVZxh9crVggJ1GSq6u/H1/JZBeoH0I/32
 iRtA==
X-Gm-Message-State: AOJu0YyBtQQ8ArNwRzPMivC6hJY4i8K+ft7JfqTeSeRGSWB9ahDPJScr
 ASHN3FUEGhcH/NhkMlhUxv3b1fXMcNjjXQgqMd/vaAjbTHq8snooAzENjGDrtXpbFNI25+dMrI4
 rfrC6RtVQzz+WBRiSUxclvMYScwSXtglwAh9nghvUgaiacN8vwSUSrtjNAaaHV2XfZANYfwYIst
 IeJi7mFIYoC1hrd28USG2k5xczQ5drSHj7bcrE
X-Gm-Gg: ASbGncutL6ZpRxkSi4iaW+6vShWlnqmb/GYptMuVpV81e9MvfTPdYuflnQHvgvNNg1P
 NJwhm47KMBVqVuIUketb5Tb/bdGzBPMTr+m/U1ulvllJwyv3J1xiIIqNgBjkMoFve+e4/0gzoQL
 YLPOkw4bdmoYCYiDcfSDhAdetlE4tfL+twISqTInOtQNk4NVYJCnOxlKPqbMEDVdVX/nAaBsy0n
 HboQgBNt2lCf91qEdrbEaGIjN90e6rrANlGV6uDWNYmxm8JeabmoZ2fFeNNhUB8DVIvsxb5jwSs
 thhi+rhFL08rq8I=
X-Received: by 2002:a05:600c:5252:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-440a65b6f77mr76467785e9.6.1745825745717; 
 Mon, 28 Apr 2025 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHitAI7cxo+5r54d1x6kI8r99LOCzmzBfmqs9z8ka16Utr8zzLLu3HiIS2N9dpMpmY+P4c2ag==
X-Received: by 2002:a05:600c:5252:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-440a65b6f77mr76467635e9.6.1745825745387; 
 Mon, 28 Apr 2025 00:35:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbe386sm10144250f8f.42.2025.04.28.00.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 25/26] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:40 +0200
Message-ID: <20250428073442.315770-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
 target/riscv/cpu.c | 80 +++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6cdb92c8a4c..e7e9e6bfe80 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -441,16 +441,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void __attribute__((unused))
-set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
-{
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
-
-    assert(valid_vm[satp_mode]);
-    cpu->cfg.max_satp_mode = satp_mode;
-}
-
 static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
@@ -499,38 +489,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
-#if defined(TARGET_RISCV64)
-
-static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbkb = true;
-    cpu->cfg.ext_zbkc = true;
-    cpu->cfg.ext_zbkx = true;
-    cpu->cfg.ext_zknd = true;
-    cpu->cfg.ext_zkne = true;
-    cpu->cfg.ext_zknh = true;
-    cpu->cfg.ext_zksed = true;
-    cpu->cfg.ext_zksh = true;
-    cpu->cfg.ext_svinval = true;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-#endif
-}
-
-#endif /* !TARGET_RISCV64 */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2892,19 +2850,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = &((const RISCVCPUDef) {               \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3204,8 +3149,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-                                                 MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbkb = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zbkx = true,
+        .cfg.ext_zknd = true,
+        .cfg.ext_zkne = true,
+        .cfg.ext_zknh = true,
+        .cfg.ext_zksed = true,
+        .cfg.ext_zksh = true,
+        .cfg.ext_svinval = true,
+
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.49.0


