Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A24C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTc-0005e7-A0; Sat, 02 Aug 2025 19:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTC-0004MW-6z
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:17:01 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLT9-0002gG-0u
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:52 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741a905439eso349445a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176609; x=1754781409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+uIoBLSh9jKC7ksgBHFT2TiR1g9EIjfFhvri+e9kKk=;
 b=vm8AletqdHNqqWpdUKmgsk4YOoYjdvIgxYRYih5DI3xOVVH/sHEa2qgSXxlMivsPo1
 2KODXUgcVl3nYiiCQ6EAoaH08kJ6AZUx0bN+T8qE3Wrs+gKOz44oxKVjjwxI4RLKWn4Y
 2S3vVLJPEIKDzNAZvuPd/xE4u3MAULt/BGJw5K8FjncSsMY5HFBDAacZzhTKh3EJuTUH
 4znBwtYbCgSvFsw8udWbjirm2kfRSILSfJr4TE3m76D+rmpYFNiPSHPeSFke2ghx5n3u
 9cL6HHGAMEJ+NGVkzf40XH5gX4KJnH+5fGEHrYHApLMaNMX1OiWjtEGJftwVumN3suWQ
 4j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176609; x=1754781409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+uIoBLSh9jKC7ksgBHFT2TiR1g9EIjfFhvri+e9kKk=;
 b=QxREednyNh9EA082FA1lJB+ZOF6cgvW7D2JOlTL6soayrPbelBTWyN5+cGDylAMYYm
 pvHTGm8fk2azJZLV1kU3+TJIF+7dVSpQcjvQb2bZRY4eHZCaRvuN8INEa4Ipc7s0iUmb
 lKI6luwMcIh7TGDhASVYcy1yy5dKuZHha6gSGUvTffI694csdvVMxVpDpkJxTEFkCqzm
 j63ik0pnc4PhDvYceISdE1PR2ddFlM1H7SrFV6xQXVNwOga69bvsuMCmS+f1vF7Bwl5+
 KExXt6f+9eUe1cZd6seAJ3t0e8NNgFUXxiguMPTCFfBf5YdrC2MQN3UIEnCaZMoCTdnI
 0SiA==
X-Gm-Message-State: AOJu0YwrwbUny6C5y37sOv+H0tmrDJuH54mZvVi8qfbvh63BB2rvyEwK
 fQTyrqzweBd1Wwik/mdfEVjnljnSzeWp8LqinpJoDA9nsv0aX1MOJv6lI8SCf7WrednTYJv07KA
 XzXIab/k=
X-Gm-Gg: ASbGncvN1bKCYIMWWWgYu50lh/6y57WtfXocOWjfnqSv8eBrWf1IhdnhwH/S20Ea3rD
 rjUBfnZOIYftejzktVMEejFJItlQd78p5b4ME/kEL7NROcp3W51snMkUA5DKwlGLz81pta0dwyM
 p9rkpF/miUMJizInAaTMJxqOGiMJ+AieLrlQZJQ93vGws0QqdyRAxiPCrPbuZ6nOmwBaLGjuwnj
 2ygb31uvi6ZKPbjMVVSnt2aMriaAnKkDlsQfLRtvaD3xUY1P7vkIEUhMMEhBLq/VZ/r1Wez/Mp8
 vKFW8rdwGJEs6qw63tmRIYqjH+LUnlyVlqYKlCDfLzoh5q7z61nXUf1/yPfMU2kDwSd8GmiTRvk
 fJrbE7jEAzkvElCiDd95c05w/T02Q+AXhejKx0jsJqizOcoHe71cB
X-Google-Smtp-Source: AGHT+IFYgfT4pm04bB+60xh2IruKdEWuQeyH6HIm8YKJB0FwLUWHJ+kT6zdrv25XElpAY+6S2S08gw==
X-Received: by 2002:a05:6830:4112:b0:73e:a0fd:ac73 with SMTP id
 46e09a7af769-7419d27d151mr2304586a34.14.1754176609206; 
 Sat, 02 Aug 2025 16:16:49 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 92/95] linux-user/microblaze: Move target_pt_regs to
 signal.c
Date: Sun,  3 Aug 2025 09:04:56 +1000
Message-ID: <20250802230459.412251-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


