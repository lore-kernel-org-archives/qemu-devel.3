Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD1C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 05:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raqrg-0007zE-Pq; Fri, 16 Feb 2024 00:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1raqre-0007z4-R6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 00:34:22 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1raqrc-0006re-S9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 00:34:22 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d7431e702dso15927715ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 21:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708061658; x=1708666458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=GfehJG1lHx3Epj1/4lujcOnph+6Ri2nF152PCkHO1yU=;
 b=HnHhM7B2ZC3bsfk3uRy52kJaa03XE/PO2ywAUtMwcodtIGTulLi1p76VcWeupEapmE
 dSOrT7Fbn9M3kmvftT89OZtrvVO6eeciR7qZ2Lzk4w9malIZGQpCEcnAkgRzC4SZLZ7A
 Q9iQHChAabqq+ZU4CZePNuzIfj29TuMrA6F1UE84HFyRaY7vXUOuhoB2w3Z7W+RGmZE5
 4L8xZ5iyHPFSo0DzdpJ0RJUXgFhS7FO5+H8iGSAr7jJWAUEKBYPXpVNm7/X2ItzU0Bdp
 UGszZFjS2tQZvu1awWLwEeww4bO9SaC8EGWhkj1+SLc1xIx/xQY3fANWocwbBnM/7xhm
 AYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708061658; x=1708666458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfehJG1lHx3Epj1/4lujcOnph+6Ri2nF152PCkHO1yU=;
 b=OrEZAkzWCdG/mmfN2GwK7dL+VpPXWHLPElAQxoz1Z/1EAheD+OsW1L9H6MUpXvL0+w
 vlBE/1cpoW+n8LScAjMg3R52RuKttzHVLqJ2jiHf0L1UPU40uayNuXLRE6rtGWURjnf8
 g9/zmZGKhQALaCPyJ8VPYIGLpZh+vvI4zAPley2R/vEcZMzlbT84m54JOkZeyCi9vTGE
 5jmtaV/KUwNs1oIj1X7huwyEjfsmltByX0OYAg1ERv7NkZXRTPIPlYDyqGmBRvSeuJGX
 lx7RVZcEhBLUQ0BFF2qnhINA1h9H8LUbdbELPD634bJ18jA09vaENQ2NIOHcSjyEiCzA
 UHbw==
X-Gm-Message-State: AOJu0YyxjNhR3u6XmQvgq/4jOp6/MWl33CL0Ha9shEWKRQR9u0aIM7+v
 V3ZlJOrMNAh8DAXTDYfbuL4btH4bDbVI8Dg6dOUI0u2ZUFnACOMT
X-Google-Smtp-Source: AGHT+IFdCKCFvNPndLoSxZsNo1o+wKKdzC36sfW0QlYzQWgEAGVsKF/9/mBGw/TiA0gLzg4kx3cD4w==
X-Received: by 2002:a17:902:d4c1:b0:1da:232:df37 with SMTP id
 o1-20020a170902d4c100b001da0232df37mr4606819plg.36.1708061657989; 
 Thu, 15 Feb 2024 21:34:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 ke14-20020a170903340e00b001d7610fdb7csm2137617plb.226.2024.02.15.21.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 21:34:17 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Charlie Jenkins <charlie@rivosinc.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH] target: hppa: Fix unaligned double word accesses for hppa64
Date: Thu, 15 Feb 2024 21:34:15 -0800
Message-Id: <20240216053415.2163286-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Unaligned 64-bit accesses were found in Linux to clobber carry bits,
resulting in bad results if an arithmetic operation involving a
carry bit was executed after an unaligned 64-bit operation.

hppa 2.0 defines additional carry bits in PSW register bits 32..39.
When restoring PSW after executing an unaligned instruction trap,
those bits were not cleared and ended up to be active all the time.
Clearing bit 32..39 in psw prior to restoring it solves the problem.

Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 target/hppa/helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 859644c47a..7b798d1227 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -76,7 +76,12 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
+    if (hppa_is_pa20(env)) {
+        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB | 0xff00000000ull);
+    } else {
+        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
+    }
+
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.39.2


