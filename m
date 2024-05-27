Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D9C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhke-0007EB-3C; Mon, 27 May 2024 17:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkc-0007Cj-NO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:26 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkb-0003eE-3i
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8e9555eabso104817b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844764; x=1717449564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXObFDu8a3M57Hv1fEFHdefFhD2xo5Ijf75RZMjb8TM=;
 b=RO+mzuhAk+FNhSya1eBk4xlxLcPDfN8jeYOE6dtj1Lhu36rDdQHsVa/dc5wIz5+jps
 /s1u4dTJsT5KlyyENTFSKdqxgcvfOsOgU9+Cudv6+whdytSBDKx6PJRZQ40KFiYYSDdw
 MvJjE6rHWuC4cHwNu7TDZ6pAQCFZlnOcLBYVnLRCZwY8RsEdPnVuKHIq+vsN2ci3Vika
 zcEgSn+atf3ZfaRAL0HfgR+XPegSNqLtXakawHPMhthyt1IGCk9bsbuKiHa22qMPC4vG
 pnltI4QOcElZae8cSRiQS+cDr0Ej56uP0YaFCWFCTOR+JG95bR8E2zQxjNj7op8FZxzD
 B+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844764; x=1717449564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXObFDu8a3M57Hv1fEFHdefFhD2xo5Ijf75RZMjb8TM=;
 b=X9lHSSMSgvppBvmP716mNP4O5vifU63udkCLNRhdV74dKzY3LuZ2JHYJoqZKH04B2P
 lcn2ME0tkmYQFCNzoGfB/acP5u7l8EZcSsxENWmOmoxkbB0yfMho/KnypCIquqOl80Sm
 scJVv/sFxTKK1MD3y9DlKiBM5HYUDQ1JM0O9BquzZe56K87dDxVNtpeRrk5sUCxvDtZW
 JR1hcttcmo/sR7oAfnmHT4DKs80dmJYz7X7/US155yXPTQCd8VnJwyjfNVQQ/4GeuGgO
 b63C6sCPKYtwYl1INthhyShu93uO36DMypYYjS0HBkAuElS2KvypRQtUt0OzmvcF5V0+
 SmDQ==
X-Gm-Message-State: AOJu0YxRLyZrt5vreySoyDXYSWH00MnvGbqKDcS6xOPG8dgNSGCYBlhv
 BaSiU+TkRITdQwfIZ4ZKBUri6v/oLajEgXv6xN6qQM57SpXor9E/6pxEguIYEbfrygLtE5I4egB
 s
X-Google-Smtp-Source: AGHT+IF4n5ynPucO2+U/vvbgwXQm4zPyUNHQ42RovatDa6lwoJfZsWmEUQ89w1qzPxb4ppem5LUWtw==
X-Received: by 2002:a05:6a00:4c12:b0:6ed:41f3:431d with SMTP id
 d2e1a72fcca58-6f8f1a6a5aemr11447070b3a.0.1716844763798; 
 Mon, 27 May 2024 14:19:23 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 11/18] tcg/loongarch64: Simplify tcg_out_addsub_vec
Date: Mon, 27 May 2024 14:19:05 -0700
Message-Id: <20240527211912.14060-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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


