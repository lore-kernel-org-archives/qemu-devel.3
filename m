Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA5AE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjtl-0003eN-Rm; Thu, 12 Dec 2024 09:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtl-0003e7-57
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:37 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtf-0002eq-0i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382610c7116so309267f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012629; x=1734617429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPe6MkxOM+2LtrF6h7PO35BI0eJhz93c0BZ5FQYQd0o=;
 b=HH5VyK1sjPDF7QcPjKagdZVYTLpfZ5BpYSlCT6crllgCHQ5gGziDGcbjFXvL9/vzkA
 FY5ADDp4LbsvusRMQrNXCJ66s+3DAln5Duhh3Z0w6E5/t3e8uR7M/iY3bUOr/ttuaaMp
 7XXMfP8eTtXyntxYUDS1v86ly+XSRqNOSBQjHztUQS+4N+aiV/w5vz9FvcgNrsgutUGu
 M6Y3t3s3cnGv2HUPz1dfsWbwPzfxZ3bgw7ty1Q4O/iSvKv4EGq0ZFqg1Irwl56jOfN9a
 zdWHvwksSsaqFtT7Fkw9fytKO69GuIbsNTY/reo9XyNPOCpugPRh8F3ILb4VLgEid483
 ekWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012629; x=1734617429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPe6MkxOM+2LtrF6h7PO35BI0eJhz93c0BZ5FQYQd0o=;
 b=eJbISqJVME9/5GD+2bQA5jJ+ZVONETd+PKMT140FSdVTl6Mec87nt2hmXznplpQijK
 D/qhG4iVf1LxjGYof190BrFXYup9TnBxZbbQJrXtc4bTVdVmb0viim1iVkW7sW2+TtWv
 iM7++hr6zLpe1WGXHQ6Ab+F+fm50i9EpBf1PmH7uTQF7tYcm+ad/8KkVfG8zIqkK7O2M
 LFNrTtiuypmMwPxV5ZLV1U/Tw+yefPvQx7wPIpOqQyhryuuLZXmiGtCtiQH+f3rJXX2H
 2sgTlwt6bCZtES0zNt4/dDtu9OiAM96sni6eFaMl8vmbmoBWGVFczz8yfPqRoAVcb+jJ
 zRLw==
X-Gm-Message-State: AOJu0Yy8fkcSoRVJLPzBz7JpoNrLQ69QE4gB92Ff/PjJF6W1RxRWJ1V2
 k2u3oGxV0SbViIdr9BYqYu58ImPUIBXVJf/Tz2M95D6bx1YP4ZUcrx7bP9gjhIan5zWs3OKrizB
 k
X-Gm-Gg: ASbGncu6tIyvxhSvqOr2p8Fgr9uH5/2DMDZDbXj9LqSDShsdI6MQYdMZf2o+ervpOcF
 yPx8o2a64Ok2kDoNduHPpQiAeq0lPVuytkyWD1pj1sSVT97ryvS2UX9X6tYumCLBEw6Yf0KB6Iy
 aYzuuBILwbcSPJ/5mpUXioSWfLFGGefJ/VNn09UPw6M72OLUJksav9jQH24hBtSGYootKnS8WxA
 m5AGGDUQT/CcByaOPAIlTN0F+XMbILLKd94Utr3/NFTcLdBgTXI/XEDU5pl0K+EkJGShxHuEzt7
 HNS36ez4Pkn6RSNCuC/2p3yuBtOLWAQ=
X-Google-Smtp-Source: AGHT+IGo2cCwBLM5LVoIYgH3AiH81gTfv/M6BdHnWVX2AeNVy0QYTKXBq8/AiRaGRko0K9P836tuQg==
X-Received: by 2002:a05:6000:471c:b0:385:e303:8dd8 with SMTP id
 ffacd0b85a97d-3864ce602abmr5527140f8f.26.1734012629124; 
 Thu, 12 Dec 2024 06:10:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ed6csm17844395e9.24.2024.12.12.06.10.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:10:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using .h.inc
 suffix
Date: Thu, 12 Dec 2024 15:10:16 +0100
Message-ID: <20241212141018.59428-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212141018.59428-1-philmd@linaro.org>
References: <20241212141018.59428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h                       | 2 +-
 include/qemu/atomic128.h                                        | 2 +-
 .../generic/host/{atomic128-cas.h => atomic128-cas.h.inc}       | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename host/include/generic/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
index 58630107bcc..991da4ef543 100644
--- a/host/include/aarch64/host/atomic128-cas.h
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -13,7 +13,7 @@
 
 /* Through gcc 10, aarch64 has no support for 128-bit atomics.  */
 #if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
-#include "host/include/generic/host/atomic128-cas.h"
+#include "host/include/generic/host/atomic128-cas.h.inc"
 #else
 static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 88af6d4ea3f..03c27022f0c 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -58,7 +58,7 @@
  * Therefore, special case each platform.
  */
 
-#include "host/atomic128-cas.h"
+#include "host/atomic128-cas.h.inc"
 #include "host/atomic128-ldst.h"
 
 #endif /* QEMU_ATOMIC128_H */
diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h.inc
similarity index 100%
rename from host/include/generic/host/atomic128-cas.h
rename to host/include/generic/host/atomic128-cas.h.inc
-- 
2.45.2


