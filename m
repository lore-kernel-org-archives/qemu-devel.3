Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E70CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNsb-0004gW-0a; Sat, 30 Aug 2025 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRK-00053e-3K
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRI-00053I-KB
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:41 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4c9a6d3fc7so1229522a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525179; x=1757129979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3DXiy/ZudcrpQh5ssHAmre0hommvxs3Ew0pZrojp600=;
 b=CeS7UVc9rzGRgWT9mqUyFpyyW4d3OuSwVdgmrtB2eDGsXD2pCDsUPY3teAhEG0iWvc
 dSTLQihM+TVubfoRtPwt2zQcBCem+LMEZW7I/EOzp8TklbpU7iXGA1jMdLXgx2Glu6u6
 aoqddOO7ATJe5Y3Lp2YufvpoRTJjB7YCYRZ8kxNJhjz9OmZ/IhJARJe82gQ2J9JNHB4D
 30VHo+qIl4XebxHh1peCQVvCCUSvsoMo1tec7HA7/h+CIiqI7kpu+69Xc7O/3Vd3SLC5
 SapFmHEZBmBWc2xE8IycpM8OQliE6WiTiFZuFoI3Y8qboTl5+FJPbk8Vm1qV+jDKiPm2
 jWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525179; x=1757129979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DXiy/ZudcrpQh5ssHAmre0hommvxs3Ew0pZrojp600=;
 b=tLvhnj9Eo8rtJDPSddWTi6x5Ulsf1VH1r9PYv2Ofr5A58PwRrgjRsZ9Ws4vB9bX0H8
 xawudPYJiiwEUdSwbElwtsDnlDCPB0REV620dL2bbrGWq1RxCQRYZS2xAdXY9jUhQatM
 1xQzYB03q5hwV+7teY8OiyUHvN9yphdXom3U1nHcN+ErdetTH3WI1vyf39LC0VfrJKFh
 42p6nJEIg9qnXHUiUy4v6xKReIXoamDwqWhXlYYLbPRFPlW4QtbmG9aDxdmbp0FsZqYx
 49hf509uDymk7JEhCDeLPpileOIBKyCyrTDHfzHzhBTQSLZ/ok+1rE0yJlwUk6ugmKp7
 zuJg==
X-Gm-Message-State: AOJu0YzbhfDXApChpnvOtmOdyy1/ODSJBzTDiGaQRGsIVXOH88M2oJvt
 g3khd9AGuKoVeMMr55OwR+QDW/OpljuJcBYDWv57CdUMRzniuuHjtdnnG4K+UETCy9ivLTR6gPk
 5ephlznE=
X-Gm-Gg: ASbGncu3Ei7KvUJL0hBoLZ6KyAryym3/j9Rxu5ecK4cbAUVzeoXbRjrnxJENDhujREA
 SyRT/Dbfs3P0wV4ZcyLYG7yg72zl0O415pI7eNOAuKoX+Ty6LdudJVrH5Kk3ebR61gTY6A7s6ms
 bAmX9Ry+pS5m0y2nbUnK8/IB2xo/z2uOSBAdbfyin/81kzFd7S1oWmobKfnivHr71FNuou2Cxmy
 giEyyi7hxmLB4MLQWmtFpDC+OdbQ0ygKRyG+pjjIuaMTJldzIDddQE7vKoClMOZX4BGjRyPuHhx
 ijTyxaDhD0A0BVNsKcHWibDMo8ChvFThgyqLpY/dNIB+qPsaunarZqGbXfcQitbILZKU49mBX9f
 Z6HIbfycGH3qBai+GQeJWKuzAS1NEStm0zQogS1GK8SQ8dMW+NECFYwd3mebPr1LOYbDGFhajcQ
 ==
X-Google-Smtp-Source: AGHT+IE9DwG3+7AyIh3/PPBM91hPP9Y1SX+5DhQyi2NP7MMSJh1izl/JFi3gs6jRFcMoil9z5Wqy3g==
X-Received: by 2002:a17:902:e94c:b0:235:f143:9b16 with SMTP id
 d9443c01a7336-24944b3d668mr10553825ad.41.1756525178885; 
 Fri, 29 Aug 2025 20:39:38 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] tcg/i386: Use canonical operand ordering in
 expand_vec_sari
Date: Sat, 30 Aug 2025 13:39:24 +1000
Message-ID: <20250830033926.372955-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830033926.372955-1-richard.henderson@linaro.org>
References: <20250830033926.372955-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

The optimizer prefers to have constants as the second operand,
so expand LT x,0 instead of GT 0,x.  This will not affect the
generated code at all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4cd5d4276c..8260c35edd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4399,8 +4399,8 @@ static void expand_vec_sari(TCGType type, unsigned vece,
             /* Otherwise we will need to use a compare vs 0 to produce
              * the sign-extend, shift and merge.
              */
-            tcg_gen_cmp_vec(TCG_COND_GT, MO_64, t1,
-                            tcg_constant_vec(type, MO_64, 0), v1);
+            tcg_gen_cmp_vec(TCG_COND_LT, MO_64, t1, v1,
+                            tcg_constant_vec(type, MO_64, 0));
             tcg_gen_shri_vec(MO_64, v0, v1, imm);
             tcg_gen_shli_vec(MO_64, t1, t1, 64 - imm);
             tcg_gen_or_vec(MO_64, v0, v0, t1);
-- 
2.43.0


