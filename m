Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EF4CEFD19
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 22:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdFuW-0008SP-Nm; Tue, 06 Jan 2026 17:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdFuU-0008R0-G2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:52:18 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdFuT-0002wu-3O
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:52:18 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34aa62f9e74so1501967a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767739935; x=1768344735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SM09ULdfP2qiEpdcHmON4uhOxveMyQcjQTT0TUWlYBc=;
 b=Qiku5II+eeEUmHTeGgcuzxhOFCIuxJMoGsKLQBXf/YOXSvjJ8wviwNgVC/be5ez1JZ
 CRQkU8wEiNFrM56L5s45V8HyVJv6E8tvrHcXFLaNLzt7VTi8N+U2PsZiVXxFwymYHqq1
 9VJrXG/RRZDYtT8sGXnuOlIcCGsaESf/CuY60J5EPeGBzEnbYAj80Ad0c+MGwY40rmjC
 iAJR6dqd414MNwrhO3oIWBq5dpYv2/XJ8gV7u+PGq5d4C0gODSp8r5BEQK6EkuQ80nyR
 7ESslrgWwdW1XkOI50SozuEfnx+5aI5BDC4oxIccK5jOsS6Dq7bTIX4Amz8Ic84KXC53
 xT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767739935; x=1768344735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM09ULdfP2qiEpdcHmON4uhOxveMyQcjQTT0TUWlYBc=;
 b=ZdPQC/r2dmKkejodUrf3tZLMaos+2EI3a8ZxdvMwMteTkiknQSOls6ymON4Xo1txlO
 ATaGLjUW5eyFSliHG9qvYRaEVjf7o4eXUp+NCMS3+VsRKliXR29HLAdnDFHWVZqt72gA
 aFqdbfWYVrPHBso8OG2XpOulqjz2+OnryJ/r+yWFee7A72Hdl6a9zvP0srnc9zy5se5r
 u7/9n/lhkWzQ4MPgQYlDDq/3TP7tXku5TMTlG7aNx4l8lc9VMYRCvGsPpAUQS1V33oXL
 ppl3WqELxaMBE4HAX7hmQ5qVjMDJIGnPOPf9LGz/pSN6qqbmwrpFjZCpLkhkI8BRtnvY
 FtJQ==
X-Gm-Message-State: AOJu0YyptvuQDffvZpG9z9e5jqmPfUXlFBq2hMpIM/Ukl6z7fqTHt0Si
 Ce/ShEP82gC5dMvxaUgQ6YlXOKo3hUZNOl0GBKFH3WgZkfgetanuCweCs2RmLsqe9yseAIccN5O
 XlDEBetw=
X-Gm-Gg: AY/fxX6TAHJMvXxvIqPNTkOOtEsnqnuId0L4g5g4eFSV6CiDsKbV4aImKw7ULz7+Yex
 7BtI5cPFpkhJ537wPkkL1s/xRgV8Zl/1I94JEHF7iUF4zGd/yG8GUX9mGlX0vk6ixm7H+LQiYG6
 ZjWnAEKoDSmMnh1RhopTuToR6vcvCSbp9ALlsCqvxYT7JRAoaQUn9HUMGllaUIOGQh0L5UHcji9
 tavtw2/sx6MJVL2oABmJh/p7eqvTqqJqyPkwD1RifxidzRnR1NKKDmF7/7QLqx9nL6PI8r1t+hS
 a/aBIXmwFP14xssuZgEikSVdQpH85gISZ0nbHYowl9kTLBArsKOi/nuLV+49okRZMc5Lwdy7Dhv
 52n4nAzFs86izBvbCJbXpNiJuY8oTTw6haBOqWVsTPTKrU0N5IHmrZ4CV0VMVU6JHS9zndwCgm4
 kMAD+4q/GJfVGMVxxO/vYAcuxpAOw6
X-Google-Smtp-Source: AGHT+IHo46eksJ/6YVzjX3oc4WYoYNEMeGS5KAbAAqXvu2enBI0sL2yr/cgIVQ8b9WhOkLlFRAZjGQ==
X-Received: by 2002:a17:90b:2c84:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-34f68c31c72mr602753a91.8.1767739935167; 
 Tue, 06 Jan 2026 14:52:15 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6007e677sm1520548a91.1.2026.01.06.14.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 14:52:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH] tcg/optimize: Save o_mask in fold_masks_zosa_int
Date: Wed,  7 Jan 2026 09:52:04 +1100
Message-ID: <20260106225204.5859-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When adding o_mask to this function, we used it in a
couple of places but failed to save it for future use.
Also, update a related comment.

Cc: qemu-stable@nongnu.org
Fixes: 9e397cc0df9 ("tcg/optimize: Introduce fold_masks_zosa")
Reported-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c546e8910b..23278799af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1088,8 +1088,9 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
 
     ti = ts_info(ts);
     ti->z_mask = z_mask;
+    ti->o_mask = o_mask;
 
-    /* Canonicalize s_mask and incorporate data from z_mask. */
+    /* Canonicalize s_mask and incorporate data from [zo]_mask. */
     rep = clz64(~s_mask);
     rep = MAX(rep, clz64(z_mask));
     rep = MAX(rep, clz64(~o_mask));
-- 
2.43.0


