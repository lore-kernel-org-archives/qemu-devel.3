Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C044EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAhg-0000P8-3V; Mon, 29 Jun 2026 08:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg6-00074i-1t
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg4-0007dJ-JQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46ee68c3b7aso2745722f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734487; x=1783339287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tNaIawusE1x3L4fqE6yce6TmDV8j2sqNoy68+MthVhk=;
 b=ZOe9Y7wtiofLjL2HiLJXu4ShF4hajyUrVNVgLMc27C/8XgRB9e/r6S2mdPFJaBO8uG
 g1LXZAjhOF9dBe2cglbBIP0UR/v6ExN5X415HB+X52LeGc/DwAnvvijic6z7imnaqD2Y
 p7wvZnDIi6moWPi9QFd+CjBxWLqtX9cLwZOs2qwnh4zhg9dFCnTrfncw7/LYxz0KZkCe
 DKiO2HMKaaXC+5PbSHPwnwjmkCCmOmV0EayVngSKsvsx5rYsCawPtydYBF/c80hB5agG
 6ZSDhCBCJhHwS7TZjfEJeR6sbRUS5mPA97V9E5BBibyGcc5Y0NRb9duNrc/MNkZoBo1O
 vF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734487; x=1783339287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tNaIawusE1x3L4fqE6yce6TmDV8j2sqNoy68+MthVhk=;
 b=qCkiKVvXiNrGYW4N4/YxWuqlwFKIQ2qMkxbKWvWL9LLFJsRDBvsOLeultFqY+wNNf5
 Z3w4Bz7GjreGc8067soypC9AA6cC+EmwTmj0XFASbyKmX7BjzN03UEimhxjvQIMHEf6C
 E8ifPobhTmfcAmfBw+rXfk35mic0D/pJ8QkeRrRNAhyXzZBRrhpf97/KIbyrZPTy8b4x
 g6Q+44JpXFoXJjXXZCC40zZMJJtGXmBdZe6NYJ50wul1+ZIgFy4u6rOO7/wgv+JRmysP
 v5QK8eQwMphKTr/8nDMUObrQU4RX5OmPX+6fPRGOM87xu4p8k1foVXAC5QVj1vAU4Xs+
 KC7Q==
X-Gm-Message-State: AOJu0YyfFq6xsh2FlhbuE5fCPBXDkprr6kFDKw0pY2Ysb3kYXZW9QtnG
 qsgpH3cH+7bihU+dJtXH5ZPYiyM+W3fQLYvFA3/bRFLhfHIrf+n793Nt2T52n3YJBSb27oefPaI
 gcayB
X-Gm-Gg: AfdE7cntvb8bkJBe7ceBubBEiweTBF2kxuyjGbW5mF9CpPj1/oGXOiqPCGdf5Fh7nzt
 tjtwxLoDMMqAbSNwPezvRYpKxLezreWtE08GKFKlQD9qEIvjyaChKdzNIVaN8NKYmsFvSaCqc+9
 W1W5BkoFDIC9yjIPnv7EfeyI/YAnqoLO/1HfOnRKKHezQfnJjivjRgICyRH++87camm4KJW7k07
 XmlcqHcPG62qeyISiu7Z6W30wzHKWTYtN8bfXV24+LXm9rhuLd42ednDV8osZK3lykbCtWRLKEM
 /GXaR1CEqPgpG68lqBHeEN8FpuS4llambCtsF+g2+gRIcR8AynVfZ2Z/YrpkL46bR2dnA54po4o
 NqLqIHhMhyWibgfKqVZ37uwIy9p8r951O0ehCQMqZhS7dlNDg/urMrymVzQVjOFssm/9Bt72vL2
 WhB+A3+HWRZvLotgf7+DK46B/4bYwbysePOrtAwmCPsrzz9kZqeYHi+1vJKe/+z7oAlYR72YFxh
 zfcRZlhCfHXqbkGltD3DQ==
X-Received: by 2002:a05:6000:46db:b0:474:fd7a:93f2 with SMTP id
 ffacd0b85a97d-474fd7a9733mr243088f8f.15.1782734486954; 
 Mon, 29 Jun 2026 05:01:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/54] target/arm: Rename FVDOT pattern
Date: Mon, 29 Jun 2026 13:00:29 +0100
Message-ID: <20260629120032.1645265-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Rename to FVDOT_sh so that we can introduce an insn
of the same name from FEAT_SME_F8F16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 2 +-
 target/arm/tcg/translate-sme.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 755d5f00d0..160cf130d4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -662,7 +662,7 @@ FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
 BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
 BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
 
-FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
+FVDOT_sh        11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
 BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
 
 SDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_i2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7eeac28480..267a6b0d9b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1260,7 +1260,7 @@ static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
     return true;
 }
 
-TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
+TRANS_FEAT(FVDOT_sh, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
 TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
 
 static bool do_fvdot_sb(DisasContext *s, arg_azx_n *a, bool top)
-- 
2.43.0


