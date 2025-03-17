Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5971DC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD62-0003Ug-Ik; Mon, 17 Mar 2025 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD5w-0003Th-Eg
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD5u-0003gW-Jj
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so16807135e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228015; x=1742832815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsdpMpMS34EmIhyJZOTed6/XyRgEKCvDdFOmkB0e2ww=;
 b=ejYmrOAxdbloSgGM//2AuI6/qoCCux120VF+yt4rkc4++n0hnVu9klBVulb8OjVAOm
 4EBHFlFDR2vH/irHk8xBXtbQkIzkiG8tTkK5Hp3EqVjgHjQRqVVuG1jvWIXpSyXzDicm
 EAXQQyRd6PnVL31Zvc8opkvYxbfhhr7Lt7zJvXljrCvHCEldJ6yKeds1DiSQNxXATjBe
 KxnV84cjd45/nq90C1QIbLimUVUmewb4hN1Y9P8gYxaK0P9f5bxZRIRqSMqx4aNYWIeR
 fmwUYF32f0MFhhFV6JzcepgyHyfAMpcMsUSFnY44yzZpAcRsTcBJyn/IVqvAq/YjP1t3
 zNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228015; x=1742832815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsdpMpMS34EmIhyJZOTed6/XyRgEKCvDdFOmkB0e2ww=;
 b=AcFhiJOdOAN8Ot+MpASfxdwnM6lczx45uHPbKoatO2rC7KxlOZ6Pj7ZQyeaqCkTKCb
 iLP1DTiWA6btUKclFKduuJjztTO9W3ZcZT1LL3CA+n+97i5urkmH8ByTusFXzQ694En5
 ETChSAObUFdWfZxOIuREWEKB2VVbNxgMQDQafxnVc8Eq64xFqCnePM9IliTU8ZV/G9uh
 CxcOQtfOH46jdGg47rcquqAG7IpCQaz/FBk+0U08Cm93p/rRDdwDu/v3IHQ6BmlvruZC
 KprpWBrM93ktzG8qdYnNEZ9NaAQGQ57RqalcFmvtc6qMreFdaKRRUcABAei7+inIGiyJ
 ySvQ==
X-Gm-Message-State: AOJu0Yz9T4Qff4dsVL44QBHcTJxh5eldd7GbCPg3Xt0kDZhI/qMGpoaI
 8pf9oJd44a7a2jzNZrVGQuAr2ViiKHcH+zVSR7W6rX1d4qiKimj9xrv+mrlgQwk/5tQ14aSi3FC
 W
X-Gm-Gg: ASbGncuUivUXs9zEcozV0ayd2J9XDIgJqcR4YiRdWHUZNpNv2KmJKX5IiSdeb91j/nr
 V9mq0SntNKnDHtqMbZLIOlMYBy/JZ4LrdH/6SYHN78QmlH1sxqTITQ89sXFo9toBXXJHg2ECOzK
 rstOX6+rEdQ1w3101p+oXkanmmXu9jhvjicTlKYvN5b5jZLROniE63nalFG1tEPUsz/67y2tGmR
 NTwPNjPWCqf3mltYElMOVuLtBAzhhIoK/03HQ9oFdfoPxMoxy2/VwvPs2QPEcWsCQPlpiaajeS3
 dZIytEaPW/9Cch8C6ILMl87V55W2NDiBOGCdyPO4kiVhcJbzxI5b4XS2H3BzQVVYUF3w8k8Vht+
 jYA0RGcAajnEAyGkckq8=
X-Google-Smtp-Source: AGHT+IHtypLZDpZCDmfaAyfR+NbndNj+3bddaHxd30R+pVvhoHdNk1VmiSCNLkfhckmisW9ERPS9Wg==
X-Received: by 2002:a05:600c:46c8:b0:43c:ebc4:36a5 with SMTP id
 5b1f17b1804b1-43d1ec6946cmr141158345e9.7.1742228015525; 
 Mon, 17 Mar 2025 09:13:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffbcf1dsm108324135e9.13.2025.03.17.09.13.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Mar 2025 09:13:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] accel/tcg: Remove unnecesary inclusion of
 memory-internal.h in cputlb.c
Date: Mon, 17 Mar 2025 17:13:28 +0100
Message-ID: <20250317161329.40300-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317161329.40300-1-philmd@linaro.org>
References: <20250317161329.40300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

At some point cputlb.c stopped depending on the
"exec/memory-internal.h" header. Clean that now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876e..5007bdbcd75 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,7 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
-- 
2.47.1


