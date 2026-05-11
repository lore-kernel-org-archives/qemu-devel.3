Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF91CD4842
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVy4-0002Lu-70; Mon, 11 May 2026 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxm-0002KI-2W
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:52 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxj-00086k-Ry
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:45 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47bdee5bfc4so3271710b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526403; x=1779131203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNzWFtx4aSEzEdv4w40+EvVQ4L/q5Dh2oDWi/8nPse4=;
 b=nH/VIH8YeoPty0pZDpE96ITYcPug1hwuawAzQ6+KmXIeDnDyJsdIk40bAroWn2aIOU
 Hn074i6U6ovW5GU4QJwMbbSakhBe+iDJr/4q8SQQlU22IoFp8TGxcVv8BJcu+q2lhz6j
 Ht6113RqOcfFYrUGV0T00g6heHveG6A3WDaLl2FrutG7vr5TDUfj6BKWi+ef5hSUpq6S
 tCUqcDto75nDVEpw3kLPd6twnlplpQSz9adVzgOGbK6pa9M8wgBbMNkfHrh7YjQ0VoCc
 0Etkd6LgPK6ErfJEM50Sn4e+z5rKFXIRfztCWvQVr480jdFfDs5k8s8vkzpDHnvqPD1F
 sATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526403; x=1779131203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNzWFtx4aSEzEdv4w40+EvVQ4L/q5Dh2oDWi/8nPse4=;
 b=BsyT2zZt4w58wKVTgoIR6P9pxU8DYYrbaNE1ffF1oyksGUQVtOSb+4XmaxHOXbWNhD
 b8Z1GcL5CKAaIQDnpwLIo+VqjeQKj3J5iEbiiCRcuTBR0W9h6jSpR7X2ctPIvLNCyviA
 Nc5yiAMoYzxJTnWqU0TQSg8MrrXKh1wofUs4LdBZiXLYsiRyKZsRaSLBNFd7+gUVc2qL
 BAdcEePYCgYH5S4svRrFUQfqtkBiTrmaZuXtwUP1/e+oJWOSKrQ3CUUn6OXdjTd0J0mG
 0HauH4g56ZDLMGtiMNG3i8bIIAzTHPoQBeikVbXBW/mIkoZqgcIX1DUimDIb5R77KoTW
 qO1g==
X-Gm-Message-State: AOJu0Yzy/wHqDfI/qOZxPBKh5HgHAt6lDgLBFSfnagur78QDYdNBgFKe
 ytur7+9G9net4H78oR3joS3X1jugjIsRAFJfaQtQjnNaB/MEy1c5c45pvjJemFvjz+7vnTeXHcc
 4zSKG
X-Gm-Gg: Acq92OG/Pjdlv0Tzrc5TRsNvrHO2d9WsgnY6q9rU1CahH99ygJK8hMCwA/qPdb06TS3
 uL78Su+uRFT7RKF2u/gIYZcgeUahnkeE1hNYpvKhKDWZSWVqbUCyo62CcWkJapYF3s3xPxRBE9f
 nmNgBN2C7pScvByuJ0hgw8prl8moi4fzSd2/CGxHeY6BzuX0r9HIU1B8aGKXhDAdOyOVUpzato8
 S5D+iwaMb0jn+ArekWpjY5HI31YmBZm7zFOLEt/OJ0G/+4WPjVN3JthcLLxfjj0DTmv8VkZPfWm
 9rrrIhysnIZNtBHnVPefL8tzB4jrA9Ll3/y9JE+XW8ggYDnjYhw3YexU3KILwR56Sr9U5LEytbK
 xkZ9VaYza/uyntTvIqZ1vT0WTlrs+pjdKX7db91E1dUOcRUypZb7U/Z4ZePRLmz7TulknAiRJuI
 ORAITA/zOWftcL5s7DFzYMlnFDUzlZuNSIjO6oaakvM/x2Lg==
X-Received: by 2002:a05:6808:2203:b0:479:daee:1084 with SMTP id
 5614622812f47-482937d8b23mr487835b6e.0.1778526402590; 
 Mon, 11 May 2026 12:06:42 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 5/5] target-info: Inline accessors
Date: Mon, 11 May 2026 14:06:34 -0500
Message-ID: <20260511190634.472174-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
References: <20260511190634.472174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Move the entire contents of target-info.c into target-info.h,
marking each function inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info.h | 82 +++++++++++++++++++++++++++------
 target-info.c              | 93 --------------------------------------
 meson.build                |  1 -
 3 files changed, 68 insertions(+), 108 deletions(-)
 delete mode 100644 target-info.c

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index d8d2194d9b..2c9f5c78fb 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -45,14 +45,20 @@ TargetInfo target_info;
  *
  * Returns: Canonical target name (i.e. "i386").
  */
-const char *target_name(void);
+static inline const char *target_name(void)
+{
+    return target_info.target_name;
+}
 
 /**
  * target_long_bits:
  *
  * Returns: number of bits in a long type for this target (i.e. 64).
  */
-unsigned target_long_bits(void);
+static inline unsigned target_long_bits(void)
+{
+    return target_info.long_bits;
+}
 
 /**
  * target_machine_typename:
@@ -60,21 +66,30 @@ unsigned target_long_bits(void);
  * Returns: Name of the QOM interface implemented by machines
  *          usable on this target binary.
  */
