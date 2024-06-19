Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233B7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pi-0002Lo-Di; Wed, 19 Jun 2024 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pf-0002Ia-4S
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pc-0000cX-0s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so1513645ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830809; x=1719435609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXrcZPJg9tD8QWTHQJSaM14aI8LugozoDgK8l3jvBvo=;
 b=YwCBA3DOhof1nrSC3TBqGkKlt5bS1sZG3OCTBVKqlawz6M7e/yPXgznCiud2qP93c9
 a8y6STFxIGPK1Z0fRCPX/ElGv45SeVkh/22xELzhOzMU7z9ZoxQyaMW63/PBOaTK+gAp
 JFlNHt/lcn402fiI7cTde4FOuaoePCtV0HnQAIIg4E0oAt1EtGEcQ7Gn/nnhD2v2rM4s
 tND22N8cdse4ko4WYK734l+SrZA2Dr6uW4uHreXfoRYhXIm+QlodI0ciquz/ibdWo6i8
 Jm/EEukj+9rUo+yo6UmlbXDzEdSh6d73Xgo9ORLv+5EAOx4ydLzL3rrgFtZsT4NqUbHB
 mEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830809; x=1719435609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXrcZPJg9tD8QWTHQJSaM14aI8LugozoDgK8l3jvBvo=;
 b=N+H/zFkUHJbdt6h0/dn+NL8L1xAx7co2jbWgkmoX9zb4npMMd9d7BelLqzp0YPG/Bb
 QQyveP5Bazy2zsVU18hLJo5F8nPIzpwk8+CMn8/ztP3nXiiw9/eeNTHw+ksGC3hVWljr
 r4lxK8bWj/AsWVYmR+bD+g8IvMwIaqSx7cpgTzfGp93gyM56T2auIxBXBHQkwHUsfHuX
 WiCOgY7CDQnQlHJ8lHbDTZALkLdApMUci7MvEacY6AMVWxxbjlsx8B0OlrmfarMh8lmc
 7yRlUaPyOcArU82JZcY2/oqvqGrbN16NWfNG2uP6J5K1NAz3D4K8noW3VhUA1PTCgCFo
 3gnw==
X-Gm-Message-State: AOJu0YzS62TA46jy/MJFMr0GiC3MM3l9lLDNyCggZ2bgGTkfXZH3DTcJ
 isMGXa1W2Wp/CoDiqkiWUgvaWUSf0jYCQxRw7b+KDHDWhM5ZuxGZTkJ0gLe2R2IFa2ah4c4XBzW
 A
X-Google-Smtp-Source: AGHT+IEo+ZxY/gNBEJoM9YH5HZ3HwiAKQwRAfFDiYp20WmxjgHk0QMljEkob5P99PLeZi/OtMcfodA==
X-Received: by 2002:a17:902:dac6:b0:1f8:6bc7:e9db with SMTP id
 d9443c01a7336-1f9aa3c33b3mr30597725ad.23.1718830808988; 
 Wed, 19 Jun 2024 14:00:08 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 16/24] tcg/loongarch64: Split out vdvjukN in tcg_out_vec_op
Date: Wed, 19 Jun 2024 13:59:44 -0700
Message-Id: <20240619205952.235946-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Fixes a bug in the immediate shifts, because the exact
encoding depends on the element size.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 58 ++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1d9e0bf028..ab1b67e028 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1901,6 +1901,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn rotrv_vec_insn[4] = {
         OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
     };
+    static const LoongArchInsn rotri_vec_insn[4] = {
+        OPC_VROTRI_B, OPC_VROTRI_H, OPC_VROTRI_W, OPC_VROTRI_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -2034,15 +2037,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         insn = sarv_vec_insn[vece];
         goto vdvjvk;
-    case INDEX_op_shli_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
-        break;
-    case INDEX_op_shri_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(shri_vec_insn[vece], a0, a1, a2));
-        break;
-    case INDEX_op_sari_vec:
-        tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
-        break;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
@@ -2051,26 +2045,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_rotrv_vec:
         insn = rotrv_vec_insn[vece];
         goto vdvjvk;
+    case INDEX_op_shli_vec:
+        insn = shli_vec_insn[vece];
+        goto vdvjukN;
+    case INDEX_op_shri_vec:
+        insn = shri_vec_insn[vece];
+        goto vdvjukN;
+    case INDEX_op_sari_vec:
+        insn = sari_vec_insn[vece];
+        goto vdvjukN;
     case INDEX_op_rotli_vec:
         /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
         a2 = extract32(-a2, 0, 3 + vece);
-        switch (vece) {
-        case MO_8:
-            tcg_out_opc_vrotri_b(s, a0, a1, a2);
-            break;
-        case MO_16:
-            tcg_out_opc_vrotri_h(s, a0, a1, a2);
-            break;
-        case MO_32:
-            tcg_out_opc_vrotri_w(s, a0, a1, a2);
-            break;
-        case MO_64:
-            tcg_out_opc_vrotri_d(s, a0, a1, a2);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        break;
+        insn = rotri_vec_insn[vece];
+        goto vdvjukN;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2083,6 +2071,24 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     vdvjvk:
         tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
+    vdvjukN:
+        switch (vece) {
+        case MO_8:
+            tcg_out32(s, encode_vdvjuk3_insn(insn, a0, a1, a2));
+            break;
+        case MO_16:
+            tcg_out32(s, encode_vdvjuk4_insn(insn, a0, a1, a2));
+            break;
+        case MO_32:
+            tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, a2));
+            break;
+        case MO_64:
+            tcg_out32(s, encode_vdvjuk6_insn(insn, a0, a1, a2));
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     }
 }
 
-- 
2.34.1


