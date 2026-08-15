Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05973C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKn-0007Pr-Fc; Sat, 15 Aug 2026 15:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKg-0007Jf-Oo
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKf-0008Km-1A
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso18721475ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823175; x=1787427975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ki19VWjqhUrb9W5NVrRU/ayXP3I7g7OAHfGnfTrb0dc=;
 b=mTtuLKkQ38fHV1kw1UHjRl5dP4rDS5hLDBqlvOhZfXMP2orC34lQCe5Tzb+FrX2i0M
 f8y/HBpjIDxoVRoc6eQpPPd8+0gdP77W9PflFg24qfRx5K8j+aqCLN8PYBlO9UY0h48L
 c+ImAsMBOtNVfkjCkbC+WsYkDII7x4GaC3SPj+P75uZA8E7lWCdCZCcXFMIWHWM9jxRH
 7hZUvPbILjuedWCESNX20YFP2qTkEkNhrjMZJYgosYqjkad7cwBm4WRKxJFWcpn8w2YA
 GuFkqxXi0eYkXiTQkAlv8hUe51r8JRa8EiWrq2ObVXqRHReEYwqH7KsIXuV9NF69LMjz
 Jn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823175; x=1787427975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ki19VWjqhUrb9W5NVrRU/ayXP3I7g7OAHfGnfTrb0dc=;
 b=ZsaRvGzZ+LkQziKW/whS5/0fL8Q6RYe8TaRTLt7JVdqPw1X5dIBMPnMkKumL+5P6lZ
 KWIFGMZCj5sAparUc7UJxjbNRZDdAKv/UHbHPKmyKFSpRKQf9u1dtbLvAtHVNPkexSY6
 liOgjF8PIliyaYoEPa40hR0JkB8hLSgKrFcYWWyNIhXwGFpYhsD4KPG2moqI5r7d6scz
 /r45RWSkBIYbljTCK3rOBjfmm6SzFn9BeYccGEJFRsBlpjqCRhGGcNx3JahpTydrCM3r
 NHoy5/ZCCtPx1ihzWrhX7OR9gdFPnKp2v7DYFbj1waWph4AxGUUWylD/tgATLJNy8dT/
 Djrw==
X-Gm-Message-State: AOJu0Yw9g/vQGHnTDkZC89v+B0I4Yv258zam7PDv0I1KcSDsdd/Vg9lo
 vq/990FGtZk2ox8zi5ZsLFVLBUwaV3LAxlpFHKN6uh3q0BKIzs+fnLnXao9yY98n5wn6+GVdOiK
 7Ubik
X-Gm-Gg: AR+sD12gMXiuUhj3TlkQlcCrBFHc697Nrbv51YbiTZ0hhE4eFnwC4pAYncKokjIr3KU
 VHg74LXB2oxWXfJ8j6qQGTcR/vGihgaSEeyAEvGURk3a6SbkoD6N7y0zmwoeS2EeIHH0imX/Y1C
 D7178JrnehOLJRODwZ/QVokEynemBHrVIboZuz2zy6TDTt3gOqyi9azeUmAWya4WXETMhaDLr4D
 gg1B3EpO73zAAiCeUTOr470XISLWI6b/3riL6oN/GfS+P6w0qy6aaSLiRe+9a1LfaKGnVbq95M2
 LvpG92RNSoNvQB077UV0UKOXFa21KXQn3tWnty1JILoSbyavC4W1nJnqFWTIEvTD+BxDbMdSOe7
 C5+t3LIvIYcodlHQ9anujDtUIbUSHRiKGj/TbGtTZHco+9VqwU0huwkBI4x1vIjehzRYsiWkXb7
 1A+4EklpFsOJE1bbV34t4G2/fOf8tyhEmVJtvNVUH6v8t/BH1XcxVnpkiSOZHzjryC77tPQsdw5
 Zelj1Q265X2fLu30sqYX3xfyxd26bs=
X-Received: by 2002:a17:902:d4c1:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2d3b0ad45d3mr144910895ad.3.1786823175273; 
 Sat, 15 Aug 2026 12:46:15 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 14/23] target/riscv: Mark VSTART_CHECK_EARLY_EXIT unlikely
Date: Sat, 15 Aug 2026 12:45:39 -0700
Message-ID: <20260815194549.1377505-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
index 5681b81815..d081397f65 100644
--- a/target/riscv/tcg/vector_internals.h
+++ b/target/riscv/tcg/vector_internals.h
@@ -26,7 +26,7 @@
 #include "internals.h"
 
 #define VSTART_CHECK_EARLY_EXIT(env, vl) do { \
-    if (env->vstart >= vl) {                  \
+    if (unlikely(env->vstart >= vl)) {        \
         env->vstart = 0;                      \
         return;                               \
     }                                         \
-- 
2.43.0


