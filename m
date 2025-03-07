Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91823C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsf-0007XP-4m; Fri, 07 Mar 2025 13:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsV-0007TF-5c
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:59 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsT-0007nj-26
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:58 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso3609191a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373816; x=1741978616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvub9wKD2OmaGYjgLz+dO6qQURDfWdRF4qq4HxWTWTw=;
 b=jv/2R72yKIX63Gwhq8rykNOaecp983dYK9zRFCtavI6zQbj6D9zCHhPkFPA//z1o7E
 REYrUbAXGWi2nfaDXwRc+RtETiUbjdbtPPK6wPnpkbOC4gPj7ASaRz0Yf7/j9ZhOVPXq
 qzpUBy8ab/kbHyY3DvuoEjqv9xHxVz2XTMAP8nOIkfQ4by72Q76nPcEhKPu+ehwPlY0K
 kGgzKOTD/spy1zVl58YPZ3mi3CJBKBDyCFAji6XX2aKCqFJyZvXNSlavwrGkxUMny7aj
 /AzItJ05H66fTQTmCj3Wl41fZheI2ybiYiqFElSqC3A502IbQMXST5yMHSgB3ElRIKjg
 U3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373816; x=1741978616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvub9wKD2OmaGYjgLz+dO6qQURDfWdRF4qq4HxWTWTw=;
 b=as2J1t9wJk1HpAkDE95JobTTrtNfYhLqydmnCrh61pjNE9HEEQij4TZYM7+19lINWz
 gd4OVaP6jQUU8IFYa6Z72qB3AMLZeWj4e8biXY+PHKqiLJ/NSWVIyfFk1NwvxAZEV08F
 zgSa0JQ/QRFLSfrU2TQrYyeWvIMxjZsTXcxyqgOVBDWEI1yqY8RTphkiLo8vuSBn6SXl
 vjq26bgRY7SFk5w+X0Tw0wV7z+fVnqQN9TGsnqsuZwaqjxAd0zr0Bi5N2krW1w6MhANc
 pGsk41Y3zDQb2wb7VeanvhXV+nussF3GzVAKiuRd5fosd+KIqcbvDiGU/DQeoKPdvLfR
 ozwQ==
X-Gm-Message-State: AOJu0Yw6+Jm/MOyq7WXQ1bkf/q3bqKFbjlQK1OqIKx1mGTrNFgmgz8Fw
 B10IAvCDmRz/hQc6krkr0CY+uusOi/MNJO6G2etq1QD10TZFW3RHmrWOYG0y8jw1C3EZma3oaYc
 Q
X-Gm-Gg: ASbGncusRWO8QmNmyNfJxu86YCEHcE4CIQk5e+0sTtWLK8Vg5iEY3nO8gsx2scoH5/+
 KpgP0LkSZBeqNtvrW5gAh5rz04LFQDfAuixvjhf5mcnLnxdPL3GdzjqN0gS3nITybeh1sV4KZdc
 qqsk0YmWzqKIreQXv67/wRr12iFMClY9aqJhM2zqA2LLBzgwiQwYAZNkKu9OYUEZZXAHATUu8ub
 u2mTJ3L/rszLXSbWnSe1IAcH0jdQa21Q8jpCDJnN2RyChB8PCgMKzG4PDDgzQqTwc2ajNEEOlm6
 vATVWs1sEFbxu9gsrjL96BkVvvkVGxzhpXkeTyFFOkraw3ZZyAfEmN8wvFBm7gAuOKfD0pUWqqF
 8
X-Google-Smtp-Source: AGHT+IGFlBjWP0Mcyc6XGqxDjRWlB3KZf3/AFkQikj0M7vjpnHvybAKT/bX2H9KmYnLRKQ4zGp0NTg==
X-Received: by 2002:a17:90b:3c41:b0:2fa:157e:c78e with SMTP id
 98e67ed59e1d1-2ff7ce65536mr7470098a91.7.1741373815798; 
 Fri, 07 Mar 2025 10:56:55 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 11/16] accel/tcg: Build tcg-accel-ops-icount.c once
Date: Fri,  7 Mar 2025 10:56:40 -0800
Message-ID: <20250307185645.970034-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

All that is required is to avoid including exec-all.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-icount.c | 2 +-
 accel/tcg/meson.build            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d6b472a0b0..27cf1044c7 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -28,7 +28,7 @@
 #include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-icount.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 70ada21f42..891b724eb6 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
   'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-icount.c',
   'tcg-accel-ops-rr.c',
 ))
 
@@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
+  'tcg-accel-ops-icount.c',
   'watchpoint.c',
 ))
-- 
2.43.0


