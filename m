Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E60E74AE0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 07:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYJXF-00069d-Se; Wed, 24 Dec 2025 02:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1vYJXE-00069I-Ng
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:43:52 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.zhangjian@sifive.com>)
 id 1vYJXC-0001pq-TP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:43:52 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so99356225ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 23:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1766562229; x=1767167029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xdzf39Cxv9I16zoXjj5epMYmB3peD9R0PL5fSbrIHIU=;
 b=THQXdTvlJGW5HRJ6cCTavrMbULy+EOpEN1cuUoFRVGNgQ7dxe1DsJ2MbElWadFPTxy
 c5T6vCdFSg24/9Y5lz1CpaWFgdX5knJ1Ad6k+Fgz+0xnOjBH78/8BnOOFlO+OZ64zMt/
 tig44UaVXCwUjg7p9dciinsiVExxWxgIlne9Dq/YRGEciogEleO7nniuzuF15LuRQvCT
 tRD6LXwcEygHanPKheTHyf6MgQUCqjAlI3gHceT3QOvzCNQhGXcrAmBM3yOoDEhh1fn1
 D59wjE3nfxk+awefAuZSIaKZ8dOJfDMUa3EqMP7J9YVjji5fOuT8ISBMtfFbVWWeqYqe
 SPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766562229; x=1767167029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdzf39Cxv9I16zoXjj5epMYmB3peD9R0PL5fSbrIHIU=;
 b=Ua8HnKLvvD99H9R34HhXyq02MyLAhdQfHOCKJCRkUiAYjm/cJDDZHSXMckr8WuGqXD
 ncLDV3Mc3M1FFnWSwDKSWR+7Tja+wCtF/DB3lz7jrh55PUQyty0eJgo9yoO3aDDAD7HP
 FXFp2ALg52/lMPe5hCYQ4euqR/14X8qom5MuF+/rLoEGgpo4as5daiUDI9AYCCOHxG8R
 bGLkJtoMubYf87Jtv5jaxKORHaQwiFZTccRw7z7rysR8nsjQhreWKIVlxHKGL+mgoRkT
 udeZbeGbgsnQC+p/kenY0ipqLCmj7WwUdc806YiAdLhfYnaXcooUPb2cRhRhJ7rDFITS
 m72Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFc+MQ2BOCiGhZYXAq9qaGS4JeJll1X2JpCv6adEoMQe1j0XX+3YwMEtYocWnbvhzD0CZpMSVZ1dFe@nongnu.org
X-Gm-Message-State: AOJu0YwTYnjI2vHoBJwtuNQo+ujBrDbvU9A43xhaAeWXQsJQQaokprbh
 J68WAtEtDXw/DPKOEFWeXYd6LVJNjAvKvxc2nvdOon0B9rDE6iRaRKq21xiyAEA8N0o=
X-Gm-Gg: AY/fxX52IAz5PEVQLNGJAqdYgpo1Yjv0IQ0Dy1CQctbd/xMX5F0W4zG1k/IiX8sxXWH
 qZZnVAghMo4/CWkwEcNBZ6s6JHru6mylPwNoTLb8jLwhrwz+y9D4YnKRySb5+tF0ZtW9bau/dhr
 CvvsJjdsQKRru9C+jp4bfaF/w0ffK9GyrDDw/xyohL/FTMqPdL+bKUJHQPASTZzcIFQawkjgD+G
 5YYElbbNLqOyB4Wxby2aKKDdFkqAevJTLjNhIA7NdK9r59v6WjkRkaEui7/sedK2bHZqwJ1UZLd
 LJ/fclFKDDcIIh/IWubccGjPisnnt2bax6PT2N96U/DKeluxMKT8ZnozRwpPSwTPR0opdTeYhU4
 +eSId9kY6KhFxMMz2vCSsBpznj8kCJsHqAipmKun1XJy+2gExAeGx7rA60Vcdm652zan588HvVB
 //EFKbMdtIG1g1ZOJLnUBT53zfjQ9UcS+U8iemoSOqAsbb
