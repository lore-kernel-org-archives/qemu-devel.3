Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDD6C7115D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83K-0005cb-MU; Sat, 21 Jun 2025 19:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Z-00030U-Rg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82X-0005F8-VF
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2372736b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550068; x=1751154868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pUvqREnC+qRs8Vh0DblPfC1qnw68a3gwv6JiEnceL3M=;
 b=Yeb6VwdJpQV+aYOUK/H+k4LLz86eK6LG6TuwLbgKiRnVQpdJD+pypsM/EW2TKAu+pR
 B7qYMmoidxo8+qlLnIUTKvf3MU95Flv8tCJsYBXgMNOX8AwtZI8ZDlU+/cXcAY+erj5d
 HdN+zQrg0GsYksC6oscrzLv/ZVfP++ch9Amk70rbdXz56Y3gjcdBUyPW1b94At+agNic
 raIICmPWe8btirGibgUQX8M5D7h2PE/x/Nde5Ceg+CdBA1rF1kGYBglqTNaxc6TwkH7S
 V145/gnJvwlqpUjY9XQEpcHOX3bz9OBXJJ67JjrNzUbqemWezlDEuj1G4wCSn/fHXd8u
 wVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550068; x=1751154868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUvqREnC+qRs8Vh0DblPfC1qnw68a3gwv6JiEnceL3M=;
 b=BiF2K81wwDeb0zZMBmt9x9X7hPa8YwrTZr1FYyQcmw+NPAevvqQVmJfba26T4BD9Cg
 dfl3SwUxqVzCQGuNqbnFUcPjf6WvwiycxXy9ciOn//Jun2QIgFno2VXpHS0Ladm59EPZ
 ZYI8+uewjhZ28qjoNRXVaA/9/aeiyMbLuLVNoVxUZRB/+UpoYMBTh117325G3F32iPXt
 egW2Kk07z6J3vOAFzN/8rZYJyXemAcdhOSGRfZQYdBTGSrx4k9A8OxMlGsF1D7TK/zui
 L1XIvF+bioiEtQ0M2B1NX42tID2cnUbMgufnENyuBVEdizxyrZH1YSOn8Vk3iugwZufq
 RVmg==
X-Gm-Message-State: AOJu0Yxi8nUrm+oF9QGg0u4Ico5l1YyjGFtmxtNROwDCWYbhhecV8dQ+
 QqBN3R9j9KbOBjgUX7rRC6/eDuBGBRUjms+Bps604iYu7kXkaLiHyAMJr7u1bMwro3U++vMZgVC
 tviJhxP0=
X-Gm-Gg: ASbGnctBtR9jwAQIJyK6pHXQrO8pLelDf21ybNg/oyPGp2XdFKkw4SOvSpjNBy/WgNk
 5v414a/mGqjj7J5Io9y5QjtSwTLR1xyzylfgMJdJQkY1YTcqBNZr9zGYFMb2O6rfY3hzKqP3XXW
 aO0ePojLCENBFEcNPAYkstUJAGLMg5GDbLeOl8/icAXQ8cTinJKLv+gA5DAGlxMcoEMtbQ/seDq
 R3zlguKZm82LVje10YW7y8XZsH5yP2Vbo1oqLRh77pGTyZGKWYRUryDSzQSg4gYGe6fNNvghkqz
 S76qonLPkp7/s+e1C2IwhgeUrr2oJfrXH7xvkqwNlS9AEZMdpPY7jluY4vdTd0SEzNvnLMycO0l
 zhKmana8ODnFNPck3LWQw
X-Google-Smtp-Source: AGHT+IEtYArWRBqPeHNdQaTBbmlt4do6e9nnzWDGPSWX4W6E30xAJU7XbU6JT8edqiShq8LpyejgqQ==
X-Received: by 2002:a05:6a21:208:b0:220:396b:9938 with SMTP id
 adf61e73a8af0-220396ba1demr4431195637.18.1750550068455; 
 Sat, 21 Jun 2025 16:54:28 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 078/101] target/arm: Implement SVE2p1 PTRUE (predicate as
 counter)
Date: Sat, 21 Jun 2025 16:50:14 -0700
Message-ID: <20250621235037.74091-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3e82c1ed49..43993fd193 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1679,6 +1679,22 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
 
 TRANS_FEAT(PTRUE, aa64_sve, do_predset, a->esz, a->rd, a->pat, a->s)
 
+static bool trans_PTRUE_cnt(DisasContext *s, arg_PTRUE_cnt *a)
+{
+    if (!dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        /* Canonical TRUE is 0 count, invert bit, plus element size. */
+        int val = (1 << 15) | (1 << a->esz);
+
+        /* Write val to the first uint64_t; clear all of the rest. */
+        tcg_gen_gvec_dup_imm(MO_64, pred_full_reg_offset(s, a->rd),
+                             8, size_for_gvec(pred_full_reg_size(s)), val);
+    }
+    return true;
+}
+
 /* Note pat == 31 is #all, to set all elements.  */
 TRANS_FEAT_NONSTREAMING(SETFFR, aa64_sve,
                         do_predset, 0, FFR_PRED_NUM, 31, false)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index fbc4487b06..13a76f773d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,7 @@ PTEST           00100101 01 010000 11 pg:4 0 rn:4 0 0000
 
 # SVE predicate initialize
 PTRUE           00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4
+PTRUE_cnt       00100101 esz:2 1000000111100000010 ...          rd=%pnd
 
 # SVE initialize FFR
 SETFFR          00100101 0010 1100 1001 0000 0000 0000
-- 
2.43.0


