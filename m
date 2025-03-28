Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88603C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFx1-0002st-1n; Fri, 28 Mar 2025 16:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwy-0002qM-9X
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:08 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFww-0007nK-HO
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:07 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f8d2f8d890so1534957b6e.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192305; x=1743797105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu5KF6BrH2yp81gEA850j0dS4wEWUhM6jM/Abi77cw4=;
 b=neN94agz2ihvw7gLOv7TcVBob4G/48XgyWghxfuJrlAvb0ED7Djl5rmgetNhKR9zH3
 jYkFdpyw2tFoMuK8WUogcy6gWiqRLUM0OtatEgrsCtIbv5ZUdBWUpgYTycKOxW4VjVd5
 rfcbQH7f/FuKitEL7DRSYPIpumooWZbIA67y9ueTdHWRqJRcsi1ElIn+oh3/XgQgVsFz
 YPQ7Lv3YK1gSnE1AAjctFcxKGyzmIA9Dn90Gsbt6k16LpskVIbwTtq3PVNLwhe48ruvS
 U8HbUl//sd0+fiDYt6c+mOVv5ANuo/5wsaqbRo1uqZbiVDA8ASNMnzvl8cqdqfrEp3WD
 /2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192305; x=1743797105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yu5KF6BrH2yp81gEA850j0dS4wEWUhM6jM/Abi77cw4=;
 b=PpEKSF+puemp8jkGDHnYG/fby4Z/4hSL6pEalLxRNkpEUtvQkAPr0H2bI/lqpNEVpv
 92oJxbEkLHIGd4deTqM2iDkUCXfM8DckWG+V8vvMycmVWdvoRbnnLA5NhScVJC5Q6LS5
 kl5frRseispgeLhFEYPNgdhlwTSIxoJGPq8NIGjxQ2Rq/5/Iq6/jAD6pgktkcHil9KIG
 hKXpY46k+DvpuP7vmi09I8QYNqOdISZWqfkUuR+AxG5mVHM0qBkxDHLkoDmKck7Hd0Iu
 brmqnpAukKajodv1/8GCXctG3xvU0kBieweecQKsef2Ugb5qvzSUzFNZINkIj33mdO61
 dOXA==
X-Gm-Message-State: AOJu0Yy8xa9xGDb4EnUrFogg+8NjHHi3EcxLpT27J0338gEU2Png6lko
 +UZVVUJCVcjcGDBKOIIXGS87MRMYepgigi6McNihqAcEr9NE1i7Fdv2r/Eq/H+VF5aO7DVPia3c
 5
X-Gm-Gg: ASbGncsQmL2aAE9FlHjFCXsQNPB4faAQYwIYNZp+eUYiScuZaNt1l4wl5dRZpaXk2Xt
 fG4ACrDjOepvXbpbWlPTyVzkS6LqjcUDQ9oPZoLR0rYW43SCKv5oQKYYf8cimygxbos9jNBIrOE
 fnSyen2OLOhpzvE7sPmHu6TRtXyfFoOQ1gVtUmmEdTCDiVwn6AeJfEwcV2v/fPGlCgritEsww08
 ihYMTJ7AXUkZKhXUsqM5peYJle09x5VyFgZdeMwf0mJK4X4KZexteSHZFtyvQfPtH/zo3GCphIy
 TU3JIhOyAKEQQsG/rpsI7KfOyix2CjIi05vxwK0/+tEIYAEdaywv1ZXBs35OHyoQQS/+fMU8n6b
 /FNDiL2Fl6TY=
X-Google-Smtp-Source: AGHT+IFG4hD2s22xWh/CxHeK9tLPwlTt3t8F2UZL/SAHYLKKWHT0/XvVTAPxPpBYi2q7Ua52Z8QR/Q==
X-Received: by 2002:a05:6808:159a:b0:3f8:cf10:f113 with SMTP id
 5614622812f47-3ff0f4e246fmr480094b6e.5.1743192304881; 
 Fri, 28 Mar 2025 13:05:04 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 4/9] accel/tcg: Remove cpu-all.h, exec-all.h from tb-internal.h
Date: Fri, 28 Mar 2025 15:04:54 -0500
Message-ID: <20250328200459.483089-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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


