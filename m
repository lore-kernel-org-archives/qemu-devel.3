Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC9FC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksh-0000nK-6i; Wed, 23 Apr 2025 20:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015g-Rx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqH-0004kL-7n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso510879b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456008; x=1746060808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7co6UPbFs3UMGwvej1q9xVe8Zff5+JIEQHNAwr6+7ws=;
 b=IPsD7zvsGnhgzz28sqU83Ag9hXqbcEQh90qEHRbqL5CFF8ZZL+IhyF+ASHcWQVo/qO
 xgFPNRpHFUDLCVPmj5omEftdYA+ZZwW6hDPn1a13UT01OJlD96Z8Cib/19/YJkgGL4JB
 1zageu+l0Fp61l+Z/MuiHPeIsQAqwZtMZVr7sqGyb7oooc4ev6JxMpwClZX0Xzn0snE4
 G63xpaB3W8JTdUYYNxqBPb9WS18+AYeZwag/zScwJl1eQmB5dGQVjxyQorp4GfweRZMj
 SUwrkeKHVaS4wPaXwlh3wjNwcSrkA/1Ke/lc33dFxTQGwaWEUYEuGyzWHmeIOcIaQrwb
 1S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456008; x=1746060808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7co6UPbFs3UMGwvej1q9xVe8Zff5+JIEQHNAwr6+7ws=;
 b=t7mTKlJuCeTKPpqxihoks923Due8FXNSq0nscP7nycsySOrfjStGptG7aDVNIHc56w
 WuLuTE0UKnJvqaJ3QlZwfVB0Rz6sSxf2lIOiJoGKZTWkNHqTtC16VqC4R5ybNcqSDdNr
 UZMWdqO4wPfvd3rCpH3e/Wj5DQxFBDL64jxY5F5wMrnFy3JPkR8aLieyZbsapTTQxdgF
 oXIL6owSAdx9ZCUVTxGV5CzGDNIwKCbQ6sC9/IBXCoTqDZjuEfhVGu39Wv1CIWvp+ctx
 9DHWJYpZdnYXo/vMg3uUAw6x9SSqwTpX6wmwhQvr4ZTVCUvMXWEYDva7Ta0D7wvkKldD
 udPw==
X-Gm-Message-State: AOJu0YxecYUdx9mCe+TbtANEUPUy2Uw0WQI9ifhL/VnY3VinzEl69MHW
 PUftsVeawPbzY48LM1ZHjocZQjhH1QV1IDQ4RIalZRY409Rlcao7PkbgPXNVIs9EmWPMZN2O19f
 u
X-Gm-Gg: ASbGnctaL24Umw7Z+D7kdNIV9fITaLRYlmXvUPV8NpxFCHWUQ4sOtI8Rjcryiew8lpK
 gaWe1RLfrqrEpw8BK2RitVUd5KghDttmcmd6GuRbDcPthqkYzkdyhXRLy5HB5gmb27UpL6bBFO4
 pv866SVls1PgYYOZkEh6bvz4XddqpIggMo3f3SLxFcXgUgd0t6v5/R+2vMx1q5d8VpfP71SfotE
 oddcWmJeFYfElqY+Hpf1LYUuyTyhV1XlAbfpPEreRZkMQxnTZJO4ika5UJn5J1PG+KYPrjZYGQX
 FrEYTDBKxDRuY/nPuqSH53dY1AXsUaUFj5C6Jx2jOUmcwjd780ujkgxB5Hxncwcj3VP8dTM8aLY
 =
X-Google-Smtp-Source: AGHT+IHNpEJwpkj4MSSWZWYOu+HrzxnFa0Fd8sqmWK24xfI72vbO/g6SdkmQ68//o+zKSOvKB5UdpQ==
X-Received: by 2002:a05:6a00:acd:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-73e267e7d8amr619471b3a.4.1745456007743; 
 Wed, 23 Apr 2025 17:53:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 070/148] accel/tcg: Remove cpu-all.h,
 exec-all.h from tb-internal.h
Date: Wed, 23 Apr 2025 17:48:15 -0700
Message-ID: <20250424004934.598783-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Not used by tb-internal.h, but add an include for
target_page.h in tb-maint.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 2 --
 accel/tcg/tb-maint.c    | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index f7c2073e29..f9a06bcbab 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -9,8 +9,6 @@
 #ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
 #define ACCEL_TCG_TB_INTERNAL_TARGET_H
 
-#include "exec/cpu-all.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
 /*
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d5899ad047..df3438e190 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
+#include "exec/target_page.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
-- 
2.43.0


