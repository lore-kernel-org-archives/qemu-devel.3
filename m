Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0354C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVne-0005Mw-KX; Thu, 15 May 2025 06:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnE-0004rr-3Z
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnC-0008Bj-AI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so8013375e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304781; x=1747909581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=axQheGhKwsHVWYKqF7lq4kkpLFgSDSMUn3Mtx8Bq+VA=;
 b=EaMEX0UGk0YfTeMxYyrif6RLt0vBQCF/+hW/pyVE7G3kQojd2Y5rWjZ9kjQBQXL5Od
 nCGQ9fTZkDLeQsvP8CKavF6AQ+91/h1HflVS0CUGBINIhBNb2AaTjjWbSt++9fw4lXg3
 qdj1SgvFxrr6mGBAEsH6pR6IGOPbbU0MgZYQls+8haeb5Kt+aIPODDfkYfv4cCh7DjYD
 h4MDC9L+dUMEKcGxpZ2cA03Twp48pU3GTfsPekp4klqm5CpVgkMLu73RID88AD87Ox6J
 1wGFR2pkd40kQSIAzTLmm8HtkmCp3dJ9vb7O+q3awVEcmpRykF3/Otwdnw8wkckBaQYu
 7qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304781; x=1747909581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axQheGhKwsHVWYKqF7lq4kkpLFgSDSMUn3Mtx8Bq+VA=;
 b=No6TOfj5LnBg0QeJE0/iIhSjZw7Wzeh5LtOCtoYSlCzLUhP+nc+kG8zYSv1G1P++C+
 n98wGu4ky7L0AiAy1JPOoJT3KpUDZ7rpzYDk6rPk5PE/O7BDGa64PjITaD7DMYYrDxzX
 lZPr6hvygM8d+XtgpMnOk5VoSfVHK7muvaqdh74fMPBc7rWmfb26z9AqFy7ciXpbmIvJ
 +aD155HmAmprwN/RtvwU5IK3l2EG2onFA01nRNwgMtp6f0I/ufe4dgjy/zaahq9ZJ/9U
 f3VOUdalbdQD3LLBBmiIdd5uRLdudzypdcT3OteuUPfRMWWoU21VJrRizjIl+2OIVkK5
 DN2w==
X-Gm-Message-State: AOJu0Yyf4xEgdmgATTaeFUjo9pCVSFJuzd4UJUz64JJmkFW4nEvFjOCe
 iO7lDCgCZyX+2sTqMhZvMb6ZoTA09PeWLAl1trccKeqP/2dAH2Yf7AyKQaCmhTKuNL+ahPaP4h7
 +LQM=
X-Gm-Gg: ASbGnctGZiCGvEkjsxK14OaKl34zzzAJtt97ye5jRrsEGvrEuIR8b8PVvxwLoxVc6P4
 DMefrjLMmVHcczMy0ghzsZUhGUIiQUrm9Y7+IfrXcXBhbUD93ZQUXhCyRrA48pPb4UNUNd6On7b
 KFjUCb+ARPeA1kRIAzkN9tDyeqgK6ctUc0zDiJJHzxGo2CT2rib1OWgLUzmVQxgWOo3BUgy7Qlb
 kpdkiD7mzY9IE2AmQQNymiEwaxuNMe/xsuAQJRWbQrxLvoZOv+GQRD4x9wc3XicJQNql0gXmNPF
 U/UJnJTwvOIlt2n06zdN6mLneMBo6/TUHIjh2Af8EaKe/ddTvpF2diyu/w==
X-Google-Smtp-Source: AGHT+IFHwDoSV0EO4qeb2+zSKlOxnR2n0ynRwhBalyJirbvnpk5VCUIkPpY8qok5B8TsmYnIjQKgYg==
X-Received: by 2002:a05:600c:1d1c:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-442f2178679mr71251815e9.31.1747304780684; 
 Thu, 15 May 2025 03:26:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/58] target/arm/helper: use vaddr instead of target_ulong for
 probe_access
Date: Thu, 15 May 2025 11:25:12 +0100
Message-ID: <20250515102546.2149601-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-15-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index dc3f83c37dc..575e566280b 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.43.0


