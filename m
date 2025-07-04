Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BFCC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGK-0007g9-K0; Fri, 04 Jul 2025 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFB-0002ud-VX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFA-0006s4-DC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so633505f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646391; x=1752251191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=26HC0FsTOSIeMw5Q00NiYX9kyMHT+cuOwa9g5fC6GPw=;
 b=OSz/dLrG0zXUzz3UCDFtFDqmNtCvbO4jqVRL7VA18rOkzD/PEkJgFq2uKaPGBK6xPU
 IQK/PH1lS82Ur9+yBE+kzjbD4/zlCDtx+MMq8vo8Cm0vUQQtUL6sLZrQ6DrpHaR5Y8P7
 /r2QnMP/larbr90blhbrepQrlCvLMolZsAqltJkcu1edocfYcPvyjcyZUMVpmtvwUsy8
 05IcdY7ybclQ7WyEcZYGWRwYbefF1jFQenzYxjc8/5sq0Prqf5It9IP3Iz3jPfU2kXbN
 FnK7p9kB9eUcf/34/3ooszO/WbvHuHZ9NDc08WoJqutc4R3uzmdFsbttEtPwYkQXyhVk
 Mzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646391; x=1752251191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26HC0FsTOSIeMw5Q00NiYX9kyMHT+cuOwa9g5fC6GPw=;
 b=abXP8jLEqA8p7RatA3MtPh/P1PC66PUUe5dRzhS381N+r9mPL5OQeDek/lIr9MoGRu
 Cj4mIRcCvz0kHifhPvE46PDHYh9MzXWJq5ihh9+YDqktGAuIm05WcQz3ocPH2+npFiYc
 Ms/t/gOadcNmwGpHXZRnJAVpn09gVz32iYwbFKoEEkMznWSWZZnO1zb7+MXo9vxrV8Cr
 oOowFRa4r0ABWr8cpgI/89wZXiWqFlWJlgWI6kpmrOZ5XssjSd/w6ZZG154qxopE9z6n
 pBULxzjVUQedzogfIktrZA1ExNDODH1Ld2KcJUAUYVUMOCAOh6LfMkNg6w5GtzijbOU+
 gcRA==
X-Gm-Message-State: AOJu0YzKJ1fsqc8eZggGjUznMq8GG05HjuckjsecNWsoJViAeDrLBnw7
 qR2ILO9BSJSPK64RTDSxxnXaaESdo73vZ1SwnOOHgwTk04jqZN8Y2GdA7gnt7NBRv2n8o/Klo9O
 y8Qzy
X-Gm-Gg: ASbGnctWgXysK4bq5KdJb17zmhG6p6WN6UV2YDe/tIIT9Nw29IacYj/3Uo9KWayTL43
 arbJ+nqTz62Z/QWWzu1KIhTELDz4b6ms1spqzyptn3P6FdVPvX3ErAoasnXeuo1aK0pGOMRfnac
 x+pcourPQStNebGPPm9vV2ZfG3pUY91+c5gI1CVw7cMyuhBPjZo4yBhEDarCafxK2e2v0o7j+Oj
 3lbuDiyTgUHDJgsbrAUYpcifs/b62vsVlR2ih3wpa1Ggb4+TqdwRj5FopYkl3u2tfxCi9X6/gTh
 Gozh/fCZE2Dva++m64a6/sn5d+VUTRy630bkq8AuBv8EdoS7kgrUu6KybU/X30g2rj9R
X-Google-Smtp-Source: AGHT+IGcqaVwEOhGN6Lr7fokd27Nd+1KVYdFf2DjotCEsJ4nQqe7/kwGnGdUKQx/s0HlBYyFZgcPQA==
X-Received: by 2002:a05:6000:2508:b0:3a4:febd:39f2 with SMTP id
 ffacd0b85a97d-3b497038e4cmr2137575f8f.37.1751646390817; 
 Fri, 04 Jul 2025 09:26:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 092/119] target/arm: Implement SVE2p1 PTRUE (predicate as
 counter)
Date: Fri,  4 Jul 2025 17:24:32 +0100
Message-ID: <20250704162501.249138-93-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-81-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  1 +
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 389a72d8242..3517efb31b3 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,7 @@ PTEST           00100101 01 010000 11 pg:4 0 rn:4 0 0000
 
 # SVE predicate initialize
 PTRUE           00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4
+PTRUE_cnt       00100101 esz:2 1000000111100000010 ...          rd=%pnd
 
 # SVE initialize FFR
 SETFFR          00100101 0010 1100 1001 0000 0000 0000
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c93dca224ce..651b4aa3781 100644
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
-- 
2.43.0


