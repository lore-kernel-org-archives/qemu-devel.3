Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55DCCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgk-0001bQ-2f; Fri, 29 May 2026 07:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgj-0001an-5z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgh-0008D0-98
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so6282369f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055258; x=1780660058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FPp7rLmAeAO7bbC5MF2z3j3U4/fy4rUHCwooIsHRjIs=;
 b=IyICqXQxsy3cEx25QskjYx0cp0ZPapjMsVf04aVgOTTEQ6cqxb01Bnt0dEbK30WER/
 /Nw5JHWZqDPNyc50LW4aYVQaYaFuYfwQvRvCslOHp03hLnU8qJnRyFZGXJhrHO74Oh6m
 Ta5GqFKsAK8S/X9J1+OcZsF9pqE0InhzWP9ud/7k60UA78KlaMn8HmxAP5my26oNq7FP
 7DWHZo1AMaYoDyXTklKncBXAKYfIz8M5mgE2+8vJ1YhVfe9vJTr3OX7WLDGabD6kxsHp
 DyITCDyjOPwIb2clYKe9h3ECQCMwsi0JclO/0wrjQ/Meq7gHHQ1BI35Uh32SO+fUkO+j
 VdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055258; x=1780660058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FPp7rLmAeAO7bbC5MF2z3j3U4/fy4rUHCwooIsHRjIs=;
 b=IXsT+6YiZoXTZnNYCLLSgDf7PaRfuhVvxZPN+9+KKS86FHrseg71vd2m2xgYTZP3Md
 RzhsD/I+XjbOYTPCb96fC33JxQ91zg3q+fE0l0dV5jPLrsjUQDRKR/6mpaFl3WFaTr5r
 NtN9/kixBsKAG8q+qHYRb2am5Kki2cMtHp3y6EkKMiauXXs+O3sb4IYQlVurOsb0QZXv
 nPD9f9GuPaj/k8/1o7hGYQ9rZO3IYqauKwMq3JIW1lZrCuQmOZKNEDIAyEsedlR5gbsP
 lftHzmSHhttQ1MJidCrFemmgYk4z15xNMj97FoQSA36EEcsDIg5G1+L6k3Tku1tAjNYL
 9zWA==
X-Gm-Message-State: AOJu0YwSABWNKq6r6ReHA3KbyM5iJZwiMwGB12qLcbVrO/czkeNpdN33
 7qGZUHhkFC09n0gJUvHQz97g5ieGJEJwuhHA0OscntwsRJRYhC4Tki0uih568F1Vj3oiVZa5Qoc
 HgpYH
X-Gm-Gg: Acq92OGa5QbFAu+7TQgSdw4vdeqto2dLh8S5rEcJragt/MMTS81I6gAg/1ETT4icAEO
 eYx92tbEth1/VGaqEQ3zOfV9QN16C00h3n6y+dfSqBMj7ZcwpEJ+LKacK8IGnY8wKMZF0T7gwsp
 nVj19EOAt+Ztpsky59MN3bwwJu8S9oFEeUMMGoyYkiKbvlOwEsLw1ZKqBDA/o8Zr46in5PYo5t3
 Zc8UqbmQBvNNUkCzrdPr7kOb+2G0xTzExjaUwI7sKKQMv6yDwQfxWjBiz52J6/U7FKlcL0hg2pZ
 pfaQiGezZN8emIPvY0dWz9RtDmtHehI70c6d7/oEf+KGZK63zhM7Fse3b6Q43huvK+OHDC77dgT
 IQv93l3+MmFiRbKV78cYR777AuDFiM26Den+jeYFwqyBm3EVkL9Ax/wSYw24HKhsJMTqEsEBPNH
 WzgQgOjQnWadwg3tGDcTMuX3p9cKJpxfy0EDbgGwNnECYzJOKC8u5eaKqJJaM+NtW8qBn6EEB5F
 624gZzWwDdgvkfBJMFvgvaz46a3me/6RP6NFwnRvQ==
X-Received: by 2002:a05:6000:4694:b0:45e:ee40:2185 with SMTP id
 ffacd0b85a97d-45ef142f104mr3358375f8f.14.1780055257737; 
 Fri, 29 May 2026 04:47:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] target/arm: Implement CB, CBB, CBH
Date: Fri, 29 May 2026 12:47:13 +0100
Message-ID: <20260529114723.42040-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Compare and branch instructions, with various operand widths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260518174750.660258-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: move var decl to top of function]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  9 +++++++
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 02c7264cb9..a5a2a45a2f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -208,6 +208,15 @@ TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=
 # B.cond and BC.cond
 B_cond          0101010 0 ................... c:1 cond:4 imm=%imm19
 
+# CB, CBB, CBH
+%imm9           5:s9   !function=times_4
+&cb             cc rt rm imm esz
+@cb             . ....... cc:3 rm:5 .. ......... rt:5       &cb imm=%imm9
+CB_cond         0 1110100 ... ..... 00 ......... .....      @cb esz=2
+CB_cond         1 1110100 ... ..... 00 ......... .....      @cb esz=3
+CB_cond         0 1110100 ... ..... 10 ......... .....      @cb esz=0  # CBB
+CB_cond         0 1110100 ... ..... 11 ......... .....      @cb esz=1  # CBH
+
 BR              1101011 0000 11111 000000 rn:5 00000 &r
 BLR             1101011 0001 11111 000000 rn:5 00000 &r
 RET             1101011 0010 11111 000000 rn:5 00000 &r
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 15b40090c0..94dad693eb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1774,6 +1774,49 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
     return true;
 }
 
+static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
+{
+    static const TCGCond cb_cond[8] = {
+        [0] = TCG_COND_GT,
+        [1] = TCG_COND_GE,
+        [2] = TCG_COND_GTU,
+        [3] = TCG_COND_GEU,
+        [4] = TCG_COND_NEVER,  /* reserved */
+        [5] = TCG_COND_NEVER,  /* reserved */
+        [6] = TCG_COND_EQ,
+        [7] = TCG_COND_NE,
+    };
+    TCGCond cond = cb_cond[a->cc];
+    TCGv_i64 t, m;
+    DisasLabel match;
+
+    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+        return false;
+    }
+
+    t = cpu_reg(s, a->rt);
+    m = cpu_reg(s, a->rm);
+    if (a->esz != MO_64) {
+        MemOp mop = a->esz | (is_signed_cond(cond) ? MO_SIGN : 0);
+        TCGv_i64 tt = tcg_temp_new_i64();
+        TCGv_i64 tm = tcg_temp_new_i64();
+
+        tcg_gen_ext_i64(tt, t, mop);
+        tcg_gen_ext_i64(tm, m, mop);
+        t = tt;
+        m = tm;
+    }
+
+    reset_btype(s);
+    match = gen_disas_label(s);
+
+    tcg_gen_brcond_i64(cond, t, m, match.label);
+    gen_goto_tb(s, 0, 4);
+    set_disas_label(s, match);
+    gen_goto_tb(s, 1, a->imm);
+    return true;
+}
+
 static void set_btype_for_br(DisasContext *s, int rn)
 {
     if (dc_isar_feature(aa64_bti, s)) {
-- 
2.43.0


