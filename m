Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5CEC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Jd-0002k2-6X; Thu, 17 Sep 2026 04:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JE-0002f2-AM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:34 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JC-0001um-Fc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:31 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso550600a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633049; x=1790237849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jSbuINkZZAU8hKwWhatrX/MpAAIvtsFEeGWZUbc8Gds=;
 b=f03yM8w6gdl1nabx+QdlRGC1qeEu1ueogs+pYK4QFpk58wYvgohXVt75vqYkImDOzk
 RyysqmSftugYvuDhWIvG3c0GxqV82NfRMQWuCtHDi5DC2jeyWN+Ctl+WhxtCyIYLAXMp
 rsafP2l2lqGLqfYovW3UZfpd69hSmrFnjGtd3LoMNwzwBUcwpiNfJ0Q53r7ZWlFXWaqa
 lmLOxniDYDd4uInHT2Be3h5uEkiNoT9GoV+4H1wigYpqYmIRP35+l0bYbr1A/Wb62J/U
 me+on4fIDPCxI1i3modX6cXJkxmNV+C2vTwqJ/4CONvIpw1ZvHSKVbr2UuDHtamZJb6/
 ZpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633049; x=1790237849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jSbuINkZZAU8hKwWhatrX/MpAAIvtsFEeGWZUbc8Gds=;
 b=QQiyQhj+BMNYaHQ0WwBGWA/yuN+/LmyZF7ClXRPYA1i+0Mf7WwTuVhz6PeG1AB0fxQ
 gU5XXE3W+78TCUOyHW2Xgy/7WYWwSsCeGmlz6wAXQN0cVnhHl7Wg8xnufjSJphagcpVT
 OrxAD/kztHRgNqmNYCk5EHDFCsCpQxIzOWhr70xghxUe7B5Dd5Fr01SwzXVSkhfNYkdQ
 3IsiuVPz1fUB8udPtcmN3WDIUUk7oWjJR9taUhsFifyosyJQRHhGv6T/cnB5ltiWKtXT
 jf3AAE3sbXgeaGX0cAPJ+BI91eV2/WBGNn1QF0ramNRneDod8MY5H17iNKFu6wFgxYFX
 e/Dg==
X-Gm-Message-State: AFuF++lzPdmmedw0P6vKN+wdtKlV8rCdiIzSkAXcpZ/MF+oq5iifv74D
 835XL2qYcbx43Q24gxa/t0PYtGT4KHY9TVjyqjbSrd6yVXaJSekP+gDs743ry3/5y0TKCjw45TH
 Zi1HW
X-Gm-Gg: AYBFou1KNxec1W/uAcErmFUAw76xvHlT8iJAkXsmKPOC/epYVu40ZW/jlg6mNybKE7y
 jxXD2c+TRLOyMkAX3DtOpc6TiG/GpQyYzsRpgE1VV3VsLix5pDxa4fGvqmhAZKfnnsfU5Snk5JC
 /+8mMHn47KsBDNhaPYb5uPJdhBu9Up/eFIIgzQfA84Is8rldHJAFRfcUEuJcxo4hZvJeA7L5zF3
 XWPxfYlDCAukeKuOBXIrILfansiEuBtas8J64ffVXFClgN+nyHQhwjeJgSjIQGAPMWlKZ5+Cvk1
 ZB6I+b6qr9IToK9kjakuCX3EKXzzYu4DdyJPtD6rC5R6LRazo4jE3t5oFPLlslSDLCRUCwEEx6C
 Cwv1DwYsL4EfR0EM6rEuCsabIy6yrlQw0L5OmyUDIwBAMXp6/vweUyYdmQnCHxvqy1fbu6WZD9k
 wnPfm4cxH23HdXbLWVi4YEDQMx5DmNAUm0bgstv/sQ8nzuC9zBWviLbx4XW5X5tflLfhd74GEMp
 5dEo2A=
X-Received: by 2002:a17:90b:560e:b0:39e:3bd2:8998 with SMTP id
 98e67ed59e1d1-39e3bd28b84mr7505010a91.22.1789633048826; 
 Thu, 17 Sep 2026 01:17:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 09/16] target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
Date: Wed, 16 Sep 2026 22:17:09 -1000
Message-ID: <20260917081716.946668-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 192cf43215e..ce14d1be028 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1615,31 +1615,32 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 {
-    TCGv ea = NULL;
+    TCGv ea = (a.base >= 0 ? cpu_regs[a.base] : NULL);
 
     if (a.index >= 0 && !is_vsib) {
+        TCGv index = cpu_regs[a.index];
+
+        if (ea) {
+            tcg_gen_lea_tl(s->A0, ea, index, a.scale, a.disp);
+            return s->A0;
+        }
         if (a.scale == 0) {
-            ea = cpu_regs[a.index];
+            ea = index;
         } else {
-            tcg_gen_shli_tl(s->A0, cpu_regs[a.index], a.scale);
+            tcg_gen_shli_tl(s->A0, index, a.scale);
             ea = s->A0;
         }
-        if (a.base >= 0) {
-            tcg_gen_add_tl(s->A0, ea, cpu_regs[a.base]);
-            ea = s->A0;
-        }
-    } else if (a.base >= 0) {
-        ea = cpu_regs[a.base];
-    }
-    if (!ea) {
+    } else if (!ea) {
         if (tb_cflags(s->base.tb) & CF_PCREL && a.base == -2) {
             /* With cpu_eip ~= pc_save, the expression is pc-relative. */
             tcg_gen_addi_tl(s->A0, cpu_eip, a.disp - s->pc_save);
         } else {
             tcg_gen_movi_tl(s->A0, a.disp);
         }
-        ea = s->A0;
-    } else if (a.disp != 0) {
+        return s->A0;
+    }
+
+    if (a.disp != 0) {
         tcg_gen_addi_tl(s->A0, ea, a.disp);
         ea = s->A0;
     }
-- 
2.53.0


