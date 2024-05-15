Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB504C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8d-0008WQ-8h; Wed, 15 May 2024 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8P-000778-Sk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8B-0001g0-Qn
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34f52fc2191so3482775f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766062; x=1716370862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSrjBrTs7BiOjRfXoLuD7sENLd2Ur3ZnScDSTPyxo90=;
 b=Ryh3qnzHtjXlFBxVouFniTjaHjzrLTqbcID4kvjeiTW0ny3yyI0s5h7CabbfG7GJNv
 eFN2h4nseEWWg8iqKRazw7CcD21bORxEykIkn68LPvxt6T8BbT7wZXsMN+5+2oxw79gg
 aFeODFD7AAL5k1FWaYBttsPfxjmHParjjbV8uZKL99vGeDkmAs2BB58fqh0aF9uBo3dK
 2+10W60Q85T6rM4jYRNLf7PIQex0KUz4P9BTapgq0RaqFndYvvtawqR6OTSTUPzjgWTT
 t70JG+APy3EpXJSpKff3D6FOIQH1koRHUlwj66GEqonOWrcK038sPCztKpGGD16iWsGg
 ZRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766062; x=1716370862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSrjBrTs7BiOjRfXoLuD7sENLd2Ur3ZnScDSTPyxo90=;
 b=HtIu/jYmRE3wOvJSJgxDCNa/QOccW5+b0y8AdqZltFeT/G6a+eUSvmCr6pkJB/w3I7
 mDg/6Cb6zC2IBbhF8+FuY9STRFdXBRQrxNfpnTUswqck4ZqD01K4E0aJMAlvznrdMvcU
 KGaao7Rf28FRtF8R0ihIe2KqmzI6Y47/tQN4OU3qYyWnfQ+xsTInqfTPCaXWS6KiyECI
 K0B9YL9s23EYsJmP1RS5RRRlTh8ulJei4kJRdIQgaf5VIbbPouQCAKT8utO3ZA/i9qYZ
 IOSsiYICzmkP0uFZbL1ElSlPg4nGqMrlr3hrrajuDEZDpJyzvcH1w8hkJ7ltJoMS+kRP
 nRZA==
X-Gm-Message-State: AOJu0YyTITVMmtoldltvfaJG35R+H4f53Dv6venczXEsCKRhPJETqsuG
 f88IUIkYXcmBk741IDOleRoj9RxEZHxFbNwNB4l+mJMvcoNKx27XsbMsdU4ESlHpfOX4UZGV0rk
 G7mw=
X-Google-Smtp-Source: AGHT+IEbx4nyO4HTnawczvms7TjEN7kgsXI/1q2n9Jv6jpcRAEoCkKqcs4FonP/79Nn+Fy+5Nykc8A==
X-Received: by 2002:a5d:444b:0:b0:34e:4cc2:7015 with SMTP id
 ffacd0b85a97d-3504a73bc06mr9294620f8f.31.1715766062178; 
 Wed, 15 May 2024 02:41:02 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/43] target/hppa: Use TCG_COND_TST* in do_unit_addsub
Date: Wed, 15 May 2024 11:40:23 +0200
Message-Id: <20240515094043.82850-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b19d7c64fe..4e49bd2b67 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1420,8 +1420,8 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
             tcg_gen_shri_i64(cb, cb, 1);
         }
 
-        tcg_gen_andi_i64(cb, cb, test_cb);
-        cond = cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, cb, 0);
+        cond = cond_make_ti(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                            cb, test_cb);
     }
 
     if (is_tc) {
-- 
2.34.1


