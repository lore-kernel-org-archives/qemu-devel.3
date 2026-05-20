Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F34CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfBF-00010C-TN; Wed, 20 May 2026 07:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAm-0000fl-Sa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:33:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAl-0005Vy-6y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:33:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd56d108454so975018366b.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276789; x=1779881589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVw064VMnnT+zaBzJaNHoIx3i0+TRGrFhLq8QhYPqjI=;
 b=r4088Lz2etVMA2vvs08DxTVAgyiunHm0egT7hauu3RLneBf/AZI9MJrj5CP+baDqIz
 M+zLVh8MPX26fPRKqJz10hyWFG5tQdunGKsJONoVfPv1BK5xd1V9pUCRtau4AeSg4yH1
 L+tDplHTD8zruIJ+pqGgXin/XIO5itZXezckAXIGM9f3cyDLttJ8eZhAghQM5ORArso9
 rPAjgF7vmrebo/90hS2M7C+UsaMzx+hv9kTEGR3Qkt1oGG/FHU1luGHS7y8TgK0e5PS0
 yBYRSre1ALLaIR/n9UfP/bRbJjipGUsBFQ0E3kCN0CdFQpCsbyYx21BwtN6KMs6of4d8
 DiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276789; x=1779881589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kVw064VMnnT+zaBzJaNHoIx3i0+TRGrFhLq8QhYPqjI=;
 b=CEu7jrKiyBVTjPNF6NhZXo8TgFepGKJKmXxs5rvEnBeLRxEVRmDumX3XY7eK1BlYbX
 K7ks96GMCWSwivmfxDmBl7M58NRsz/h+kP6e/qqT7zAfETQipVHcqlUZ6w0jQ7eQZ7Zx
 ZoqBEYd4X73zGhbTz8K+SBlk/VqMyTxUIjjPZvUNIciJfZJCpHHyAWebVFPrOOoURH+B
 OO4N+zM6GbrAxwU7MpXVb49DwvCrtookc6/KaJFp1gm+4Hs/O030iUdx3GKzECQNIzQC
 7+RgGl0UpAqOBjceEmjXybw5knt88iYueFZiTL+m8WGwlhxBfaVpCaFQZ2uc4ku5BQoL
 HSww==
X-Gm-Message-State: AOJu0YyaZJE2ND089zKJNwke1KstaklGWTFVxvObQjG/PgO6db9P0+TN
 sR18B73jpkzkU6dF3e40nK++L3CQYMx3g1roMBkqhx0D0DhtS88eXLttN7uhEHmV9BwOdVrPsNB
 itkTwaOo=
X-Gm-Gg: Acq92OG6V4x+Y92cK7GOdGt4L6ZX5zlh1ZTQLpyHv5epzlz1rwaHOx6g5sSjOlCVATm
 n01emalZztsKUXWOTC1uO2rQGycWbB7PvTHAx8jl7KZqIW56A8oj8KwLtLh9UTSv5mBQvixu63v
 LX7TxgjDn9DzBH9GcFALqHZhx91bNwx+aQ6aMGvyS+2rk443CGjhZb2z3o7kV2AxmyqRjNXQSeY
 +4uam3joQIIJf7+6vqSuNT5affxntd899dKFLoyNS/9dWcmhb8lIyIwHi+AxUwPZwAKpxc8tvOz
 eJq7fyOxGVuZW0Lpr+a71OdP5Mp4JLb0Ug6It68xRpbgrI/YL46n7urfSo+qqIgyTScs4CtWrrI
 cjVAT8plqpZ3EnDgGjkplhWCcb/9/3tB7VyRVwVFCMxBuz9Kdy6BKJ6rmgp7DPy5Fp/NLtFCGdN
 uf2aIRlRakp2oseyFjRC1wfFLL+z204pDq05/wjZBZt5HiVe3cCp3cnZedAI+HlPB+WTvxwXbC4
 gVEusjWePlA7J4b
X-Received: by 2002:a05:600c:c173:b0:48f:e230:c3f8 with SMTP id
 5b1f17b1804b1-48fe661b50amr388412625e9.30.1779272401873; 
 Wed, 20 May 2026 03:20:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm53777845f8f.21.2026.05.20.03.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 15/24] target/mips: add Octeon ZCB and ZCBT instructions
Date: Wed, 20 May 2026 12:17:56 +0200
Message-ID: <20260520101807.9971-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd507..01ed3b50beb 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d3dfef2e0c9..b5ebad98048 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero64 = tcg_constant_i64(0);
+    TCGv_i128 zero128 = tcg_temp_new_i128();
+    const MemOp mop = mo_endian(ctx) | MO_128 | MO_ATOM_NONE;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 8; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 16);
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx, mop);
+    }
+
+    return true;
+}
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
-- 
2.53.0


