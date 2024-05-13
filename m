Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6798CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QQ6-0003k2-Ua; Mon, 13 May 2024 03:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPE-0002nH-NC
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:33 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPA-0001LA-4A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:32 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e538a264f7so36924351fa.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586446; x=1716191246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VF6uhgMTXvCNMpmE9TGG3M5Ce9XJhasOpTWLXUhXUs=;
 b=to7oM5G24BtaTUdtK9pxsvaVdbime/xj0/94FS3BsXOTK9mbgeFC2VW0+gW2LH+a0P
 H9o22rCLxNOrbUfOABirSZvflEDQ21yW7XL5+gemBR+Sl0HQ8Vk6QN/qdu93UhdD8WUU
 GD6zuCDuur9EJFyKF7B/1VFB6uglEOLLaLP9x3EPe6+ayBRkQiCp4vato/doCnEog0oN
 mRTxCeIAuCPLnBG4Me68R1kAKaP1AFw77UXV+Dxx11gCOLgwHB4deo8clukrh+XWZSQb
 i/o7CC4oKMlnHNqwqNyXve6un8snW3lgLaAqgEwhF9Dg0rnqGG2efBq2klYkQnrkhgFC
 AghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586446; x=1716191246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VF6uhgMTXvCNMpmE9TGG3M5Ce9XJhasOpTWLXUhXUs=;
 b=bECxkDoBeZHuMuqor7Rt0QnRoR7wjMizsm6uOcq4oyKoRgfjhfag8roP7lK/dst3iM
 MoF0Yh4H2JaTHKGF5e5atR02A7MS1wKxHrmcmoyUz5LfMFoYqoEG6Xlh54YVZgIrJCvM
 OevC3e/6kKGT7gKMQPokTLm5iyTNfN8tu0l14pBQ9K4u75M1Mwm0t/jy9PcMbnHhtYG6
 z8QIwGxnXdU8rUjA47GqrFh89HpckTJ/q46Ajxe5dS4s6hGSt37bzVrtvkgdd9rZXbnu
 0pj8p1sw0lkySyTVsPgc0FuQYzJdAYgctWcncsVDBDsQMrZ0OK3AFBLkmLLvCwWJcrEN
 IlWw==
X-Gm-Message-State: AOJu0Ywt1f145K7edK369TgeiBt3xwc3IyR/0t1DtnaJUdFBn98yehyB
 BhAFzqEnzJ2evZKGh5Yv2qfX/LS4fhUzSUnrOpTwL4Jxqxae6JGK94Vb8zCB/2ogy49DoskDN1o
 8xgY=
X-Google-Smtp-Source: AGHT+IE7OJEj23f1JpsbYCQLKloqFDRUyouRNsdIa8vd7zjTHaSfIjNBG9zb/9rG1En9Wc5KYp86Sg==
X-Received: by 2002:a2e:b04b:0:b0:2e3:cba4:234 with SMTP id
 38308e7fff4ca-2e51fd2dccbmr59550281fa.10.1715586446495; 
 Mon, 13 May 2024 00:47:26 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 10/45] target/hppa: Skip nullified insns in unconditional
 dbranch path
Date: Mon, 13 May 2024 09:46:42 +0200
Message-Id: <20240513074717.130949-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/hppa/translate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a9196050dc..ca979f4137 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1805,11 +1805,17 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
-        ctx->iaoq_n = dest;
-        ctx->iaoq_n_var = NULL;
         if (is_n) {
+            if (use_nullify_skip(ctx)) {
+                nullify_set(ctx, 0);
+                gen_goto_tb(ctx, 0, dest, dest + 4);
+                ctx->base.is_jmp = DISAS_NORETURN;
+                return true;
+            }
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
+        ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
     } else {
         nullify_over(ctx);
 
-- 
2.34.1


