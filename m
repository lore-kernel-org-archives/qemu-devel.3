Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4544AC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugulh-0007r3-W6; Tue, 29 Jul 2025 20:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMb-0006rr-6M
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:10 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMZ-00058y-BU
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso5065708a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834086; x=1754438886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j71IaTtPMXoz6fbGb+M6MA3PKEcR2w4MIFOEVOFwAB0=;
 b=l7E/6kSkMtkGj6BYiADO2nc4+Inuq4/2XrtnfoNKE5b7hQkVNxU95viLyl8IG7Zex/
 stDfh3wJ4LX/h29sqz6CaUBunPXJvrR4u0VDHGZoY994EsjxfT3egej6qgkOeiSZ55z0
 C/nQ0yRziKxPRO/lBlLbR5RAGLpByDsUu98KF9+/qR8Td833KlYkKAIixRp1ynRoyWrm
 iysUvvpWQzjg5y5A3W+Ql+SO6xoIR9K6v3ZagQEGb5bbjINZDb4qJiz+RnWKzUrjI8n/
 ciNuYZILdlesggcTn4KvDfI80qOtrucaDZxZwFHp/xUJUFCguT0j9vDcFh0yebIqqdVZ
 J9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834086; x=1754438886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j71IaTtPMXoz6fbGb+M6MA3PKEcR2w4MIFOEVOFwAB0=;
 b=ki3KLxeB8xVIvNPm92dH7vrI5QLb0gg3zzEVkWK7ogD3o8GLHlxsZk6LcZJURkPzPj
 o+Hb7FKcW/TuuTKw7gIoQHrdS9KAnwpRUvN9mmLIXcuesCd/G6DzLu9OamfVA/aNcG5R
 1RIwWBuXqtuAwc/8JYFb3bf8A293fngoNstHmDElSIqUB17IQcHEk4o0vd1u/NWt0tzN
 hE1Uw3jH5EjigyD/9l7gByk+ED05SKaz/wfCtpQ2Tlit6PdgjtqjjqRODh8OtnDac3oL
 wnltYIwz4h7hCoHt0Ntn9Bwel7jDZdeYJgYwaPtd/y4DZS/yDoZJ/BIxdnrc9yrOWQeq
 ifnQ==
X-Gm-Message-State: AOJu0YzsbdPJvoGZon7UTRpjj6uUj26Ind2hjBr2b2j/ZVsvCPdj2nDn
 xv5cVFYU1IvhVT6BIg0kC/wdTqslO2qRwa7ynQkwtF7wLDeEumjnL7twMsyAlPu/g0uLHzrHQyg
 E9HDQ
X-Gm-Gg: ASbGnctoS7UqkCNN4vROAhp1r8BIhjzUYGzd/JDlZwfEqhP2ARc42su3ivVB5egUtYD
 CkktlkkHesDyRaR+/yCQwAoP8CGg3suyOe63N12IUHyisD+tNv/fw7BbnmCQAZgQ7udo313g0Rj
 pUI2HpqNz+i/C4mCO/8v+Drv+LcXF6ckcqJ+0m7/K3wE5OhGbggaNlzJsC5kRU08p0Xnnn0wcQv
 +ke0DiJH5iI/lQ90+/PDbEtMmaYBPKgrm2wonXxn10l3NNAct1QcPyV3fBXGgCJ6TNPKapzbXU0
 YJaqoaQL+oFBDx3NKP07USxgCZkyQYcYxleIJvQtUuIapkT0TYS2iNn7s5y8xtjK/ewOY90+qwm
 VJfwz2TNl04EpbFd3nK7K8zIImRRN2TG3rPnfdLSRb6wPmhLerKWnhsbkBIEkdVa0yNyFtHrhUb
 j5E/TR5iJliQ==
X-Google-Smtp-Source: AGHT+IEODpb0grAO/RVAJJNADrhHHjwPktJLRY3O6QAkjZiiTLkunFgZdfv2vk0XW6OHCQPsR58mfQ==
X-Received: by 2002:a17:90b:1d05:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-31f5de656edmr1696735a91.31.1753834085786; 
 Tue, 29 Jul 2025 17:08:05 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 86/89] linux-user/microblaze: Move target_pt_regs to signal.c
