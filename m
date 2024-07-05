Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B93BC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl04-0002dj-Fe; Fri, 05 Jul 2024 11:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl00-0002cs-KK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzx-0001Ii-E9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77c9c5d68bso102304166b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193840; x=1720798640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76ccM/rpS4+7b3Bhm1qL0Ddb7vrGKR7l9TAhXh8rp+A=;
 b=kjFNQzVEI8ykmlzOEf+A0Oy/chPrmFq+JvD6+Gc+OB0f1s8S51li9eEqodfNYyNogA
 tFC8Dx/EksX+JpErkm7Jbt5jZ/0fp3wGWJuQjNic72tgcycl8ynqQEr6M9xgfIR4c/xJ
 smF0iy2zxGikR2tvPgl5PbCsRR9SPODP4Ii2idGvXzg+5JokagHxqkI7eAuikiXn//pc
 0Qecbpnqq5xEA9X7Kcvr75/X1CTt56+qRcsywvCdj282mHF+i5bTpdFE3ET8uSR1nI0c
 omNQRCldwdFvCpQF5Qr2I4UmqAVR+lV/CIYhrkNY1H4E/9f/S8fQbMkXNjpwC+vELQ/M
 HKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193840; x=1720798640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76ccM/rpS4+7b3Bhm1qL0Ddb7vrGKR7l9TAhXh8rp+A=;
 b=lzKWrnJI3vSJFr7R6kyfTKwsRQk0teT6AhjCHz3ZlYOPGIga50YJCdvbxnDBRSd+DF
 tJE7Rs1+6yZ/ChBtQrIb4elNC5r62eDbV1397LZT/ezLCEiXtU1v14BDxp8b26ZJyncn
 hKeJ0pBW54gbQRXHfzOjE+BKuj7gT2A6Im4IPJ/djQ6zDwstP+B0mxt52XIgG+aa28Wz
 X6OpKuYphSMF58FuBnWVtQFg38QxH/t524C8czNCEr8ntcdcYD7bpOoQtGUXoxkb7uLJ
 QnPplKzI6Tjdq8DvSL4WNZpbwrrCm23Yqq94R1gY2ZRYE1jk78lz4PwSSMY4jk+Hz4uh
 oLqQ==
X-Gm-Message-State: AOJu0YxSqNxEL+/NEpPkPEP8xe3g3JrovTMnW1ze98iAgEEpDmYHaCh/
 ieCMwZ9iAFXns/ChTZNi4P35wMe02QFVBTXvTkyy2e2E+53v1w2MqFNHZuCWi1I=
X-Google-Smtp-Source: AGHT+IGhxE7tInDQ8kKj6jlkWBZRsDeJKtXZ+VjXhnql4D58J6iWxmk8b5TI+qCHMbN9/W6QZN65ZQ==
X-Received: by 2002:a17:906:2c1a:b0:a77:d773:54ec with SMTP id
 a640c23a62f3a-a77d773565fmr118370966b.8.1720193839763; 
 Fri, 05 Jul 2024 08:37:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d138sm690977466b.158.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4086362170;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 34/40] target/arm: Make some MTE helpers widely available
Date: Fri,  5 Jul 2024 16:30:46 +0100
Message-Id: <20240705153052.1219696-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
available to other subsystems.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240628050850.536447-6-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-35-alex.bennee@linaro.org>

diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
new file mode 100644
index 0000000000..1f471fb69b
--- /dev/null
+++ b/target/arm/tcg/mte_helper.h
@@ -0,0 +1,66 @@
+/*
+ * ARM MemTag operation helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_MTE_H
+#define TARGET_ARM_MTE_H
+
+#include "exec/mmu-access-type.h"
+
+/**
+ * allocation_tag_mem_probe:
+ * @env: the cpu environment
+ * @ptr_mmu_idx: the addressing regime to use for the virtual address
+ * @ptr: the virtual address for which to look up tag memory
+ * @ptr_access: the access to use for the virtual address
+ * @ptr_size: the number of bytes in the normal memory access
+ * @tag_access: the access to use for the tag memory
+ * @probe: true to merely probe, never taking an exception
+ * @ra: the return address for exception handling
+ *
+ * Our tag memory is formatted as a sequence of little-endian nibbles.
+ * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
+ * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
+ * for the higher addr.
+ *
+ * Here, resolve the physical address from the virtual address, and return
+ * a pointer to the corresponding tag byte.
+ *
+ * If there is no tag storage corresponding to @ptr, return NULL.
+ *
+ * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
+ * three options:
+ * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
+ *     accessible, and do not take watchpoint traps. The calling code must
+ *     handle those cases in the right priority compared to MTE traps.
+ * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
+ *     that the page is going to be accessible. We will take watchpoint traps.
+ * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
+ *     traps and watchpoint traps.
+ * (probe = true, ra != 0 is invalid and will assert.)
+ */
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra);
+
+/**
+ * load_tag1 - Load 1 tag (nibble) from byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ */
+int load_tag1(uint64_t ptr, uint8_t *mem);
+
+/**
+ * store_tag1 - Store 1 tag (nibble) into byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ * @tag: The tag to be stored in the nibble
+ */
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
+
+#endif /* TARGET_ARM_MTE_H */
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a50d576294..9d2ba287ee 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,6 +29,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#include "mte_helper.h"
 
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
@@ -50,42 +51,10 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
-/**
- * allocation_tag_mem_probe:
- * @env: the cpu environment
- * @ptr_mmu_idx: the addressing regime to use for the virtual address
- * @ptr: the virtual address for which to look up tag memory
- * @ptr_access: the access to use for the virtual address
- * @ptr_size: the number of bytes in the normal memory access
- * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
- *
- * Our tag memory is formatted as a sequence of little-endian nibbles.
- * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
- * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
- * for the higher addr.
- *
- * Here, resolve the physical address from the virtual address, and return
- * a pointer to the corresponding tag byte.
- *
- * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
- *     that the page is going to be accessible. We will take watchpoint traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
- */
-static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                         uint64_t ptr, MMUAccessType ptr_access,
-                                         int ptr_size, MMUAccessType tag_access,
-                                         bool probe, uintptr_t ra)
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     uint64_t clean_ptr = useronly_clean_ptr(ptr);
@@ -287,7 +256,7 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
     return address_with_allocation_tag(ptr + offset, rtag);
 }
 
-static int load_tag1(uint64_t ptr, uint8_t *mem)
+int load_tag1(uint64_t ptr, uint8_t *mem)
 {
     int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
     return extract32(*mem, ofs, 4);
@@ -321,7 +290,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 }
 
 /* For use in a non-parallel context, store to the given nibble.  */
-static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
 {
     int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
     *mem = deposit32(*mem, ofs, 4, tag);
-- 
2.39.2


