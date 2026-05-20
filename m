Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B1DCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPma7-0007oD-EE; Wed, 20 May 2026 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZs-0007VM-C7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZq-0002pm-Bs
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-452169ae568so3383100f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305252; x=1779910052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PVX5LHyC01XbeGNw4EVVzle9YQztiV8mFBcRyRC3n2Y=;
 b=b895lq0pW4EJ3e0bTfrDfD8Q6lylBytC6JtSpS9e8DFoT2QPRM4NbHjtMvllOP3Q6R
 diM0dEaQc6sTZ4moB8GnZ/PbJD+ZreJidDieo2MT+KiSL7oZCrLqtI+A+zbjrS3bLPyk
 LodrWKG2/d20kSyKig4v9/mYT8EYk3oL4ozV8t+oJBisjuu/xxvGRI8oPPwDCzL+iuu4
 WT9CRj6rzFBiY36SvKauv19FKQntEy4zXxksv/So3mRZoelqMrIW2CS+ftl6TeNq1n1S
 WizGeGy1+W8Bl4i4Baa5z9Uoof/fxw+YZ2Ne3zjSHdEXMtt2Niwo4qpTgcxIXyIHctV1
 idJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305252; x=1779910052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PVX5LHyC01XbeGNw4EVVzle9YQztiV8mFBcRyRC3n2Y=;
 b=BcHWvvWyRBd8c7PDf04GwXmXhFaf+6wq0aqZV6xUuz/ICqWZMUEi3hV5o3lL5w8HmS
 lWKIupF6YjphN2bzSxsw3datKpTpus4TGaiGNTm9i0QSVMFaMZqPe3sjFQbhH23WBVnJ
 VFJPSb+O2m06/2Qy+RY+JJ306V07AkGcSOkFchL6K1wHgr7N6hNUROOnqbQATbRR7OCV
 LKc6VfomIetHpGUolCt/XwPcgU65U+cSNs4OhFNX9RGVsPM6gH/rc/pkoQqGl13m49Wv
 4LUb2zgfTIlRqLNBD+M9kbRS//O8vRRPo2NNFBaBM3Gmo9ZpS5/x4qyssJzbMr30v+lH
 /iIg==
X-Gm-Message-State: AOJu0YzoiqhFJqtMrRYYz8sJs1nS7zJCApXAuWmzjkC9eui7yzsQ02MN
 v4o57J9YDmP/Zycex4rfT/DxbM3/TbKOdMj39vKY/jEFEHnLVM2UklhRZOogFG0L+65yjoCs1uQ
 5to/rPek=
X-Gm-Gg: Acq92OFh4nq/IbnJPcC9uxu1HW/X2uwfWkRUhLEyxNjMfif01DaL7eH5SHc6ht+1W3N
 R37yVWUzz8ad6uQllUIwVmYAcimTfObfBZmslJCRfAKEb+biduVr/Na0hkAmeW980J78YR+2eFm
 z38fwKDOHAC2YZYHodwpHkPqJJEYnndK/GWDQeK8kL+CNvila63PiKUDF69ONaIsSucgtTNTrOl
 PP3nxtNExcwJpW3MNhxvw/iDYpsAcW9wkEG5pgF97pGm6NBwYbtRBV+5STbTnH0uEuA2Ls+6X+D
 JDercW28/dcjaF1yVRU40HjrlOTkSIEbOXDC7wgYosGiX83yeTL5MFIZV557dexC4yUkOEnrBsG
 egq2ORXvJ3PAo4xqHU3vy+miM2lAgxNwuHqpjy+1dp6f83Xvtv+8m+XOduDJmOQCec55bA1RGjX
 cLl63AibFrN7iQ/nKpP9tqgGn+70UHqLnAETYA8/c1hJ7AqkHIL49p8nrVW7yNBvFnnr3XmToS
X-Received: by 2002:a5d:584f:0:b0:45d:484b:ec10 with SMTP id
 ffacd0b85a97d-45e5c5bbe5cmr41448740f8f.2.1779305251964; 
 Wed, 20 May 2026 12:27:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm60248042f8f.7.2026.05.20.12.27.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/33] target/mips: add Octeon LA* atomic instructions
Date: Wed, 20 May 2026 21:23:38 +0200
Message-ID: <20260520192338.40036-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <bd591571-121c-4eac-8ce6-e1e2234dcf3f@linaro.org>
---
 target/mips/tcg/octeon.decode      | 17 +++++++++++
 target/mips/tcg/octeon_translate.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2d02b4e0bc3..1e44c588dd6 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -68,6 +68,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&la          base rd
+&laa         base add rd
+@la          ...... base:5 ..... rd:5 ........... &la
+@laa         ...... base:5 add:5 rd:5 ........... &laa
+LAI          011100 ..... 00000 ..... 00010 011111 @la
+LAID         011100 ..... 00000 ..... 00011 011111 @la
+LAD          011100 ..... 00000 ..... 00110 011111 @la
+LADD         011100 ..... 00000 ..... 00111 011111 @la
+LAA          011100 ..... ..... ..... 10010 011111 @laa
+LAAD         011100 ..... ..... ..... 10011 011111 @laa
+LAS          011100 ..... 00000 ..... 01010 011111 @la
+LASD         011100 ..... 00000 ..... 01011 011111 @la
+LAC          011100 ..... 00000 ..... 01110 011111 @la
+LACD         011100 ..... 00000 ..... 01111 011111 @la
+LAW          011100 ..... ..... ..... 10110 011111 @laa
+LAWD         011100 ..... ..... ..... 10111 011111 @laa
+
 &zcb         base
 ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
 
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 90bd68cbf25..b0af2f48382 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -185,6 +185,51 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
 
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
+
+static bool do_atomic_la(DisasContext *ctx, arg_la *a,
+                         AtomicThreeOpFn *atomic_fn, int64_t imm, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    atomic_fn(old, addr, tcg_constant_i64(imm), ctx->mem_idx, amo);
+    gen_store_gpr(old, a->rd);
+    return true;
+}
+
+static bool do_atomic_laa(DisasContext *ctx, arg_laa *a,
+                          AtomicThreeOpFn *atomic_fn, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->add);
+
+    atomic_fn(old, addr, value, ctx->mem_idx, amo);
+    gen_store_gpr(old, a->rd);
+    return true;
+}
+
+TRANS(LAI,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_SL);
+TRANS(LAID, do_atomic_la,  tcg_gen_atomic_fetch_add_i64,  1, MO_UQ);
+TRANS(LAD,  do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_SL);
+TRANS(LADD, do_atomic_la,  tcg_gen_atomic_fetch_add_i64, -1, MO_UQ);
+TRANS(LAA,  do_atomic_laa, tcg_gen_atomic_fetch_add_i64,     MO_SL);
+TRANS(LAAD, do_atomic_laa, tcg_gen_atomic_fetch_add_i64,     MO_UQ);
+TRANS(LAS,  do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_SL);
+TRANS(LASD, do_atomic_la,  tcg_gen_atomic_xchg_i64,      -1, MO_UQ);
+TRANS(LAC,  do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_SL);
+TRANS(LACD, do_atomic_la,  tcg_gen_atomic_xchg_i64,       0, MO_UQ);
+TRANS(LAW,  do_atomic_laa, tcg_gen_atomic_xchg_i64,          MO_SL);
+TRANS(LAWD, do_atomic_laa, tcg_gen_atomic_xchg_i64,          MO_UQ);
+
 static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
-- 
2.53.0


