Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BDEC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2R-0004Ym-0C; Fri, 17 Jan 2025 13:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2D-0004B6-53
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2B-0007vy-HI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165cb60719so46223415ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138330; x=1737743130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP0y8NpW/X+aOIiXkj/XmIYJ8qwvnfqBp4uvWUSussY=;
 b=kakt6d6GTdBxbVn6pw/B8pJKlL52PH7wC31G2gD2uixlo+J2mOtfowD7CLXyVrFd9i
 UuEbaeQjdIVbW+g3gavvIn8RkfTT855QWY66KMxUX/2HvIBhd3cGILYqOot83qUraXEn
 nTl4OyxDy9P1q9kUtNMIyptTmdKzcOAcqzfwfKst+5aPYGtgbhvtyyyt2dOpa+WMiNQr
 tDCNCUM6X9fzeFDuj0n2GOu7D09qCh8oP/McLOsQBEc+hrUR2SLz4fRBCggT7XkYh9Bm
 iZ+yv54v5YcJJvfqglR9rF84+Nx/mKAlG4JH6FMs7zN6WE8AaiaQFIzGML0PHt2KdJYl
 /geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138330; x=1737743130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VP0y8NpW/X+aOIiXkj/XmIYJ8qwvnfqBp4uvWUSussY=;
 b=Y1gMyxGbD9LrjCpZgrFs7Pcn2UWiVqt1zC96DCN9wqppBPi/PA/3bFmqZdUet8aBqU
 ihgrWLVVc2yGV+N2Qa5bTM3UdumJlqxko49v5yQKUaJ6HHj3nvUReOvgddBFXshqOwJK
 uFFgIobFbRfXCZ9DH3xjU+Hq6dppQm6ocbA32gb888ZaWnj0YI6fwfoWCSGjgnmFrHwA
 Qm1siobBaKPZyVqvG8sU1viyGcKKjiNcI3uRaDkk7NbQ7tEQWuls7qaxRGSHuVu3lsys
 MtAZDrBGI6RxbiM1OiHsnBQQz5gmJpM1up0EZnKspq60uAlAg2C77DVyPG8n4VHWhb8v
 oOEQ==
X-Gm-Message-State: AOJu0YzUyffIuKENXRoHbEMorlZfjDq7D3Gl9TP/F0XcmxiuN9N2ueLR
 3+HQTA3TjyI5/v/TbNWa7hCKcZeWmGFMEyYWr50k8d0QxeLIW2oef7AEz+6+aTeYzD2eIrEWM/u
 S
X-Gm-Gg: ASbGncvqUskYrfInqe8VDYJmJujNjLmKHhSyju7am8z+nnAx1g6JJdveriKAeQeDySc
 76mOu/dqPN79D0Hl5E+F2rhvVKDUnwACIgEheuhm8PYPuAjbkTWHiMfOWGpIHt/MnNE/C1UpkrG
 Pd81+JrGsGs25db44Jt2pGqlbPs86PjcNPosAEEm3Zqlzxtae+YFARDzvwzNz7pfxyCf6v1mb6q
 EdHS8cKJf3qvANMUfR/EofMWPAnTLL/N92t4oCIZt/OhSXtWBRd0pI+9hk6t/jJgOIY/vkDgZr1
 swtmCHdOdCBVIEE=
X-Google-Smtp-Source: AGHT+IG0nft5Rk1AV79KilqcqkPA9Csasr530o42nlM2bNYacfTZZsrixV6XA/LqSh6Rul9UJcDoaA==
X-Received: by 2002:a17:903:2447:b0:215:8ca3:3bac with SMTP id
 d9443c01a7336-21c3540278dmr54210745ad.16.1737138329848; 
 Fri, 17 Jan 2025 10:25:29 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/68] tcg: Constify tcg_op_defs
Date: Fri, 17 Jan 2025 10:24:26 -0800
Message-ID: <20250117182456.2077110-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Now that we're no longer assigning to TCGOpDef.args_ct,
we can make the array constant.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg-common.c  | 2 +-
 tcg/tcg.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e28894c57b..a4630e44bc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -716,7 +716,7 @@ typedef struct TCGOpDef {
     uint8_t flags;
 } TCGOpDef;
 
-extern TCGOpDef tcg_op_defs[];
+extern const TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
 /*
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 0f30e5b3ec..e98b3e5fdd 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -26,7 +26,7 @@
 #include "tcg/tcg.h"
 #include "tcg-has.h"
 
-TCGOpDef tcg_op_defs[] = {
+const TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
          { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg/tcg-opc.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index df7c4dab88..32975fe298 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3364,7 +3364,7 @@ static void process_constraint_sets(void)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    TCGOpDef *def = &tcg_op_defs[op->opc];
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGConstraintSetIndex con_set;
 
     if (def->nb_iargs + def->nb_oargs == 0) {
-- 
2.43.0


