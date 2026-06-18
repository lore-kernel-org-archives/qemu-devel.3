Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4F7CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIso-0000Sl-7J; Thu, 18 Jun 2026 15:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIsm-0000SM-Fn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:58:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIsk-0000MR-V3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:58:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c6d31bfc70so9033945ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812713; x=1782417513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iAXbBFVKIe8fCwdUITV3KmDYWZwayTbI3PUyT91PmE8=;
 b=Tw+Cz5CAcKOj0UTMqKln1sPyT/gX1xJRRTYMLWtAMvtjKaI426Lab+af5YOSozaGjk
 GEjY8jaCwpjml8XMyGokQ4eEoEGY5doLe4zMQ5vuO7+h+Tft2VWpsRizfnmw2mN+VEHO
 oOh3+w0XoL6SKnrB6uZ3W10mmAleooJaV9qW6q58VPM1m/D/ZVbGd+xhkY48qfVbStXT
 6nNHZlGhsSoajGqVGlBygbVbdK8T+8KRFuF2FFYg0OVuFLBOoNxqVhbfil9vaAgLn+3b
 w9LdLhp3T9Kyel+gKn40SKGOsf+MuQbOWdvAtrU355UDpY35G7al6JeE1AT7E0Uy7cde
 wz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812713; x=1782417513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iAXbBFVKIe8fCwdUITV3KmDYWZwayTbI3PUyT91PmE8=;
 b=A7oTKdzImfXjO5vfeToj8HJmX5lOGgjyAjA5JtqfUuwgAVydYGnebh8xeaK9GBySD9
 szzizw05UCgu1xZqmdoYc9i5WKhidwZwSXRc9yhcRWBX7QDvt+NbDWnr/vRXteEulHAm
 0u9gAFWmOFXgm23Vd+1dQVQQwfyjkZlchUqSM6WGGHWeb1u0aoNn1myf6z/kIe/FP/kU
 wtOFZ0thE1vMV+THXq7TiTD5BfOUT2epk6h1caav6UXbloOborvBaBMY5YtO3o9dWfjz
 8lIE5hzMcjeQP1eF3whTfNEDMyMU6d0PJDBBX8tVVQmIeFq022XZ9SzMLUtA9Ar55gZF
 3iKQ==
X-Gm-Message-State: AOJu0YwJ8PcRiUlACBHDTxXKWOWLNrxJ/HGxhKSnSozq0o/QvcLJdmd9
 uwKxOyd9q2Tl6PZ3+sz97AWy7AFBVUkiYi35erxaf2X/thTwTvW91wkfjEJTFgfKwksFHrWj6Jr
 we35+
X-Gm-Gg: AfdE7cnwceoxOHqLvW9KKm4or9t+TINE9BdniYZ5mwNe5J2v/1QACWACCTgGR7MCQlD
 iKn9+l7Eyytk0TZeG9qOYOepVP+QjbrROvGDZAZ+tNyRZY9F21KMsr1C2dW29yaQ3jOFeUmbZLO
 oLGo2vY35vGFOChw7cpBlC75A6zLqjyhsS0PwBFHzTg1XU4zd/oLpB1HhCrWrANepN7is+KArcR
 PIxbGdz19zgmKj8HoPr/6i8VeHuVhBMxAoD+1hHpW0Kfu4G7FfRFsAgvcE/rLrafZ4wuc0RKl53
 zGBwobC5Vvk3cQFjOnxJ4nj/9OTMsA0P/SRV4lmn+fKDqJaT/Vj9hPq5BtgZAKBS9rj3MbCj6q3
 JIsK8tPKw7gGNbTsuB5c2Ri61E9wRZQH+4Fdq17bPmjxmCWAe/0P+++s2K9H//efDB0Fwvas+It
 e5/jS8l5GjvLpCZXYeBa1jxELXxYS1Zpr28NTTlNhCKwRBxVj0tQ==
X-Received: by 2002:a17:902:d541:b0:2c6:cbcb:bc77 with SMTP id
 d9443c01a7336-2c71900a21dmr5932365ad.28.1781812713410; 
 Thu, 18 Jun 2026 12:58:33 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205776395ad.55.2026.06.18.12.58.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:58:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/13] common-user: Implement read_self_maps for FreeBSD
Date: Thu, 18 Jun 2026 12:58:29 -0700
Message-ID: <20260618195829.590072-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195829.590072-1-richard.henderson@linaro.org>
References: <20260618195829.590072-1-richard.henderson@linaro.org>
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

Use sysctl to fetch the vm map of the current process.

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


