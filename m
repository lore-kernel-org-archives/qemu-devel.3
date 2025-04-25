Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA48C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBJ-0004kc-O2; Fri, 25 Apr 2025 18:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAq-0003ei-GC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAm-0001pp-D3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so2479586b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618727; x=1746223527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIZI0tzKdNyXGhR53Lj2hO6pQU5qRPpH+e5Nl3AJsgM=;
 b=WfEMAxtrzfjroG2LM8PyiWzsrA5v5rEd3R8lPaMNrphJ19nKSHdm0YhnKiQsxFQsA3
 TTupnY2AsGP0/a8X+uWIWHDX8nJSHVqvhj+jbeDV0FKcSj8QPmDVg8LiQKiwgECHSRJ2
 GN6inyeRZo4kvLqMNEaaezsRcvvEyVIhmlFmblyFwC6XEqTkYRR4yN79/G+GVt3an8AM
 wMjK9Mg0rPl8V9AONTu9+Q/z9XD9WkHGquIP4tuAkTdkNYrJn3fcyXpMBwjUDwvey1gF
 1rlVtRFj2khAFmMRgbxduGgRLQv5HHdnx+6M5gVPk9nfbMoWmwKM9u29/PysSXTl3r6A
 BwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618727; x=1746223527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIZI0tzKdNyXGhR53Lj2hO6pQU5qRPpH+e5Nl3AJsgM=;
 b=dzpf8G1ki/q7TTswz4r09Id1epwDCo4CLYMksOLYz4tZlyxvcMPnDEEUb65Tm9Y2XT
 2Yedio/GgvG7YrpxwCtV6E4JRmosv9u4z7nSVl15Vv0EDqEw7gCH+M4oyHCmqtiCkA66
 GJId+xuLPnSXujOjRmBp6EbngXhxnvK371Ss7/Xg2C7W5+Pr4TZdC4ERrKs5ovS5K4zl
 nuI8D+em8TNv0Agj8qZ/khOdHfmwB6PLvCvNonV3FIIjb7bvm/oZSkdb8XXBl2Hlgefc
 Gz1z7BZoZQMx1/wtdGn9MmAbfIaoY4Q6vmzZMjUpd/+0wLGCQ3W5BQOTEeYwE+Jbv/id
 beRA==
X-Gm-Message-State: AOJu0Yy1q7kEhOuh2nzOZcLIavUJsnoSVgUyuLsyCLvrKAsb7bW5OZ0G
 AHipVF9DFE/hhMrzIjeumRUFizeLH6U1qVyyOb8PyZjBD6NUesyIXyUopLwMZuoJq6ygOg4g+sF
 9
X-Gm-Gg: ASbGncsnJOYui0kndiCJDfXl9M/e4T6LikWcBXdu19VzscktJjJo+7NpnANACCskt4F
 ALshw4JOU4n/m/fxN+Qh6HYX4zmGiICfFrxdjyZbIG2QZ5hSWkvViTy6Z3COJBumLjj2CB2wOJu
 juESd0GVov59nwmaJaYemz3nfgUEFOgWCAkUkw4WAQnXLssC4YQX38ys32Au9RWDKPg6QzunilJ
 ewg8jaHqbIAZZmsSzrd7RSZn8zr8hIg9uH2Um+OWXFNEdGcwYt/FKZPRMsBXeLGWGQMRlv4wAse
 EyeV7TD3R4x/ksw+RC02sZZv84/S6LugvL5M/cS+07OlskD9TN8C5IK70YtUJmes6qyA2rC2yO8
 =
X-Google-Smtp-Source: AGHT+IFgRyTpttLZzP63P9J3gTV4cbOkPP7INf72EBLbb2XUQ6Sno6iBQT5+a0e2U7BFmVTKVSbl3A==
X-Received: by 2002:a05:6a00:4fcc:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-73fd71cfbc9mr6358942b3a.8.1745618726719; 
 Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 123/159] tcg/i386: Honor carry_live in tcg_out_movi
Date: Fri, 25 Apr 2025 14:54:17 -0700
Message-ID: <20250425215454.886111-124-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Do not clobber flags if they're live.  Required in order
to perform register allocation on add/sub carry opcodes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 04e31cae12..8e0ccbc722 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1092,7 +1092,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type,
 {
     tcg_target_long diff;
 
-    if (arg == 0) {
+    if (arg == 0 && !s->carry_live) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
     }
-- 
2.43.0


