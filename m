Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F21FD3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXwr-0002xO-Nm; Mon, 08 Dec 2025 04:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwb-0002vB-LX
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwZ-0000OU-Tv
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:13 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2e239ec0so2455484f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187650; x=1765792450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZl189lS71hA65yLzKHLtYXIj+NYpaKlD7ScPegZA88=;
 b=QJl1gA3uvGyIxoSXVM9OWyi8FKPdRksd6jUrZvh3NmFbQiPgBgCOWQpWVyH3o2CzBQ
 LoEE3xddv8EmjfpD5VemrDoocD3Z6jagJO8d2JmnlFXqiL8ZviPeddXJiu9YXn5tPBoT
 2H1KQTmJyXlTQ8Bsl24dAhoFkIm8cXaOI51jejJ+GmlaBxdxY3xAbPtXAKG+3QvWmO7k
 +V5Kuk9dNTTlwvLP7CL5MGCLN8kqhkcx2ogfEmmukE3XaHgyEEYNfaO0sYYcw8zf+34G
 Fehgm7XaT64kX07HyuNyCYqXhj7y5WzxWz8IacblQeTwF+6HXWctCOxYcnBBXEolezN3
 SNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187650; x=1765792450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZl189lS71hA65yLzKHLtYXIj+NYpaKlD7ScPegZA88=;
 b=jAI7QQ1YqkZfmVud4IT3ahryfTgqX+rQ4zThV34RBZYIkOVJIQxOMEs0VGLO+tl5Hj
 DIQ0ingQHPStVIo/8HvCEp+Z43JTVuJWNs63EfhkbDZmKIr/rqMu2jHl2GisFNxLrfFN
 3PfkX8c7i72JeBx/gvrl6z8RwHJjsIrrhfC4hIxw/dfyDNTjJzcTtxLCjOd7uQN31sgH
 rRfXb/TNj4Pa+Qvz/JMsCu+URNLV4CoXmr6NkQaxhq7DSgnErhbw1C2LfmHgna1GO3Qj
 3dClDolFn9tQuDgzEhsttoEaA6aA2LRVUHumNfvKLwdoilzWB285Dr39+FtXmp19gUCo
 ghcg==
X-Gm-Message-State: AOJu0YyztZvixICgcsuo6IXjMRssOwGG2O8DSbI7kyXd3jld1c2Bd1jl
 PcNbPFcMWcE8+WOEbLUMl6SPv638DGg5ZsujSbvbOzrKPODW6+LciTiCstzlaYQiUuwdA2FWsMx
 7j8Xs3HQ=
X-Gm-Gg: ASbGncvG7NMiKwEhpDCI0Ch3OcM/OvkjtCYCDwSFcGiQyJYotERLbwmo2IQFDsWaD6M
 L1N5suNilLFDW38BnEWBTM4GkrOV5qCLK3mDa//NOYahnPTFUGzZv8aVU/h4AJKYM7+Y+nT/vXi
 ptqWfGZOHfHa7OjBTYUftjQF5uWF1qwOS7Gr7LDaWvBD56zYDevPApL4XmAGLF7HiOlKxwklxal
 39HxlV0WkBh4Ea2OoxBmAUASCxSPBL9S2qHl2PWs4hhTBkRLhtFI+6KGht0DHHi1qjnAn9DhJMB
 pHVek0Ds3R5wJV9HwHlMxl4oGDoEh8i47VX2PYn20wCXu0YOK+3WBgSjhL0H9LH7W6cWfo/M+Bi
 buriKLHd+8ZyHI8rSR8rUstL3RrLzCM2uG5t/V98Ai92h8qb5nMVSlRSsH3sXWKulmpcwWZAC9T
 Eyq9psqJsJ1d3AaYlSTAVC387zmoMQQ6KCTwYvxWy9cBi9fGzoP2xJhsBGza0f+lhrPNmNVds=
X-Google-Smtp-Source: AGHT+IGdMtJn/QxzU4sC2yY28M2zPm4ktwkBcKM8U9pQd7ASEGmqLS6Iw0LF4M9NbZT6ti6bWsX/pg==
X-Received: by 2002:a5d:5d03:0:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-42f89f28575mr6742245f8f.14.1765187649736; 
 Mon, 08 Dec 2025 01:54:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm25796350f8f.22.2025.12.08.01.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Dec 2025 01:54:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 v2 2/2] tcg/loongarch64: Support every TCGCond for
 cmp_vec ops
Date: Mon,  8 Dec 2025 10:53:54 +0100
Message-ID: <20251208095354.25898-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208095354.25898-1-philmd@linaro.org>
References: <20251208095354.25898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
is not supported at all and will trip over assertions, and legalization
(currently just operand-swapping) is not done for reg-imm comparisons.
Since the TCG middle-end will not legalize the comparison conditions for
us, we have to do it ourselves like other targets.

Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
help legalize NE.

Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Bingwu Zhang <xtexchooser@duck.com>
Signed-off-by: WANG Xuerui <git@xen0n.name>
Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
[PMD: Split of bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 45 +++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dbb36a2a816..1a243a57beb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2184,6 +2184,33 @@ static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
                             bool a2_is_const, TCGCond cond)
 {
     LoongArchInsn insn;
+    bool need_invert = false;
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        /* These are directly expressible. */
+        break;
+    case TCG_COND_NE:
+        need_invert = true;
+        cond = TCG_COND_EQ;
+        break;
+    case TCG_COND_GE:
+    case TCG_COND_GEU:
+    case TCG_COND_GT:
+    case TCG_COND_GTU:
+        {
+            TCGArg t;
+            t = a1, a1 = a2, a2 = t;
+            cond = tcg_swap_cond(cond);
+            break;
+        }
+    default:
+        g_assert_not_reached();
+    }
 
     static const LoongArchInsn cmp_vec_insn[16][2][4] = {
         [TCG_COND_EQ] = {
@@ -2236,32 +2263,30 @@ static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
          * Try vseqi/vslei/vslti
          */
         int64_t value = sextract64(a2, 0, 8 << vece);
+
+        insn = cmp_vec_imm_insn[cond][lasx][vece];
         switch (cond) {
         case TCG_COND_EQ:
         case TCG_COND_LE:
         case TCG_COND_LT:
-            insn = cmp_vec_imm_insn[cond][lasx][vece];
             tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
             break;
         case TCG_COND_LEU:
         case TCG_COND_LTU:
-            insn = cmp_vec_imm_insn[cond][lasx][vece];
             tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
             break;
         default:
             g_assert_not_reached();
         }
+    } else {
+        insn = cmp_vec_insn[cond][lasx][vece];
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
     }
 
-    insn = cmp_vec_insn[cond][lasx][vece];
-    if (insn == 0) {
-        TCGArg t;
-        t = a1, a1 = a2, a2 = t;
-        cond = tcg_swap_cond(cond);
-        insn = cmp_vec_insn[cond][lasx][vece];
-        tcg_debug_assert(insn != 0);
+    if (need_invert) {
+        insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
     }
-    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.51.0


