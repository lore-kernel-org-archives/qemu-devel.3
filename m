Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D04C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMUs-000429-VH; Tue, 20 May 2025 08:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUQ-0002Tc-07; Tue, 20 May 2025 08:54:40 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMUM-000113-CF; Tue, 20 May 2025 08:54:37 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b26f01c638fso3938626a12.1; 
 Tue, 20 May 2025 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745671; x=1748350471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW1RsXRiDX3fR+HjAtpX8n14C4CKemsei/P4rdx2cjg=;
 b=IbRbXF6CR07Yk3SkQebshaQYPAqXSF/x9IZw78JtJGs+sq2sLhg17nicQJ6zZDPkse
 /rqQVKSgKu1UhZCeSsCxIx/OVerLHzdoxiuv5rcQ1FW09imOC4wWlTNu25nt35NEmTPu
 WkMrW6HUVyOW4+MC7wlicfwyp/25JplvfNRATQQXSwVS1KeBxJf3C6fOz70UcLEW993Q
 cyo5IsrXTNnZRo9OlRA+Jn/MSVdyE9PhQN4hcheLqykuAsEENMxGuladKGRzhprEgr/B
 8/CEFvKS1kR7ksxUeSXsfgMl7wbiKQ01f85yC2VhvpGIC2d8I/9/6K3UG+yHvhLkJE9c
 nAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745671; x=1748350471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW1RsXRiDX3fR+HjAtpX8n14C4CKemsei/P4rdx2cjg=;
 b=IXeh8G9NYcVowzkIWSXRCYVH5qfTITJgZ4CqpUy0TcknIAgqLex0yD3eDFN/+Lu0hj
 FGa5uuqj/rrCYwjMv6o5JwG+xfutW+1jVDHZbzaUGsMM80ld28NF4maSc8K06kRgKtf4
 hh7I5DsBQSwW3KqhL/I0dqHrt2WkJKNIwSqQEKn2XDvVK0QSJcysJBEMNjjjXDbsYGGX
 Mns3hfSpRh05YTg1jQsTIGeZWO/IGnqXj4iBPqGHljcbOGYEkQWX1WBqWsSAW7CgV/pj
 2b0B2n0nzSEcA5nik+odBL5KsH5ZMJRKAYAwlx1UQqr2/e2Yh1X1x2RY7EgBF3vlKReM
 6fqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIf9TbFojvmeL3gz7ISwbIhEotpg0ERuwld2nHELocBpvuHJpRo6V8tCPYJJ9e6WsNqV6emXX6NA==@nongnu.org,
 AJvYcCX4moMwlwETCPatVHsw1cWa6+2cqjYdLLUBzANOW9e1CJod74ld/SWY21vz7bn/ewoE4xUyWtc+KbdJbA==@nongnu.org
X-Gm-Message-State: AOJu0YwFNBMRNZYIhQiR2QTGP2zrbeAIbIPKDSH0ZDbMMPU8hD2oMY8V
 zlpcd/Twka/M7Ev7RYt+FBcPZp3+AlQEWsYMJ47sJacI++j7Yer1KJvLHb1qVRAH
X-Gm-Gg: ASbGncsf+xDlER3vuaSEcyQKXVNgykh2wjRigXDG1LKr6XM/j4IpGMH+jTqARHFSIhz
 QrvZ0vS/8XQBvD3Gs2ILwdnNu2PrIjI9ElcXnCYNvyfXcX7XXQSM/sPYUkpGefMDrD9jkCAbxvV
 p/eD0f/oOyt0B9Jk3AY7O3tMNw9uS5vrEIDcbfZZTZdCyIkH6G/da/4F4Md1B9iQQ+n1s/99eew
 uyvKpJnaCyc+AtT3LsAQAK0ve+rizdmZZhyHiEOguTZbvEpKdytzZgmQQ0f/t72bPDyLlDYXazr
 WrofQW/QoPsd6vGdBS0LP7D64BWtJghHGeVi2Xlt44Ydn4iHSxU4zGbGkTE8sw==
X-Google-Smtp-Source: AGHT+IEugiza3fgduRxn2ow9OvjRvHyOfJwN+IFpHUh7HXpHpxCh+bAzoEvIlSNWAfmhOeZyaMK5eQ==
X-Received: by 2002:a17:90b:3905:b0:2fe:b8ba:62de with SMTP id
 98e67ed59e1d1-30e7d5a96d7mr26190895a91.25.1747745660242; 
 Tue, 20 May 2025 05:54:20 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:54:19 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 22/33] tcg/wasm32: Add qemu_ld/qemu_st instructions
Date: Tue, 20 May 2025 21:51:24 +0900
Message-ID: <50dd6a8e7cce06b191b1dbb3c5cc470e0819a566.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x533.google.com
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
 tcg/wasm32/tcg-target.c.inc | 108 ++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 708af1fbb6..ea9131e6fe 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -1793,6 +1793,112 @@ static void tcg_wasm_out_call(TCGContext *s, int func,
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
+    int helper_idx;
+    int func_idx;
+    bool addr64 = s->addr_type == TCG_TYPE_I64;
+
+    helper_idx = (uint32_t)qemu_ld_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    if (!addr64) {
+        tcg_wasm_out_ext32u(s, TCG_REG_TMP, addr_reg);
+        addr_reg = TCG_REG_TMP;
+    }
+
+    /* call helper */
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    tcg_wasm_out_op_i32_const(s, oi);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+
+    tcg_wasm_out_op_call(s, func_idx);
+    tcg_wasm_out_op_global_set_r(s, data_reg);
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
+    int helper_idx;
+    int func_idx;
+    bool addr64 = s->addr_type == TCG_TYPE_I64;
+    MemOp mop = get_memop(oi);
+
+    helper_idx = (uint32_t)qemu_st_helper_ptr(oi);
+    func_idx = get_helper_idx(s, helper_idx);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, helper_idx);
+    }
+
+    if (!addr64) {
+        tcg_wasm_out_ext32u(s, TCG_REG_TMP, addr_reg);
+        addr_reg = TCG_REG_TMP;
+    }
+
+    /* call helper */
+    tcg_wasm_out_op_global_get_r(s, TCG_AREG0);
+    tcg_wasm_out_op_i32_wrap_i64(s);
+    tcg_wasm_out_op_global_get_r(s, addr_reg);
+    switch (mop & MO_SSIZE) {
+    case MO_UQ:
+        tcg_wasm_out_op_global_get_r(s, data_reg);
+        break;
+    default:
+        tcg_wasm_out_op_global_get_r(s, data_reg);
+        tcg_wasm_out_op_i32_wrap_i64(s);
+        break;
+    }
+    tcg_wasm_out_op_i32_const(s, oi);
+    tcg_wasm_out_op_i32_const(s, (int32_t)s->code_ptr);
+
+    tcg_wasm_out_op_call(s, func_idx);
+}
 
 static bool patch_reloc(tcg_insn_unit *code_ptr_i, int type,
                         intptr_t value, intptr_t addend)
@@ -3128,6 +3234,7 @@ static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
     tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    tcg_wasm_out_qemu_ld(s, data, addr, oi);
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
@@ -3153,6 +3260,7 @@ static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
     tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    tcg_wasm_out_qemu_st(s, data, addr, oi);
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-- 
2.43.0