X-Google-Smtp-Source: AGHT+IECTJoFjNDaChFbZdKAnvGu7o+s9QKg5aEb1JvoyQOcEqv1jQf0qaIBtbtZ8Jh4dYsaUgf1ng==
X-Received: by 2002:a05:7022:3b8e:b0:119:e56b:c74b with SMTP id
 a92af1059eb24-121722b2840mr17137507c88.16.1766562228596; 
 Tue, 23 Dec 2025 23:43:48 -0800 (PST)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217253c058sm65287974c88.11.2025.12.23.23.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 23:43:48 -0800 (PST)
From: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
To: alistair.francis@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 frank.chang@sifive.com, max.chou@sifve.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH] target/riscv: Add data type views for vector registers in GDB
Date: Tue, 23 Dec 2025 23:43:35 -0800
Message-ID: <20251224074335.571933-1-jerry.zhangjian@sifive.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jerry.zhangjian@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enhance the RISC-V GDB stub to support viewing vector registers in
multiple data type formats. This allows GDB users to inspect vector
register contents as different element types.

New type views using GDB builtin type names:
- Integer types: uint8, int8, uint16, int16, uint32, int32,
                 uint64, int64, uint128, int128
- Float types (conditionally enabled based on extensions):
  - fp64 (Zve64d)
  - fp32 (Zve32f)
  - fp16 (Zvfhmin)
  - bf16 (Zvfbfmin)

Backward-compatible aliases are preserved:
- b, s, w, l, q

Example GDB usage:
  (gdb) print $v0.uint32
  (gdb) print $v0.f32
  (gdb) print $v0.w

Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
---
 target/riscv/gdbstub.c | 120 +++++++++++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 28 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1934f919c0..89a3700508 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -21,30 +21,24 @@
 #include "gdbstub/helpers.h"
 #include "cpu.h"
 
-struct TypeSize {
-    const char *gdb_type;
-    const char *id;
-    int size;
-    const char suffix;
+/*
+ * Vector lane type definitions for GDB target description.
+ * Uses GDB's builtin type names (uint8, int8, ieee_half, etc.)
+ */
+enum RVVExtension {
+    RVV_EXT_NONE = 0,   /* Zve32x (checked at call site) */
+    RVV_EXT_ZVE64X,     /* 64-bit integer elements */
+    RVV_EXT_ZVE64D,     /* Double-precision float */
+    RVV_EXT_ZVE32F,     /* Single-precision float */
+    RVV_EXT_ZVFHMIN,    /* Half-precision float */
+    RVV_EXT_ZVFBFMIN,   /* BFloat16 */
 };
 
-static const struct TypeSize vec_lanes[] = {
-    /* quads */
-    { "uint128", "quads", 128, 'q' },
-    /* 64 bit */
-    { "uint64", "longs", 64, 'l' },
-    /* 32 bit */
-    { "uint32", "words", 32, 'w' },
-    /* 16 bit */
-    { "uint16", "shorts", 16, 's' },
-    /*
-     * TODO: currently there is no reliable way of telling
-     * if the remote gdb actually understands ieee_half so
-     * we don't expose it in the target description for now.
-     * { "ieee_half", 16, 'h', 'f' },
-     */
-    /* bytes */
-    { "uint8", "bytes", 8, 'b' },
+struct TypeSize {
+    const char *gdb_type;        /* GDB builtin type name */
+    const char *name;            /* Short name for union field (NULL = use gdb_type) */
+    int size;                    /* Element size in bits */
+    enum RVVExtension required;  /* Required extension, RVV_EXT_NONE if always enabled */
 };
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
@@ -300,6 +294,53 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_csr_feature;
 }
 
+/*
+ * Vector lane types using GDB's builtin type names.
+ * Float types are conditionally included based on extension availability.
+ */
+static const struct TypeSize vec_lanes[] = {
+    /* 128 bit - requires Zve64x */
+    { "uint128",     NULL,   128, RVV_EXT_ZVE64X },
+    { "int128",      NULL,   128, RVV_EXT_ZVE64X },
+    /* 64 bit - requires Zve64x */
+    { "uint64",      NULL,   64,  RVV_EXT_ZVE64X },
+    { "int64",       NULL,   64,  RVV_EXT_ZVE64X },
+    { "ieee_double", "fp64", 64,  RVV_EXT_ZVE64D },
+    /* 32 bit */
+    { "uint32",      NULL,   32,  RVV_EXT_NONE },
+    { "int32",       NULL,   32,  RVV_EXT_NONE },
+    { "ieee_single", "fp32", 32,  RVV_EXT_ZVE32F },
+    /* 16 bit */
+    { "uint16",      NULL,   16,  RVV_EXT_NONE },
+    { "int16",       NULL,   16,  RVV_EXT_NONE },
+    { "ieee_half",   "fp16", 16,  RVV_EXT_ZVFHMIN },
+    { "bfloat16",    "bf16", 16,  RVV_EXT_ZVFBFMIN },
+    /* 8 bit */
+    { "uint8",       NULL,   8,   RVV_EXT_NONE },
+    { "int8",        NULL,   8,   RVV_EXT_NONE },
+};
+
+/* Check if a vector lane type should be included based on CPU extensions */
+static bool riscv_gdb_vec_lane_enabled(RISCVCPU *cpu, const struct TypeSize *ts)
+{
+    switch (ts->required) {
+    case RVV_EXT_NONE:
+        return true;
+    case RVV_EXT_ZVE64X:
+        return cpu->cfg.ext_zve64x;
+    case RVV_EXT_ZVE64D:
+        return cpu->cfg.ext_zve64d;
+    case RVV_EXT_ZVE32F:
+        return cpu->cfg.ext_zve32f;
+    case RVV_EXT_ZVFHMIN:
+        return cpu->cfg.ext_zvfhmin;
+    case RVV_EXT_ZVFBFMIN:
+        return cpu->cfg.ext_zvfbfmin;
+    default:
+        return false;
+    }
+}
+
 static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -311,21 +352,44 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
                              "org.gnu.gdb.riscv.vector", "riscv-vector.xml",
                              base_reg);
 
