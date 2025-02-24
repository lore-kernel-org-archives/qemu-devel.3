Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625AC021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2p-0006w4-Mw; Mon, 24 Feb 2025 12:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2n-0006vJ-7l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:01 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2l-0005ZE-MH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:00 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221206dbd7eso96051515ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417298; x=1741022098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQhk0Fpp4PMz94k2EY0GWDV4XbAExFWlF5T1OtyqxVg=;
 b=nm77BKpHdk42AbHOq4I5ak46IretxuO1gk2wLhSDXEOtOiSSLG7o3kFCrds9t9baSl
 L0CZKYdw6z3e3B1ubxl5i7SyX5taS1BOzFBT/jXkFQVvibycUF8WZKcMV2ujlQdCMh2y
 uwIBq5VIdRd2MrB3u01A6+Tew4x5fPNq7uO9DQ1J2W8uyIjVGPnbn/pKf4RrEnQitRn5
 973CtNcHhUV1dga1D8mbbdnPVLpotnZdnnDehNbu+69s5pR7WkHNckfNGu4O2kXePUgS
 vDJgi/gn1nNvQa2JM2SqBD6B0xV2cnfPZTSmkKTdU7/vmYZglsI/AQl66AY6iLksrj/I
 sJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417298; x=1741022098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQhk0Fpp4PMz94k2EY0GWDV4XbAExFWlF5T1OtyqxVg=;
 b=mrHD9K46K83oOLCpH1vjIiV0XBnaZPHu+27MDnAihrOVzG2ioG+IPtVl3X4+U9e47f
 qcfAeqtdxgIU54WAKkJH0SUucMHyJXCDO05/gdlY4WkzYJMr4kZj55oRkJfjRAxu6Ni7
 oUMX15PPYrl8/9+mi8H8pv7lemCH9kctM90KsBvf/8m+2JtKnMVhNgoA+ssRw2Jdf6fy
 KFeMdQMe/KMXHBiilNsBIMCYvfAoZXeJKyc1izy4+T6yweV4ra1O3yqFBV0V3B+axwHq
 rWQ0GKH9RPWj0YGHBX9+Glt5peE5Ty+KJ5u6DTYzsoFAbqMdtRqmXtgRIGjP7px1UNQ3
 xpDg==
X-Gm-Message-State: AOJu0Yx+snRiYUAn8lw/nIbeirUcp7eKIe0er14vfA+D1DAD77TginCI
 z107/lNBamc2qoEYMFMm3ZmXzdt3Q2Q2Bdlupg6aZlJFZtdmCk5zy/CAqBTCpXve2L5kL5eAzSP
 A
X-Gm-Gg: ASbGnctouuvHUw+05D+Yrqhh0IKg2U1c6qnTvqhCGHJw3w98shTZyJ0wigNA53xWoz1
 sARB+Rxj9JNGdKlDVQ3jSqIoWBsgu8Rqq1Mosj7r1BIHP+Uae3jNQgHh6Njtv+FCXdp3S7XxY2s
 U10S0Cv+YwdiEA620fyavugG8IGOzRcS0ZaQM/0AlWWMFri0d8R39eek4XD4zY9bUHVJ8irJydh
 K0TcwXLpZFsBeHTXNjs12BcAOjDELE4vaYZX5F211pJl1ypvilp6p/zO8eoV8D/mdHLsVK6jS4D
 nhkTP3LMkrkgb/w9cN4dh/K9E4qTJnH8rYE=
X-Google-Smtp-Source: AGHT+IGwKrSm3dhXzJ636EdXzu2gdhaP90dlHH8Z7x1JnrLlzh4U7I+IMNmHP5/32kWgRwzGbf6wow==
X-Received: by 2002:aa7:888b:0:b0:730:979d:e80e with SMTP id
 d2e1a72fcca58-73426caaec7mr23437514b3a.7.1740417298076; 
 Mon, 24 Feb 2025 09:14:58 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 08/24] target/m68k: Use g_assert_not_reached in
 gen_lea_mode and gen_ea_mode
Date: Mon, 24 Feb 2025 09:14:28 -0800
Message-ID: <20250224171444.440135-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f093088d66..4f70b77621 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -768,8 +768,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         tcg_gen_movi_i32(tmp, offset);
         return tmp;
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
@@ -893,8 +892,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
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


