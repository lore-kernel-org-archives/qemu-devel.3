Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0FFC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDU9-000391-IW; Thu, 06 Mar 2025 10:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSy-0008Or-B3
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSr-0006KE-71
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:50 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bd5644de8so9712635e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276127; x=1741880927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tpYVdS1VQrRLJn+AtzliasS5gEtN/QTYnA/EkOtkTRg=;
 b=cupCHcmMB0qqy4dGe0tVVkt7WbJOAGy5AkiUCstKkGyZrm+UfcbIazj4zZsB2DAKb4
 1ukNwR912P4qAKpxFVXp0zsY2q9lc7Z3O7gG4Pnnuqyu98ychq2sijJL7TyIQbq+zFEN
 E8JWKtU1+saC3Fj8kEr8IfE/+Ow9xr0Hvrn6ihveSkcjr6gGTuWMkNJkoZPNNAxMIc3K
 90ULV5bfGggKrAZiHIgEt0BvvyzNJz2jKjcvOalplzwJ3CQ7wtfwjCWZmPeDq4ooCvrW
 RCr48+oAy7cRdYwtLE+gLPjIAht/KNKVfoj1JaOV96GTqlCxluADJHlFbo63WVG6y8yE
 3iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276127; x=1741880927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpYVdS1VQrRLJn+AtzliasS5gEtN/QTYnA/EkOtkTRg=;
 b=Cv76mQBmvPYtlVZuHzbL7CkWZxg5HL/NV2WPg2YfPJ4StaAw+cwH2pDNFY6tqHWWVX
 +ApSNjCYZkT3iT2AYaj+7LiDrndFjmIgkN+J33IGsf9IoU6kiGj6SgPqU0XbCEnKRhga
 2e83C//1NkWvVl+Ipa67ndVby6l/wPrDbxSbS0ytZqer7hEnH24Z40C24iREZoiMf4iT
 LXHjo9HkWWYE8xDgT2PjuJOu/vpwoq9ScAb7qCwI9122rXEXAdECP/h0zdOYfa9+Bw/F
 qyy9SywCynYb9/Dlkojoo8KAzoU9qQPMB8B8jKDtzGnaSSM02uN9A0dQ5XdetqwUf3mK
 Fx/w==
X-Gm-Message-State: AOJu0YzsK1QA3+ShL7WNDxwaLY/TcgwIhLrxwG1ieh2eLU32pnd7y1tg
 QPDSIBTWhVMM527jXrCXFN5rCCDd+m/Dq8v+g3axqSfGHmKBGbseOVrdssBqViz2wEfYvGz+/Kl
 OdFs=
X-Gm-Gg: ASbGncvxl6StkeQrcFPEhDVSESGXzpDQyLcOP79ux7oRh7JNHQS5pNwF8K7MikYzGrA
 eCVIrilI0i0tZMdn+8t4H6U/IzFpguivJQXvHdGuyUmuAbRuQlx+qeRs4TTqSjaKk3fGeP4efFD
 rLtXpLp9gZy3o1zJBx8PDQzY66Dbkq4br0iWegJDRyty+Um6UFVwQQtVY3TVs/YKxjIiH5hUqRM
 Z2r8m7ZmndqZI9IsWz8SCBeexuJ3jLTkzLkQYlt1c0+nOCSEBAufrr/03XSw1pquYkq/zDM/VbR
 t/qclgR8Nmyz9td/mZdP9UPkUSkNUO/zIUGEIpdXKzamvQj4zPSqSVLZN0ArLvBFvURglZzBcHG
 aKyYhbA03aaJFDRof9lE=
X-Google-Smtp-Source: AGHT+IE2OyHNjoDTb/KUwR7g+DhA2Fxolpt+sj5X3/foG1y6ZCRFpm89SLi3URB6mm9wtdj+XgJPEA==
X-Received: by 2002:a05:600c:4f15:b0:43b:ce36:756e with SMTP id
 5b1f17b1804b1-43bd29487a8mr76591035e9.12.1741276126567; 
 Thu, 06 Mar 2025 07:48:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0461sm25054045e9.4.2025.03.06.07.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/54] accel/tcg: Include missing bswap headers in user-exec.c
Date: Thu,  6 Mar 2025 16:46:57 +0100
Message-ID: <20250306154737.70886-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit 35c653c4029 ("tcg: Add 128-bit guest memory
primitives") introduced the use of bswap128() which is
declared in "qemu/int128.h", commit de95016dfbf ("accel/tcg:
Implement helper_{ld,st}*_mmu for user-only") introduced the
other bswap*() uses, which are declared in "qemu/bswap.h".
Include the missing headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250217130610.18313-3-philmd@linaro.org>
---
 accel/tcg/user-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index c4454100ad7..9d53c9440ea 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -30,6 +30,8 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
+#include "qemu/bswap.h"
+#include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
-- 
2.47.1


