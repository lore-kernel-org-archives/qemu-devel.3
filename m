Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C69BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmZ-00081f-Ec; Sat, 30 Aug 2025 11:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cH-00050r-1r
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cF-00042D-5y
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2376941b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506637; x=1757111437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTQnacEh/bavu4Iz6YuAlqixOQk5hLWfu3s3/rNKivg=;
 b=AwegcnjpNBE5oPyThjyvZtSC7eusCjo/FuWVlcbKuYrFxWb/acwrUERD5DFC8xp/EU
 HQVIE6ivkCf+zWXNHK/JiYv5t7G3cZJCK9KC7WENeIk9hz3DUe35uB+c9wv9N7B/yJFe
 yRd3R7mQ8s7nwjKWoqqUqJ9yjEW7YE1GxdlYOo+WJmj19ftoPZMJYEVsprxhiBcFnMs0
 B3SUm6aA14jn5guHufKJyrhkfA6LTRlZLEEYQv7ecUNnDVriGouwmK+rDgXjE3lzqX/X
 dAomUpdhqRXZH/NfeyxT88w/Mf/Uw6ZQYU+yo57+fYR8pp4f/lJnEuSW1XGCW/9Z3362
 AEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506637; x=1757111437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTQnacEh/bavu4Iz6YuAlqixOQk5hLWfu3s3/rNKivg=;
 b=DzFTZB2xwbnAgM9DE1dFxatQ/YWKMs3wsAXt9Sb21p5aXYQNP6MwJSlzeQWmjnuUwT
 m884vsSxiIiDLpxzzEfqQKFZN0469NRosPlix9xk2hhUc65S8KgURs1+EbffU9wbkSUA
 9qEuFbQFC921a7HTbh05nB7MXAfqGVgJwKPDwouxdHN+sle+WjBIfqnHCy+JDRxha637
 zv+Ik3+RXOkKZNdbsVFKjAKPwYguuwZbvub+MGoN8Mlx0srIWmxqwj+E7lcHjQa9JC5z
 gD1vQ8aTTu8zu+/TRSw4pFaz89P8m3iZRPvgusgutnDV5zrzS28UkgVVOtVmTKroslVM
 7DuA==
X-Gm-Message-State: AOJu0YwqFUIf+3+oldrj2MISzk0Wm/lNDfGmnK6pamsvsulaHQjEqXVB
 hwsXhieZOjHKhY/nwXYJLkVMWquw9bpHN2jdJJw0XQ5qN1SLtM+mBeYB40FsWUNIS0vBbdOtG0B
 hd6euunM=
X-Gm-Gg: ASbGnctIu+rzULoVsDiLV2UXLlt4EjwH0973nuXzlOAgVKNYlEEf0jQauMI6qZKQvVu
 GZxQuwE2D+C1wfXyQiyeYxq//TFrkc1vAsc2PmN91x7iqfrRgM2a7dsro8JTpKX4wqGpRbH8mTo
 i1D3BLDj8Svuig5cto3aXdiBCkvNwvgQW5ImypuQ7WDq3XN2N7tx1RsytPuxnDImde/3pyW7dqz
 wGkP2a3zzRgTCkPmIv2BkWpPVh+NjnZ287CrAvGCp3w+pitqSsKF/Qggvyd4hYk4aGc4Y7TtnmW
 dRsxp5CpKOT5M1tnN+0m0y26lY9KKQsOu1t1VZsiXt4zz/H+UbkVEbbaGagycCxFW1bXRfnK8HG
 8XhXDFhWsN8cFYqivg8K+kEdbVvrHF92IkYihCOTJRGwT1vc6IO4vB8btGRjUozg=
X-Google-Smtp-Source: AGHT+IF1c2cBBB1YMUnPrz9xgZP/vv4P8i8g8kfA43cZXe3EYLd2FzyVNPIAe8IejMaQqKCXZdPRbw==
X-Received: by 2002:a05:6a00:2b86:b0:76b:f7da:2704 with SMTP id
 d2e1a72fcca58-7723c503bc8mr564755b3a.11.1756506636685; 
 Fri, 29 Aug 2025 15:30:36 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 76/91] linux-user: Move elf parameters to sh4/target_elf.h
Date: Sat, 30 Aug 2025 08:24:12 +1000
Message-ID: <20250829222427.289668-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


