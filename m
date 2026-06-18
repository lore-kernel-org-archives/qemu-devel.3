Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A211CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqH-0003vt-Vy; Thu, 18 Jun 2026 15:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq7-0003uk-Vi
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq6-00080J-GW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c6b3f71648so18132365ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812549; x=1782417349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLc4bOAmdlNUJRnLOKeEd6vpG/eMlgp574CGKB+t3Qo=;
 b=jHrva1++Irnf/T605J2K4kmszMzMAQZ7+h1AmSztrMg8H9KqGu+Rdug1LPQz0ty0G3
 LZ8o+wn7yAnz7FRiyNby3w5vNTpHYTqgu7CDi48tTzIA9sS24hdJNMWzIMTse3Gsot9b
 UrjoDdCva0ccflfAV0o0V+AVfQr3iYfYIjIdgxtOjsdSJtkdoljN3yziZOz1toGBl92S
 oXH1ekrCCvdXcGqpbAlmFyUzfxglbYbBwUsysH6HWHWYFO3OCB1TMTX6xmR1R6nc7AI4
 kUr1A7xemsGxeWqYIzv/vrfsnqeGbXbR/rFvC7dpl9isfpwawCX6KTxe1YF9EmMkWOJO
 84Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812549; x=1782417349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLc4bOAmdlNUJRnLOKeEd6vpG/eMlgp574CGKB+t3Qo=;
 b=figz7RC3RpmTQRo6i5kyUMxmf5TGu55pzrZgdO429tZWQ9EamCdjOvKezusTxmPm+/
 rE8eI+qHBiFrs4B/+TZB+sOCI66LEGPvJmTXEVXAl2duWTGTSZBkBvFqIyts6k2SvIsK
 zlfPeNrNWobjJfEU4ftsQF2mc7i39//1bXKZTcgjdSkL9KI/qZET/xAdDCZ7ZyFNb2RP
 CrtahgoSzoV+TgPBI55lP5JZ2pC5UzP8/5pAa0VknBxa9tYA12ZRSg2Mb7WhCfL9P9ey
 Ixgb5cdH5TP/NIMoPogoTOJ8iC4si4sO3sVWPakWx0SQCfKiadz99KRZXKcx++CIXNVV
 M5OQ==
X-Gm-Message-State: AOJu0YxHA6qBERc/NrfYFiJut1/+0748MgLiiX/loAQuN8hn7tUB2EYQ
 NLvTc3KtxIISCP0p0FaT+SKw3zg9kCaMSW0pqkwGWm1ccnHpW60G0JMG2bLkSZYs9VkhDb2L0d8
 eWhA2
X-Gm-Gg: AfdE7clm4PNoTZ7JebEN+YrbtfPFDo3vPHaYMuNSIU3jOgX/bIalYVZNJW+CrRJTu5l
 g2Xj3aqKDCpCYTSf0iBR96XivQS6Ux3xLa5TvB7n0ghlKeBDOvSon1RhcVRnqCMJzkkNVM0iHGi
 Q0yveGrUBfb4WCIDrQY+a+JHKMiq3lIH5jtZOeBgQJTvz0kfYfV6LxzKma6IBqF6kuNh9uO/kc2
 wF/wAzgOCfrL7HdOOHc6ewaqlQ6KZy7U77xVoXa/wP2IYSJV7HTWDuwq4bQhrn0kqszkgd8h1x4
 jRWj50oYcp8sl9Tgmo7fNPaDe4fbLzp1DQfyaOEcSy0pSUNf71Qr8BHEHLHNiumczF8eCNye+cp
 09An2vWIr6ulYJMw7ZSURiiSknohrSvvMLZemo3dd+6pzB7MSr5SqekvQ2KHVAJW/wT3i5uSB0x
 qNAbmiks3liqIwj7nNA0xNNcv1q02MFkzhNUMGkh3QojbhoHN1hInJsWpZZ2UO
X-Received: by 2002:a17:902:d488:b0:2c6:9758:9db2 with SMTP id
 d9443c01a7336-2c718caf4b0mr6429295ad.3.1781812549224; 
 Thu, 18 Jun 2026 12:55:49 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 10/13] common-user: Implement read_self_maps for FreeBSD
Date: Thu, 18 Jun 2026 12:55:16 -0700
Message-ID: <20260618195520.589907-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
 common-user/meson.build |  5 +++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/common-user/selfmap.c b/common-user/selfmap.c
index a1b88dee66..151d066801 100644
--- a/common-user/selfmap.c
+++ b/common-user/selfmap.c
@@ -9,6 +9,10 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "user/selfmap.h"
+#ifdef __FreeBSD__
+#include <libutil.h>
+#include <sys/user.h>
+#endif
 
 IntervalTreeRoot *read_self_maps(void)
 {
@@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)
     g_strfreev(lines);
     g_free(maps);
 
+    return root;
+#elif defined(__FreeBSD__)
+    int n = 0;
+    struct kinfo_vmentry *entries = kinfo_getvmmap(getpid(), &n);
+    IntervalTreeRoot *root;
+
+    if (!entries) {
+        return NULL;
+    }
+    root = g_new0(IntervalTreeRoot, 1);
+
+    for (int i = 0; i < n; ++i) {
+        struct kinfo_vmentry *k = &entries[i];
+        size_t path_len = strnlen(k->kve_path, sizeof(k->kve_path)) + 1;
+        MapInfo *e = g_malloc0(sizeof(*e) + path_len);
+
+        e->itree.start = k->kve_start;
+        e->itree.last = k->kve_end - 1;
+
+        /* ??? The rest of these fields are only used in linux-user. */
+        e->dev = k->kve_vn_fsid_freebsd11;
+        e->inode = k->kve_vn_fileid;
+        e->offset = k->kve_offset;
+        e->is_read = k->kve_protection & KVME_PROT_READ;
+        e->is_write = k->kve_protection & KVME_PROT_WRITE;
+        e->is_exec = k->kve_protection & KVME_PROT_EXEC;
+        e->is_priv = k->kve_flags & KVME_FLAG_COW;
+        if (path_len) {
+            e->path = memcpy(e + 1, k->kve_path, path_len);
+        }
+
+        interval_tree_insert(&e->itree, root);
+    }
+
+    free(entries);
     return root;
 #else
-    return NULL;
+# error
 #endif
 }
 
diff --git a/common-user/meson.build b/common-user/meson.build
index 831a7273fb..5e041de55e 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -10,3 +10,8 @@ user_ss.add(files(
   'safe-syscall-error.c',
   'selfmap.c',
 ))
+
+if host_os == 'freebsd'
+  libutil = cc.find_library('util', required: true)
+  user_ss.add(libutil)
+endif
-- 
2.43.0


