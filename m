Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF3C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyg-0008Lu-VZ; Sun, 16 Feb 2025 18:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwV-00045b-Bw
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:58 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwT-0006Qk-C9
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:55 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc1f410186so4938408a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748050; x=1740352850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ch5FnbM66td79I8i1JJKCB4gGbWMUmbzkY/Fv1rZM20=;
 b=vsa+/Juwk1uj8hc5u8rS7eCSU4aBdlhsPmaWnpESM7sZx2mbWBqRYISK9WcgaazSO2
 p29cTPokQRMnE8a2Q3pXmtp48UORUjSPSVWBWoYFQNlSFJEkgC9bnyulDq/YOQPKtx6q
 WA6pA0ciU3bmuuUpdREaVYVXyMvSp6QTXdWIeNmeX9XSKQ1aPPq9sh3EZEP/gvudh+lr
 MnTNspKUhiZLdF/8N1t3AfWJ7cgaSMr8MeDwVtwfiknyil9bLPYAyz8C4ScwsYXS2J+j
 Sue30w+kHv8QK7dSkl44pchDZ9PbftX0qn0Hkt3nkEj0IVT//mVW5DjonANXEPJylbrW
 TbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748050; x=1740352850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ch5FnbM66td79I8i1JJKCB4gGbWMUmbzkY/Fv1rZM20=;
 b=JUzhXWTh4Dyjo2sQ6LLrW58GJpaDzA5v5HbF0YgSOunj1sVFwFaamEwuN5G1pqUs4H
 NHcQJcYvZmrURF5jxqTAmv5LbI4U83MUWbZyceCFe2V5UHkfIw9UUFOj+xNX/grCwbtf
 9+CwmvXnFAdWJzQLqWeajClyfDLP0yMaMgc7FIHgeCw2DEeCx+OzelEQVic6LannzfdX
 zd32vxfCPKx0kxIa4OikUjdzhwF/83C+Mz/YJqGBLqxz2lG9RSQWju7pErMs88eZsmAR
 gQhVVilem7kl8eJoEscQKLVEjljTrp67yZb8RUhCUR4hpfeVZJsdVKc6zDLcixBKA84l
 NzfQ==
X-Gm-Message-State: AOJu0YxkAWiSvw2cazUmTNRkIuWJg6phfIEHxIw/qwLgUOYz5kq+38Hs
 3YOhad2X3LLztS4PMt1n/8Y51FadkkJdUBi3gX+A57VUo2oFsPqxvPkH7Hzko+KbWmmdjC2aEGv
 Z
X-Gm-Gg: ASbGncsbZqxoWzirqml4gzniY98cDXPnHuAnuHyPFjYkLiq1ayGjvc36gnoLKmfiP3w
 xhUDreh1LQosARATK/u7Rwfh/FZoHmpIoBnIkLFxNofA3QkXy2W/wRmMO/S0iOAMIZvZZKcXnNC
 483X4n7nCUibRMGWU5CdELtwo1EyUyij/CupydYZ5hM+Ac6WKj/tuyHjYL3pIp41wKK7XFOyR1r
 kbrsQzGCq65qEQfVFts2lyZRKiX1fOObYuZDMfdOHsW+yqxrq1/qbmprzefAO+se085Tarux8LE
 DPNEUTb0gWOVv+qQ1FmvuFrqKowHsePab/jVC2iEnKUUZm0=
X-Google-Smtp-Source: AGHT+IGpAOnPOL60mKSljRiRpdaRyyK7th0AZNkuG4IcN9xVOCuFnLWKIWAHGZScmrZhd7k+JejE4g==
X-Received: by 2002:a17:90a:dfd0:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-2fc40785f14mr12006882a91.16.1739748050376; 
 Sun, 16 Feb 2025 15:20:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 127/162] target/ppc: Use tcg_gen_addcio_tl for ADD and SUBF
Date: Sun, 16 Feb 2025 15:09:36 -0800
Message-ID: <20250216231012.2808572-128-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80638ab535..a31ff0c5b7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1717,11 +1717,10 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(ca32, ca);
             }
         } else {
-            TCGv zero = tcg_constant_tl(0);
             if (add_ca) {
-                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
-                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
+                tcg_gen_addcio_tl(t0, ca, arg1, arg2, ca);
             } else {
+                TCGv zero = tcg_constant_tl(0);
                 tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
             gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
@@ -1920,11 +1919,9 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
                 tcg_gen_mov_tl(cpu_ca32, cpu_ca);
             }
         } else if (add_ca) {
-            TCGv zero, inv1 = tcg_temp_new();
+            TCGv inv1 = tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
-            zero = tcg_constant_tl(0);
-            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
-            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
+            tcg_gen_addcio_tl(t0, cpu_ca, arg2, inv1, cpu_ca);
             gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
-- 
2.43.0


