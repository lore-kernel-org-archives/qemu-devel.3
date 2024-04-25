Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9691FC19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY4-0008Lp-2J; Wed, 24 Apr 2024 20:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXo-0008GB-7n
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXk-0006Ga-2E
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e65b29f703so3494945ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003249; x=1714608049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Kg1quTAZLERrFqYvUT2qOEYC/gEDF5UQhncM4bnEmk=;
 b=Mjew6F/jQleEEI9BhxpfOxABkg3bwpYazjKcHKHhlYLHlT/D7DNm+Piv7h5vNZgHGr
 C97B5I1UpUa293rF3yOAJKYcuGXNrAOubZq05klHlKzTF6rLfSZmuEfitSYEYFQx0P09
 Qn5bGg24gDIZWou0Aw2BiC12kNEr0aV4akhmrAtqDS2D9oYiitzs8V1KutAYECwyGCJ8
 8kAE/FXOQHe5y7+GONy55SYBxqszB+M89s2AljK8/e2rnxwOSjPgYOAK6WUju5PPIeKm
 iI3fiTydLK8jzzuzjAql04KOUySwOi5BqxhSMlCg4zWssyPJ1S/rDQ08ZY0YgIwGkQVY
 4spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003249; x=1714608049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Kg1quTAZLERrFqYvUT2qOEYC/gEDF5UQhncM4bnEmk=;
 b=aNnkjQbz+YVw8WDyWeUdEEuadYUQB37qknT60YJNwNaiLC95pE7TI1oQPVb0hAiCg7
 B4GG/wO5R4472thSH2kiRjkd7c5aq/uqjzkYEMZL0mnwvSo0ZFCEWoQ1TA1/s/ggfhLg
 rRSVEfGHryf2aIhNoIwph/4gH+tVDqREi4ccF4j94pzU8Oy/tD2FNAcFVA3pjq/PMO+g
 /s2gi9nw4U3dMNgUVniSuGFxCkOoGVbhqtE9SQoRoQfwlqEIKgC86narRPt9q/95ekd6
 gOVNlAEySvukvZitDQi0/78tO506vznvDfIASJ7xBpeoA4cvKhBtBq5LfKnMEcfouyo1
 5Qqg==
X-Gm-Message-State: AOJu0YwjyZxyAV5QW3+F18ChKan9OWDDrB15Ef/fqdlBF+iUaS4SC7Uo
 EmLttPMv84UrDfPEoNtQLHjiGOrvTgFNqz4C+oBtgC3WmhZhN0zAo0SHr2m70s3ZDtyxYHMX1k0
 u
X-Google-Smtp-Source: AGHT+IHV8N4sM5N+CdyLWT/KT/vp8pzMfD0oRUNcv6FHVdxa1tEJE+Mr8kq8tna2uo/bBQeaiwHCGg==
X-Received: by 2002:a17:902:da83:b0:1e8:2c8d:b74a with SMTP id
 j3-20020a170902da8300b001e82c8db74amr5184421plx.10.1714003249045; 
 Wed, 24 Apr 2024 17:00:49 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/45] target/hppa: Use TCG_COND_TST* in trans_bb_imm
Date: Wed, 24 Apr 2024 17:00:02 -0700
Message-Id: <20240425000023.1002026-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/hppa/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 38697ddfbd..c996eb9823 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3514,18 +3514,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 
 static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
-    TCGv_i64 tmp, tcg_r;
     DisasCond cond;
-    int p;
+    int p = a->p | (a->d ? 0 : 32);
 
     nullify_over(ctx);
-
-    tmp = tcg_temp_new_i64();
-    tcg_r = load_gpr(ctx, a->r);
-    p = a->p | (a->d ? 0 : 32);
-    tcg_gen_shli_i64(tmp, tcg_r, p);
-
-    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
+    cond = cond_make_vi(a->c ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                        load_gpr(ctx, a->r), 1ull << (63 - p));
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
-- 
2.34.1


