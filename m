Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97B0C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr397-0004xd-5m; Sat, 08 Mar 2025 17:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38b-0004db-2i
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Z-0005OA-Hc
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239f8646f6so55704245ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474758; x=1742079558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4kmr8U/nSCs8j0qCWAgIeO/cec/3d9GL3wtnW/tBPU=;
 b=N5lggADgjMVkBjkJVafKuVeSJzFTGgVkkyAhTP0Wg9GY1oZYCjyHrKfdrWDDrt4GRd
 NhbPlFEG8aHrfeVXWw9f6ibmLY4qEgzAgDj+4GzBMjJFI5TQV99G2Fi9vkaNuYLqXEk3
 s9BxraoqERXQjvuPhzZ2kGU4yFeJosD81Uf4KNf+MxSQYZigubTOv037LdLGp7WUX7Fj
 baeqqDA41vm9odHFEonV8ESZiyHGGDkTXeJ7SGQnzRWi68BgpR5l2DY2BMWHj0hNtf/w
 sUyAJR7H/rTwdcHbi3Or2vRy4PM2kwV3OeJ7R52YhNc7UaABts6ES28vJuslUoMvUEaj
 nbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474758; x=1742079558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4kmr8U/nSCs8j0qCWAgIeO/cec/3d9GL3wtnW/tBPU=;
 b=Kcy8Sp6GHAZNV9EfX3wxQpVLdq9UoRd/qs1mG7Or8baAiyKr1FX9iQt3G2v2jnWi29
 L9LSHKHPL4R0izX8xL8kcqLxWaC1STPdir4+/levLGt/u/elxO2IQJRJynacX5YgDhAR
 n4ET9J/uj85EITDK2qiMvE5iKBS07ryN612JNouY6nXCJS1r661haWMMM92QIX0qp5Fo
 EPE3njvARgJ0CmD21xlwcOm7WmDZ3FhYTAz0uQoBhcsR1rDYwCZMQ1E1uC7Bh+JuW+4K
 j4rY/8jd/8K1Z3fK8C8CtIxNjsoym0MU+ECPkT65MEDbXvLump7zJaDkBOvZwXF4QLdI
 eDgQ==
X-Gm-Message-State: AOJu0YxCxjgqub/oB/h0QKZm+Odvbvi2awrfgCZ0oAQUfJT4hKIfO58q
 A0+tiXUvktkH8IC7LIBnb3EfIGRup4Dqmp1Gv1eMfTlOO0VZKP+JeBqhJ4SXcf0mEhejCfUygU1
 h
X-Gm-Gg: ASbGnctDLOPq6J9duhftNQ999IdUqvXUQMGtbm/VaUSJoRnnZn7tKGCk8f2ItAF0pPI
 n0ac3ZcdWGHx6rzrgGgPb4hj3XQhaJj+BPw106O2piAPbZlcm0UBBuq/Ln9EQUKVV13TmsI7s5e
 AfJVNnmM+9i+m8xvP2268IRpIivCdWs8HZ5vw6dZfjn6e6Ay8dCelJQv4JL7YVBiDuPEHm0hhsT
 s/wkr611w1ISr2Bv8P56VS9nXFLzf+E6NZVN7psmvdGCkmshcFbklj+QjSDFF5hLfussnWsz9ET
 D4JfAzBRLcdQVOiqWfC9PNMe2F1V/u6/o7sMI7Z/U/1f8I84/oLjNfhQAJqBANOc8w1szfQ8T9B
 R
X-Google-Smtp-Source: AGHT+IHbdh9wfzupah/15/B9gMaLzg+aHoefK7+ZDpQxhEcFdoEtDgkB4e5lRqTYVgDbm2ZwTeGPVQ==
X-Received: by 2002:a17:902:d488:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-2242887eb5cmr146067055ad.5.1741474758076; 
 Sat, 08 Mar 2025 14:59:18 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/23] qemu/atomic128: Include missing 'qemu/atomic.h' header
Date: Sat,  8 Mar 2025 14:59:00 -0800
Message-ID: <20250308225902.1208237-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

qatomic_cmpxchg__nocheck() is declared in "qemu/atomic.h".
Include it in order to avoid when refactoring unrelated headers:

    In file included from ../../accel/tcg/tcg-runtime-gvec.c:22:
    In file included from include/exec/helper-proto-common.h:10:
    In file included from include/qemu/atomic128.h:61:
    host/include/generic/host/atomic128-cas.h.inc:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
          |           ^
    1 error generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241212141018.59428-4-philmd@linaro.org>
---
 include/qemu/atomic128.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 448fb64479..31e5c48d8f 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -13,6 +13,7 @@
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
 
+#include "qemu/atomic.h"
 #include "qemu/int128.h"
 
 /*
-- 
2.43.0


