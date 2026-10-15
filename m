Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81ACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4m-0002Tm-HG; Thu, 15 Oct 2026 06:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4j-0002RK-Mt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4i-0007qe-26
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c02782159so3137064f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061558; x=1792666358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Egu3+krcfWvY48xOI8VjpxD82XKD9beAHKkkIEL5+KY=;
 b=uio5TdoanSiqReZLy3uzBWgKoSixNj5Jmxnbc85UBj+PRrxkHaY0+iMO5m7E6MEvUc
 D5+PfawGlqnrcrwrktNRtnbACFsGM2LiBFcW6/BZpmbIQK+mKvnFwt/lKdonkp5Xs1az
 7h24hHz+tENCJoDTS0fJGQaru4L7C07BKJCsgInbo7+Vwr293xadt4asuFv9NxX/TO7g
 +Nn1drzZOTElHHhNZSTjBWmtqwbBopQZJBNFYzLlbDNHeF47d7olDjzYqbwK4xFy447R
 n7qNrzVkFhB7hlbp80PdDd2QhEYKuksAjw7Wj2E4sroL5/dsJJElFfIm9aewQcY9g8Cu
 xR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061558; x=1792666358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Egu3+krcfWvY48xOI8VjpxD82XKD9beAHKkkIEL5+KY=;
 b=arSR9nGjEXzVb15R3oH2guohr8kuXM3WSu2vxjrzskvmhliyUz8y8qwW4JhFTSVvXe
 O/lXg+5GeLaVYQFZ4gTfsreLRvoBPGDaEY/qkcx5G8iz+bECPRk3QhHnq1GUD3N43dnP
 RI7Q5wqNG6+QeEGGHvpmA99ECWRT9UFRj3zCokpWdFMACXnSWvkKeac1GTHuOi0B6ggT
 Lrx9RNM4qPCeAJ1ZuUxpM5cc/15tvjXWa7Hk45xpvgwT1k3XW8+Hj/wmWXGUV840lz63
 nEq2vf4k5mdqsZQV3SUUX/ho/WXFvDwAVbOkQ7iGMdBtYkX741EJDyrbWWMGx2MbjiWN
 InCQ==
X-Gm-Message-State: AFq9FYLJQfiTjLau5nFTvVRCbtIfMX9eY0Mkfz/ykU+vSY5oYT7021Q2
 UMk8N1yYgp87OrTKYAadePZZrb3/6lCEoV352Dh2PfuxN2s2wuK7IQ/I7k1fMoN9j8/9a+xxtAu
 qPf4hSbQ=
X-Gm-Gg: AYBFou26ub/1kqHCKOdWt6/hWU9A28TImTsyjoQaquMjwa4OvnheIrGF184JJRbTF7J
 s8LYTaiFRXH53A2AC5UmNJwlubPOwgOUNsLyrSoXghxjHI9v0ImEu3623xN46MFyOdtT2nTurnp
 G0INKY4z31xAIs7nMNXYD/A0Ja+uwvBvzIKWsOmjhqenZomutB36CQLfhrRRl4Wl8uxuPoCqyJQ
 kke0pVeMcAjnYHTqGaDQcxVvgFGiy1ILvRQbJZZWVYw2JWM76m8xMdEV8rbBgQrM9luh0xOXqtv
 OOs57D2lzJDrn0gMQtYytsnmY//ZX490GV4WFKBM9cpyxHPbO71uTFsFLFps5lL9buiDNtzYq2b
 gE3snCVzSW7WAp7/KwBwPN9cfPn3KZmtPGxIytQPxesYSq/kzk1YF+ZGxu12bUa9BpVvml8DhxA
 qtXqttiEGCYsGVXUO+CRxl6FX+aJrOIiO0nidfkJjoUNeVdpBz9s0EL61osJ4BOcZWokeaAbYoK
 EXCEkhvSgy1LvP0m4M3+/7kPNx+JJXVimXuU61Yw2BYfm0GC6WFP9435wsuutldrOWBpago6Xf0
 qfgc
X-Received: by 2002:a05:6000:2997:10b0:48d:e5f2:e517 with SMTP id
 ffacd0b85a97d-48de5f2e58cmr11000815f8f.54.1792061558309; 
 Thu, 15 Oct 2026 03:52:38 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/16] tcg/riscv64: Assert immediate in range for {i, s, u,
 vi}-type insns
Date: Thu, 15 Oct 2026 12:52:03 +0200
Message-ID: <20261015105212.356392-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 247b4a6a60e..3a7761b6fec 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -443,6 +443,7 @@ static tcg_insn_unit encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
 
 static tcg_insn_unit encode_imm12(tcg_target_long imm)
 {
+    tcg_debug_assert(imm == sextract32(imm, 0, 12));
     return (imm & 0xfff) << 20;
 }
 
@@ -458,6 +459,7 @@ static tcg_insn_unit encode_simm12(tcg_target_long imm)
 {
     tcg_insn_unit ret = 0;
 
+    tcg_debug_assert(imm == sextract32(imm, 0, 12));
     ret |= (imm & 0xFE0) << 20;
     ret |= (imm & 0x1F) << 7;
 
@@ -494,7 +496,8 @@ static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1,
 
 static tcg_insn_unit encode_uimm20(tcg_target_long imm)
 {
-    return imm & 0xfffff000;
+    tcg_debug_assert(imm == (int32_t)imm && (imm & 0xfff) == 0);
+    return imm & 0xfffff000u;
 }
 
 static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
@@ -527,6 +530,7 @@ static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
+    tcg_debug_assert(imm == sextract32(imm, 0, 5));
     return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
            (vs2 & 0x1f) << 20 | (vm << 25);
 }
-- 
2.53.0


