Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4660FCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpE-0006EV-Uy; Fri, 10 Oct 2025 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp6-0006Ap-Cv
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coi-0003qE-RZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so20234665e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101547; x=1760706347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=enwh1J6egv9t5DFR/y6StdYupePvfYrOAyg7vK7uziQ=;
 b=Rl9KuDnSq5bkZmN3iNUDiH8lixZW0pLwGIZpRVkQYh5jC9C5g/pTN6bvJpoZG3AIOT
 cRL1RHTBmnw6tfESMhADR9CO2LYRVhFVHXFeo9w5E7DsI5ylB/e8rvW0EHhMH6c6DWxJ
 ePnn9/Ptvv85n8Pc1qSubIJ1T1KORiUwXjvgT4uJGeDpPvmc01wMenEUZvLRgkFKgzFs
 jk0FwxYdLbq2V8EavaV6jueSHhcq6mZu3JmeKxhUwrL/+Zi3TnZRPpFKmwCsBXkLAfk9
 r2QK/+2BoGdd/Kz7bbO+sss3+t+wGbRN4jBVdCxXtBSSAKpFjagiEl3XIk2yLxWj9IDV
 z1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101547; x=1760706347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enwh1J6egv9t5DFR/y6StdYupePvfYrOAyg7vK7uziQ=;
 b=PsF9ut7NMPIHC7Qw8uDOx/OhJpVoA9jl3Y+kQ4Du/PdyVwD7pPrc38A7yvbhGzYId5
 K4jOx1dfmb+LRh2UWphI5MHXZ8LPWrKFTKpXn5+aRKyKjSsLsXoojmMPOcFXR1pMgHmG
 Us2qbx/A1l1VELhxOu9KtHPS+ynG/BXevinZUIV7Ka+1mSW+FxAKp1WeIi1p7YmyOLZF
 GCuYHTGmVRPG6ZDQWmS9CQSpBRZsOzFauWN7coC2HJO4RI7ifwWqF2w1bSqOueG5L3XH
 KN65gKgq38iRmuPuQcLVejWdDCC7BP+Is348Asyg0GwoOk1sL0t8axi+GgbX0j/48xB4
 T/Jw==
X-Gm-Message-State: AOJu0YzuZGfb/4qneBcJlfxcmAEBPKETh8BjgbDjtBfX5iMDnFgAJ7xH
 7/ikuM0Rv9ZgeVxHuieTJ8H9dtagV2WjjnJo6JG/B7FkG+D2IRLqteX6EMb3MXb74WSc0/IKc5T
 CfWhP
X-Gm-Gg: ASbGncuoc6j9BgeXY5eGuoQO0mxoeHOwTx2WIdCLDCFD0fGjvrqccfjuFIWKbOwFJkq
 T6/KtSA2enleUK1HUBG4bP4PNhjXxokfNCCtaM4QGUBXgDv6c8ud5AObSJTWleYUDeoOlk6tNlG
 BrCQxiEIEq5Xnh3ML2D+RN47T0MzkgglOktLg9KpnBFkqE+oC6DBYdERWQjHcHpZS7OtjGejnbM
 8g5fVE/9pSSLQMUUqu53mKA+1DDjc1XfiwdPYnH/R5jFy4nvlkE/nx9mX+uJN8pIcf7BA/VnDoe
 yFtC14agIQg/uz3iHJoSYLCqnIVwnvbQmhtOErypcLsKM5mjHHNgobkKdUD6RFROgGpQqd7tPHN
 OpRf7IW0JmbqYEVdUgSSI6Y7oI/GVpGh7ZexVojHtB1GDtkofNtk=
X-Google-Smtp-Source: AGHT+IF01bSwxs+gJP1JJvcPIVTuji1yeTjvhfHhjLA/P0LrqaebyQnw8my6Dior/S+icyegtLlLAQ==
X-Received: by 2002:a05:600c:3483:b0:46e:1b89:77e5 with SMTP id
 5b1f17b1804b1-46fa9a996cbmr79201265e9.12.1760101546622; 
 Fri, 10 Oct 2025 06:05:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/76] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Fri, 10 Oct 2025 14:04:25 +0100
Message-ID: <20251010130527.3921602-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a37..66d9c58b3af 100644
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