Date: Tue, 29 Jul 2025 13:59:59 -1000
Message-ID: <20250730000003.599084-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

This structure is part of the microblaze signal frame.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_syscall.h | 44 --------------------------
 linux-user/microblaze/signal.c         | 44 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/linux-user/microblaze/target_syscall.h b/linux-user/microblaze/target_syscall.h
index 43362a1664..66f5a9ebe2 100644
--- a/linux-user/microblaze/target_syscall.h
+++ b/linux-user/microblaze/target_syscall.h
@@ -4,50 +4,6 @@
 #define UNAME_MACHINE "microblaze"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-/* We use microblaze_reg_t to keep things similar to the kernel sources.  */
-typedef uint32_t microblaze_reg_t;
-
-struct target_pt_regs {
-        microblaze_reg_t r0;
-        microblaze_reg_t r1;
-        microblaze_reg_t r2;
-        microblaze_reg_t r3;
-        microblaze_reg_t r4;
-        microblaze_reg_t r5;
-        microblaze_reg_t r6;
-        microblaze_reg_t r7;
-        microblaze_reg_t r8;
-        microblaze_reg_t r9;
-        microblaze_reg_t r10;
-        microblaze_reg_t r11;
-        microblaze_reg_t r12;
-        microblaze_reg_t r13;
-        microblaze_reg_t r14;
-        microblaze_reg_t r15;
-        microblaze_reg_t r16;
-        microblaze_reg_t r17;
-        microblaze_reg_t r18;
-        microblaze_reg_t r19;
-        microblaze_reg_t r20;
-        microblaze_reg_t r21;
-        microblaze_reg_t r22;
-        microblaze_reg_t r23;
-        microblaze_reg_t r24;
-        microblaze_reg_t r25;
-        microblaze_reg_t r26;
-        microblaze_reg_t r27;
-        microblaze_reg_t r28;
-        microblaze_reg_t r29;
-        microblaze_reg_t r30;
-        microblaze_reg_t r31;
-        microblaze_reg_t pc;
-        microblaze_reg_t msr;
-        microblaze_reg_t ear;
-        microblaze_reg_t esr;
-        microblaze_reg_t fsr;
-        uint32_t kernel_mode;
-};
-
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MCL_CURRENT 1
 #define TARGET_MCL_FUTURE  2
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index f6d47d76ff..add814acd6 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -22,6 +22,50 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
+/* We use microblaze_reg_t to keep things similar to the kernel sources.  */
+typedef uint32_t microblaze_reg_t;
+
+struct target_pt_regs {
+    microblaze_reg_t r0;
+    microblaze_reg_t r1;
+    microblaze_reg_t r2;
+    microblaze_reg_t r3;
+    microblaze_reg_t r4;
+    microblaze_reg_t r5;
+    microblaze_reg_t r6;
+    microblaze_reg_t r7;
+    microblaze_reg_t r8;
+    microblaze_reg_t r9;
+    microblaze_reg_t r10;
+    microblaze_reg_t r11;
+    microblaze_reg_t r12;
+    microblaze_reg_t r13;
+    microblaze_reg_t r14;
+    microblaze_reg_t r15;
+    microblaze_reg_t r16;
+    microblaze_reg_t r17;
+    microblaze_reg_t r18;
+    microblaze_reg_t r19;
+    microblaze_reg_t r20;
+    microblaze_reg_t r21;
+    microblaze_reg_t r22;
+    microblaze_reg_t r23;
+    microblaze_reg_t r24;
+    microblaze_reg_t r25;
+    microblaze_reg_t r26;
+    microblaze_reg_t r27;
+    microblaze_reg_t r28;
+    microblaze_reg_t r29;
+    microblaze_reg_t r30;
+    microblaze_reg_t r31;
+    microblaze_reg_t pc;
+    microblaze_reg_t msr;
+    microblaze_reg_t ear;
+    microblaze_reg_t esr;
+    microblaze_reg_t fsr;
+    uint32_t kernel_mode;
+};
+
 struct target_sigcontext {
     struct target_pt_regs regs;  /* needs to be first */
     uint32_t oldmask;
-- 
2.43.0


