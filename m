Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FCECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeh-0004kF-Me; Wed, 20 May 2026 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeg-0004iO-RT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkee-0003fu-PD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b150559bso39943755e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297862; x=1779902662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9vRnvnV5C9I2ltCn+ugALI+ERIDROE+jpEU5rU5xpQ=;
 b=suiDtjW44V/rNMdat11J/Z0iSyaikoBGVspC3jbgkcQrVKE7jfQAiHRKJM90Hx3aZb
 n0PrnVApx5ArbHVIRsd+yLcEp7nodX2SHr0sG1bIwsP23nN99YENzmFyIkaRg3kSnyIA
 7pwdTzoQ7S+JGA/E0xKZIN51OyESXRowHtcNgArRyFG6JV//ZQMO4fdRUF6Ae6I1KGcM
 ONmX8jofeSTvvyyQ0WtQkkqp5WIu6SYJRClL07tr3XPX7Ya/qngUmXkS8ygSS6X36i6y
 P1Dw8X68SNSBM23Luk3pRqiLXgaNt6zm0egJ7NkG1zeJxYosGoz2WfuTGj9QMXLt16fj
 +U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297862; x=1779902662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9vRnvnV5C9I2ltCn+ugALI+ERIDROE+jpEU5rU5xpQ=;
 b=iTObC0e9hGIZzld1S9qggSf1krPjKEN3XiieVCpZB0Lk2u1G+o5/b0Mb8XxDfStPQK
 T7CUuxE6lAEtnsjUQTdas3oXBvY+x+T8b7j3CJF++v/C/E2+osRwDBSrlLAcVF3Xd/yl
 La4a0BP5/G9E1REyt2jtLc2LeResNOgLMadK4LwJ0yNVZ5HBCRoNAZ1jEVLrJXCXJhGp
 ruTws2ib1/vDYjysrlQpGJ9voEjymFQ1yt1hwxW3K8EPaPVq0noQkHv36WJDOHxnDPRn
 KkrLff+fSrk8ClsW93hWatNS3zyfw1ZlabFDqULHxapg2QsSa7g0BHclIJKpzEuRNjvz
 GDvA==
X-Gm-Message-State: AOJu0Yw2k6phpn6oH2Tvu5ZojaCuGFO3Yv+W0u/dvMoVo1eda76Dnr7m
 YFX6+STr1XN5ZJnfpgYEsYtONIkmpYM6QUKzaOAslbZoaGvbEZ/fzzfjVO3N3CfvJL2WzRoEWyh
 V6HnBMSk=
X-Gm-Gg: Acq92OE3Pn+eZQg086O8DNLsnB2e5jrzvQ/ZX1zuK6ApXUhracDW0xwm1P8dAjyvkjq
 Ui+V/8lPTAq/9toT4NXJm62Ylg1vo92fnnNzybn9BjqYJdEEUh1eKVzwzHil7A11VMg7jOcxX+p
 BZatOlbcaQGx0jOSmLMys4mj2gJHvb4utAlKPDFVtxAJKmqFlTfNPdvleY8kLX3bXv/SA0jT8ti
 G5RkIBfGQi8wpU9C5l1zVvG1nKEe6r+FbMYBNkNNhGmaxVb1//E81rejkD2Yw/j4miqcHSpYGvu
 Tk19GMK2ofw+3GWvRStW/RadI6Gy5wh9+33Or1WaiIP9NW+9MzVDFlcs537cbKuAzkU0DCgd8S2
 TkwQZPLJByc7XoGsIkV6DEWRS5CtxsgIq49halqrBzlm0wblTNuvwtzcfQ6KWxPvk/6zjxeTzFZ
 sl/sJWsJHL50WfT27dHRPnTjDxNJlvfH3N0MHZu1aqF5/tTFZu//KHYA7lC7jomi8KuCu67z23
X-Received: by 2002:a05:600c:46cf:b0:48e:8974:c377 with SMTP id
 5b1f17b1804b1-48fe6626ba1mr363520245e9.29.1779297861904; 
 Wed, 20 May 2026 10:24:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e25bsm5580785e9.11.2026.05.20.10.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 09/24] target/mips: split Octeon SEQI/SNEI decode
Date: Wed, 20 May 2026 19:22:57 +0200
Message-ID: <20260520172313.23777-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
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


