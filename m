Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1CCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbv-0004vx-5o; Mon, 22 Sep 2025 14:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbt-0004ty-J0
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbk-0004A7-78
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f35113821so1180468b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566991; x=1759171791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=jxjgyxTrxi4ch6+y574d+D88YSrJ10r2OJ5Nzd0PGlAi9bMVnNnYRwlMhNWdkAwric
 MbXxUw5HK2eBZswLI00V8gxTk+bfnn03PDUkavqo4maZ7kdAarmSbHD2aNq3xsB8aYTA
 QfuD2ubE0gYputbqXYOdZ7uouzuXsQkLCGMhWFFv4DKSIlDOQmiSuLtzTr7HMF0soyVT
 DDNt8goewOeZ+EB1dY+I7rNIfLiytdub+fxeSSdW8HcNe3ZbIvqLIl1WZtygwZswvu5u
 000BrU70VfeEO8NQKvbMizBd2hjrPiBp4UT/KJ+SmK3xs24Qggc1EPx2MAj57Qg6BK4V
 xwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566991; x=1759171791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=gHH+1B6J5algT2v9FLn1TcSD6V3GvRur4G/6uxL7PpPh7c5p2UnMEC5BXGnWWCBwNN
 Bcjy+Bsljaohj0hNgjNndiBUUZd2yo9CTY66Q3yExmCJptUqxk9eM7uXgebem/UenGMe
 yyBd1pCVdq2TD3OvAmr8zwHSbZuHE3hI8KLAYzQecMy1U2xwbNJQ4aiY2pUuvujr2owD
 jjzNbOWF5Yt3UFq51FZcSvPXIgq0HFRCvLi7mmCRLfKORvxPIXIoHJIdXKyB0mVHcCJ6
 Z4uszGLkN+qMSpUlkeKKBvAAsEg78jlwze/kznRsoOAq215OdgTDjY6qKIOcFkewpb6x
 GtNg==
X-Gm-Message-State: AOJu0YzwHB70l9KMqMbX8hh40FADKf/kO3RIPbcjMq/KrRykLI+yprse
 84FL6eQ7AKP5nj+aiT+j5rfwtPnQc3KjLvn6boS/+3XEWpKUT7+LzAVbeknSBNvuVWMOIKPOrs7
 HnjEU
X-Gm-Gg: ASbGncthJePZXqx4da1T5GJ5/KnsbCQMZTe0Ed1gMtGIYz1FF9fefdy95WmHj3lpPkw
 RqlC/RWtiR3r3b8H3GcgeF+WqOkR0ISKj7D8gjnwYOXWD1tHzYMBOKq20aUT8IHty0PZd4anZhR
 RY1nF4SME2/geW+2MG7tcMFiAWIx6mzqdGvcdVeXUCFOYON+Q3td4PZdtUCfOSIbv3tkI1zCp8g
 VPmg0huIzjfbCo7FQx+nseUnFlMrKse63bL6Jw46fKjFTQwlEGcho4ZXUZWG3MZFQNKmNrEKQvW
 ByDD31CAv+YecW9YsD4ywl+aohP3yYr4mKshaz2SwthfIqEsntctKzq/hvsLpFOq3Lwd81JoRu0
 zoN+lky8W/7YYZVi/pEuXDEMKzz8U
X-Google-Smtp-Source: AGHT+IELIj2e2AE/JlVor0L3U7eO0NDK4nbbxGLgfDon/xopz74lgCyuM74OCjNG/KHQNt70PFmhNw==
X-Received: by 2002:a05:6a00:330f:b0:77e:74d8:c6e5 with SMTP id
 d2e1a72fcca58-77e74d8dda0mr14025097b3a.15.1758566990678; 
 Mon, 22 Sep 2025 11:49:50 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 17/76] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Mon, 22 Sep 2025 11:48:25 -0700
Message-ID: <20250922184924.2754205-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


