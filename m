Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E15C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsc-0007Ww-Hv; Fri, 07 Mar 2025 13:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsX-0007US-FR
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:01 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsV-0007oZ-HW
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:01 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso3426749a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373818; x=1741978618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RytMCD0LlZ8TULuAO+TyiQ/M0TGfjDPA2CE/B7x8fYg=;
 b=eRjIM7YLZBgFKoD48CopjteZE+NKJUCbVxUn6Nideg0MKEfs41ZHYRjbU3XnHd2sAe
 5KFvZdIQ9LT6+902mwaSSuHqhg12oUkV9fs2zsttb3jCGVwu4oyv4E6egrBX25VVBnrg
 h32JE8necZfpJxc0mUA5uixp/WoIW6uMnv/1kUQ1hjA5lOlZhQ0aTz8yIvtLsor0zJwf
 UbBpBeW3qRwctUhW23zQxF9z08ZL2fG4IWG+eKX8Loesm9kbyCosr4eRJtmHIb3fotug
 MIFhUV3klnSBKHjqsH4OlFMP+fgJM1vAes4fzqWcN90qkQvSl0f6rTUJ0AugEjU+xnLR
 eJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373818; x=1741978618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RytMCD0LlZ8TULuAO+TyiQ/M0TGfjDPA2CE/B7x8fYg=;
 b=XgEFgcgpqoYDktbpabQUs/Pb6j1g//Z5Xbov8eLoB0Zt3cNv/6HV1weygUfwVKaa4h
 c6qLhIg+RRY6WMUar5SgteW8+pcfD6zzLAv1sE+ZO0wECuv5zcVqrULo4tAdgKGmpB3R
 JXhu9i67io3s7lAqmXMvrFvGyyWyH5fzmQXW60Rbc2xPsnAv0oEbQorq8l8v+ZHUR6v4
 3fRp3MJJ2uRCrnvTjiPeTR6pmm16J5NkvQ0+mHc5axv0+Pq8wG9jL3R2v40oiMcgdvst
 F87PelKf1rlrV5S1jr3JD0/qUAdAygcHI5RBCA9gPyFWplSVocEzHkga4rZV2z26TCI8
 EOjg==
X-Gm-Message-State: AOJu0Yzz5hCe1TT+NdZJ+8Mqg1c8HP1chqlZZDzT5uH8Zkbkn51+yAvc
 5tRenc5Br0ViuHaivVJoK2a6tqbzFxXgEwQTFvuF4FlU5+HIgM3ShWf+3TJAPLVRifLsec2EqB3
 h
X-Gm-Gg: ASbGnctFAKui2lskGfXOzOHIdPwbmjAwnLguxPkfc3PrPXqOSV7Tlpb8HAogS41rZ2h
 7xWbAfCCDQxYSK7a8oXUtYB7DqK4VwXnVF25k4StCSm07rxFmpZ5/8UT1Dz+YcJ8JA2ogKcsPrQ
 aKgR5Ee5BwMI7BWb0F0ShdK+5w4h9x0eFQmy+UF5Hx+HPVWGag6BSxEimk5VbtOjem+WtQow8s9
 RaE+7fbuo0/tdTQ1CfGUU8vjyU3o76K/TU/uniCkcqFjI4sSxNHsmbGp0QHATxJvqXZJbQhTlg7
 Eel9UG1j2cKIKR4KwQVl//gWLrfLnX6H+9W8w4l5sYglmj6HzbHh7sNhEvNUXQJ0sIPB7y0go/Z
 H
X-Google-Smtp-Source: AGHT+IEmanZVN6fDq31cc/MRYn0mF40fpIZsYvaPvVw3Ix+iW7huw2xf2c1FQF5DLOmMB6Al2CfLxQ==
X-Received: by 2002:a17:90b:52c3:b0:2fe:b77a:2eab with SMTP id
 98e67ed59e1d1-2ff7cf26f00mr6164815a91.32.1741373817883; 
 Fri, 07 Mar 2025 10:56:57 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 14/16] include/exec: Split out helper-getpc.h
Date: Fri,  7 Mar 2025 10:56:43 -0800
Message-ID: <20250307185645.970034-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Split out GETPC and GETPC_ADJ to a target-independent header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     | 19 +------------------
 include/exec/helper-getpc.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 include/exec/helper-getpc.h

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a758b7a843..22a99ca502 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -26,6 +26,7 @@
 #endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
+#include "exec/helper-getpc.h"
 
 #if defined(CONFIG_TCG)
 
@@ -177,24 +178,6 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-/* GETPC is the true target of the return instruction that we'll execute.  */
-#if defined(CONFIG_TCG_INTERPRETER)
-extern __thread uintptr_t tci_tb_ptr;
-# define GETPC() tci_tb_ptr
-#else
-# define GETPC() \
-    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
-#endif
-
-/* The true return address will often point to a host insn that is part of
-   the next translated guest insn.  Adjust the address backward to point to
-   the middle of the call insn.  Subtracting one would do the job except for
-   several compressed mode architectures (arm, mips) which set the low bit
-   to indicate the compressed mode; subtracting two works around that.  It
-   is also the case that there are no host isas that contain a call insn
-   smaller than 4 bytes, so we don't worry about special-casing this.  */
-#define GETPC_ADJ   2
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
diff --git a/include/exec/helper-getpc.h b/include/exec/helper-getpc.h
new file mode 100644
index 0000000000..1c8bd72c11
--- /dev/null
+++ b/include/exec/helper-getpc.h
@@ -0,0 +1,31 @@
+/*
+ * Get host pc for helper unwinding.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef HELPER_GETPC_H
+#define HELPER_GETPC_H
+
+/* GETPC is the true target of the return instruction that we'll execute.  */
+#if defined(CONFIG_TCG_INTERPRETER)
+extern __thread uintptr_t tci_tb_ptr;
+# define GETPC() tci_tb_ptr
+#else
+# define GETPC() \
+    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
+#endif
+
+/*
+ * The true return address will often point to a host insn that is part of
+ * the next translated guest insn.  Adjust the address backward to point to
+ * the middle of the call insn.  Subtracting one would do the job except for
+ * several compressed mode architectures (arm, mips) which set the low bit
+ * to indicate the compressed mode; subtracting two works around that.  It
+ * is also the case that there are no host isas that contain a call insn
+ * smaller than 4 bytes, so we don't worry about special-casing this.
+ */
+#define GETPC_ADJ   2
+
+#endif /* HELPER_GETPC_H */
-- 
2.43.0


