Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66209C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57C-0006RD-7O; Mon, 05 May 2025 19:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC575-0006Ki-Cs
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC571-0003aY-4O
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2279915e06eso54807725ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487237; x=1747092037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=RfHmEvJhhIcmLOcIf6z2Xg/H8PKQDwe0wv1NXAHJIUmyhY/0vrZ9LqUKHE+yEo9kBn
 MHREADKO+XnuAvmTYMgIywu7/ajlX2ZeksqibcB6VnVIbDb55GGS4F6xB7B4HGTHoH4t
 RMsnWb2a5LmMaRkySq7LGR3+Gpy2M5ZJy8BqDekynIpZVjqUiLkwJr98t80S7l1Q4+/6
 39yV3VZdfGZojtqj00/lAFl26ooYqy3jQkyakdETflFqPK/xG/+4Ag6qdpZlf9IFJAvC
 ZtiZ3QPHnqbXxYF8ipFnEOcU7eTiGM78QEbN2a0CqDhPkUy9etLYM2b8xFmnkhLB0K90
 CmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487237; x=1747092037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=d8e7n2vONcC6k5suTCi3HG2Izx6tdty7lWRMjWjPk+4T10jB05gAN1T2yuac3sDkPd
 QUi6mWBLKoWxsy4g9bMd49JlINZuQ7MCBwTEm5ntVqzlrk9xPl585dcFCLL5pw0WPO6/
 FjOJOUJVfzH3LXp0vqEXuRQWAWsfbmGtE5kJpY6GqGwiU6wKcKjv9iyZe5pkVLNTl0rd
 zn8dYCJANoDzAJM01zOk5/1II1+GDiOGYYpWbhgRohIKiIw3OHNBn+5v3q+I4sIbHa4j
 wV6ilO02gh5CYG5BhZhqi/FwnoPF/GIDgdyTrjut7PY0repngGueu2L51REPP/xBlpW6
 3+gQ==
X-Gm-Message-State: AOJu0Yy8ZBNvar/4+1b5u5YiP395p6/QQaUrMpH+Qq0NH4js4i/aLBmA
 MwolKMWoQycRjxLg65z0jH/Kqb86vpt1TVYXcPo7Q2bm0zMWXwefxfw6H6FKqxjE6DV+dwC7axv
 C9lc=
X-Gm-Gg: ASbGncszDea286LNx9CPQ+cIOe2S2meeFA9yka9PX9Sc146q9DxrSPNG0uD1hN6/P71
 oxwtffi0mazRAo02X3MehYOMzGy0Rl9jjGtlaxeNH8g2qsGa9EXWLqohs1xIUwaLqjTXO83JZwz
 p1A5tz+gvg8AEaf49VEANWwQ9skhBhQYPgwZZniUFJ9CTzP9gVNUHOqfi1RnFJGUNPeENSwokjl
 xHxWJvzGcow4VD4TdpB3QoEqjhpKRr4xcSkpPKT5prKzIFXuUGzBPwM3XXNKU+m0ygLxohk3tTM
 aiYn9H1adXN1EC9kR7Sd0cr8rRuktNQOnQfiL/Q1
X-Google-Smtp-Source: AGHT+IE3nk/0V+BVylyx4venVIl99+/yB106zJ5mCx0F5wFDY1DkA2BWuWgtA/VYU3cAbsPYqddZLg==
X-Received: by 2002:a17:903:18e:b0:224:6ee:ad with SMTP id
 d9443c01a7336-22e1eb0c7fdmr138049205ad.44.1746487237553; 
 Mon, 05 May 2025 16:20:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 19/50] target/arm/debug_helper: remove target_ulong
Date: Mon,  5 May 2025 16:19:44 -0700
Message-ID: <20250505232015.130990-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 357bc2141ae..50ef5618f51 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2


