Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF7FCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbo-0004oq-Il; Mon, 22 Sep 2025 14:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbh-0004jm-UY
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbe-00047U-48
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f169d8153so2465325b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566983; x=1759171783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=B8H8RuHzjKuMgtVt8c6UyZoPDC9PXzpNIQd2kgw1ng+ZM2ysuU+ep0YHoc/fAJxlnQ
 2KgQBHKm0iEILPyTm5aS0hP3Y0SCWE2m8EGQ+MvEzGG4LRodbvR7/AJFTTTdu4em/v7R
 eVCyrSNIkFnQxkoOu1Zgjm44EShHnDtJjOF4MttVQh7BRH1+uxjLs9wVjqYen0OGC7dr
 JTyob8qpR0lAxibb13QMATA/seQ5coPBPN2najqW8HT+TctWELREz/X9GU/JywbJArHX
 OCvETn6sv5oKEGgHIMDUnNwfo8Lc0BzWFPhq0fXrRtjeeTZYBXxQR11ZAa132QgLBtRF
 pyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566983; x=1759171783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjDdAknr01k7YxkbZX1BtFHr9eMT0hUzaWlnonFMe1U=;
 b=FtS8Fq7tgSUxoV3xZbMVzBsOHo/exW7xU6to8m+bThuiL/ElRLhRwPn1Y4bXLs+yBz
 NB+BQmnMOVQ4tpznBsNaz3DZtsjgggZCj+vw29gLMlJZEWDGbfrZxe0m1HweRRV8nCVD
 tk8ovX3phwRv0ItRipyrZ5px3u7wl5ucz00+rlpOXGx6FTUNhIC9Pnp1Epw7+k9glLAi
 srs3HKAOTehc6Tgy6XAzOkHlCr2L6yEDZVLl2FB5ugMQ6h3pCk0D0pEtv8gRxW2Lm/mk
 wdh8LD4f1ZGAbQ8VUFRjxhyIv7KjvHo+qa6HVSg+yVYgVG2Usu6osV4vgMiKCvMNxFad
 u9Jg==
X-Gm-Message-State: AOJu0Yyf3rJXHEw1+msMcX4elgVhV/mtTk39mv1lSziDoPQMHBwFa4tD
 n94V2F4l5R1s6YPqm1t951P9ThfGO7nkXZyV1sAB5oVkckWnxaCGGfL54QU5C8mMqgHj3XnGm/Z
 pU45r
X-Gm-Gg: ASbGncsbhxTeX6XCfD6YLsxUWJwmVXGkbaSh/DWV70TBHcJ+eylzEBhb4gx4S+vdIi0
 TB3weMkmYwdQyJb96G6X3rDiZszGMAHMXFC0ufC65ju/7H2fCQ4HaT2RP3qF789gcTqI4cAy/Qz
 5CIST5htqJ6BIiQdZheMXx/xfaA6ok2yM0Ru4w/9fc3ZLLl0SfukY2SJFcMVRCDbMbhRbgg1tUX
 t0SZJDtl7ORlmXfBrMxis3khmXgyCA6L/PbL2KGFyemN/i+k9J16LxnsBIP8sGRozxHW+MUVQpe
 wNNJAIgbt3RjsF2RkN2Op3AHb7vx5auovfU4HgT6ZICwTkJ85q022pmi9+iDwQ9v3SPBxtw4uNo
 Xwog+7FTZ742J1lzNCssv+oeWrRBX
X-Google-Smtp-Source: AGHT+IG9l/E5qxoU415HfVm19C5uvxsbygJtQKbxCJJ7q9D7/rqC6pLuePWOnQuVt3LEXzJjlFjqBg==
X-Received: by 2002:a05:6a00:b8b:b0:77f:2e62:1e32 with SMTP id
 d2e1a72fcca58-77f2e621f28mr7111628b3a.2.1758566982569; 
 Mon, 22 Sep 2025 11:49:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 12/76] target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu
 max
Date: Mon, 22 Sep 2025 11:48:20 -0700
Message-ID: <20250922184924.2754205-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e..76193826ce 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,6 +1253,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 6b04c96c8c..94a6192fa9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -122,6 +122,8 @@ the following architecture extensions:
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
+- FEAT_S1PIE (Stage 1 permission indirections)
+- FEAT_S2PIE (Stage 2 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
-- 
2.43.0


