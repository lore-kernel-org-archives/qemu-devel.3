Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA58C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxru-0008L5-Q7; Wed, 17 Jul 2024 02:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrN-0005bu-Jr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:53 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrJ-00035z-J2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:52 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ce74defe42so352255eaf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196586; x=1721801386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57DdanWVRLYnAUN5YF1Z/JUbHmS65EczfEpSlC06YmA=;
 b=wePVVf0ygEbl+zb75+wpb/7Mu5abD1ywmETe5t9ODIr4VkOu6FTDHluTQyE1bFDhqa
 cbPPrG8iGTGPEv1qP/q/eqOjrlktHsCAQIgH+WQfB4lzLEIrNrbHmBZfjpru1Anq3tVl
 llN4ccI9Ei5hJyTWU5On6W/LA4nFgYwRbDp/iX4ts5L0jDMnsxACiMTRIq7uV+aMoSuR
 UbsTufu56BO6/S6eNIrAUZc0LQE11EYfa1BiUTA32hEaHKPTSBUIa0ZTh4/sPl2sEHrq
 MRAmYOlME1izLMANpAYBDzOh5BSdDK2MdI+6NWGvA0RuvhknXXk4viNcZP0mlryA0xLw
 FMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196586; x=1721801386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57DdanWVRLYnAUN5YF1Z/JUbHmS65EczfEpSlC06YmA=;
 b=ZRYGfXk4raiIr+FDnE2bJ8JhaPipD6iUVdESBgnKffEZUqJtoQJd6j94DIyh2WpHyA
 G+ZbmMLkWxMwL4jbopt9PT9s0EWr9UMJz+lAT3rjPwln6tKabyYq4TpyHsQ9z3yb6jr/
 9pMr7ICuaMF5CG1cxbxEDSAMtuJHcbcIRQGN/iPJiIW4+H8fXNaJKM3cdNr3ZpR52Csa
 ZZGNaZjEqoncSewTBarTbKYsRWGxrcNVEaVOXycuj9VydGZQEMQZIBXCaLhYDP97pXgP
 9/cwJXcLbvtkOJBGneWyok6kFHidgmEXPF7gtjTkEmL3ChrW6D/ifQiidODRpK+eSh6V
 AQkQ==
X-Gm-Message-State: AOJu0Yx7A4oqYQGeOHUqVte/gEgYcUxR6A0BPEkEzvoLGQBc5InbHA49
 31499Ppfi/ovZcTU4Nci67ocBpZUbrQsq6ucKRleNfOE1eD/YbvuMyMcQP4IPemkw2lBFbK8d3n
 VtiE=
X-Google-Smtp-Source: AGHT+IHGO1Pf2nQiQ2rZdrnL2yJ5uvyVx/nwpxmtfjRkvheiJea/oI8PrztwSpvhg6JrF1aYstaucQ==
X-Received: by 2002:a05:6871:79a:b0:24f:d873:9f32 with SMTP id
 586e51a60fabf-260d9222ad5mr578504fac.26.1721196585830; 
 Tue, 16 Jul 2024 23:09:45 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 14/17] target/arm: Clear high SVE elements in
 handle_vec_simd_wshli
Date: Wed, 17 Jul 2024 16:09:00 +1000
Message-ID: <20240717060903.205098-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

AdvSIMD instructions are supposed to zero bits beyond 128.
Affects SSHLL, USHLL, SSHLL2, USHLL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fd90752dee..d0ad6c90bc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10471,6 +10471,7 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
+    clear_vec_high(s, true, rd);
 }
 
 /* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-- 
2.43.0


