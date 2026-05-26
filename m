Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E0CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtXh-0002K4-VZ; Tue, 26 May 2026 11:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXg-0002JB-Gv
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXd-0007UR-W6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ed9336049so541450f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779808680; x=1780413480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ce62S3udliLiLQHSuUUmSL5npolTfaaGB+C/mMt/HY0=;
 b=zGGikwuZBMGLtuGv1w0FPac6CeKDTIYYdrz/tS17XSH+z05EJkBYRM0HdmqFRfLD7V
 SssNX2W1Qq1xhj5O94mcZftWmwngvrHDPWMzSsag7hMROXWpEai8lF9xxH7CTE4Z7yBe
 f3lPd8VvS1Zw8fhyWIQu9FRvYzSLbuDOId6N+sWGWYAKP4CLOiQU3LIeCxhf38xTX3Da
 gFupDVO6RUU8CdKwo+JVH0DTAA1G4KNkNWf4XJQz/noPJVSkUwXlopsYGGmETTCbSsex
 vdKf2K51BapMMH1kQePPLTwzerKTSIts7Tx7jLnI7WBIxSp10FwoSq6MSOWaJEqFSKhY
 j4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779808680; x=1780413480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ce62S3udliLiLQHSuUUmSL5npolTfaaGB+C/mMt/HY0=;
 b=Dw0LJazpZkOc5RTudFxNEJdECypR8LbJx79Su0YslC0s7ih2tHM9a+RBrUvaAWls6t
 KCOYB24v7iNz28nmirrGLhtI8sYiJzdsKg9riTdTrLzgU2XsvwHuc9Z5pg5bfaW/TLFT
 G97xMzC1rhA96ZLS1oUc0wGGt5cbsgbVDITbm/vliZGVq+qUmyp9WgB3dRX/+7YGd2bP
 Uz9uBnMOwJInSxOyXuWUypSG0Ke5znG+jZfzdvYNbckZFepmO74pSGPlYG6jP2hF8rMS
 eR1in/vvVv5BUKnojlULUjEu4BIFrXflv1wF4xe79kH558AK9MP1EpAkv2EeEur+ErrL
 60ZQ==
X-Gm-Message-State: AOJu0YzpU5MCAOMQWBr9L0QB/VRZU8pLZ6udodtwcqJoDs4uSWjuxlIO
 dfysssOyCkw2k/rAzo/CR56Zxv2WOYd/M3NxRgSSKh5FIPZTa0SZR3XlHR6M/tiPhmgwlzeUBR9
 5PT/S
X-Gm-Gg: Acq92OHrfzQJOnmtvXJA9RKT1gIYklo+ekHidXZlZsCPAQ4nBFlaBKdRGhwhNptruv1
 8IGOqNVkC70OI7xoHWLmMga2npdUGl6Dh0ajqJAhKEP/l3DWpcNjHFaETSD8hRjouflHQJ6HUuy
 9htygRuThFMhdRKQh+pNKvRcfWTkbJOtgpg3a/Uv4eHWLnCuVuFstmoxL09QktYrKV7HN0ACzUC
 dAnI7pq8jwGXbrxu5cQk0lxXyu84CHcNBqjnq7iSDTP4UlGn8a/U6OFCcuFLGPE2zNv2gS53DMX
 x4XOY3uVx0l0YCB4VROc/yjt6DRwZ1xqUItug0GTC2M/la6etGKY/3iArDtcI3W746dDtI3bLsi
 CvkcueTlYnimtCzJPyffP2fw78Ohy7ym5tDP1/91RrNXOWj7IfM6mhS2HMpfVhcP7zdB5cbgCAL
 9XahcTzVDLA01+ojNqA5grnvewuJIRSjFxUcbp+BrHqXKuFurpeEjjijVeBxjbF4Un6+EjLuw6L
 SMcdCHwKOUHTBfGWee6IObIZaBTSZ2y2tNBKSCFgHtqL/aTI2Cg
X-Received: by 2002:a05:600c:4592:b0:490:6237:5212 with SMTP id
 5b1f17b1804b1-4906237533fmr147168715e9.9.1779808680219; 
 Tue, 26 May 2026 08:18:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042ce923asm111485275e9.35.2026.05.26.08.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:17:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] linux-user: Move init_main_thread() prototype to
 user-internals.h
Date: Tue, 26 May 2026 16:17:56 +0100
Message-ID: <20260526151757.2371476-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526151757.2371476-1-peter.maydell@linaro.org>
References: <20260526151757.2371476-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The init_main_thread() prototype is needed only by code internal to
linux-user/, so it doesn't need to be in qemu.h (which is also pulled
in by various files outside linux-user/).

Move the prototype to user-internals.h, and give it a documentation
comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/qemu.h           |  2 --
 linux-user/user-internals.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 7f98fb2607..474489f046 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -371,6 +371,4 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
-void init_main_thread(CPUState *cs, struct image_info *info);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 21daf422b7..fbfd12237f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -194,6 +194,21 @@ static inline void begin_parallel_context(CPUState *cs)
     }
 }
 
+/**
+ * init_main_thread: Set CPU state for main thread
+ * @cs: CPU context to set
+ * @info: information about the image being loaded
+ *
+ * This function must be provided by the per-target code. It should
+ * set the initial CPU state based on the information about the
+ * starting binary in @image_info. This will be at a minimum setting
+ * the initial guest program counter and stack pointer; it should
+ * also set up any other guest register values where the Linux ABI
+ * defines that they start set to some other value than what the
+ * guest CPU architecture gives you out of reset.
+ */
+void init_main_thread(CPUState *cs, struct image_info *info);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
-- 
2.43.0


