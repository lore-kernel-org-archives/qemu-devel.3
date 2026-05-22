Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C258CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY12-0005mz-K9; Fri, 22 May 2026 18:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXyX-0008A5-5i
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:04:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXyV-0000Vc-Jz
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:04:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso58228015ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487450; x=1780092250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e8wwKP/bBxQafPToM240yR3kugkfCmhC9BaMFftKeuQ=;
 b=Pr7anjiAXNux33IR3x0H/VslGKINyTVpHJ1seFLo3bGMMtSMtXftfDWiVGeocjTTUU
 X1SKr+1BrfuLl/sDrODP9/82EE/sXKLRNZZqEIzPcMgG/sr+YJoCljeC8syQrF51YdYu
 x7gjhqRFh9uFO1jNCDgzt0/WNwYJ/DHGJGLpMyCh5vOU1cGKUff0WszO9KXJFSYU4MoP
 +gwq9H2wZRhBKozWCDw5LhHxYjSXzV54rdUfHLfF9Nsz3BY7jm60KNU/1typJgG0Bn4V
 MtbEsdqf7zhub0tN3EpB0DFCjH1T7YEBfH1HzkDit4o4M9eq6hq5z34DL7LhWPVvqegi
 2fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487450; x=1780092250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8wwKP/bBxQafPToM240yR3kugkfCmhC9BaMFftKeuQ=;
 b=OCEJQSS9JkEvxsm1KlpeW4VnfHSI8VF1o+jkNB2OicbggPUn4FWvNb3oB1OlsFiIEv
 dYV/Wht+47AQSHqauGjEo62l36Pkrp52scGM4YC8N2wyeQ7Vknu0lgBnUEkRxYjjZZfZ
 XQMWQZNpOs6rv74NrJt4fAF9BU3/Qmi5IJFUvrGPjL+Wd/rB5XeCoPi0qhLK4pOgG/MN
 UhgHRI8mW2siSNPW5xrN+CwCfqdXIo3v3P+8sApQazu5MDFHZ7b5xlP4cHOM400+qfW0
 1zzcaj/DEf9XAXcsWaDkhd137gPlul1t5jixRrDKtch6IBBMDfl6iwN7OATwVnSENSGo
 RYIw==
X-Gm-Message-State: AOJu0YyJJof8AwfiQcVW2hD8DAdWrcRw4RUg354oiMeC0Uagq9qsPXMU
 QG7/pUC7laRNoSSauK4V2yGGt1D+8R2ZPedQSzXWWcMTotK9nZzdCxy1mFEcCYUfdy2KvZ8ayEG
 z+U6A
X-Gm-Gg: Acq92OEj5FLaOyZobAKhQOZ9xaKREwG8iD2aVgJhFdnpHCCR5mvrE++OuIQQa9JM50n
 +eR5MmxmlNRoxBKf/KXFUUh1yBB2BAxV67CNQIdwEmHk6PR+zg/B/4Dex3bjmFZlsLiHSfr6KQq
 7XP8uumV4fDX1GIczB4SQBSKC7YEITGRGjUU6A1Y7pBUQoOxWRyR5qVDFpBxhfYd2fZ8Xcd6QLT
 mAqd55GRPROy17MgxUN3DmdP1YAdbjyBN73mjUlY8QtdUQtWE24VCIE+tUj6TUgdno1XBKb6H/H
 nu3Acsz8+nu+0vwcMJx8OaZDZb5AdBCCmYHitYXVQGFiscvwBlbkmdVMhEv5sDBp4XqKwd0ausY
 Eb21GOL9h1cQ1If3MAczzSpQzVEPfZTjx0LEe3mAZvROjGDYrd8d0Ig6CEpC6RfeDl+TrtjHVOk
 DNbC9t3CFVwaopNG4roJzp+oi1XgrM
X-Received: by 2002:a17:903:1cd:b0:2b0:6f21:8289 with SMTP id
 d9443c01a7336-2beb067c5a6mr58563455ad.25.1779487449780; 
 Fri, 22 May 2026 15:04:09 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695f05sm35289235ad.6.2026.05.22.15.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:04:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Enable REVD for SVE2.1
Date: Fri, 22 May 2026 15:04:08 -0700
Message-ID: <20260522220408.235438-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa7d72a35e..d604a53c18 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2993,7 +2993,8 @@ TRANS_FEAT(REVH, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, revh_fns[a->esz], a, 0)
 TRANS_FEAT(REVW, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
 
-TRANS_FEAT(REVD, aa64_sme, gen_gvec_ool_arg_zpz, gen_helper_sme_revd_q, a, 0)
+TRANS_FEAT(REVD, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
+           gen_helper_sme_revd_q, a, 0)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
            gen_helper_sve_splice, a, a->esz)
-- 
2.43.0


