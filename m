Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A0AD3B7E8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXwq-0002wG-8V; Mon, 08 Dec 2025 04:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwW-0002uJ-19
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwT-0000BL-OX
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42e2b80ab25so1729614f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187644; x=1765792444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWqIBkKZOyRnim34uX/x2qcoNQZW/zRSJlzTBCI0DFI=;
 b=fLndou6qnzIzB1VrOfptEfIxJapOjv1oBo6NpkZKN/Pn5z107E68aMLdVGWf68UJWS
 Bg7/cM3C1h/E1KHttOExb5EpH8ONayrkQUm4Oh93UoQl/qniy3zpUMOBjqSSfqdfJTTR
 d8P7QykPp2ZrqtF4Bzzw9nZV118ArBDKzF7XswdIjR0KrlG3cAnybBtatZ7QLnKumRC8
 tOjv44H6/cVba/IIg14dgwYnN2kajMiskV3fS3ufTh4lj8JwN48183/vZzJyhvqC+oPS
 jgY76LGJtVuO+7gDgjyBNlqsgbwpp4yLX4rvdv6pyoAyjNyoSGziOOgzyKefPWLeQbVL
 X3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187644; x=1765792444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWqIBkKZOyRnim34uX/x2qcoNQZW/zRSJlzTBCI0DFI=;
 b=m4MgOhz+inVqZhMNt9zqMU4NHlUZGh3RwyXfr6ezEvPUpE/Fj5TEZ8Aym63GT099Gq
 fxSGhIrUZP8kVxKEsiUf2Bt6fwypLORf4yls/z9Fo/5FTmgeVcjAe2toTUOR2I5G7nw9
 6j+lqHZk6QMQPzMAb5rdWicodaPhu1BePZWiitFcBrbFu8vAdBZR2cjOQkGy36l2325c
 mAUT4VkUIz71gZbU89kZEGzctLgpfKYVNFyrYppYXec7Nm1grg3pNAGw66GpVQIF8E23
 HXaUd8rtY6+bzCLF4hLASRBvSwcSHLOp3d4sRfnJEkpI+KlAhT1nDcrP2+ElzwDlDmcl
 8PvA==
X-Gm-Message-State: AOJu0YwyFzsQ/aKACMuFeM4wG2eT/6AoJbbAJmhTp8LRMi6z8lneofE8
 X5T9Xt9TibuCqa7qkHzERFzHPJIlmNj06lbV1mpNoWOAG3G7bg7WWEb/1IMBQI61aRlWLimynVx
 DJD1Swx0=
X-Gm-Gg: ASbGncsZ9mzjU2XNArkrEkETAhKbdU/RYsHrk+20av62ou5wOMCd1AfbG6qoeCHFp/B
 IxZKoO7iQ6nrmS5kqqo3ZVMULkLGGQKLXdrbpAnu3J8dpdLhBCW1tCXUjXZh76NXiyIgIdAGeK/
 O4/uTDKOtmDnr/PZSmC5j5wPbb6fGy8/ouyIJ68/RLUyYhtuW6C2e/Gmu9PbIclU8Iyoe0yt+py
 cD9ESScVqaT+YxNhd9Lw/256aW9NEJDQnAO75QwmCKCVLCnapNwc07e9rTF8jt0uDLP/aqk28jG
 MVPl3TsXLTD5ihm1SE3L7Wt0yK+QnkYFHcauP4RiQXJAN5N4X2FYdQHDODBdEuoyU2KSdB+neqh
 w2eq8PIKuH1IpU+EmrZGRKRS5pya5BvrIr5Wtf3vZJN16kiB3XF/SpG25hbJ/R2hns0qRaHTsoM
 ryGvsU75SpbPh6YQjK4NG6qC4ZyuhgDxjZY7M6NMMnK346TAtwrkglvc5UDxWI
