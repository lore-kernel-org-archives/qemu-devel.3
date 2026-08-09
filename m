Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE59C5AD7B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7j-0000nE-AO; Sun, 09 Aug 2026 18:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7h-0000m7-LW
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7g-0007Kr-4Q
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so1292966b3a.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314963; x=1786919763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qgTTE57E6VDpc7y6ZZqT+hvgo0JgyQBjCGNKyS2wwVI=;
 b=KPKTP/NTrWJuo4h9+baebgxM9KUjafPlXPcXoVWdipQ5hUFSa6yunWI1k+ufn8Yi+b
 IW0PS+FC+SgQs1+ZZ38i6f40XuGmwvb+dE19XEYcwWDd8LcNu2vCqPlmKUH3dEWe2qCu
 PXn0z7cotum46lJ6ArIlueSDPWbf5RFPc8OgVwNtjeigyzM4rVzRDYaEmOfsLTnsapN4
 hWc38B14xOtd1cqtvkEwt2L/XptboIXXmIg2rAZxJRZ7yDS3H06jMookmbGKUivlCDmU
 KCGCGShrhsYIE+IEIo4rqHP1PCjlNJwJBIdt7O8gLGQlmc5lfBjKEGxJQaZMVQROiS+v
 HD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314963; x=1786919763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qgTTE57E6VDpc7y6ZZqT+hvgo0JgyQBjCGNKyS2wwVI=;
 b=Iuf4nfYFp2UIExkMgBv1lGeH8ywH5KX0oGj5ytM4wl68PimTiZ3GpgUQN25EV/OD6y
 6zsRC2Nxj1olzI8+li1/Ykb8cOgAeSGxbWwP+qIvuNHaIK2tNDua/kyoqrYQBqgtw/Xz
 c7Ky8GB+HjEiy5qBGmnXFAr4AydPS9FYgjuzXpwFoUjv0hQUBN4aFQHScj5vEb/iLPU0
 +iqApOYYyG/8fNJoBkMp42XpKrZlmXDxzjByCusYaDJNZw7EIta4KwU3zuMcMEQ3e774
 npR8XSO+uzR/Ed49YuaeM8h4rxfJ9fRELSQ5N0pVkoZwBbPpd5vX9H21mbq32YIxXiyO
 U+6Q==
X-Gm-Message-State: AOJu0YyhrU9zdfPI/ksUO3JfXqCFEyqiipvfonN6ep+rPTuy1wbT+FYf
 3kusgwNoisvCGphvnk5JQVrBJ/3Hha/Gl55wV5RUXhDOXHsTYBsEqmUoW9hI+pYKs+RMb98BT2p
 ofp/Y
X-Gm-Gg: AR+sD1165qWtZiDGI3o09/MfftmtHPfJbCHu7AaRNHoFLYLs9THE4cGK/HwnnmsM2u2
 SQAOtt5l7Y2r/nyZoGxVUTgotGwulG7wU1haSTW2gNk/Bc83OghsVhjLr5evw6cN142LXazSMv/
 XoHE2UFXGt9OJ8DDJ6GU3zqWdfOLhZ+YuNlyrBPEK7HSJ3NWEMeunEYXEXKgmbMTa7mLbAswa/P
 mC1DvxD7RCHSW4B2Wd73EDVfK1l7oqupopzvj+t+7fIjzpm5CIzHcR+ldgPSd4En+VFSRyfsV1a
 PXc+KCnbH8nfbGFGS5BUq8oe5F4XtXhuOd0K+wJV5MxDqA4GoiGYPPwVH16k0fZ7KjE7DGv5R45
 b4ZStT6JDyJG/ssrUucZyhBAzfEn1p8WuxeFoyhA41uEqh2cYytjaCyarEkxt3GAFr212+lMFWF
 iREZIpnViYeSQBX9NB9nc8UxgfC42yxWNFzOcOniSE6NYJ6DYX9ujRs8KXd2YygvWE5f1MBBY3Z
 HGM4T7eL1aF5uCGDzQOZO+217t8Xns=
X-Received: by 2002:a05:6a00:302a:b0:848:7443:f2de with SMTP id
 d2e1a72fcca58-84f2dff77cbmr44314020b3a.13.1786314962780; 
 Sun, 09 Aug 2026 15:36:02 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 12/56] disas/riscv: Pass rv_opcode_data pointer to format_inst
Date: Sun,  9 Aug 2026 15:35:01 -0700
Message-ID: <20260809223545.730664-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0be2f07612..70ea41f125 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5111,17 +5111,16 @@ static size_t inst_length(rv_inst inst)
 
 /* format instruction */
 
-static GString *format_inst(size_t tab, rv_decode *dec)
+static GString *format_inst(size_t tab, rv_decode *dec,
+                            const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     GString *buf = g_string_sized_new(64);
-    const char *fmt;
+    const char *fmt = op->format;
 
-    fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
         case 'O':
-            g_string_append(buf, opcode_data[dec->op].name);
+            g_string_append(buf, op->name);
             break;
         case '(':
         case ',':
@@ -5466,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
-    return format_inst(24, &dec);
+    return format_inst(24, &dec, op);
 }
 
 #define INST_FMT_2 "%04x              "
-- 
2.43.0


