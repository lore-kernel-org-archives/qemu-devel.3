Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46AFC48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 01:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb9yB-0004jc-KU; Fri, 16 Feb 2024 20:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rb9y8-0004jD-W9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 20:58:21 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rb9y7-00070H-5r
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 20:58:20 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e2de202d9aso1048921a34.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 17:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708135096; x=1708739896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=LPdabQpB/k07IdknuZ1qRdlEreRQmWkHPCDUa56ZKyA=;
 b=WDVPgeZ+Tdi355jMlcBho1BXJHgP471GPSyiSUqvG2HcOQO0TM9wiyC8kRxbi9N0Yz
 pKYXZeN7djfVTQzYzU3hw6D9c3gNiasY1+TNHIFFYTyZvDRId5hvYK630FmGHtgcFILG
 CyP1z6p2sVB6j64SloIcqSEpOhT7ElCT0sAwC0aJVDw1cEX76FNmTsF3nDQ9KGURikwQ
 iR+5tqh5zg7lKQDmBWdSDKryyT/XcxsEaGQnz6I7FfYInXu0A8MLX2UEOcZCwlJ2coVa
 5NC/RvyrhnSoF8os8L5jperu4B/fycDrjhdusjR6gXyDWKdjYQod/iWkHDoNjS6K1yhY
 ZYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708135096; x=1708739896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPdabQpB/k07IdknuZ1qRdlEreRQmWkHPCDUa56ZKyA=;
 b=Lly+QhrqrgTdOlNK9+m7oWpd3VpD0yAO7pb6sSl0jkQmKvnIsV6jBGmv3WrkVS/AAm
 WfPPBI2kpXW3jKfEa5RYu4ldBJryu/fRtP8nCJDgYPGJ1SGCPfKZI0cJNJGQBxJxhySc
 PLOnsB+IhOBW0rfaELAYD/fLmOxPaCjR66NEWh99yFgoKue0Th5mWD0zS+N/Xk9B/ZVx
 +gymjXIeRwzUVNuXzzL3w4uTgT9QPehDYhDtPjdlowXfmz6ZV2uhleoKZJaIBx762od9
 eDDz/rHbe/sNe9SieAE5Z+2tNBr4dwMg6ylTYZsn5QtBXAhXy2X4XyjtZ/RjoGrJDRmt
 qX6g==
X-Gm-Message-State: AOJu0Yw9diMDTJTU3iC15YmmLfDvsUDVpODWazADIDINflgNRD6eImuv
 jgqEQAjDGfOQyehyLoZtcnvuXoQHHjkTLQdMZMm7zAjLS4/tiTMOQlE7hdSS
X-Google-Smtp-Source: AGHT+IEGNlHQlmpv29a9JVMjArRNdwuX6in2erzOrzpWSORyCs9k8ZzdFS34rPZAQrY/0Eslw30vcA==
X-Received: by 2002:a05:6808:220f:b0:3c0:3653:aa61 with SMTP id
 bd15-20020a056808220f00b003c03653aa61mr8203981oib.1.1708135096551; 
 Fri, 16 Feb 2024 17:58:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a17090aca8400b00296f2c1d2c9sm654001pjt.18.2024.02.16.17.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 17:58:15 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Charlie Jenkins <charlie@rivosinc.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2] target: hppa: Fix unaligned double word accesses for hppa64
Date: Fri, 16 Feb 2024 17:58:11 -0800
Message-Id: <20240217015811.1975411-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=groeck7@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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
When restoring PSW after executing an unaligned instruction trap, those
bits were not cleared and ended up to be active all the time. Since there
are no bits other than the upper carry bits needed in the upper 32 bit of
env->psw and since those are stored in env->psw_cb, just clear the entire
upper 32 bit when storing psw to solve the problem unconditionally.

Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rework to not require conditional code [Richard]
    Add Richard's Reviewed-by: tag

 target/hppa/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 859644c47a..9d217d051c 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -76,7 +76,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
+    env->psw = psw & (uint32_t)~(PSW_N | PSW_V | PSW_CB);
+
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.39.2


