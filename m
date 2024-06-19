Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFA6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pd-0002Ge-Pd; Wed, 19 Jun 2024 17:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PZ-0002Dt-5d
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PW-0000ZT-Gq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f9aa039327so1636525ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830805; x=1719435605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+Ozu7ks7y96Kn86P8uNW/7FLhNhS83VVYtywBJAgxk=;
 b=H7n1dsR7FOtmaJXG/rBsdgeq2GnelmMBK543ap3IeKuCJ9RVOHh9KQUXiC0U2gtbhe
 TdMDXbv7dNDXgtzzPCrmNrbpk+9OCeznIoiHFMFC5GaY+Vrw4h3ZRDzGmXW2YnMTsG/Q
 KWLgOZd4+hxxX4eGMUwcbUnyca2qfjPry6W5XuglvHm+dhKSAFn4h9XqTKxBK92QrDwK
 08BmvgYiwcYOn3B+tFIVFjknzDOrE/QENITJsUddqSigbg+il6kkZjYFlHs5o1KuLeei
 K3Ayn5aLn5H6OJf3gJmlXPoQ/sZHfcze2/8ZiPQ2jT+5StYnlyWXJBBjd2xsZGQQO3TL
 Ermg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830805; x=1719435605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+Ozu7ks7y96Kn86P8uNW/7FLhNhS83VVYtywBJAgxk=;
 b=TQdoSD+CBJiFnvVSuJ1w76yDQgwbRMCPZDLR7z2RpyC8FCc1oS73CTFG6rP+cqfofR
 puX6e8MGRWmaOB6+C3p2j9ydpItB0oAN0SW0Jm/7fhic35IcnGc7e3kzMjWrcPHzo9O8
 WBNEdLgx9XymGQqi8xxzP3xxTrUnZxQi6kDgzb3ugqDOI5X2mo2nGKRtJYRo9psbeQwY
 B3tARyern/tishyGHT4iOqeDsZu5oJhY9Dqq31l/+qndfohCHWe4s3Pub3qKgneSGa2o
 DpbPbrQEZs3RVgI6zi/WcCne6D7dnIGRa7rXFprAJv3cKRKW0Y3DZgJyiYiGhMko/usR
 hjMw==
X-Gm-Message-State: AOJu0Yzu8WIVMNkGqty0blx8JncipVoE0ZSsmqv/kB7JK7Lum0LijX1Z
 SetMFJK4lZhX6fyR3D3vfh/lmmdmMMUHvau8x48hhz5SDqNp2UTwX9uwaUIvDnn8GkdVI2Ki2k5
 Y
X-Google-Smtp-Source: AGHT+IE2WaHDwVcK43idJX3v6Hr9ZNokEUC5fJ2CpEIQ6uhfpGHq/0JbIB5CBqlxzt+APv40LAHmsg==
X-Received: by 2002:a17:903:22cd:b0:1f9:9ea4:6b50 with SMTP id
 d9443c01a7336-1f9aa44fc30mr39389665ad.52.1718830805110; 
 Wed, 19 Jun 2024 14:00:05 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 11/24] tcg/loongarch64: Simplify tcg_out_addsub_vec
Date: Wed, 19 Jun 2024 13:59:39 -0700
Message-Id: <20240619205952.235946-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c7d0c7839b..47011488dd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1774,33 +1774,34 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
     static const LoongArchInsn sub_vec_imm_insn[4] = {
         OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
     };
+    LoongArchInsn insn;
 
     if (a2_is_const) {
         int64_t value = sextract64(a2, 0, 8 << vece);
+
         if (!is_add) {
             value = -value;
         }
-
-        /* Try vaddi/vsubi */
-        if (0 <= value && value <= 0x1f) {
-            tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
-                                             a1, value));
-            return;
-        } else if (-0x1f <= value && value < 0) {
-            tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
-                                             a1, -value));
-            return;
+        if (value < 0) {
+            insn = sub_vec_imm_insn[vece];
+            value = -value;
+        } else {
+            insn = add_vec_imm_insn[vece];
         }
 
-        /* constraint TCG_CT_CONST_VADD ensures unreachable */
-        g_assert_not_reached();
+        /* Constraint TCG_CT_CONST_VADD ensures validity. */
+        tcg_debug_assert(0 <= value && value <= 0x1f);
+
+        tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
+        return;
     }
 
     if (is_add) {
-        tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
+        insn = add_vec_insn[vece];
     } else {
-        tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
+        insn = sub_vec_insn[vece];
     }
+    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.34.1


