Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96052CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqO-0007Hi-Bb; Fri, 10 Oct 2025 09:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqH-0007CD-OG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpO-000401-If
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso1539985f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101591; x=1760706391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7GyyqrpcCED3owHKwsReg3NQOmlFtdP+Ki71kwEP7Q=;
 b=TB5NvlVCEbQswnnUi14zPkiyThAM1YaSN5tFo8AHi/OUPXXcLIgeI5Bd+1O/gXxdaK
 64sW/Mv+JH5FlebykXN7GKby6NqCsz+Z4ZniYBHbNXUbYd7essV22WxOpEkhOteMX7H3
 4LlNkO4U2N5B14nBKFE3UqfBagMa69CA4U1TmzriHuPGuI9aCqAK5Z2J52YcLsOTWLj3
 iF1y5UPNZYCjXx3n2KZkc4YIV2LaAW9ag4IE4Ep0xyJBD0iFy0qtMZ5ZfuXetbrtrKBm
 iB3QsEPZMQWxADx3MWz5sx8Fqab9/9qimMhCpqDSFPhplTY7KVsKlRb8xLd+JZQCylVK
 j9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101591; x=1760706391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7GyyqrpcCED3owHKwsReg3NQOmlFtdP+Ki71kwEP7Q=;
 b=VjwmfeCknPhaMhdzcs9ETFqAoUeo8DDeNHKtw8gtKqUonXT5bV6LxwsCcn75fZ7tqa
 ffHAoTOu+8pNzKu/eKDl5bRsvK/+MC3XJgtQhExJxKQWFwjnfrf0EGjfggIE35/krL6k
 FIp0M/Pd4Tlvbichhz2LdGMN6c8lxiHxQWdOVEd5xZWHmGuwL98TuHphhS5nyyQm1Ber
 eULBAVPwIkUXtbUwedB0Hl5RWiv84z1F+mlvzB8ItEJg24iK6U7onW6zZ9UhwOJGLUrV
 ORIUCBuXKYJ0g1PLSoEn/WmlQAhmM7vvNJcwEaGp4oo9O7sTgwztxSBRwZP24uD53Dbz
 RZnw==
X-Gm-Message-State: AOJu0YxCgmvaCyCJyfw6pcTZFsChk2mHnuMORyyqQBUru9ZINZwN5DkM
 aDR4oMAP1/eYc+vvztvwF+WUC7yo49ChSAYf343Y6wWuVeOE0FdaRpFGLklLIvQ74gXGD2yfbRw
 X/ARj
X-Gm-Gg: ASbGncus/WWmiE7E0W3JpHljzz89F1f4UGZ2XXVCJiqIXgBA03c0FwVJfQLiBSS9BTr
 aEHX+AW44/U2ur4izcnBXovywCtKrrDKuEec2M1g5DMGyu5aH0qyq1iSHuDaxNteZd9tCKzf/5h
 adhPCRDT/Y76cNUBw+zfMQ84LQqTM55+NPouKxVbMtelP1w+dw6Qcg3dwIWls2375f30jOFAGSr
 tWOHjv2xm4tIzpUoSIt/2bExrsUY3LArJE1/Wh+e2Vc0HdjI185fnw2cVCLDdxiXSEo11D84I3V
 lX5ci2DyMltuX5/XhG5upgrz1E9+ZfsQAJ9E+cKIJXWdJdpvjC45JX3d3lGzJTfIJgZFuBPRvaL
 P3osauSE4z9ZthrAdztO5u4vW5w+eDSAA/wZE6SmFZagAx5RiF8I=
X-Google-Smtp-Source: AGHT+IHB3+xJ+oj5pKiXSMhdlK4fcwYuhRPYyoR4Wm0IMdf2I1ZstwpPf8D8TuPy3ryITSZhmZ94Qw==
X-Received: by 2002:a05:6000:1ac8:b0:425:72a0:a998 with SMTP id
 ffacd0b85a97d-42666ac3f18mr6741481f8f.6.1760101591394; 
 Fri, 10 Oct 2025 06:06:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/76] target/arm: Add gcs record for BL
Date: Fri, 10 Oct 2025 14:05:06 +0100
Message-ID: <20251010130527.3921602-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-56-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d58257be40e..9a564339fa4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


