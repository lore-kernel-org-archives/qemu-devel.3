Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DC7E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4YM-0003V4-9Z; Tue, 07 Jan 2025 03:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XC-0000Mj-2w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:54 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X7-0002zJ-N4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:51 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so17813948a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236907; x=1736841707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8VEzXl4BnO/efZUnoujEnV2JQ2xjJx/4lbc0rC8g5E=;
 b=U022may49Ap4Kf7pd5ALjD0nc4f6gbyJVrqjQLmG2ndHX2peUyJQpmLj5AA0T3fzHJ
 cFBKGCVMrdCuvwK0521J6OIZgSkexKZaY/Qdmghb03dlkE582ZRFmwv8WIU4KETDbHiv
 TCKw7pC5pQTHm2QljekUkJ8Tkl8pN5grRGQffYIthaJSCVhvqCSxouolVEYIfk8f53co
 +8W0tYrWJarXjVLJ1Mw6g0sY3iWOMtkpKzfIwfTU/sInCTygaLS1rv2QiAAUKG4TvkqM
 kdq2quBoJ8F3HHZf4x+sZ9iFXxgNAijsxNyq1XS8dc6kGXVMv44TIibKmcZZFh585Lw2
 e8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236907; x=1736841707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8VEzXl4BnO/efZUnoujEnV2JQ2xjJx/4lbc0rC8g5E=;
 b=qdxvBpKwsX4z9gTfRDIpsaDbpA9jGF8+dlfl98KS8fJ0yC2PGYRgR85BCRr42EJz9n
 G6Ce7uvBTnUS/OC1gxqtpoil5//cDg4kAuAJLECdi1yRP8dSbwXb7bM6XUjZyMXdufWG
 9nf+Y5y4WIeDLMhmJ5AM7PC3zOTcXoNCFGlgo19CpsJYhtF2oyyLLwgKcLLcF4K8giG5
 y+BimIzcX5XEN3q4vPZgM9UJhHChWt7S6dBWcftlq1Uf4ybCOrMrh0QHE9oBudwEJCHf
 DMx9N9iC2FxU1J1E5xT/Ml5UG+aHxZdLbVqjIsGUPjhh2hdtQUR5thwfwxBTIJvI1Q96
 nWBA==
X-Gm-Message-State: AOJu0YxoUMAEHslz5sToss8jCk5eNu1FBNAcHZks7/c0SuX52/t+nKWi
 3EWZLITFyMgxaI0I5Yh1gPIpKEJvZIhN9z2E93tB39k1M1kRzEG6E2jO5aH/x9MSUVzEHG2ZAhU
 D
X-Gm-Gg: ASbGncsvZY4eGG2Xg3MrpgPbjeRuOrdBLJweZQh1DGQAUlwJoCjR81bOpMkD/AkrBPz
 mgQ9FNPYghqaplvkyFzalkk/6y/2AAExqGC3gIRJ7fOg4NWgjDPcWcC35K0skrS/eINAgzyrp/U
 9OhBtSFsXEqskMsj2xiRu/AxfHoVDtxAdC4gcqg5Q+sheQkW9T3yh2RFhvWpIznCtNBlclqRHLb
 jSEIVpip+3w6rFgcbHCEx0+auHTBExzHN4z6VHOBPxrwPSYHJ6vO1sv6174cgifFVdIvoYVWK1o
 0vF6T1+CQJTf+iHN0Q==
X-Google-Smtp-Source: AGHT+IEn8EwbL+eCcNGlv6ZRUTVaWlBdbjwOuZNFi+HDO4qsRLPyl/2U2pzSxetNN6GKsvkq2dkfjw==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:c797:e276 with SMTP id
 98e67ed59e1d1-2f452d3000cmr106708371a91.0.1736236907130; 
 Tue, 07 Jan 2025 00:01:47 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 32/81] tcg/mips: Expand bswap unconditionally
Date: Tue,  7 Jan 2025 00:00:23 -0800
Message-ID: <20250107080112.1175095-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

While only mips32r2 has explicit instructions for bswap,
we have built subroutines for bswap for use by qemu_ld/st.
There's no reason not to expose those subroutines for
general purpose use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 5dbc63cef6..d3d874ffd1 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -51,6 +51,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
@@ -78,7 +79,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -92,9 +92,9 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i64     0
-- 
2.43.0