-    /* First define types and totals in a whole VL */
+    /* Define vector types for each lane type */
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
-        int count = bitsize / vec_lanes[i].size;
+        const struct TypeSize *ts = &vec_lanes[i];
+        if (!riscv_gdb_vec_lane_enabled(cpu, ts)) {
+            continue;
+        }
         gdb_feature_builder_append_tag(
             &builder, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
-            vec_lanes[i].id, vec_lanes[i].gdb_type, count);
+            ts->gdb_type, ts->gdb_type, bitsize / ts->size);
     }
 
-    /* Define unions */
+    /* Create a single flat union with all type views */
     gdb_feature_builder_append_tag(&builder, "<union id=\"riscv_vector\">");
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+        const struct TypeSize *ts = &vec_lanes[i];
+        const char *name = ts->name ? ts->name : ts->gdb_type;
+        if (!riscv_gdb_vec_lane_enabled(cpu, ts)) {
+            continue;
+        }
         gdb_feature_builder_append_tag(&builder,
-                                       "<field name=\"%c\" type=\"%s\"/>",
-                                       vec_lanes[i].suffix, vec_lanes[i].id);
+                                       "<field name=\"%s\" type=\"%s\"/>",
+                                       name, ts->gdb_type);
     }
+
+    /* Add backward-compatible aliases for unsigned types */
+    gdb_feature_builder_append_tag(&builder,
+                                   "<field name=\"b\" type=\"uint8\"/>");
+    gdb_feature_builder_append_tag(&builder,
+                                   "<field name=\"s\" type=\"uint16\"/>");
+    gdb_feature_builder_append_tag(&builder,
+                                   "<field name=\"w\" type=\"uint32\"/>");
+    if (cpu->cfg.ext_zve64x) {
+        gdb_feature_builder_append_tag(&builder,
+                                       "<field name=\"l\" type=\"uint64\"/>");
+        gdb_feature_builder_append_tag(&builder,
+                                       "<field name=\"q\" type=\"uint128\"/>");
+    }
+
     gdb_feature_builder_append_tag(&builder, "</union>");
 
     /* Define vector registers */
-- 
2.51.0


