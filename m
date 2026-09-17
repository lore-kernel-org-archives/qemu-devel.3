Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C489C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo0-0002hw-4E; Thu, 17 Sep 2026 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnv-0002aw-T9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:03 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnu-0007fO-6T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:03 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc52bd91929so5311a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681081; x=1790285881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QkDd6+Gl1s9yScKkLWoxZuJcbFv9kVWo61y3ikzRLU8=;
 b=NehQDb8hS89UC9liGcCn56laJMRPA92eKZano+rUWAr7XyaHRzw2KFo9U8tjETZZdZ
 2bpTyD/00nxDcevYokfeAiouFIkdk3okc09xOFSksRJYrYdmVjUdBx7sSy2uUWd27wO/
 FSZCtntGra3LOYvKRB4jnj13VStTyXVmGJwERzlfqs4qd3pbXV5rvMT7KRs4or8yWUbM
 zRSyvkSlK25XYwkLvm08BNGzHsu1w2Um7mUgRAFKGdTHr1J0GuPk5uTVU7Ji7uMFtnpi
 rZUUVNNRIPBXn/F/Sbytmodt9srv5EwmB88VHOULn/314l/fcToLABDsDeXzMWSwdVBD
 FrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681081; x=1790285881;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QkDd6+Gl1s9yScKkLWoxZuJcbFv9kVWo61y3ikzRLU8=;
 b=d+lV1Xhrc+YSXUo6H1Se0b5vlrbJXBNv0f799CGDs6Yv3H6T0QPldg6Zpi0U7Q464X
 hURi8+oCV18+JlICWj6TxBp+Zi+SuEr0OEqTMYZJ6NBk4JXSZJnF8wWFSBkJgkBHWQKE
 43HlYLxzB+3CiBEbTDyliPpKA3zdzMHWHsPVhCN5OV5AqR8+YRNogHNVqu5E1X9ibF8l
 mpYPicyMcRR+HNtLvW4d2nA2NLhQXzCkaAZGpjqzJi2bpAmHG7KsXI2zN4OlEWhcPAiz
 cHGnWrIV+ZfYRDKBfT0MSH5WsmxdOYZj5npvSAV/e/koWVXEz6l5iVZs9UafWqdHsIac
 +RuQ==
X-Gm-Message-State: AFuF++l2KUwxqCmm05ma1rEcAGhKZ5V9N8Adk5qe7mgJKtDcfR2ldkHF
 H4jY2sX/NoPEeTIv9tdQN2d3kkhdVVq4Xi9xnLLdYkwB0Ki9oLOkayJ/ayQQUcmTFcPzFnweVH5
 Giz0c6Pc=
X-Gm-Gg: AYBFou1JB10aoJBwPigvXWYfYNDaNHLmIGrvMinfEkqbOnwCxt4HpX1imFfB85R6GSq
 RGc+fFlDlJqndNm3KNoTsQz/YS+kka0QnUXvQPDNoKiv4CDJ1OILoofqN2Td5HtftR8+fydyHR0
 rDXVJkCHJo1ugzC7aW5TF5840TR8dqHe/tv/lnm/NvO0hfstNmqURdkNlPEsniBGCF5T5Tf9gq3
 5J3cJ2qOifEjFmCEyihH59KJy171A6WihYYcfDZzXlW4dQSqUL+Zv9qh1rrmH0wPpMSDJXL8VbI
 wAzhcxXF00BSMvHbjr0bmNBlWFcOIEp2+sIlRVN+IV9vvt/e+NLBYSb2RZpCLfEMtpurnCE7QvG
 4a+f1Vuje8mHiDDv7Kl74nPJCXKBbpVs6i7ohsRJ7CcKmVwqVEqZTOyAF4tQd1l84xn0dNuF1/E
 doliLhIJ0RbXQYOfI1QrVIhBWEXGNfVA6J9jXFb4tBgWOqxrqtksB29s/v5GDhzNOwSA0CnUqbv
 W8RVY0=
X-Received: by 2002:a05:6a21:32a2:b0:3db:4e0a:df51 with SMTP id
 adf61e73a8af0-3dd8c5297d4mr626294637.22.1789681080535; 
 Thu, 17 Sep 2026 14:38:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/15] target/s390x/tcg: Convert op_ld64 to op_ld
Date: Thu, 17 Sep 2026 11:37:41 -1000
Message-ID: <20260917213749.36756-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-8-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 5853804f2d4..b7d174b7c69 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -422,7 +422,7 @@
     D(0xe358, LY,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESL)
     C(0xb904, LGR,     RRE,   Z,   0, r2_o, 0, r1, mov2, 0)
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
-    D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0, 0)
+    D(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUQ)
     D(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESL)
     F(0x2800, LDR,     RR_a,  Z,   0, f2, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_AFP1)
@@ -435,7 +435,7 @@
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
     D(0xc40d, LRL,     RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESL | MO_ALIGN)
-    D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld64, 0, MO_ALIGN)
+    D(0xc408, LGRL,    RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUQ | MO_ALIGN)
     D(0xc40c, LGFRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESL | MO_ALIGN)
 /* LOAD ADDRESS */
     C(0x4100, LA,      RX_a,  Z,   0, a2, 0, r1, mov2, 0)
@@ -465,7 +465,7 @@
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
     C(0xb912, LTGFR,   RRE,   Z,   0, r2_32s, 0, r1, mov2, s64)
     D(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld, s64, MO_BESL)
-    D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64, 0)
+    D(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld, s64, MO_BEUQ)
     D(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld, s64, MO_BESL)
     F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
     F(0xb312, LTDBR,   RRE,   Z,   0, f2, 0, f1, mov2, f64, IF_BFP)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 607dc3a3af5..ffbef87f595 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BEUQ | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_lat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
-- 
2.53.0


