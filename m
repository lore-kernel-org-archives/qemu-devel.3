Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9649DC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFr-0004kf-5i; Sun, 04 Feb 2024 16:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFo-0004YK-99
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:20 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFm-0003dU-MJ
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so30524755ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082937; x=1707687737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTBa5jnTmGPw5Fiyw2n1vRD4BYHoTuI+qXkHnySYH1Q=;
 b=B1lPYf4nLcp48lDb7pCulObNTwUm7Kq00BW2XFzRB8aM93q99gp1CPvK9IId9Yv3UM
 ePTxo4x6WJSY3B47T46q/htumRlsZkT7jemXYXD/6QuD7jMhwTpeQc7a4PBddJEyx60e
 cnVrv6VQjY42rIcxvs/Duql35tcWSfOT0oWIYLOL2l/p10j+3zCOle/YPzgNZ309H0kT
 jFfF2vMf0d3riQ7O8BffXMvIvgMnN8m8F8PwLq6C9urHfAYig21RM+uTcHU1vLl4UHR2
 Mb/PkOIrsxrO9rDiOf+hxGZq8OjzpAMp7h5u82Nh/rzdQ7MZIluibqkLtKcu2ieLWF46
 Nm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082937; x=1707687737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTBa5jnTmGPw5Fiyw2n1vRD4BYHoTuI+qXkHnySYH1Q=;
 b=GrGU1Pd4NgCfBD/xurfr5dF2VhnDRhZA8DpfmAHYiEBmkn/Wjsv7JdeFTJMyyljle4
 gNGn2iSwpeAAZjO9iHXSNHfRFrujjjUJLkgogJzdWsiK1SMMMi9b3Vsc/hbiGJ5ciFNr
 w7jGXVi24Ug9WgX64aQXVbkPeYH8prwN/6ut2juVMyqETlITE99C4bNPq+jHIC80sYsM
 QGiIC8nRwgs8izVGLRPbJ8TyAxLdB+Ng/um8l2hTbDlrzOgqB/4MUrkPa7zOCyPH3SPo
 AyemWWsg8RjOjrqcEdrOMWWhkxZj+DXuu+i/ZelhNhdZSgcZYhqzWFuW7pl+U/d313Kz
 rfJw==
X-Gm-Message-State: AOJu0YyjmUBYtKmBB/ux7+BRT87RjUR8ekgxQulqmWMY0XS4gkD1hk7S
 kWq9/jNUok3zaiq5UJbU87igAdM9VLUyRmLiFDi3Qaz+f/Rjm7bFj3R/ZD/f0TcJQCjuAQpgnvj
 jSTs=
X-Google-Smtp-Source: AGHT+IESmmkBFm+M8f3aSkDkhTBlFaT13euJXEWnNYvI4FEzuq1Wn0lap6usPc9yxNWn2d17mceAuA==
X-Received: by 2002:a17:903:2d1:b0:1d9:6895:81c3 with SMTP id
 s17-20020a17090302d100b001d9689581c3mr12848060plk.22.1707082937445; 
 Sun, 04 Feb 2024 13:42:17 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/39] tcg/tci: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:52 +1000
Message-Id: <20240204214052.5639-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.h |  2 +-
 tcg/tci.c            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 609b2f4e4a..a076f401d2 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -117,7 +117,7 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
diff --git a/tcg/tci.c b/tcg/tci.c
index 3cc851b7bd..39adcb7d82 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -228,6 +228,12 @@ static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -270,6 +276,12 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1041,6 +1053,8 @@ static const char *str_c(TCGCond c)
         [TCG_COND_GEU] = "geu",
         [TCG_COND_LEU] = "leu",
         [TCG_COND_GTU] = "gtu",
+        [TCG_COND_TSTEQ] = "tsteq",
+        [TCG_COND_TSTNE] = "tstne",
     };
 
     assert((unsigned)c < ARRAY_SIZE(cond));
-- 
2.34.1


