Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2DCC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mJu-0008PH-6V; Tue, 15 Apr 2025 15:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAS-0006Jy-Ky
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:19 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8h-0006XS-Ct
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:11 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso5586397a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746009; x=1745350809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/icXR9rPS4TkXbbgbXcXZQMlEO+JipjRgWA+vktz47I=;
 b=wlJcd6oJDJsvH3Wb6OI+EidxJuU64EEWh2eRMSG1KVHuChi0JxMGAFb4x3Fg7P9xIU
 kTpZdNWxI3XG/q+ixYkb1f58YhFYcSvkFQ16lhO0Y9VyxurWJlbQk+llaM/dvLwEOJHT
 cON8SevNvP3tLWxacn9fzaZQT0CtdE5+SBLc+7jnFNjk2mHJP1M1edBdT36H5ShNlqpS
 oTGEhFEfkonEtrIFAgt+Y0Gho784iYms/eAvopV94g1Q3xHA+5ouMtoLGWUCldAsqIfS
 wOrDx4zSoctD2/jj8IrTDKYrUwcQMkWP419WQ+TQnr0yOrNeoZS3P08Nw8vkrpx+ZeuG
 bbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746009; x=1745350809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/icXR9rPS4TkXbbgbXcXZQMlEO+JipjRgWA+vktz47I=;
 b=siwtD2OwPou2iJNc4aOL4FV+Es2rfHY5gAZjFBna+T860VsdidAU+8k55sQtZeq6+P
 0CAJXNwNMcJTCG2LB8iIgKPulumwACDYpfu3at4wb+VbUCAGpZT5Ve1DnTqtcuVxG45N
 z4drai5qOpHnSyGcvmE8ykTaUKsZ0ru+4Rh9f2C0+B4VzIAtGEOXMhastDxIVuGA6gAf
 TaNIqCMAgzVHsvrXQ6xGO6nJjLsLx8IbBKtmIM+utghfnkCtDXww+KGoThbAZh+d72Mu
 kHNsKiUh2JGErl3ZHGAxZy9OUOqEPijbp3TiSGjg64cT23d3lrkmULsnpCuKPmzc1SnJ
 YZwQ==
X-Gm-Message-State: AOJu0YyCNxMs1tSYEp7U1AhqiB1T1OfYVOUf0TKMQc9gDBpRJ/nX5RRE
 baG++/gqdJ/wVcP1xM21XU/gyijBpKINeep4cpP7cYIW6aGKRfu3BeoNTm2yQJYk0QPE8fnPFwR
 J
X-Gm-Gg: ASbGnctV4y0R61/A7sqrUVjMuSWxqTkNm3XBqIopCc3ibo5WBoExQu6G9a522NMYQxu
 nOaJxw7wYgIb39YUEGaeEGuDt7boK2S/dqLrcFq87CQvit08SK2/HYfB1ivihVRTxEHYc9bovL5
 p2kaCZIwL8K4iWSxfnjS+eO6e4o1ghPYByZDGLcFr0kxF4PxA+jcw7bsg3Stl4bMrnPPINcu4Yp
 GQnmddBEu2l2PyBkcoCrSSwIUJ0GEq0ahtDxZF9rJIfCEVRGYYA82TGdwNPrz9ZNt+mc3Y8sU7W
 aPzG1kfQgVCRn9yppAXy+zuYA2vKvlewMswHCZMP8IM5Qk4MjfX9IbFr+UWfsh+Dv+JPO+RJHRY
 =
X-Google-Smtp-Source: AGHT+IFf2Nc2j0KIbLtdz5sTVWBIrHmSHrtcjB8SL+IW9cMq/TrNCubFgBYHSX+8h0rI+NihZZsarw==
X-Received: by 2002:a17:902:d48b:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-22c318a901bmr5367015ad.5.1744745547271; 
 Tue, 15 Apr 2025 12:32:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 083/163] tcg/arm: Expand arguments to tcg_out_cmp2
Date: Tue, 15 Apr 2025 12:23:54 -0700
Message-ID: <20250415192515.232910-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Pass explicit arguments instead of arrays.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3d864c1c1e..cebd783285 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1254,17 +1254,9 @@ static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
     }
 }
 
-static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
-                            const int *const_args)
+static TCGCond tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                            TCGArg bl, bool const_bl, TCGArg bh, bool const_bh)
 {
-    TCGReg al = args[0];
-    TCGReg ah = args[1];
-    TCGArg bl = args[2];
-    TCGArg bh = args[3];
-    TCGCond cond = args[4];
-    int const_bl = const_args[2];
-    int const_bh = const_args[3];
-
     switch (cond) {
     case TCG_COND_EQ:
     case TCG_COND_NE:
@@ -2344,11 +2336,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_brcond2_i32:
-        c = tcg_out_cmp2(s, args, const_args);
+        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
+                         args[3], const_args[3]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
         break;
     case INDEX_op_setcond2_i32:
-        c = tcg_out_cmp2(s, args + 1, const_args + 1);
+        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
+                         args[4], const_args[4]);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
-- 
2.43.0


