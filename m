Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC499C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sg8-0008GC-Jy; Thu, 03 Apr 2025 18:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sg7-0008Fx-0u
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sg5-0003kr-7J
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so1103051f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717887; x=1744322687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVyO4Mxkb0F/UGcN3gePDsdWIGD9Ydr6wuyRdXDPD+Q=;
 b=URdunBJh8DY80KX5Beg43D7egiIaHQF4oTM8S9ezIQJ9UVrkr4aiB2dYhWgUtA94qW
 m32ECmOWVt9ZTptlGwg0Ui02OMZajZtoaIaF3u8OLE96jY8qWO914qccwSfRX0GP9SVQ
 pD7O9nvZ7KVpeuTpsXIgcaJZud+KFBjJ28v4BGxLiazpdtD8OLwXQu1AsuaXrH2zyO8E
 L9QcNoWhB4xCcRq596xUleQrDz/lIxa+9Yaij0QsSJTuMblFQwg0+fVRTUAXPeXecXZV
 ZhbATexFvuQN/3IKEnEaZwUTsM+ZZ2e/RhydkhzCzM/tn8cfIqlPwF+vkquZRSK4Zky6
 2W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717887; x=1744322687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVyO4Mxkb0F/UGcN3gePDsdWIGD9Ydr6wuyRdXDPD+Q=;
 b=HMF8VZiAqIQ+qkis0OCScCqfWMKH0rpcwrgLjiCVC3rOjjFE9duggKhf6zJ3r/wnLm
 RSPg03RdQoghwK3gOeneFgIznNwvbDTApfdc0caDHcjdjMc0ZIDH0joOdVyuIktwoktt
 P7j5bJkM/07a+nNGJN5L4n/YxzYgFpH/C9Pua/llHy3fkNuog5i38eQJGuKIX9UalJ2W
 VW4A83berGH0Lk7YXUh0ISjImbBu8wdZpXlIRUP2z91p3+ogQd/q0NG7nCLU/TEpDNmw
 b4N85kpZVmUFYqq5Zel7DKoLoJ5D6nVDw4zm0tuW7GY9QVBj5NFZGMIN3As3Uivqivg/
 uDBg==
X-Gm-Message-State: AOJu0Yyrq+IAldPoU7yiPdRoQm0ag4pKx8gzs/dhXCBgNqKu8w95qps0
 hSusxC9TIgDEDeV0OUY8DYeigQxIhgiwQqXuUN3xPDCFf4U+a+esHu9gop4XQWE56z5vRAUYrC+
 Q
X-Gm-Gg: ASbGncsS6NNHg6MM7IEweuweOtH/AJeGPy9bNBzK9xQXsbZGhKi629iAEBYBlAj/PHV
 iiKhF/a+DMcePRciUGAHTjuVDN1RnMZBMifdJDbaGpaMJFLZzk/H/RXIUOZSLBfxKVNa1oWXFop
 8iM+uBUPLUpCrldMQULXzl+w2KmUhRJDhA53mVKaaltuuTPIHjfYeHR7hpP/MIea2lgF19wjvdH
 8TIKv9K9oUxelDW8SMH8aFjAKK6npAE+KKzf4NdxZAOQGP5mGSycIGARTmS0YObRweF8Xs4Exjz
 O69e6MNNZi61HsDTPqtxDDDXeEI4B/vKWtUlzbyKm+TumAw7xgPfmNQBXwnXekT/ysIGo/dr6N1
 z7O+Yw75y7WGdrfDEJg5WznPB
X-Google-Smtp-Source: AGHT+IES0mUMLoE+3N5qi3N1Djr4XiyGGgr0Sn2Ycr5lt6KM0+rUCdFcbzNhV9x9GD+va3GNOU2clA==
X-Received: by 2002:a5d:64ce:0:b0:391:3915:cffb with SMTP id
 ffacd0b85a97d-39cba9825d3mr679089f8f.43.1743717887087; 
 Thu, 03 Apr 2025 15:04:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ed7sm2737003f8f.8.2025.04.03.15.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 05/19] exec: Restrict 'cpu-ldst-common.h' to
 accel/tcg/
Date: Fri,  4 Apr 2025 00:04:05 +0200
Message-ID: <20250403220420.78937-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{exec => accel/tcg}/cpu-ldst-common.h | 6 +++---
 include/exec/cpu_ldst.h                       | 2 +-
 accel/tcg/translator.c                        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)

diff --git a/include/exec/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
similarity index 97%
rename from include/exec/cpu-ldst-common.h
rename to include/accel/tcg/cpu-ldst-common.h
index c46a6ade5db..8bf17c2fab0 100644
--- a/include/exec/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef CPU_LDST_COMMON_H
-#define CPU_LDST_COMMON_H
+#ifndef ACCEL_TCG_CPU_LDST_COMMON_H
+#define ACCEL_TCG_CPU_LDST_COMMON_H
 
 #ifndef CONFIG_TCG
 #error Can only include this header with TCG
@@ -119,4 +119,4 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
-#endif /* CPU_LDST_COMMON_H */
+#endif /* ACCEL_TCG_CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 63847f6e618..74761ba5f30 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,7 +67,7 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c53bbdef99f..034f2f359ef 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,7 +11,7 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
-- 
2.47.1


