Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CBFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNva-0005Wq-73; Sat, 30 Aug 2025 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMe-0006Bv-R6
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMd-0004Ip-CI
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4cf40cd0d1so1186770a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532578; x=1757137378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=Gwb+cN7v29ZIpDaMEiAxE7mvYw0kEP+sKHgQjl7s3WWptbv4Ok1n+CuC4/vVJmjY4l
 vG93ThrvnIFtoNARNTJLv0NjKadjjIRoYt3wpEvu91cu4VfBTUpehhFilkoH8SmAMl7U
 JKVwTL2jXoAlzRhtQF0vtT3cFW9rZ/0Fxj0LagZIwV7sHwdDa9MFyqwugf9T53+43dhG
 iCYIMw11wvgP/rPhvDGy9sfSNt2/I7wxAO7go349e5Pxhg4AVu0FDoCYBhxjLHDUQHWY
 tq4I+5DuXM4xXRxEnICyla6aLZTFGYFqac6JDb7pmXlxr+bl86C4JvH7UWFG1yEb78H9
 sd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532578; x=1757137378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=dHfoqX9huG8NygEAY0A0Vu6wc3/z9nJ8S8m1P16TNwsV3HicuoeoXRKuSOwHn5d2ZZ
 M0KKBsqb/nioe3xT0i/fHW6uCPJSBMDD8OmXQADKjHBXQV7vD5lAjXMUrjRKooEUiFCD
 MrvAY5mTPUIQkgXQFwAmFRSEdwpSdTfZln7a9IyYx1RnW9GE75IXS/6rGpAJKZVpm4R1
 qwyrQQsT8Zjh4KbWEvtt+v+WgBWtLxEIxhd5yIpvhuWR2jTXZaO18+RMM+xL1DSTlPYi
 WY+ORKeY2+7MxbgmKYY+rsJjsQEXZRZnpMZJkKGLCuhEQR6fd/RZcBx6L9pc16kF3c50
 17qw==
X-Gm-Message-State: AOJu0YwyMPUsUt0M3HTlORRFk8ToJhJu8oHplVEXU8LA7NKYr71nvWRM
 km9wYicHa9OOM8GAEd498itCsAfv/WkZuDVVpfVmiGmR/xDJzsbov0zo2Z0gpnHehi9o06GhPCe
 NnSYhEFY=
X-Gm-Gg: ASbGncvyx4jB5JHKqUgSM5YBP+st41Pv9W+WF5ZeBUMv0S02gBZrDhwaoNs5LiWVvJe
 J74CoSkAvHoI2Uv/bJtr4yKQLYiVewfD0fz/VOzOW0mZ/b+r0y/vWVE65gd+VTqn7z/ZMlAGIz1
 wdh4W2VnE7ubLedWIRVEnKOtQ9HRenWLfoZvsFkacGOtjbMLj7cEyTbIq9SPVWNELUs1tUDGVwr
 N8b4ilpgfWZokK8vO6FLxbfXl8DNecgOD12T30ng+HsJvfep06mWO3/wFDjEEjlL0a8duTahEyC
 kEktz3oCwc/lKMdNma4mJr0M9NrlCnQAgClsSVVZp+CP6enQNXclI7Q00HrvB78G6ew1Yz2w8Bl
 6cXyY9QoZ64hQjmzacWes3P+9MJycFI2Nem2KPaXwNk5fdnVs82IligP9mNi8FNM5AsRUp0I=
X-Google-Smtp-Source: AGHT+IFRoMIMA/fa3Wp8hcRs4bRrRir2Nsz/n+9i9sQEJyNXT3pA2BDwk4dQjmWsBNvDGPoAysUQ6w==
X-Received: by 2002:a17:90b:4d0f:b0:327:ac8c:10af with SMTP id
 98e67ed59e1d1-32815704c28mr1499179a91.36.1756532578065; 
 Fri, 29 Aug 2025 22:42:58 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 30/84] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Sat, 30 Aug 2025 15:40:34 +1000
Message-ID: <20250830054128.448363-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