-const char *target_machine_typename(void);
+static inline const char *target_machine_typename(void)
+{
+    return target_info.machine_typename;
+}
 
 /**
  * target_cpu_type:
  *
  * Returns: target CPU base QOM type name (i.e. TYPE_X86_CPU).
  */
-const char *target_cpu_type(void);
+static inline const char *target_cpu_type(void)
+{
+    return target_info.cpu_type;
+}
 
 /**
  * target_endian_mode:
  *
  * Returns: QAPI EndianMode enum (e.g. ENDIAN_MODE_LITTLE).
  */
-EndianMode target_endian_mode(void);
+static inline EndianMode target_endian_mode(void)
+{
+    return target_info.endianness;
+}
 
 /**
  * target_big_endian:
@@ -86,62 +101,101 @@ EndianMode target_endian_mode(void);
  * the target, so please do *not* use this function unless you  know very
  * well what you are doing!
  */
-bool target_big_endian(void);
+static inline bool target_big_endian(void)
+{
+    return target_endian_mode() == ENDIAN_MODE_BIG;
+}
 
 /**
  * target_arch:
  *
  * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
  */
-SysEmuTarget target_arch(void);
+static inline SysEmuTarget target_arch(void)
+{
+    return target_info.target_arch;
+}
 
 /**
  * target_base_arm:
  *
  * Returns whether the target architecture is ARM or Aarch64.
  */
-bool target_base_arm(void);
+static inline bool target_base_arm(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        return true;
+    default:
+        return false;
+    }
+}
 
 /**
  * target_arm:
  *
  * Returns whether the target architecture is ARM (32-bit, not Aarch64).
  */
-bool target_arm(void);
+static inline bool target_arm(void)
+{
+    return target_arch() == SYS_EMU_TARGET_ARM;
+}
 
 /**
  * target_aarch64:
  *
  * Returns whether the target architecture is Aarch64.
  */
-bool target_aarch64(void);
+static inline bool target_aarch64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_AARCH64;
+}
 
 /**
  * target_base_ppc:
  *
  * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
  */
-bool target_base_ppc(void);
+static inline bool target_base_ppc(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return true;
+    default:
+        return false;
+    }
+}
 
 /**
  * target_ppc:
  *
  * Returns whether the target architecture is PowerPC 32-bit.
  */
-bool target_ppc(void);
+static inline bool target_ppc(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC;
+}
 
 /**
  * target_ppc64:
  *
  * Returns whether the target architecture is PowerPC 64-bit.
  */
-bool target_ppc64(void);
+static inline bool target_ppc64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC64;
+}
 
 /**
  * target_s390x:
  *
  * Returns whether the target architecture is S390x.
  */
-bool target_s390x(void);
+static inline bool target_s390x(void)
+{
+    return target_arch() == SYS_EMU_TARGET_S390X;
+}
 
 #endif
diff --git a/target-info.c b/target-info.c
deleted file mode 100644
index f02a033584..0000000000
--- a/target-info.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * QEMU target info helpers
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info.h"
-#include "qapi/error.h"
-
-const char *target_name(void)
-{
-    return target_info.target_name;
-}
-
-unsigned target_long_bits(void)
-{
-    return target_info.long_bits;
-}
-
-SysEmuTarget target_arch(void)
-{
-    return target_info.target_arch;
-}
-
-const char *target_cpu_type(void)
-{
-    return target_info.cpu_type;
-}
-
-const char *target_machine_typename(void)
-{
-    return target_info.machine_typename;
-}
-
-EndianMode target_endian_mode(void)
-{
-    return target_info.endianness;
-}
-
-bool target_big_endian(void)
-{
-    return target_endian_mode() == ENDIAN_MODE_BIG;
-}
-
-bool target_base_arm(void)
-{
-    switch (target_arch()) {
-    case SYS_EMU_TARGET_ARM:
-    case SYS_EMU_TARGET_AARCH64:
-        return true;
-    default:
-        return false;
-    }
-}
-
-bool target_arm(void)
-{
-    return target_arch() == SYS_EMU_TARGET_ARM;
-}
-
-bool target_aarch64(void)
-{
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
-}
-
-bool target_base_ppc(void)
-{
-    switch (target_arch()) {
-    case SYS_EMU_TARGET_PPC:
-    case SYS_EMU_TARGET_PPC64:
-        return true;
-    default:
-        return false;
-    }
-}
-
-bool target_ppc(void)
-{
-    return target_arch() == SYS_EMU_TARGET_PPC;
-}
-
-bool target_ppc64(void)
-{
-    return target_arch() == SYS_EMU_TARGET_PPC64;
-}
-
-bool target_s390x(void)
-{
-    return target_arch() == SYS_EMU_TARGET_S390X;
-}
diff --git a/meson.build b/meson.build
index 9a804dc810..aad149cdb4 100644
--- a/meson.build
+++ b/meson.build
@@ -3868,7 +3868,6 @@ endif
 common_ss.add(pagevary)
 system_ss.add(files('page-vary-system.c'))
 
-common_ss.add(files('target-info.c'))
 system_ss.add(tinfoqom)
 
 subdir('backends')
-- 
2.43.0


