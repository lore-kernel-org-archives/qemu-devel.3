Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A2CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPeuy-000169-O3; Wed, 20 May 2026 07:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPeue-00011N-Qf
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:16:34 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPetc-00007T-2S
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:16:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso10587518a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779275702; x=1779880502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abjz/PzLbgsNKFk17/59EkYKI0uoQmNYLf/G7/w/B6Y=;
 b=pzmOvI9LMxtL6zEY+CnbFnaXZXt6dX4u2svVhLTNfyhAj6QiPNnPAvYQwBvnwdsds7
 cUw5bOWyeVs8f/tClpMa5fXPE+4zTiR0CTjkOKy6ntVu6DfifD/D1rbnbPU7Qn5eomlC
 vGgIj5ln3z4Rk84nff1V0r6OSARMGXJO4LktTZh9Jucv2D+HsHvP4S8B0eIvWLNUdzOI
 AvNcluSZcHaE5NL0ZV/7FWFoGU2d89oiMUV2sN1a5OoBM01Slqi2NzjdkgCTsvJwX99k
 OEWK54E4LS8y+zP2ZglhOnHBSSqDWKVhwL7oVoGLOiXZxeWLvt+Qx+8HZ7YJFlt2CDCK
 8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779275702; x=1779880502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abjz/PzLbgsNKFk17/59EkYKI0uoQmNYLf/G7/w/B6Y=;
 b=UEmL3yO2da5UisiHzSxBVRUHn/22fUiM3rDzbOmTl/jIMi5DAuQFcWw6FBhhmr9UDU
 JSYCj1VWtDZLchyWedp04rKv4Va1y6lyWHLVUNwbDgYJtyJ/ehtu56IaaBxYRiOu+ZYu
 7wGwmNd5a0u5lXOu6VrajZXE+fIOSnNpCPsrrQS6MD8vy1CHQmoUId/R0BeknNmrh0NZ
 +XT22wfui3Cb0tZG88HyJx19o59WghAB6JILaBksb38p5xd21Pl8u5BWLhovfbE7U1WN
 1vnRyncXhvF5LpwwURVtAIfEH9ebGNTB4GqAW+Bd/1Wz/bRTRo5od20rDxXb+1JTr544
 29Eg==
X-Gm-Message-State: AOJu0Yx84ShcwsaHJxfttJfPNg+q2jMkIK2LJjv218LZsxBi1PFZUHSj
 l5MbxThY48W95ZnX80lkId3LqXmsZbhBBSbYUhO0yScEqOHl+sZNABIlSdE9Z9HnBY76J5kWUQT
 i/YZx/kY=
X-Gm-Gg: Acq92OGN+k/DbHwcjy+9VMXEnQPUvkGwqCkGSFisPKSDh6nD4n+ZZ3676LbrRM+G8K3
 kdCGq89AjQ7hQ98Ltp5/IJ+mGLDvVoKQPtbmYuawFWJn6T4RAXvOD5zRRxuHpRrFRV1MYzqBFtp
 dFx5FqWVj5M0JZ7IJ36NZPPpitaVf0Rx380xyqMNZoU/6LJ0k21Zji9R4uF2hS9QrzKmDX2v44+
 BupmYeR4pvTT8m3K25yfjVN7zf1oF8Br/66FTkSjg/x3r+O8V07DwANkGQsARmUb9jccPfkxiB7
 UYXG/gcNMclhR9WlhSLAXZz0fJEMc7SVwW8WDzfFoAbKsogcYCATs4CoYJYI4fCI+yALTkpOG+p
 jWgWBhWiQ24cNGlHBVtqgTo8bhgU/C1AMjygDn+zYi0OK2jqrNxhQKddf/yM+eqQaj0hnUfbAro
 vZ3PdXOrFtyWQsbSm873vYWEnBGS5L3FCpZCRzyVwnvLI9NEQUzOhW8HE2cABi91yQpjvpsXIUo
 iyY+w==
X-Received: by 2002:a05:600d:8:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48fe6325213mr298546495e9.22.1779272358166; 
 Wed, 20 May 2026 03:19:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm423824845e9.7.2026.05.20.03.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 09/24] target/mips: split Octeon SEQI/SNEI decode
Date: Wed, 20 May 2026 12:17:50 +0200
Message-ID: <20260520101807.9971-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
[PMD: Split SEQNE vs SEQNEI (this patch)]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