X-Google-Smtp-Source: AGHT+IFFgR01Kxkr8QwaH4NcjFECvVcyCdzZyigUMf7zpmBIWNonexfamOKiT9hpfCDXRIVvqt9Uaw==
X-Received: by 2002:a05:6000:220f:b0:42b:53ad:bbfa with SMTP id
 ffacd0b85a97d-42f89f648d2mr7570230f8f.53.1765187642991; 
 Mon, 08 Dec 2025 01:54:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7ca4f219sm23360153f8f.0.2025.12.08.01.54.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Dec 2025 01:54:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 v2 1/2] tcg/loongarch64: Factor tcg_out_cmp_vec() out
 of tcg_out_vec_op()
Date: Mon,  8 Dec 2025 10:53:53 +0100
Message-ID: <20251208095354.25898-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208095354.25898-1-philmd@linaro.org>
References: <20251208095354.25898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: WANG Xuerui <git@xen0n.name>

Lift the cmp_vec handling to own function to make it easier
for readers.

Signed-off-by: WANG Xuerui <git@xen0n.name>
Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
[PMD: Split of bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 94 +++++++++++++++++---------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 10c69211ac5..dbb36a2a816 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2179,14 +2179,10 @@ static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
     tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
 
-static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-                           unsigned vecl, unsigned vece,
-                           const TCGArg args[TCG_MAX_OP_ARGS],
-                           const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
+                            TCGArg a0, TCGArg a1, TCGArg a2,
+                            bool a2_is_const, TCGCond cond)
 {
-    TCGType type = vecl + TCG_TYPE_V64;
-    bool lasx = type == TCG_TYPE_V256;
-    TCGArg a0, a1, a2, a3;
     LoongArchInsn insn;
 
     static const LoongArchInsn cmp_vec_insn[16][2][4] = {
@@ -2233,6 +2229,51 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             { OPC_XVSLTI_BU, OPC_XVSLTI_HU, OPC_XVSLTI_WU, OPC_XVSLTI_DU },
         }
     };
+
+    if (a2_is_const) {
+        /*
+         * cmp_vec dest, src, value
+         * Try vseqi/vslei/vslti
+         */
+        int64_t value = sextract64(a2, 0, 8 << vece);
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_LE:
+        case TCG_COND_LT:
+            insn = cmp_vec_imm_insn[cond][lasx][vece];
+            tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
+            break;
+        case TCG_COND_LEU:
+        case TCG_COND_LTU:
+            insn = cmp_vec_imm_insn[cond][lasx][vece];
+            tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    insn = cmp_vec_insn[cond][lasx][vece];
+    if (insn == 0) {
+        TCGArg t;
+        t = a1, a1 = a2, a2 = t;
+        cond = tcg_swap_cond(cond);
+        insn = cmp_vec_insn[cond][lasx][vece];
+        tcg_debug_assert(insn != 0);
+    }
+    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg args[TCG_MAX_OP_ARGS],
+                           const int const_args[TCG_MAX_OP_ARGS])
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    bool lasx = type == TCG_TYPE_V256;
+    TCGArg a0, a1, a2, a3;
+    LoongArchInsn insn;
+
     static const LoongArchInsn neg_vec_insn[2][4] = {
         { OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D },
         { OPC_XVNEG_B, OPC_XVNEG_H, OPC_XVNEG_W, OPC_XVNEG_D },
@@ -2347,43 +2388,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
         goto vdvjvk;
     case INDEX_op_cmp_vec:
-        {
-            TCGCond cond = args[3];
-
-            if (const_args[2]) {
-                /*
-                 * cmp_vec dest, src, value
-                 * Try vseqi/vslei/vslti
-                 */
-                int64_t value = sextract64(a2, 0, 8 << vece);
-                switch (cond) {
-                case TCG_COND_EQ:
-                case TCG_COND_LE:
-                case TCG_COND_LT:
-                    insn = cmp_vec_imm_insn[cond][lasx][vece];
-                    tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
-                    break;
-                case TCG_COND_LEU:
-                case TCG_COND_LTU:
-                    insn = cmp_vec_imm_insn[cond][lasx][vece];
-                    tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
-
-            insn = cmp_vec_insn[cond][lasx][vece];
-            if (insn == 0) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][lasx][vece];
-                tcg_debug_assert(insn != 0);
-            }
-        }
-        goto vdvjvk;
+        tcg_out_cmp_vec(s, lasx, vece, a0, a1, a2, const_args[2], a3);
+        break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
-- 
2.51.0


