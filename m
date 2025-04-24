Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E50C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7koi-0007RZ-IF; Wed, 23 Apr 2025 20:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn7-0005ey-7r
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmz-0004a2-EG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so360658b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455804; x=1746060604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=EEHIFO2a6QsjsyVRMlCWR+B/R+KnLfNEpuD8Ypq6EvpQa29job+DWMxctZUaUf9B8Q
 HHlB9KJ0oSjIsZAYJmwrvmHDXrrPGZjyulDoYnQt9f2zijCrte56UG4L1Kltjzv+eWTY
 SxFJs4QQDB1iGxowFkmRuleOqsHcNgqWpfsKWwbD72DlKvgmSPzNANabL7dmHr9tR87c
 70chVVV0mMWoqRhoR13YVJB18mz1nE5H+YnpocJM4IZuD/vPAZFPjPgIYnJVrBdPOFbN
 4XFMq0H+TBxsnFZ2jYg9KmuWHGZ0JeTRR/OZzCel0+SQxJFiIHuvYoYFdlDNH/SWyn8Z
 w5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455804; x=1746060604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSTxcdVupVH5RULwmr3LUReRVWUe6351QoWFFPPNbok=;
 b=GPU+MHyXZ9Vduxt3bSVRmSsKH44D/GZ/LWDPw3FfQ2+wZnBGImDVAhi0cnxJT22oli
 C8G0o9omYpjsIaipgvJHGZ6p9rI4qQ+mYRp+fscoG8wh+mNU4mR1Sbow8EukdvkoLDuC
 sGuq4BG6UgSoB0E6X8inmnVAkzaad3guiZkuHlf7zX0QjKRTPz0H2a2Dc3eutYqblA3C
 co4xwhfB7NW15TpvCnTX5ElCErnYh8kILi4k9zMl37uyqYLm25PyakKPVxFHiBtB+Ydu
 ETR3w/vs42APH8tOj11z934NjWSQscUba8GgEyFEGDm/hlGncZ8AT3E4ex0qzeYlYZXl
 JUzQ==
X-Gm-Message-State: AOJu0YwdCcvuHAGSiznt8dF5OFR7sUpYoeHcUyb0Lfk2gef53GeW27bQ
 ngWq1NYF+AnX1mfuxzEbgXUVYZ1DOKsSR7C5hzLXFaL2Iae8/chyg+/C0OV0Q6cmEETtE5PgoqS
 2
X-Gm-Gg: ASbGncsZqI21wAtaUZiKP3zPY5thVhMOqT0RbLOsceuts/qF8q+Da1oQZKwcmjvJ15X
 Y/B7NY0pJW5ufBxuOSW2b8P95qWK9gAt1+zPubuvwvGyPgxBBzyxsJT29xbTTwplCgtTMtnt1tp
 6O4urrLzYuQkfllVJBa3Z8cNB4CS+K7B28iu7omXVX1t0Zg6MIF/caaWNBEt08aNC2HQRDturYs
 VoN76OH1FahdPkB2Qn+WkDovoZM5h31P2Xsg2OTYALuuXPlrDqk2x3ug6mdvUwUK2kNhDS6CL2k
 ZJFLjFWZeKEL5BdlUTlkuJE0qMtg0nMApgWOsWu11JIfcUJZkxHNOv7D36eauQCn8INN/gsoSNY
 =
X-Google-Smtp-Source: AGHT+IFcN6omI25GDqQD/9Vq+Rd74TwSymomTUKIaGw8YL85iZXfz5z+mXSyLJkGR2Alxu/ITL3w8A==
X-Received: by 2002:a05:6a20:9f90:b0:1f5:a3e8:64c8 with SMTP id
 adf61e73a8af0-20444fd1e3bmr1065319637.36.1745455804108; 
 Wed, 23 Apr 2025 17:50:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 039/148] accel/tcg: Remove unnecesary inclusion of
 memory-internal.h in cputlb.c
Date: Wed, 23 Apr 2025 17:47:44 -0700
Message-ID: <20250424004934.598783-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

At some point cputlb.c stopped depending on the
"exec/memory-internal.h" header. Clean that now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-2-philmd@linaro.org>
---
 accel/tcg/cputlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 134e523cab..613f919fff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,7 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
-- 
2.43.0


