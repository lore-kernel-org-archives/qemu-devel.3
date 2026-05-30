Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79535CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzf-0005hJ-L6; Sat, 30 May 2026 17:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzQ-0005dR-BL
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzO-0000h0-8o
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c3546924so892045ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175581; x=1780780381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwHofvv5b4D6PAnuAwIZ35vtZNb0237w6FOxDkbf6sQ=;
 b=dXEtOXmjiHT6CB6no8XU/pSPeuxjAgEOmWtLPHfAS61S5IC2Nc4U7dlX1SG30lqzIR
 6VGInoDJfBMYodZ9IyIWsOY3w9MmbZS4oaNA3F1p3RXMJSskMkBiqra98ymKZ3y9oFtA
 KKNlj/z4mo1A2ED8QlAPH6EpwTCZMvpZLkOaVM7tckUeUHRfcrs9sAbH3UqD1f91t4XB
 +cJ1r1uHQhIfkqmOugzJpQNJItjzVwQNlq6S3TW2eHwXV5+NBwRltb1JX/AGYaGy49eR
 W2L7MMop8bLK6z6GP/e0Jd3m/7NIbGVpVmvTjKF78C9qTZqVLbpCajxdwgtY1LJia/q/
 eLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175581; x=1780780381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwHofvv5b4D6PAnuAwIZ35vtZNb0237w6FOxDkbf6sQ=;
 b=VhRz27UQ76DRqP+WoznF6HXujDLZcDlx6pMnylyC4HGarC8OJ3W6pI3EFbDsbUNYTZ
 Rmq7o/owJMS7z6BJwTqhsksAK7xDWz32Dn1YbtOgw8jcSGjql/GaOIyCJ2cjJHAQ/BIy
 eWrfmB2Jpj+TtV7Aq9nV04OtPGwMVHF9eE2amXbsfbvweQYSJdY9C00i5SHm+dlxf4Nw
 u0yNVOT/aLOTbdo75UdO7Fvcgikel28SunvJl8odtiG2t0aRIFygFs0+NdIpineiz1TO
 poEADf+4ZzLsLxtnK7epKH3hCjlfWTEz5W13/A6Oh7yt0ZLduVoFKaev1nybVx09Sp1x
 fmuA==
X-Gm-Message-State: AOJu0Yw3liVktTkTgkJALyX20cHt48BCtILIeAKk6ikfE4fjzgyPalcR
 KHCuxS9vm4qu3I+vMHP3zG+6xrqMIaFyfDQ0W8q1eoMtBjZIGLobk5fUL7eukBLJILef/y6mlHa
 o/IYg7w0=
X-Gm-Gg: Acq92OGtcCjLgwy+fcFMbux21fslsaYtCcyxw+5x2EaSlrZG1zm1V2L1g8UzTH9Up2A
 HMOdYEEBSC7Lurw/dc/jKW4rPUd/L1BnGI4igh9wkwS1gZC7BFb3Zi4v8fDuA8RvXzflD+SeD8Q
 LW1ZY3JyOQdgQMejelgAd6q4ic3HDXQbX2hTRJ4dWoPFWPdC0E6lVQtVMsaa/N3B3aS1VcQQs1y
 hVhyB5d3oDfzcxsnKZnzefXCydRAiS9d5nf0xPvt5PHH44u9tQYPIfCPQx/sV4jVBCxHtfTC/Ee
 X7uK4zB4Rht5SANt7uOHmUT/KVjCFmKVkFbFBNBvgNG5cqDXu1wDhfZ7bR0SLIO4C6h7Pj+pyUW
 BMZgMlBgd7xi5qulJr3mV3wiu2Ta98geSVCZqJkJgdUBLWfpmGCYKZDZtOmJSWsVTjvg9gcMC9w
 b+fNekO4wr8XDbjZmulGcIia2ST6jtvx1C8rX1S0F8kaByGgWTOA==
X-Received: by 2002:a17:903:1905:b0:2b2:5491:e32f with SMTP id
 d9443c01a7336-2bf367c8d3fmr60093345ad.16.1780175580853; 
 Sat, 30 May 2026 14:13:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 10/13] common-user: Implement read_self_maps for FreeBSD
Date: Sat, 30 May 2026 14:12:44 -0700
Message-ID: <20260530211248.375318-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use kinfo_getvmmap from -luser.

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


