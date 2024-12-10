Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E1EE77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2vv-0002Pi-P7; Tue, 10 Dec 2024 11:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vl-0002Nl-MM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:17:49 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vj-0006FO-N0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:17:49 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffd6af012eso61404831fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847466; x=1734452266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQWBBpBVBB2pYpCBMt9NLIFTJDB68D9O686ayP1ZAos=;
 b=YWnXYVc0tmd1bzs1oOkY34Rh6wvbWSkNERxRKVK6YGFH3VxG7BGASPbyqrThoyaaEk
 L4dcKaTcF5849CXBd8ZJAIlDiL+mm+AF6XtcNCem6tzZ5qKcsanIo/pYhsRR8+mbRLCl
 V3s/ar5DHNwfdYv9j+dFwpp24n9LkaWuCMN/t2GcuBojhdYBll33uAyfIXZpbb1pGKeN
 R8DmEnG5il4/dx5Vg21nYdy49xG9Eept02aYAxfQsucPNuZwCakc7AN8h8OaaL/iC3w1
 HYYQOZ1737y72mEjfncdApbmIAxBdfY6nPUKjkvkP1LR53rjQlW/f+tqVWWE5BaHdakK
 L2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847466; x=1734452266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQWBBpBVBB2pYpCBMt9NLIFTJDB68D9O686ayP1ZAos=;
 b=PEc+ugNiZKj5psRiqBNzgkQPKIBXCmhppJL8faVd1q6iW/mcPeAk8y+uuWI+kacXp8
 9ljXMqvxvJ63NzCR0C3NbqiZm1vhBLk8XyySYmHA61HoDqS29FnL7uc4lmT2oRCSkW7i
 Q3h9wC7y0gA/seyBwVvMlZc+zRV/lnTulcSAbmJlejlbv7HIm8kbRHImQVWTt8y4gnpq
 rb3ztB9thVCNG8nWmbm0LWe0m9mdHKMXv7dwX5Lve5MnIa9TIYwe4coFZPJjbeP0DKcm
 gNynPoBsNs9MUnuseFYVAyxn02DsPjW/0R7KVGkbELudpZdk5Y0d3Qijl2coru+fGkMy
 BrKA==
X-Gm-Message-State: AOJu0YwYnObDrKghGtBnSmC0O5TUv/k6NxGVTbahfhRvpoE+CAw+Zz9X
 GeYWNUpZ7sNZIYEVMxJPMpwKjQSrHY2U1WN0FNqbXj9LGOBZzxso4uJ6G1/JFaNyIjqkUdoZlXv
 atGFkZPam
X-Gm-Gg: ASbGnctg5opS78cUg/aCrGkYabgb2QnRnY5uP8zXkLMLyyjCFcWy1TKX8mn5DyMhH7F
 92NAtAY8HSFswtsF/c+Vfz4WFKPTbi6NN5DP+fVCewe+2ADDpEK8TfdLlpFnvDt0XB38hRxvaIT
 qYvOs/tvPnr59NWQ549ipUQmMF5fUQ0sipcGvqS6PLqKyihmLavz6WFAyEt1PJ5vLVrAb4lFFl9
 HLhCoee3iHIA8EsEffubkIeyi//04dXlITOyKDppXq6GCBTa39qxSKx28Q=
X-Google-Smtp-Source: AGHT+IEj+kFGLfHpaBjf3mqeX/ndPZwb6QkY+ibDiYsfHILmhwDB3OeYkzZM+z2SQPkbKkPZKaBByQ==
X-Received: by 2002:a05:6512:230b:b0:540:2022:e3c8 with SMTP id
 2adb3069b0e04-5402410762dmr1996437e87.41.1733847465740; 
 Tue, 10 Dec 2024 08:17:45 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:17:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/69] target/arm: Add section labels for "Data Processing
 (register)"
Date: Tue, 10 Dec 2024 10:16:25 -0600
Message-ID: <20241210161733.1830573-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

At the same time, use ### to separate 3rd-level sections.
We already use ### for 4.1.92 Data Processing (immediate),
but not the two following two third-level sections:
4.1.93 Branches, and 4.1.94 Loads and stores.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 331a8e180c..d28efb884d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -161,7 +161,7 @@ UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_32
 EXTR            1 00 100111 1 0 rm:5 imm:6 rn:5 rd:5     &extract sf=1
 EXTR            0 00 100111 0 0 rm:5 0 imm:5 rn:5 rd:5   &extract sf=0
 
-# Branches
+### Branches
 
 %imm26   0:s26 !function=times_4
 @branch         . ..... .......................... &i imm=%imm26
@@ -291,7 +291,7 @@ HLT             1101 0100 010 ................ 000 00 @i16
 # DCPS2         1101 0100 101 ................ 000 10 @i16
 # DCPS3         1101 0100 101 ................ 000 11 @i16
 
-# Loads and stores
+### Loads and stores
 
 &stxr           rn rt rt2 rs sz lasr
 &stlr           rn rt sz lasr
@@ -649,6 +649,21 @@ CPYP            00 011 1 01000 ..... .... 01 ..... ..... @cpy
 CPYM            00 011 1 01010 ..... .... 01 ..... ..... @cpy
 CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
+### Data Processing (register)
+
+# Data Processing (2-source)
+# Data Processing (1-source)
+# Logical (shifted reg)
+# Add/subtract (shifted reg)
+# Add/subtract (extended reg)
+# Add/subtract (carry)
+# Rotate right into flags
+# Evaluate into flags
+# Conditional compare (regster)
+# Conditional compare (immediate)
+# Conditional select
+# Data Processing (3-source)
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
-- 
2.43.0


