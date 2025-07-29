Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucO-0006u6-8T; Tue, 29 Jul 2025 20:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIn-0004Pu-92
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIl-0004ac-EN
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5675030b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833850; x=1754438650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GrjBl0Kcx4MIhJLsQeiAbiQaN6olXKLDYOGwMaev97Q=;
 b=VSaWPOip9q9zbTzFHS+prcyZWuuIrt1PS7x0YzKbpjHFpxnq63Wl7iAF6VgLUBWPRm
 l7jLsDQ6MSnnBV96Aoox7pdhZNyHao+72fCVKg9k4Hi5CNNZWsVEN8o0DNHZMYDaNVtl
 nSbRTLmo2iIB7BGobgxuegfqH/1/8GR+TrF+TL+ax5C3UOykL2r82axPGLdNOPBIvGsV
 RiNCtGmGJThAdPMuldkomFpeELmSPcaRI3EgqO4QzG4iWOj07JpqfxtOJZb+0pYBtBud
 jQvFZLw0T8jb4jRe4QnM7p5wX26NgE3HNoMPXb6hqgKUrXdkyVRhl3j3MIQm7+JbOWG8
 JupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833850; x=1754438650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrjBl0Kcx4MIhJLsQeiAbiQaN6olXKLDYOGwMaev97Q=;
 b=S5QpIS38PTWwFuKZO8f1AbMRAhBn6calJpsr4V0QEAN3V1ybhxnihA0koRn2uSdcV1
 qsS/tDbLMtaCwYOGphttqGO3aTVEEzDUWCbqa44p3SQzdchMQjrj7bl+TkADtat+Vz/O
 04oYaiiZwzfCDm1FMyZ0vvQEaNMEifdUUd9o7xE1Wukg90Evs70UV0fWLbtBnmWcueWN
 5w9pZwvWu37Jbv7t538OHbuGwZTTz8WqqSWSqg62J7kb9yARGg19mgfSDkTg0nikaxMc
 qYqWE48HBeGDwrw/s4AkyrSTWMICH45RlHnHWHygFZglU2BkNv9BzyPeZigBWsbwTiT5
 pT6A==
X-Gm-Message-State: AOJu0YyHaOb35HSZHzpIF7kFMKHc3Qm9+rpwvTQFKOB+tvhs9WJiIZcH
 zMDig1Voz83X64qZK75KNmi+hE2IpQCc9UvEjovwftOZde+neDmZlyPUp4A42FhFHMkG3X/FW0k
 7WQEK
X-Gm-Gg: ASbGncublKFPYeHylr8S1gRtRNqidwnKWwymuP5p/zScOjiF0iwa2tCwDUlFgxz+eLP
 hWYumeG7O1vyWCu68qOooapfmdt7P2d47hNR53cXgFcdx2JawYJT+dcapewg8c4a+G4XDLxxOVY
 6/3UM5QY9dn3Xzl1mL8jw+j4+cJURZAlDGRdtwXHJZfAzbxVLpzTGvQqYD8IqXvI2/3k/JS7VV3
 nRJT1W3d+UORcGf8Sx37N4fo1mrLz5G2ZOFddEZW69eXB30ORvTBaLiiXXmlbisVdMQS3oKLW9G
 3z2uSpKeyz4PwpPM1wc5o64E4kWQto3gKL05VYUUQHp8EXGOwWK6MEWEjfqtIGzMlP7SKdsC5t2
 IHIglO5ZASaEvJNjKc8+cJamGQUQbIhHJBzWT7Tfm2PivYHfcU/VuwGfvc+pBsNIq4OFWp5MK/P
 xeFxeZZTxLhg==
X-Google-Smtp-Source: AGHT+IGTzCDc2Q6uIuQGOJGTn62AAckmemzic/y+krAOlJEUPKO3maO9TQZr4jzc+/+uYEAYblFt0w==
X-Received: by 2002:a05:6a00:21d5:b0:76a:6b76:3aa4 with SMTP id
 d2e1a72fcca58-76ab333a5a4mr2260873b3a.24.1753833849979; 
 Tue, 29 Jul 2025 17:04:09 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/89] linux-user/arm: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:16 -1000
Message-ID: <20250730000003.599084-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                 | 27 +--------------------------
 linux-user/arm/target_coredump.c.inc | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 26 deletions(-)
 create mode 100644 linux-user/arm/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b315a5a243..b35f35b2a6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -229,32 +229,7 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    18
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
-{
-    (*regs)[0] = tswapreg(env->regs[0]);
-    (*regs)[1] = tswapreg(env->regs[1]);
-    (*regs)[2] = tswapreg(env->regs[2]);
-    (*regs)[3] = tswapreg(env->regs[3]);
-    (*regs)[4] = tswapreg(env->regs[4]);
-    (*regs)[5] = tswapreg(env->regs[5]);
-    (*regs)[6] = tswapreg(env->regs[6]);
-    (*regs)[7] = tswapreg(env->regs[7]);
-    (*regs)[8] = tswapreg(env->regs[8]);
-    (*regs)[9] = tswapreg(env->regs[9]);
-    (*regs)[10] = tswapreg(env->regs[10]);
-    (*regs)[11] = tswapreg(env->regs[11]);
-    (*regs)[12] = tswapreg(env->regs[12]);
-    (*regs)[13] = tswapreg(env->regs[13]);
-    (*regs)[14] = tswapreg(env->regs[14]);
-    (*regs)[15] = tswapreg(env->regs[15]);
-
-    (*regs)[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    (*regs)[17] = tswapreg(env->regs[0]); /* XXX */
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/arm/target_coredump.c.inc b/linux-user/arm/target_coredump.c.inc
new file mode 100644
index 0000000000..e3cb51b145
--- /dev/null
+++ b/linux-user/arm/target_coredump.c.inc
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define ELF_NREG    18
+typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUARMState *env)
+{
+    (*regs)[0] = tswapreg(env->regs[0]);
+    (*regs)[1] = tswapreg(env->regs[1]);
+    (*regs)[2] = tswapreg(env->regs[2]);
+    (*regs)[3] = tswapreg(env->regs[3]);
+    (*regs)[4] = tswapreg(env->regs[4]);
+    (*regs)[5] = tswapreg(env->regs[5]);
+    (*regs)[6] = tswapreg(env->regs[6]);
+    (*regs)[7] = tswapreg(env->regs[7]);
+    (*regs)[8] = tswapreg(env->regs[8]);
+    (*regs)[9] = tswapreg(env->regs[9]);
+    (*regs)[10] = tswapreg(env->regs[10]);
+    (*regs)[11] = tswapreg(env->regs[11]);
+    (*regs)[12] = tswapreg(env->regs[12]);
+    (*regs)[13] = tswapreg(env->regs[13]);
+    (*regs)[14] = tswapreg(env->regs[14]);
+    (*regs)[15] = tswapreg(env->regs[15]);
+
+    (*regs)[16] = tswapreg(cpsr_read((CPUARMState *)env));
+    (*regs)[17] = tswapreg(env->regs[0]); /* XXX */
+}
-- 
2.43.0


