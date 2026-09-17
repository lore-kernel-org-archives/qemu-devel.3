Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C18C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JP-0002hA-21; Thu, 17 Sep 2026 04:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J9-0002eJ-U0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:28 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J8-0001tb-FC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:27 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d2fe2056so323038a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633044; x=1790237844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FutGg4dEqSXpSwNwdawEaCYJ/4Vv7VGANxjbNML7FmE=;
 b=pjmx/ndsBnhSx6D/eDYLuUEMcc/RT6abesXSXcoJagWQU7aCL80DY1Bu115K/n4c6m
 FCThMPAHc9XwKtZCNh2UQIIiEJfgpL/o5/Moe3+NireHE1MP8R1j1f29vuECkBUtaS94
 IGF7SILGGSWVxuvMRl8fZ0pkvJcQzdWANx3HZGcFBUTqLj94sGAmwqj1T/ENbkFiqBD6
 Hzgpzmr7Cgom0ut8bU1ovlwWQaeZrofm0+qg4xekasFf0/oiScRYSdOlj/YaU0jkVXa8
 R0fgJ/ojtfvo5zW9XOV2eoubXMe/VgLgeVAgvxJ0bF5V3/LLVo2L+yvhRmwq9c4vbwTg
 wS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633044; x=1790237844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FutGg4dEqSXpSwNwdawEaCYJ/4Vv7VGANxjbNML7FmE=;
 b=Z6ONW04hnenFKGUnFG6A1/C/VivYRjkVNNK64wi9V6qSUvFeg2ZnmeId9QHxgl1x8S
 egvfuWkXepJb/HDfDbJaNDlROCs85y0cyXXU9+4mctMfr119SjC7na2aCO4OkfTsVDc2
 vLgMJ8smpUHjDOklJDWpxP/f1GC5cy4rIFCBu4fmhn/YxDj8hWS7v5R+GwJhvNa484dh
 yxHC/EsU/kD+fgEHQte8heh1pBa+nNK/i94OxoJ21Tei5S7bUSeUS6Ju+sKezjqNBZ+E
 MIPgN0V4M6yT6g+FjUhYBjNdU2uAy+OKkEYK0mFBAxEHb/OQn73c5Z0a1cWNg1EnbGGg
 7isw==
X-Gm-Message-State: AFuF++l/+BJGrI/tSIR394Np1g/dGbxlEoBXgPSPEUHOsSwS7gyp/yUL
 LokqoPgTEP9Ci7UnHFzJMdIWqpXOS2D2JkDE3NTbQKWoKVVmVDyQgsAoyKXl5gLywd0SbTFD9xk
 Q2YqrviM=
X-Gm-Gg: AYBFou3j4Y/FkOfQ0iCZpfwF3R3mfyU0pOiUl8sBEib6ZWHAB4Kott033MG9/AW+Fq2
 ZIaXpOjCBxJSmrs/QnfLf8fkLAazf6JpI0cdFghYl+k3xZT6KEIeCWOpy0/KdfDlAfGHio4ucgh
 DhwPA9pABQL+JNvyQr4aZy8Za0MqYu6kM/3o2KZyvrp6zDWyeSdvUqAlRJuQ958+EvS5rwTHr0V
 abb5Gd8sENum8EDJ+IIY3OVOfJeeQTGslCEaOPMeq8rftyqShxEIdMG3oGw8wgsMIgBEePhpsol
 dnjaoTZY7U+ZFoOd1FoVuJEfB4sA+04Rdz7nCrK84blSdX8AYRwIphAIE+vN8SuvR1D4sCD74cL
 tnDFbMsgyHF2sRpKtrycTlz/4uxn8u0Db+d1ns76/AUkwCQbhe5LlGGAJHxaLuNqHaDsy//F6sr
 X7ZFvfgO37vB/uHcvqS/Z577f5480osyYoYHnN7vXZ+JHSqndqThMusxVdBaI6uvKTndVDhKBhe
 IHomQA=
X-Received: by 2002:a17:90b:1648:b0:39d:e43c:5a0d with SMTP id
 98e67ed59e1d1-39e1e2f9e12mr13064424a91.8.1789633044419; 
 Thu, 17 Sep 2026 01:17:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 05/16] target/loongarch: Use tcg_gen_lea_tl for ALSL
Date: Wed, 16 Sep 2026 22:17:05 -1000
Message-ID: <20260917081716.946668-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/insn_trans/trans_arith.c.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
index 2be057e9320..c358e642649 100644
--- a/target/loongarch/tcg/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
@@ -188,9 +188,7 @@ static void gen_rem_w(TCGv dest, TCGv src1, TCGv src2)
 
 static void gen_alsl(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shli_tl(t0, src1, sa);
-    tcg_gen_add_tl(dest, t0, src2);
+    tcg_gen_lea_tl(dest, src2, src1, sa, 0);
 }
 
 static bool trans_lu32i_d(DisasContext *ctx, arg_lu32i_d *a)
-- 
2.53.0


