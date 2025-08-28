Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6E2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBi-0002Wv-CP; Thu, 28 Aug 2025 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXQ-0000s5-Sc
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXP-0000IT-8r
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:32 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24457fe9704so8996555ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383330; x=1756988130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTQnacEh/bavu4Iz6YuAlqixOQk5hLWfu3s3/rNKivg=;
 b=ghFtz3V9/T4t+ZCGGdbDrFJ1niYk7j50BXM+KJ8SWmkefzKRtehCCnjMw9SxVCfWby
 thzwxKRYQHfrsZfHzZ9Urv5ibeBcWHxHvGYYyECoHgPUgU4cdfPRNexBX/PWLSm4Dnaf
 XRdc55MlCzaXsLmB5qowo0APdF/v5dvq3go8qvXhvVCqnkcB0Mt1EbCMtTNDlZ0w7y9+
 pFa3l3qFjjHUDKfHA6GEAl5+gqDbz1OOUaHsnLoMFgA8o/X02vmnE86tAVyVxvoTQljG
 q1358DtkzKqqmWqAUm60VLqgtYodXYsc5aeeJH4EcOzQC8GRTkxXJ1TwGVcYd+9exkBs
 kYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383330; x=1756988130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTQnacEh/bavu4Iz6YuAlqixOQk5hLWfu3s3/rNKivg=;
 b=ngJmhXHVbvKxBxJGY8hPUVCX1hurHEsDRI7bax+Z+uylOpM63FOgS1XIbaBFh4q27Y
 8bxbazcCashdQCMWrRvXvKObOghNz/L/uByCukrufHABm2baIUfke77AfxVMvDf3l4ly
 /8uu8WKQdzPFYfxt5DnwoRypfAwVvmmf4qbN8HDOGPsC2rpYMDfNSZCisHpuZ6Jm2czv
 d3PaP6gsouiO0iphMUyCNj5x5qt+pbT3QyF/i6CJNSirCbEuFqfzOdU1UG6LVw/cRorO
 q864L2IxSgSddJbQOwutmTRFf7TmPvqamZ/73r42j3Oixyz66yI0N+CLYzMVgT2lJFc6
 /69g==
X-Gm-Message-State: AOJu0YyWw1YE4pgrdTvZJyZM8ps3zj1msW9EteFZStD1lQd0t7KtZ0vZ
 9wdUQzX26GVZp5mkix94kT0unfnZbbPKpgqlWp5sO8DKT7Fm2b7Xdv8BjHwDiFwLeljAW3yvsX2
 RAbRMKuI=
X-Gm-Gg: ASbGncuTC1stYrEImG2nAzVIk8iTh1MIeTe6Pp0DhWmZxpHst15CYQEEv6KVG0XorD9
 V1E8AIBbMw3d+xiMdD/+HHkokIrePG+LTAAN8SWKhLz/+9Lqc9CnvtsMZCPuhF1yp35ppxqwEzA
 NyLa5qe6+KAi/T8v6dUt61dP2abeZFTGleKHeEcqksw7PwvysDf1tB6VRAG8Mtdeb68dF34lQaW
 382GmqDGe6Wt7U2ycNXELUIkzSPs2Wb47y32QSNyZixgLSTCLHTpQ16P/NME3Yl6IuezaPNiv4L
 XDLmP9lYLGNKMQu6FZD49itdXQl74LUAYYpaQ7kR/W6pdDEkVd8h1qJqxEHv11S/xrNJy3AacJ8
 lumLhOJUQEnRRAl0uaUED12dH6w3GJMcf/rwlTxq/vTgJdD8=
X-Google-Smtp-Source: AGHT+IFdnWarR19Zs7YMYKR76ewlkuZ1xQNFYikel85sg8cfVHQoTdZDsBi3Qw9x6IM58vaNNLOhcA==
X-Received: by 2002:a17:903:19cc:b0:248:cd0b:3467 with SMTP id
 d9443c01a7336-248cd0b38bbmr42389455ad.11.1756383329761; 
 Thu, 28 Aug 2025 05:15:29 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 72/87] linux-user: Move elf parameters to sh4/target_elf.h
Date: Thu, 28 Aug 2025 22:08:21 +1000
Message-ID: <20250828120836.195358-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h | 3 +++
 linux-user/elfload.c        | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index fd3ae68a01..61aea237c4 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_SH
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d0993621c1..1a6e81394c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SH4
-
-#define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_SH
-
-#endif
-
 #ifdef TARGET_M68K
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


