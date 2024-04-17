Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE99C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA3I-0005bd-H5; Wed, 17 Apr 2024 14:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2w-0004jT-Ek
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2s-00040w-9j
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:13 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so13264a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378608; x=1713983408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2iJJmV+2DNCV1vqfBBGFjheXtYtlaqsPcXM/OBu1Kk=;
 b=jo5u4ce0FeUMneV8F7Ls0Nr5gNiJBFbSFRCVyrNPdSA7cze0BKBEhlBw7xLF1uTgFZ
 oPk64MQ2ob6IiUYs2uUu3Oz5TjWJS2wkPriK6OGbX1Xe2a4ngYaBZJqimgnkZEVIy6zK
 B36n/huHLt/O5ruc3rxqByWbD5202UuCt4QtSZwmriTSjGSPUQrgV+uqD+lQjHRV0e0h
 KE8eiDXUpizjiC4K5N4/VB+F6ON9jTprp+RW41OgqOBR4zp6jk9w9w4Pd9zypGRYxqqe
 VYiio/wyZrqhnkep4fCqub8HKsjyVWD+V5V9jhv/ee8sFNEPkSf7BuSfZmigNDdnorvI
 X/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378608; x=1713983408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2iJJmV+2DNCV1vqfBBGFjheXtYtlaqsPcXM/OBu1Kk=;
 b=Q1oikTpoW7k3+4AKmXLq0hbJsW42FTgPeFzGEl5jcqNAcStzoVG9KFrzo2NUef2ZM8
 17fn2Xfgiu/iHGUzq++uGBNW7tib8KWxPWMqvD6J6y+u+5yHqICraTwjW+v30OIppKjl
 O7LUD7IeHD+2gQvD75IvQxLeimjNCsOd/q3gbTCX5zA3A9XgOcWdE/bUXfHvc/pjaxoo
 AOh/I1DtXDNzP7nct3JpQlFnAg0VRJjkPERg3b2NISMznZqJgVq8uoDta98T/2DYnHJ8
 9RO5++gE166QD8BRIuIyc/rMDRpVM5MU2wQVQU47HKBHD3AJ8YDcsBoT8u0YP3xcW389
 6rhQ==
X-Gm-Message-State: AOJu0YzqcMWdY8wEImKLBBuKlny1TgL/wLyrlZuD8kot0/TdwEady6g8
 072RfNlQfJL8guWti0fwCGrFMg0pJKTAkvRBRSYIq49+pMDG4q/NPnXCThkhp+Gi3ZhwUAxzBqK
 c
X-Google-Smtp-Source: AGHT+IFPW8DI84t0fCPJYcuOwRuBH1BfbTttDro0zYs74B+ghQSKMr2oM9unIcsCYStPMLVAH7G1TA==
X-Received: by 2002:a50:9e4e:0:b0:570:d50:e7d8 with SMTP id
 z72-20020a509e4e000000b005700d50e7d8mr306233ede.22.1713378608179; 
 Wed, 17 Apr 2024 11:30:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a056402020600b0057030326144sm3467024edv.47.2024.04.17.11.30.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:30:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/21] exec: Declare abi_ptr type in its own 'abi_ptr.h' header
Date: Wed, 17 Apr 2024 20:28:06 +0200
Message-ID: <20240417182806.69446-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

The abi_ptr type is declared in "exec/cpu_ldst.h" with all
the load/store helpers. Some source files requiring abi_ptr
type don't need the load/store helpers. In order to simplify,
create a new "exec/abi_ptr.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231212123401.37493-21-philmd@linaro.org>
---
 include/exec/abi_ptr.h    | 33 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h   | 17 +++--------------
 include/exec/exec-all.h   |  1 +
 include/exec/translator.h |  5 ++++-
 4 files changed, 41 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/abi_ptr.h

diff --git a/include/exec/abi_ptr.h b/include/exec/abi_ptr.h
new file mode 100644
index 0000000000..2aedcceb0c
--- /dev/null
+++ b/include/exec/abi_ptr.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU abi_ptr type definitions
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef EXEC_ABI_PTR_H
+#define EXEC_ABI_PTR_H
+
+#include "cpu-param.h"
+
+#if defined(CONFIG_USER_ONLY)
+/*
+ * sparc32plus has 64bit long but 32bit space address
+ * this can make bad result with g2h() and h2g()
+ */
+#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
+typedef uint32_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%x"
+#else
+typedef uint64_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%"PRIx64
+#endif
+
+#else /* !CONFIG_USER_ONLY */
+
+#include "exec/target_long.h"
+
+typedef target_ulong abi_ptr;
+#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 82690d3947..64e0319996 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -63,20 +63,11 @@
 #define CPU_LDST_H
 
 #include "exec/memopidx.h"
+#include "exec/abi_ptr.h"
 #include "qemu/int128.h"
 #include "cpu.h"
 
 #if defined(CONFIG_USER_ONLY)
-/* sparc32plus has 64bit long but 32bit space address
- * this can make bad result with g2h() and h2g()
- */
-#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
-typedef uint32_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%x"
-#else
-typedef uint64_t abi_ptr;
-#define TARGET_ABI_FMT_ptr "%"PRIx64
-#endif
 
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
@@ -120,10 +111,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     assert(h2g_valid(x)); \
     h2g_nocheck(x); \
 })
-#else
-typedef vaddr abi_ptr;
-#define TARGET_ABI_FMT_ptr VADDR_PRIx
-#endif
+
+#endif /* CONFIG_USER_ONLY */
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
 int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3e53501691..e932d364b6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
+#include "exec/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 2c4fb818e7..6cd937ac5c 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 #include "qemu/bswap.h"
-#include "exec/cpu_ldst.h"	/* for abi_ptr */
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "exec/abi_ptr.h"
+#include "cpu.h"
 
 /**
  * gen_intermediate_code
-- 
2.41.0


