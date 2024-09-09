Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBu-0004bK-3x; Mon, 09 Sep 2024 13:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBq-0004KU-0H
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBo-00061d-I2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2054feabfc3so40721075ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902914; x=1726507714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMzYtP5qPR90CaUOV42z01PghnM+kK6Tb+IUF2wbyXM=;
 b=esy2v8V5svuvQzcIuIPCHSE3NxxeoHmlVq18Hab/3avNUUzr20n4edghvUDChEMKpO
 M9y8CjdN9jxDZTyHf7yqzfYZcPWdpVlifU+2XtKU4jqwsO1did4iettZuGiI/12yEHgR
 DMwbubYZaha2dSZOL2cAuqT2Hwg6X1WpigSnqpjROFK81RQQ1jUfyiaoE0l6Da12nDWv
 br14O9dqosCI1ED1aBZdijtOS1UJY+nesbVGa+4oEhgvFjD0RUFOnyOgoe93eEdKicCL
 X6H2hmI+HCEnqHQaKOrNmTmhB5H+CW1KZriQHfXN6/TS0p2HgJTODavzQ4IpXmvf8kfa
 x9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902914; x=1726507714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMzYtP5qPR90CaUOV42z01PghnM+kK6Tb+IUF2wbyXM=;
 b=m3IJbkbcorQyWh7kkwm5U/Wpvoc7L9rTnF7h5NqKeF564lNqw8yYjN9TYUYdndWc/z
 KnW9OfjVCSe0taUUmNJ4boWfucW2nm9MG37ATMjIUQINwd4U2bLSRPIgcbFRQTdvCrBd
 lBQ86VykhwkFoXErW8wiDE35X7kYT2ynEEGzADmJgUVQadZsprw0kLRF7aWIYXzVy016
 VdVSDhkzuugKVqjvhbFYwhs2FMjeK/Aah6M3kgrAW0ihTlVx7SGcKOuZFzkM36sqgUvJ
 21ALim12T9toHVFbuUWm3cnjNnjivfzAJCLsyjEWFv5OBPuqRanlrWPCqlyVcNvf/ips
 59Cw==
X-Gm-Message-State: AOJu0YwnFW/PPbSa1/wO1QeJptZ8SWMnVdjlubSHYgq96GmLxDQYkE6/
 twt0Pbzlbw9V100tWUNImwwpwXxroDuifcBg9Xz1pqcgQEMOVXb0q9uy3ZzqoYF00DLe3WvlZaj
 7
X-Google-Smtp-Source: AGHT+IHkQWSNjDG76X+iNhNTeq3VIgw7vwCklQJK53In0ek7LJfiEk2XGiRa6r/n6KVTaDQuAJJ+kA==
X-Received: by 2002:a17:902:d551:b0:1fd:9c2d:2f27 with SMTP id
 d9443c01a7336-206f05428e1mr162715015ad.24.1725902914299; 
 Mon, 09 Sep 2024 10:28:34 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 10/26] target/m68k: Use g_assert_not_reached in
 gen_lea_mode and gen_ea_mode
Date: Mon,  9 Sep 2024 10:28:07 -0700
Message-ID: <20240909172823.649837-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The mode argument is extracted from 3 bits, and all cases are covered.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1ba1220b21..71dfa6d9a2 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -767,8 +767,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         tcg_gen_movi_i32(tmp, offset);
         return tmp;
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
@@ -892,8 +891,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             return NULL_QREG;
         }
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv_ptr gen_fp_ptr(int freg)
-- 
2.43.0


