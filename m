Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD96C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6g-0007lg-7v; Sat, 15 Feb 2025 19:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6A-0007cy-IO
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:32 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS66-0006GW-Fh
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2211cd4463cso3736385ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664080; x=1740268880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0w1nAz3ZZyz0kW9yi4rO7ndLN0hIyYSz6AGDjBaQFXE=;
 b=KnUO7jbnh3ce3SMoQOsCx7SN/GLcSf2AXR5EzPLLvfYMcnu0tNyAd2HTl9oAx1YAPD
 CZLU3vtz31bdWlZCnWqRPsDzRuH1kkaPvjJdK7brxLghnJ0cGubmsIHAwhvLNaKsKFNC
 XgBzGB84yJnlhwnAGJKWyQBnZaalECf1HrGXgKOtZ8DYHOzc7IK0/mTSl3uh0lGliXlM
 fpWScWJv9yPZgoK0R2wBA8eTbu4AGsK4yx6ybtFxlyMQPaFirRJqXNUCybI052HkrcDz
 HrbvTAcwKDghgNu2gG2wJrvIO/y4i3BvI+44W/FelrZ+nmj8S5uU/suK/n7hClXBgi05
 qvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664080; x=1740268880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0w1nAz3ZZyz0kW9yi4rO7ndLN0hIyYSz6AGDjBaQFXE=;
 b=cHgtduWnElUlGsrVXlqKaaZzo+fqj6YkDUtV5PiDbSxGGMrkvJAHZXnygFGbSfS8E0
 1Pvl9nKFRAK3yTXNGyrW8bH8UKL0jb3vA5El3ta1YNYdp4WquPDqAen3V/cmH+vOmkvz
 1AKyKv9ahWBLk1p+d8ybtJGR4+E1sbHVupD6G+3o0chZui4fTypKK9CeHuGJl9/mMIBC
 2YdZiYLLVFAgU8mpYyvPXyGQyM1gXxkb06eP+eF6KkC0moxUr8bLnEe66gFIeCpMW3j+
 UQjtX9heKap7mJ53dIXvqFCZMb6d0Fu32jYlzJTtyqKciJas7FaVjHXOLu35YlxORTlb
 ArGg==
X-Gm-Message-State: AOJu0YzzR1QnzVBSs+Uud7EqevhBYHwFQo01wNpuKiz06gl0zhB+P97O
 ecXRYlkfJiMDC5Ep3s0mZdgEIPxqLWysz5kR7HIInRmrVRMUep0kbLGDf8ZsdzzuywsY1SwbWVl
 B
X-Gm-Gg: ASbGncss3hcH8yMWNB68UV0U/gofQDc/0JsEw/OI914FJWqeOJ9D3YRe7WAindyLCOo
 P7PpmXqD0ZTER5LIGQIK1WO6bt6dIc8jCrOtndOSjaGLN5adF5gTKie2QNSGtzZVLiPN2fRlv8m
 U7vXC5kenBlEiatwJkhS/l4/CMhyzFH10DTKxwd2BRh99vVqDIx9dQHEfbmdWRVLiB5BX83uIsd
 IAkBpQ5YH5V1WWvXpy/VWiSbE9TOZXKdM9zw7yfF2QjEqWXXKo6mxxah4VDngWrZmZpPmndzcKF
 XIMPswzEPA+9VKMe0tpsnqPqsAUeflLU+7R6GXhZ9uCIzQE=
X-Google-Smtp-Source: AGHT+IFsTf64zQOmuyjY6EZGX0Whxgdtq4nhSgC6vF2T1Q/C3TCiYu6fIuGdUdEcW19O2vqVPuERtw==
X-Received: by 2002:a17:903:22c7:b0:215:5a53:edee with SMTP id
 d9443c01a7336-221040136afmr69580765ad.9.1739664080111; 
 Sat, 15 Feb 2025 16:01:20 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/24] include/exec: Change vaddr to uintptr_t
Date: Sat, 15 Feb 2025 16:00:56 -0800
Message-ID: <20250216000109.2606518-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Since we no longer support 64-bit guests on 32-bit hosts,
we can use a 32-bit type on a 32-bit host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/vaddr.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
index b9844afc77..28bec632fb 100644
--- a/include/exec/vaddr.h
+++ b/include/exec/vaddr.h
@@ -6,13 +6,15 @@
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
+ * We do not support 64-bit guest on 32-host and detect at configure time.
+ * Therefore, a host pointer width will always fit a guest pointer.
  */
-typedef uint64_t vaddr;
-#define VADDR_PRId PRId64
-#define VADDR_PRIu PRIu64
-#define VADDR_PRIo PRIo64
-#define VADDR_PRIx PRIx64
-#define VADDR_PRIX PRIX64
-#define VADDR_MAX UINT64_MAX
+typedef uintptr_t vaddr;
+#define VADDR_PRId PRIdPTR
+#define VADDR_PRIu PRIuPTR
+#define VADDR_PRIo PRIoPTR
+#define VADDR_PRIx PRIxPTR
+#define VADDR_PRIX PRIXPTR
+#define VADDR_MAX UINTPTR_MAX
 
 #endif
-- 
2.43.0


