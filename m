Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122ACC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRU-0002AJ-9Y; Tue, 22 Apr 2025 15:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP1-0005B3-DK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOy-00074f-Ho
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so63588525ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350526; x=1745955326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uk2ZrawXZYiOMoISYC3G3yGzQ++x7vjYflwSfXkzRVo=;
 b=ALi5vwPqYr3cHuZKemP9+QGASB/90ShuMYUGXn2YswkM2FPoo1z2z2fw71pXGPlzza
 Wd4BuFQrsKTuDKES78x3jrI0zq6vEDrtvpmn2qc+CinKikgjny7wySoFWzakMoV7mAWp
 KQBplEl0BybX8PeoR7mPwIuid8pdUYxgV5CC2fA5xLuXoMVbNw3lzGw5d8YinIUriS84
 BrDCR8rJY+sVw4zFbxxCD0aWXVKCthkxraOqy94leW4P8I850BGD3vOo3/mZu+oaqUOZ
 m5R1YJV7ehzS7hI4ewPfewacvqox82Ijf6w0LloVF8Q5DgGO577rZtsMl/rlJs8654TW
 rkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350526; x=1745955326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uk2ZrawXZYiOMoISYC3G3yGzQ++x7vjYflwSfXkzRVo=;
 b=LqW9PbTq5++8vOwOQfvqsQOJxWOCO5FKlT9nCYAKIPq33PuhADxoD7+wVm+e8JtyHq
 leGN2ZJkjAzXBKWk+u5pz3CkHzcELHZ74YUjLxTWylngBL0SudcCjNwc+14bPnzmw4mZ
 cakYPh793AUYAQQGyMIgNUQZBZb+Dlm+RBnNL3IdYMo+euS2dZlmG+Nf8ZLG8JTgItCP
 +7d5km+8OEka0Luau17FgYlonYC09X26fCOI0kv7dpbFmeggO2zzx3329+aAus5xjJYn
 fn4mHn7h42x6KJjYd7OUdtp8zbnP+3WrcJp6Ui2fBM8DZn/Aju9bKMRy+CN9zx4IQlZV
 qbzQ==
X-Gm-Message-State: AOJu0YwtIewePReSkCjJ10WS70QqqJoGQqXblsUMWqatH/AFD8VWO876
 suxQp9lxxTaFiVmLFRHd/5asRL+athwp5cBW5QmyjEX0ik5Z5ukW3TncUz/SKINDC0Thkm037FP
 b
X-Gm-Gg: ASbGncuA4r5xM0W+wXXW4NkWL4vR+hH0aej9Rr7+MycYFUFw/bPSLrPpmJLKL6mOxJ4
 jYRKA7q44QnWqLVSZVvyLcyVbLoKOBnQzA3Xch9kwjQqcG6woyxUIVJyKQaQkYZ6uik2y4y10P0
 itO7oyJcZVJKHzqSHfhtySeWhmwiDbXuKFrLboe7HAJ2Upi1fPTqMG/uP7LimE6+p9j6a3kJe/i
 GJWAvDQiUm/1n5CvRaE1PB7Iuo6SUt9+K3yLr6+bRYEAe67szFGFqCWVZtecJeuaztl6ClgRnZN
 UDVZ6EiNH3XBYNwYEYiLePvhnYPI6pxH2fhlLbF1utKoK8C9qbR3ZED0cxHPdgkNsIoTxvniAsU
 =
X-Google-Smtp-Source: AGHT+IH7WMAJRlPRMEw/0aNBxQE02SPMnBWKDXOONk2f7iOo9BnqdHywyjXGKM4UGS4n54APAsk2Hg==
X-Received: by 2002:a17:903:947:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22c5360c7admr276939285ad.38.1745350526622; 
 Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 101/147] exec/cpu-all: move cpu_copy to linux-user/qemu.h
Date: Tue, 22 Apr 2025 12:27:30 -0700
Message-ID: <20250422192819.302784-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-3-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 linux-user/qemu.h      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5c4379f0d0..2aaaf0548d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -31,8 +31,6 @@
 #endif
 
 
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f00750151..948de8431a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 #endif /* QEMU_H */
-- 
2.43.0


