Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0224DCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYk-0002O7-80; Wed, 20 May 2026 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmY6-0001NQ-KI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmY4-0002QP-53
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so48914525e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305142; x=1779909942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2Z40oWVLF/kpQasU7JFTmHMWs+RtYXMErFNxHICK6k=;
 b=yHp8lnIGScqLJgY2iQnhTKQzdXzzbNLBlwS4vxnEMefAGk2VakugAvm9FVPdHQrx7m
 aNBRjE2vNVKAQqlQab4WhgiCSkydqGZL2zZeDp1tJmSXw/M1yL5u8VdgNqkWgCI8FPZc
 zbwVPKprXv+jVrIlv1a0zamq0tmBYYAcEes6B30VXgC4F7jxW2U/FEk99J5/M80b8yt/
 DGmHayjwwwScjn8w1Y9Fror5fitAUh8iQLQLoU5hhVbNMHRnPJN/ba2uz1OdMt2NaO1Y
 d6lfaj3z+7/QG8o4mG4uootak744EDzxx4bgmuymGHx3q2S4B+jyyi7ud5B2AX8XamZi
 3rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305142; x=1779909942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2Z40oWVLF/kpQasU7JFTmHMWs+RtYXMErFNxHICK6k=;
 b=Ixuh5ve/YzChMdzht3worFFL7AoOgY/+d7vtdBHnrEf4LlJ0axw00wHtmzbGBn1ya0
 ycZs8uk/TMnS5hVdyPlWjDPQpbuzKtlymvuA+oZXSr9quslmrsK2voCn5wWs7VFWBOGm
 prxNKDL3ys3NWrA5sPNhcNiiBgE6keYhGsAYq/s1UZuOOyURVmfCo3YmcT2iY9bHn3ep
 hy32nX2xs6Szof2s9gbplAPlWIlc5TW0X9DJxwkfryIjDHmMZHwOkvSJNRCF6x7k5x5n
 8zDrmwFbynPGvFK8j80SBYGF/3CCJuu7SOW6KStfP1yz49yR5tad/o2WqfcJ+ll4qToq
 a/mg==
X-Gm-Message-State: AOJu0Yy0dtiDqgteR3f3ojnLXyRg1oH3DSrLyk46YdiZfGx7LlCYeUDw
 4mgTVqtEba1JalO3kbghbBv5LUc8qWXZ34mAWgbxHvbfuUswWW7QvP+xCtS/TdGaan58FdpiwI+
 3A5ydaS8=
X-Gm-Gg: Acq92OFaZYLegyyqZ/QvUTtephhOjNA1qz9YsSkvK0VdEJamH+ATONFPKsw7JUL2boN
 zUvObH0d5Ze8M78IN244y9ylaLgQSeWv4kAH4A2w/6f1/+Vpy/TsoBoydNjTae+ItpwvsAwaVhU
 TeecFqDuXFTV4Lsra06VxPr8//dE90F8u2aRu1gkX14XzA5H4HWysI3NSRRXB+tApA/8jdBSiYf
 5rPHv4qVAyTE/3OMRweGFDwJfY1QJw1DUYv3u1AkPTRLufZUTujUiNIU/vPH6KX5grWfk61NVwU
 namloUlc45/W8vZYMXHoviVhrvII9CtszarOMD6pFDUST7gF3WfvRQqhR6IbygMhrqR80ZuPjsu
 oALjsbewk/EDs95xd6wymvBnexPjtnb6W4Y+rQhq6jqqsOgB5uF7hKQr6DAjG7/iH2hhXz8vOQw
 9DbVa1B8iAfJekOLUV0LYsuvwKyjuMgRFazQXh6IDPQQcamOtrP2ak4thiu3u0j3a3dmVDSlDK
X-Received: by 2002:a05:600c:4fc9:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48fe60e50b9mr352759845e9.6.1779305141919; 
 Wed, 20 May 2026 12:25:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767ee0sm52486183f8f.1.2026.05.20.12.25.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/33] target/mips: split Octeon SEQI/SNEI decode
Date: Wed, 20 May 2026 21:23:22 +0200
Message-ID: <20260520192338.40036-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Decode the equality and inequality forms as explicit SEQI/SNEI
instructions rather than using shared generated SEQNEI entries.

The explicit decoder names match the architectural mnemonics, which
makes the translator entry points and trace/debug output easier to
correlate with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Split SEQNE vs SEQNEI (this patch)]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-10-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 +++-
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++--------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2c54901f77e..a2bfd0751d3 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -30,6 +30,7 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SNEI rt, rs, immediate
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
+&cmpi        rs rt imm
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -40,7 +41,8 @@ CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
-SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
+SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index dfbb55e3fc3..5497ddfb108 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -132,29 +132,28 @@ static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
     return do_seq_sne(ctx, a, TCG_COND_NE);
 }
 
-static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
+static bool do_seqi_snei(DisasContext *ctx, const arg_cmpi *a, TCGCond cond)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
-
     gen_load_gpr(t0, a->rs);
 
-    /* Sign-extend to 64 bit value */
-    target_ulong imm = a->imm;
-    if (a->ne) {
-        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
-    } else {
-        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
-    }
+    tcg_gen_setcondi_i64(cond, t0, t0, a->imm);
+    gen_store_gpr(t0, a->rt);
     return true;
 }
 
+static bool trans_SEQI(DisasContext *ctx, arg_SEQI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);
-- 
2.53.0


