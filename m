Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4078C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtA-0003P7-1x; Tue, 07 May 2024 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsk-0003BS-0K
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsd-0001MV-MR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso16719745ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092396; x=1715697196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gCKDBZgmkxkw60aZ1JTPBVFXSTJpz/Y7AMgu8NmXySI=;
 b=rU21QaQqyzZDyWF+otofLRzwyXy8DlkglFIyd6LY/hux+bSBj5Kyseh7dbrxWwY79K
 Yq1Ctj+cBoCyq9V05WR6etxlH5QjeR60wX3AnUOSHxl7tyELUozlc/UcRAwuQBFS2Tam
 XqikWDOxQpB15s8+Byc84C6ttKOOOdXgb6dAO/OM2/uvw0o/vfaD5V2p2YfzhUSnv8OH
 tCyFuNylElULJ1Lpj+ZU75P1EjMeJF1MVht6TOTAt3wjFe2fIfcKlHztANpU48OjLJXV
 Zb1KudVmlSsEGSDL/+qN2a9Wu9tft0k81jb0BvoLHPBhNCpwangUb0g82FHgeF521Vle
 3aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092396; x=1715697196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCKDBZgmkxkw60aZ1JTPBVFXSTJpz/Y7AMgu8NmXySI=;
 b=bmvm2A5qR/rAfU6Uvb7bKI9cPdD/567utmYr07UbGTkGtkKsn5brR33U+grBBZ8GyV
 OvDVXjYHZjMPlga4EoSEnXxfvGT1RufDcE/gREm7/GjykYxzcFGBMvBKC8nsF+6QT+Rl
 olgMLkGQ70k3AKjqnjRRJmOVdcdHqW/ZY3jI5BOBJlB5QfDmOpL+VKpRclfMvOGPpOv6
 8TrDThgb/CzF9+/99TWeX9wXc90oJWIIVcvORrK7CO3WKoRhO8wgJFHoCDW6MUQBHP5+
 KxNh+e5dJDL4VilF19ig68xrMColLmoNaYXABr7Z4ZePJCHAfnEvGBv6xOlW1n9izP6r
 x5nA==
X-Gm-Message-State: AOJu0YwvbHp9rWKHGRqxjQRuSER3o+PVrstnwppLuVEyhzvSYkxFMwhz
 k84TrCZJlwUfuycJ0GW66FN7M+hzt5r/8tvuRhv+UVqGSB/OC57O0G8j6FCYNijfl2A1bwNeDp1
 s
X-Google-Smtp-Source: AGHT+IHWo/vw1iNCOfcDjUQe03i3bd2Av3k6ZYTsrZlgi045cAAmeQ6o+oZGM5MgZ6pzeezIyRS3OA==
X-Received: by 2002:a17:902:d50c:b0:1e5:d0e3:b960 with SMTP id
 b12-20020a170902d50c00b001e5d0e3b960mr16194495plg.11.1715092396486; 
 Tue, 07 May 2024 07:33:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] target/sh4: Update DisasContextBase.insn_start
Date: Tue,  7 May 2024 07:33:06 -0700
Message-Id: <20240507143309.5528-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Match the extra inserts of INDEX_op_insn_start, fixing
the db->num_insns != 1 assert in translator_loop.

Fixes: dcd092a0636 ("accel/tcg: Improve can_do_io management")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index e599ab9d1a..b3282f3ac7 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2189,6 +2189,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
      */
     for (i = 1; i < max_insns; ++i) {
         tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+        ctx->base.insn_start = tcg_last_op();
     }
 }
 #endif
-- 
2.34.1


