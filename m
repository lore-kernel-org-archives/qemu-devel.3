Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE804C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVny-0005jU-Si; Thu, 15 May 2025 06:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnH-0004zQ-LX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnF-0008CQ-NT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so669323f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304784; x=1747909584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Byp0Y4O5zheOoMWAZrB5mhT0UXR53h/CRs+fbHyD9ww=;
 b=B3YJmlhK/5VBLFR9iG4Z+CTlhVK5dWidKr8KJAPrM5NYWfUR1VheQMlZBadiEOnWyD
 8odR04SbDBaIadXMjeSyDKlJ/m+kCiTSEP6xnbHKfRTnTpPg1mBARAs5Sko5e8lX466j
 /mYfqbGXB1JgBhjd4+GgJ4Rf4LL5JyZK+qgtSAKQ+AMUWUJd2qHK1xk5KhnEq51y00Hc
 /zjPx6HiwGcVU+ovXIW5tS3Usv7eASwhQo4nN4gZvS/jT40e5o5zPON3PLjdDis1pGSq
 rKFon9xDUG8Ne4QvqJBBU/KQQTnwkS017jAbklDIsIsHSyGKNnI+osIpVBcfI6L3SZZB
 SYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304784; x=1747909584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Byp0Y4O5zheOoMWAZrB5mhT0UXR53h/CRs+fbHyD9ww=;
 b=jePOXKR6WnAAZnAREQnakjJoPGPjHcpdfkLC9LV4PnwYyHG0alUT02Z7e5/tu5uSA6
 Jz9Clx1Z82UpWJGxf8YwIuwnvOmIYas5mDNcqM5gvZ5NZgXTvMe0S4HdWyGyttvhgpq+
 /FJivJVqzdjp1h8SmcISbP4f5SQkH2YGWyeCARf1O8DxN8AD23KmYRWnXZyFH2LE/FrB
 5m8NBVbyiWJrl3BaJLEJgcMyd8tP3x5ojiN2cHmSH/iha6o8C4vLpHTtkyafLnDYjzIr
 SGuDrRpheQXWO8Hy3Dixp97Dym4o9HkI+8q8oafeRWjwxDSkqolfw27EqsfMnkGJ9yL4
 OLhA==
X-Gm-Message-State: AOJu0Ywv5JC9o4A1xOrrESSOLXQnQcRsMa846H4PUEp8t2FdtlnwOqGE
 +JjIDsjO3Do3b3BsXpZ32a2N/+1lI95/m9fVYEMHUqCLFx7L80dPY5fr1r/oSTrBBS+Z/vVRKcE
 0CZs=
X-Gm-Gg: ASbGnctGlZ3cg3C7rbsX8i7IqHmD8D0E+RyZBIh6swPX4uunk5KNSGhdR4ji6so72/E
 vU75eAnjJwLw0WdGiolFUx/jvnK1TwvX7zXOIAdYeGeF8bqdIS9X5MOYjjBk5hFZsQGeqi9LPgX
 L5x7osV8R1RoByg7zaGLQA8aMdRsDvPWwqUI7L+kJ1taBu08Gma8rYHuz24OcLxGtYeVr9XXmfP
 kcbGRYKptyiGMtxqyEMcIzwOadURSAW5jJselUjS3zLsoUfKUjk6ySfspe9jCl8X3SG3XjzFRlr
 E82OhkKfG+lY9WX7mgkXBlUfI2T1FkgtQBYZS1e6e1c6tPwLb8hoY5NCMQ==
X-Google-Smtp-Source: AGHT+IGiWoW59Mp/M85NXnGEmTQ0MBF+vOuGrLs7Zfj+5Yb0gJ3xXAZ62ovXdgtqnUQhI6ySkDopXQ==
X-Received: by 2002:a05:6000:40da:b0:3a3:4b95:aad6 with SMTP id
 ffacd0b85a97d-3a34b95ac81mr4625720f8f.19.1747304783975; 
 Thu, 15 May 2025 03:26:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/58] target/arm/debug_helper: remove target_ulong
Date: Thu, 15 May 2025 11:25:15 +0100
Message-ID: <20250515102546.2149601-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-18-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index cad0a5db707..69fb1d0d9ff 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -380,7 +380,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.43.0


