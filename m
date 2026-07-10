Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64590C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE6-0004Pq-5j; Fri, 10 Jul 2026 19:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDp-0004HT-0O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDn-00032T-Bm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:28 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1211632a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724485; x=1784329285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/pGEOfqexvIxUlRRyRk5XlzbOiuQDRd5o3A4U/Y/0M=;
 b=Ux/ncW5sHhc379d3xonQ++wBsus7Dnl6MlFwr+D6qHHOxlGCUDdCLIjk0tjN9rMNEG
 7wMFjMnChw4FO+MWYoxlt8LT5+FrOIEuQiRZ+oHr+ABnZl/w2sowFTlpke5H//6NjgsL
 WSIyYPrS8iGwcgKYkLV2PTkJrPoVv/fDd0RB+vgYVl35fpgNKfcDzFqD5ruHwhcbvG+P
 MlvcAWUsUycD4z5vVaaXXcA35lXCz+r19Pt+14SsXtAOj1x9oZYfMMFWa131IaqKB9kY
 aGOzkG71A1pMz7pNhuqj1VsbTCRSdY9IgJZtt0+ORmLQCMx980rufgC+BNGnLHnc0MEI
 3/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724485; x=1784329285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6/pGEOfqexvIxUlRRyRk5XlzbOiuQDRd5o3A4U/Y/0M=;
 b=c542yY5xWPXkjJJj9JQt7K01EXg+jV+BWOrmGE6We+amxJiEKdIcX7dyFXQn7PdvPZ
 leFpXMHkWO/mOaoYhZRjO7ibCdlLFgxcOB1Yt4cgMTHjj9KEOVhnOip1xAPmv5ugIyRy
 ewKvpHjUcBVT0lajYN1N+S9nrxI4ud26OEk7li4j/P3VuUQcz+WzFneDjdzHiYJmczcu
 TFWHTb6XXVmlBHOQOUYhlhgV+uPtYl9LG9wYn5bAQDBHhXTQmg+rFdk8BHlI/crWPuE6
 jvzWuJn0mIyz7WtAK1GuZtX3C03koDrOL9G6Biv0kGAD8xjjsIaf2UM7+eIuEoEn/cWx
 99xw==
X-Gm-Message-State: AOJu0Yx4/LxEY7JYkCb/m5gP7gE4b81YDHMgLUea7YI+qUS6hg+ndMig
 xAc4GcsjhkA/gpVmmUI7sXKBep+VI6r7YQ7LCp3DgqHjwmvIH7fltcmgE487jetVQklxCU96P/u
 4oxcs
X-Gm-Gg: AfdE7ckqGb6TPv8FOX9CsCY7k3Suit9JnWULmRMzGDN36W5LTu0h2qXrbyr9ibjB0nE
 aslw2MlOYVQhZeKOknTkuceKzzXZ3JpgBGbdUcM0wTOw6c9adSMRTzDHYEZcCYoKFqvxkhQdNVA
 hPhHk0Bp/fiEMFErQkTFCTCrKyOa2M0Swyu1S9sA2NuajMycqxX8ZvTHQvdtmu8IMlmeSq3Jja2
 iHYSDmmkTgRHX5wLQGNRq3wjW3+EynC606ZVi6e7LVYy/kdGfqPKgPw2FRcDfyyFE+lunve8gpj
 5kFdBCtvts/Z+y0FYXrSfWTn1MQ3HzGTiv9bcrGjeEh997ILxCAi2nKC4lesc07C5QByJu7v1uq
 a0SlDxEL53ky8ayBgw6Wit4EPhk+5XL+KIrpRmcBQtARZ0uriIABeWDUehIUyjtDfJwvMj1K5aE
 Hiaka3yav5WKUzDv5x3w==
X-Received: by 2002:a17:90b:2641:b0:387:e0cb:7f4 with SMTP id
 98e67ed59e1d1-38dc783efacmr829262a91.40.1783724485437; 
 Fri, 10 Jul 2026 16:01:25 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PULL 10/13] common-user: Implement read_self_maps for FreeBSD
Date: Fri, 10 Jul 2026 16:01:13 -0700
Message-ID: <20260710230116.900171-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
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

Use sysctl to fetch the vm map of the current process.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 common-user/selfmap.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/common-user/selfmap.c b/common-user/selfmap.c
index a1b88dee66..139dae15e8 100644
--- a/common-user/selfmap.c
+++ b/common-user/selfmap.c
@@ -9,6 +9,10 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "user/selfmap.h"
+#ifdef __FreeBSD__
+#include <sys/sysctl.h>
+#include <sys/user.h>
+#endif
 
 IntervalTreeRoot *read_self_maps(void)
 {
@@ -80,9 +84,48 @@ IntervalTreeRoot *read_self_maps(void)
     g_strfreev(lines);
     g_free(maps);
 
+    return root;
+#elif defined(__FreeBSD__)
+    int mib[] = { CTL_KERN, KERN_PROC, KERN_PROC_VMMAP, getpid() };
+    size_t len = 0;
+    g_autofree void *buf = NULL;
+    IntervalTreeRoot *root;
+
+    /* Probe for buffer size. */
+    if (sysctl(mib, ARRAY_SIZE(mib), NULL, &len, NULL, 0) < 0) {
+        return NULL;
+    }
+
+    buf = g_malloc(len);
+    if (sysctl(mib, ARRAY_SIZE(mib), buf, &len, NULL, 0) < 0) {
+        return NULL;
+    }
+
+    root = g_new0(IntervalTreeRoot, 1);
+
+    for (size_t i = 0; i < len; ) {
+        struct kinfo_vmentry *k = buf + i;
+        MapInfo *e = g_new0(MapInfo, 1);
+
+        e->itree.start = k->kve_start;
+        e->itree.last = k->kve_end - 1;
+
+        /*
+         * TODO: The rest of the fields in MapInfo are used by linux-user
+         * for the implementation of open_self_maps().  These fields are
+         * quite specific to the textual format of /proc/self/maps.
+         *
+         * We may need something different to emulate KERN_PROC_VMMAP
+         * in bsd-user, but so far they're unused -- leave them zeroed.
+         */
+
+        interval_tree_insert(&e->itree, root);
+        i += k->kve_structsize;
+    }
+
     return root;
 #else
-    return NULL;
+# error
 #endif
 }
 
-- 
2.43.0


