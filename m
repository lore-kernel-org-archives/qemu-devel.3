Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED34CA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR1l-00022X-9i; Tue, 19 Aug 2025 14:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1B-0001TN-2g; Tue, 19 Aug 2025 14:25:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR16-00049e-R4; Tue, 19 Aug 2025 14:25:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b474e8d6d04so1586294a12.0; 
 Tue, 19 Aug 2025 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627901; x=1756232701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJ2AmRGKg71BgJxwHycIvBP2PoRXyVHsYPqFMrkrais=;
 b=QI2brFdqdm8L+BvzgVoo+S+dka6AkBgcQsFmyNDY1och6f63T8Eeg4CI+J3pdqFFbw
 t4DDcjvwTxu+z19u/xP4nwUDkaeKIJKEtRGyKuDx+e/8yxA0m8tXJ53OgEMLmwRZgbxd
 XFU1tZItEjzX04Kfl2nBK6dORmSf3Jmof1wliw4IZe+Gd3NNmYwgVXknY4TGQxAbatqi
 Nj40FQvHFXPhHdTQDgEFcaXBQEyOFKOF0ABC0ZfYyiq5VL1ZZzby/X+fQ8VIWE6mqrLv
 tZiZkCVeqBZyFJdKD1oS84pyQ6dSMGG21e4DE6OcFA+vTTkM5eZc/90GIXnsF81SUi8r
 uIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627901; x=1756232701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJ2AmRGKg71BgJxwHycIvBP2PoRXyVHsYPqFMrkrais=;
 b=l4DR0GkKSF/9WMX4wH8s7OIJgcshF140IUCyuzfg1aGCDP62vibloUt0vTq9EonhsU
 CZCwN3vsapFBI3ks+hJnpJ0omvim5os8n2TMS7gESdPLBdjvK7ewmzTNagKZN92aKqgX
 Z3Q4jkwuhBVypCL8RlyLx/m9KauFqQ0F1xE3R/zGB6wLXofdkZbg5tzjVW7S6BtzFA46
 7DiaC6pAMjmr8R79Coh2Me+R+uY/NEpOzj+Qg4xEJTiwaVbfVt9bfWSAfSbTnQDChc55
 sVlNYyfqouHKvw31eVhMNzPTYKLeaYDVJ49zgzavb2QFrVrInrJb0A0rB0bM+z7F2QiQ
 oKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSa3zsz2o6u7XsNRqjgeInAVqaGhx8if+xLx3G6DPD4+IIxnm6sMvFSZSBhvJI2Y77B3R7e/qiJA==@nongnu.org,
 AJvYcCVqHj0zKWluqThVPalM7otf3g3uneRI7OmhkQ9o0rYi7H8MiCqErLL4B8tyd6HagJdURISxAZ2HzCCZQg==@nongnu.org
X-Gm-Message-State: AOJu0YzstkXe73wCt94GlAt7lDLjOs4paab9YPx9XzjkTvwhWFC3Z6c0
 uKQE3+iodo/JTRM4Mb+tfyM3pToBZ40acpEZH0vZ1JWLT2cqo3K5Cf48a7pASA==
X-Gm-Gg: ASbGncvCFYXjxeZnUIj3l64Rj9V/sIRSjHtS9XjQf1Xh2vVqyQYPHjPx6EmZK6ZXydb
 vxTGtfAaGASv3PvnvxHgdGVYzAHsiZMMpEb1zxbgmRkTCbPzmfhDoq428bubPd3MiqQo5KIYjmc
 KoQXwgkbpx0OzwGnoIcA1eVyFFII5H/qgcljOROquVtnOBMtbj8yskja2E1uUVvUd7RNkznLvfj
 xTZnTJzRrLTwPb2J8nRjaqCcGS0jHIq+6PxfASc/NAmL2EFV8JiOmDnPmKZacc+bLxsjOK77Ukv
 ReHTNsQW5dP+tL2lSOPUkmqlWubAYFYtKMWnwEVJyP9FXmGl626FyS3uQrnhAojMf+K41zRabHR
 O4IHK0OtBkniU/m+tXpjAxA==
X-Google-Smtp-Source: AGHT+IEKRG45BU+fO3Sa1lBHip2Ekmy/CpCu0yzlt0rex6zd0LjhamAbNxOkzWjxSEtMr0H2n48Bbg==
X-Received: by 2002:a17:903:2346:b0:23e:22dc:665c with SMTP id
 d9443c01a7336-245e0492439mr52750485ad.33.1755627901085; 
 Tue, 19 Aug 2025 11:25:01 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:00 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 26/35] tcg/wasm: Add qemu_ld/qemu_st instructions
Date: Wed, 20 Aug 2025 03:21:55 +0900
Message-ID: <aeaf5cedd55a620870255106d232a3ba47fad40c.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit adds qemu_ld and qemu_st by calling the helper functions
corresponding to MemOp.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 95 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index d7d4fd4e58..db92463941 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -1155,6 +1155,99 @@ static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
     gen_call(s, info, func_idx);
 }
 
+static void *qemu_ld_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu;
+    case MO_SB:
+        return helper_ldsb_mmu;
+    case MO_UW:
+        return helper_lduw_mmu;
+    case MO_SW:
+        return helper_ldsw_mmu;
+    case MO_UL:
+        return helper_ldul_mmu;
+    case MO_SL:
+        return helper_ldsl_mmu;
+    case MO_UQ:
+        return helper_ldq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_ld(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+
+    helper_idx = (intptr_t)qemu_ld_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(data_reg));
+}
+
+static void *qemu_st_helper_ptr(uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        return helper_stb_mmu;
+    case MO_16:
+        return helper_stw_mmu;
+    case MO_32:
+        return helper_stl_mmu;
+    case MO_64:
+        return helper_stq_mmu;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_wasm_out_qemu_st(TCGContext *s, TCGReg data_reg,
+                                 TCGReg addr_reg, MemOpIdx oi)
+{
+    intptr_t helper_idx;
+    int64_t func_idx;
+    MemOp mop = get_memop(oi);
+
+    helper_idx = (intptr_t)qemu_st_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    /* call the target helper */
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_AREG0));
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(addr_reg));
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        break;
+    default:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(data_reg));
+        tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+        break;
+    }
+    tcg_wasm_out_op_const(s, OPC_I32_CONST, oi);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (intptr_t)s->code_ptr);
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -2319,6 +2412,7 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
     tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    tcg_wasm_out_qemu_ld(s, data, addr, oi);
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
@@ -2334,6 +2428,7 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
     tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    tcg_wasm_out_qemu_st(s, data, addr, oi);
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-- 
2.43.0


