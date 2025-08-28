Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3BCA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIC-0006Rt-82; Thu, 28 Aug 2025 13:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXL-0000hg-MQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXK-0000HK-1A
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24879ed7c17so6633765ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383323; x=1756988123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXwv+ZFBmnLT3vqO0wpKBBBu8DiiTjaPnesjLL2Fb9A=;
 b=zkHaVY+Rhnozgivy4GKpP6G9ZfcBoX/E/sBithWC0pfOsoEy2qTblA9G6Kprq+fBnm
 0QCXAajb0/V0L4c9HdmDSdPkZjmqB/nQwqhBH243fpiiyGp6+5nJmJU5IIKrgqfUwDC0
 nWEjE4R/QjNuScc2tQK5/i4dbNc5uCICiHRb8YJqjXIFKCoVYZ7S/pcb3+B1GV6+dIdC
 Hq9OjQYzFgvhb8msQ0FzMNkhaZLy7Mu79pF5rvCoK2pRmbNlChkfu4/e89NhLyUCQZr9
 gApe80NrJbWK/1zL3AJlV4pNpIs8rbvdNg6+D+ZGfUIbbMcnmFA2DWUPPYk/PPgsji0D
 3ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383323; x=1756988123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXwv+ZFBmnLT3vqO0wpKBBBu8DiiTjaPnesjLL2Fb9A=;
 b=hrl4jQcNrc/xW3vGJF/iEoOtnZKS4UGCBYck4+Zbr0Aqib0AZetWM8cHY/OXkjoD0Q
 +jsOcWHzuaf3xvZEhwDpa+02lIlf957ekg9nX7xrM0yen/5EWVC08+jc5KgCsDBIY8y4
 TGLRjjm9p2OK3aOwMEIfGW9o1xk9FTkncIZpqG9Tzxm34goe7U+8HjaqDTYKTxHOk2M6
 Cqx9AnPJPr38jHgFrkA3j617QQo4nP/FlaasYsiVgre8K/J+bAwdSaueXwjSwOGq96FD
 AxyjI5jHEYK5hcjyZ4cx6TOkCRRfVlIKXJkMl4aye606u4GglKAbcZpXNlSVy+u0Kl1e
 SWNQ==
X-Gm-Message-State: AOJu0YwtXWltUuosS3t1sGy7oeNSQuKLucIDQec44g0AJU8kSq55Gg5C
 Hdbkk7oOWa4JQhV3wu58/EG07/xVTC+0tVh6xUZhJztgQeQZraHq9Dw79SXA8+kY5tFoo37/HV/
 OMdtRRIA=
X-Gm-Gg: ASbGncttb7/S1OymxiqyQcizfsz/GXC6ssUGtgmclfFPjVnu7u0Fr7N6z71qOJQgPch
 CQCIQRrwFrPysi5C+ssuKyVjEnkPfsd4gJNwu/MzYuBJh1ZO4wSmZKOekJYd+Kfm1ypsQ1WXjJc
 ak+0ZAkWAOoTgTW7iDwhLkTwOnZFVXFPEM4Cqu8isnpdrICUCgLn6y/lU/mUfEeAoCy3hia+O2c
 60NS3wOGf0j6GxQBdiHLjX7PWEWPMMniebsmeCyCcEZO8no+aPyhUcJMHF+bUK3Li/Mq2sVpB5H
 mGOKP30Mepab+WxKd8Loar2GMLokcSzW4s8fKuaV7XclT5mU/QZUalus0u8HnN4blmBN7vFpgOw
 VovFpgFxKY/vbI64TjHtBWBBb0RcXn2KhNndl
X-Google-Smtp-Source: AGHT+IHJKptoRq61SZvu8sg8L9EepZrSFBZDTmGs+U5jSHmRuqrvscnmsjjQ6UQrbsrB514i89swVA==
X-Received: by 2002:a17:903:298d:b0:248:9429:3638 with SMTP id
 d9443c01a7336-248942939bamr83890375ad.7.1756383323275; 
 Thu, 28 Aug 2025 05:15:23 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 70/87] linux-user: Move elf parameters to
 microblaze/target_elf.h
Date: Thu, 28 Aug 2025 22:08:19 +1000
Message-ID: <20250828120836.195358-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h | 5 +++++
 linux-user/elfload.c               | 9 ---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 56de77d4f3..a622cd8e43 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -10,6 +10,11 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MICROBLAZE
+
+#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a67147d43b..6c8771d804 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,15 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MICROBLAZE
-
-#define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_MICROBLAZE
-
-#endif /* TARGET_MICROBLAZE */
-
 #ifdef TARGET_OPENRISC
 
 #define ELF_ARCH EM_OPENRISC
-- 
2.43.0


