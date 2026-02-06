Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F2EEE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh7-0001xg-HO; Fri, 06 Feb 2026 16:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgY-0000bM-BB
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgU-0002pb-2r
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so11045415e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414491; x=1771019291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsyDcZvUn4Ye1SpbslgvYtB+Ajf37CUHv5TqhZgKD5I=;
 b=pLYog0vunAyzpIG1f9NHX2ElloOweOwfYAqKsF+lOqGJ2/R+laa/1Xmh96l/gTJBez
 yJKVsbF8mAI0bLGWyCTH2pDLJT7F1HN4jB7eEa2qrTfc45JmA7IqhxHA9IIFJ8NMXjSS
 bvvR8N756hzdnZYIE3FNrcJoJW0kY/bb9yN0wBAiHto4Yyn8RMUDAvDL7EBrlsG0oZKX
 nzXtvxYBu7CWlx3fDy5zIRb84mAJvCYEURXpmFPqhZEOsFtZCjetf3aEhnmyypmGfSEd
 Jf9NWhmpIssmF2UFETFNr2Y3qK55rZUvb6nYPXog89MYoUvW3OZacXBwopz2oE7o/cEx
 8R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414491; x=1771019291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SsyDcZvUn4Ye1SpbslgvYtB+Ajf37CUHv5TqhZgKD5I=;
 b=KzvS1SLVKp4lN7wbfWhK/ooV0/z62z3qnpBjcwaC+V3eRsz2j4cG+lTcVfbjeiiALG
 19VAYswGRo2kp8b5uQ/BKD9YZRqTMH/WsfeBjUDxA6pWWQ3KAw9uYrNy3aNOueYF/9z6
 dmBO99PUBBjDc+E9k225anCLgpxEqNSeuK943qpEnx5XyYVmbZYQbS6kJ/CzLDVzgeSE
 8lwbSK3kij9giYSjXOmuxMp86AVou2+1LWLBop24xPYSa6KfwCeFcB0gP1YlhMAApgWf
 TukRPmbwn3r8otDiUmifamFodaN3GVmsDLzbbzgH7n2PrSE3uSCcj6Htu8FQT3UE5l5J
 6coQ==
X-Gm-Message-State: AOJu0YyIhQaIgmCsUWFOKbkUd5R6VskMzVMMLaJyv3nEsuWjBCLXeQ2R
 xSNeP8TMqUkv0V3NTwu8C27bw8qh+Vt8FzrS6Bs2l0Ff0Ai+JWF/rsI3a2Q18JVy9YkYlyStdGS
 MaNY5xA0=
X-Gm-Gg: AZuq6aKpQTAWHCP5y337LkAqj/q6fiW4TCHk1M2F3GUo9meYXZumH+orNJ8erqYQm6p
 W/y6xbKCBhUYigwPEBTo5n4YP6GGvIfQpzWoatXmj2+ygpKie+vJLlHOxGmeVyPCCsvsCc4HvDT
 xxNZmHJ9sXXrxQ0YPT6NYQE2HBa8kgEVy0WalQKs+P+eMmCdIT6aSyJP7/FiQEYUQQfWGiraNjY
 HKCTUeayrSBF5KaazV4h6vcVNvXelJzAZxYM3LB4AA7tLkVyS8EYwVKesJ9sBM9abSpxDge9coQ
 4nDWHfZteiUet0iQT+zurp10qmB0HouRHnrYAM20imnQiVerJdEngkDZWKoqkPwV6m1uL9Xy3S7
 DquBilBZLQVsthd9/EN1tKvyZmuiNZtM3T4zy7BMU2w/w/yQpKtfYPjYDMdBEErINqX45+EB4SC
 i5DMDHnieo6IUn/G3spSJfP6ai8Tcb57COE0xyInQ7PTdU3XvsnaiDzX4VRp5S
X-Received: by 2002:a05:600c:c165:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-48320213840mr56506655e9.18.1770414490548; 
 Fri, 06 Feb 2026 13:48:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a99asm167883245e9.11.2026.02.06.13.48.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 30/30] target-info: Statically initialize target_arch
Date: Fri,  6 Feb 2026 22:44:48 +0100
Message-ID: <20260206214448.22008-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Use TARGET_ARCH and token pasting to initialize
target_arch from SYS_EMU_TARGET_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260205030617.266625-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target-info-stub.c | 2 +-
 target-info.c      | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target-info-stub.c b/target-info-stub.c
index 8392d81e8f8..65220cc7820 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -18,7 +18,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = SYS_EMU_TARGET__MAX,
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 5a6d7282524..a26532f660f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -24,13 +24,7 @@ unsigned target_long_bits(void)
 
 SysEmuTarget target_arch(void)
 {
-    SysEmuTarget arch = target_info()->target_arch;
-
-    if (arch == SYS_EMU_TARGET__MAX) {
-        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                               &error_abort);
-    }
-    return arch;
+    return target_info()->target_arch;
 }
 
 const char *target_cpu_type(void)
-- 
2.52.0


