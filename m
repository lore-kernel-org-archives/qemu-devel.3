Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CBFC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l02-0001qN-6N; Wed, 23 Apr 2025 21:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwq-00052O-GD
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0005UN-5F
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736a72220edso419994b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456412; x=1746061212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mp9J9qjnxFI/eYHYBGLU+fFqwqKgFBMYv+K6pTDgibE=;
 b=efDpYvo+Hv+NZNJ0SefBUwh/7aptIeF+Rvat0kqakMm3ijeR1JS1z953nFhailoFIy
 N2WmnMhESs00OLsLNJBJvxQlyzjf0op5u0L+lqLFODqvasTVPMXKl0Ct5+KPJx8tHHNp
 TR2GnpWG/gU+hqOxtsB5S7UJMmDYOZFsu5XncvnA0JsY8/LJ2iBNPip25dZrNIRmg+Bz
 nzU53Ub+HoqSwPczFvZYW7CkEjZnFkBT/cI+S1GPF/b045XXW+8qblaRbh5U5i+Z+rY7
 8Pc1OnBaQosXqZRRq0E31PZH4jvBqQp1Q5xrLUoMiWgXa1yM0u8pVWbaZ62qDiIzWkIP
 wi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456412; x=1746061212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mp9J9qjnxFI/eYHYBGLU+fFqwqKgFBMYv+K6pTDgibE=;
 b=qehHcf1lTkTp6TFboPq6U5AQ1XHQhysnzMN2qd2Mrp54zu81DO0/vEzROkrSYLGuHN
 qti01/TtLt5cfbPSrrYpvqeGVQldHZvV4di0H6CxEIotOqtShcdTel/Uxv0l8k2BD2wo
 Ll5+FCk4BuUixlVp5WbUUZIfPVTbxiING2CvlxKPi9YzqoptHqyaewHpmRMemI1KYMZO
 Oe6X9Vem80ILAeCx55kWyEEU7d0QCALzyryoJlzcVduTHH7v1qar9DqcwKybK5cigXRY
 /n5lo6klTsZic9GS2QO/woScBPs4s90VcMHrkPgf12zrBbPd/5D1rZ1+KJC+nUL9BuX5
 hH2g==
X-Gm-Message-State: AOJu0Yz8CiZqC8FreEG2pLJPGFN2EzjN2D+pzEUaKXeGP2Vq5J6zeow3
 1C6uVbbtp5RBVI6NT3dBCkcgKOZ1ee70eCVGpRjj8cqJKUP2cl7P5hfOtYo9IuX9HwMx4u003H+
 2
X-Gm-Gg: ASbGncvWzK0cZain5qkaW+PkABNSw6C4Y85u/KjVI5I4iAuw7Gp2SWpvmzhdiJznpz6
 SnBubHNKeW9OQdwgyxC7vzWG9cMr6q5kPzrW8hrHHdyU4ZGdsjLLTO+u6EkHcJva0+oAWgsIH3S
 dZzDBbiGVTCL9gkq13MOWdElfYHfE/545ufDVb4T2Wn48aBfXrGG9t1MEv39lvHfBFESsHi3wLe
 /oV2pH5xdj5GW8unogNAZxvaoDW9JIntFW/Th7vTKZTfvzld+2lN7fkdZqaXWlMaXu0i8RKB+AK
 6HxS0H2+LH5BMdoHKOGOewcnZFW8d+zsYT53ts/TF3SZWjiIAAWNtWmfPCJzeQ125poo1/m5QNJ
 qKmd7W3jCtw==
X-Google-Smtp-Source: AGHT+IEsz+nHXKyYJG4VuWF8sqLYw87dDILiSXKd3vCWHMMWK+/vqJA0hy7l7DlSV1VwdhIqCvRc5Q==
X-Received: by 2002:a05:6a20:c707:b0:1f5:8748:76b0 with SMTP id
 adf61e73a8af0-20444f25fd2mr887921637.29.1745456411667; 
 Wed, 23 Apr 2025 18:00:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 132/148] exec: Do not include 'accel/tcg/cpu-ldst.h' in
 'exec-all.h'
Date: Wed, 23 Apr 2025 17:49:17 -0700
Message-ID: <20250424004934.598783-133-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only 2 files requiring "accel/tcg/cpu-ldst.h" API do not
include it:
- accel/tcg/cpu-exec.c
- target/arm/tcg/sve_helper.c
Include it there and remove it from "exec/exec-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     | 3 ---
 accel/tcg/cpu-exec.c        | 1 +
 target/arm/tcg/sve_helper.c | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 70608a11b6..944b579d91 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,9 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#if defined(CONFIG_USER_ONLY)
-#include "accel/tcg/cpu-ldst.h"
-#endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5ced3879ac..b00f046b29 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b0d40c9e1..87b6b4b3e6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
-- 
2.43.0


