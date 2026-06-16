Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB926CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDo-0005fj-Nq; Tue, 16 Jun 2026 17:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDe-0005aN-NP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDc-0007R9-Rn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:14 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36dd65b95f2so263465a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644871; x=1782249671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwHofvv5b4D6PAnuAwIZ35vtZNb0237w6FOxDkbf6sQ=;
 b=BHNtRsRHK3kPqpYPaXAyTBv9d2U/K7dpVRz8AJSgsLFN0rXTAD+R4VZNF1bvpuDe/K
 1Z8/Zmn2OXwUNO/yqPokzO6tmDmQ1LlLIyIQjI3vVUizi7kZeGwV4X0DGNczGh2mDVCf
 tQ+x0mtB4hlu6QBVpad2+FdAegMAYLQPUHYtBGwLPcpKWeuoCsDryuOYo3q5Mlp5v2AV
 Kce9oPXUefNgXhZ0jqzQxAJmd+9L/gwgIcLIjk5zYM80E22FmRCLBQ1noUKYTwbCOm+8
 mm5UfSo93adXlYNgXS7LiI9tjR/rQxQulsLzqDgL1xPiJUq6GjF9ULtq0/3cdqL8GH9q
 fgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644871; x=1782249671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwHofvv5b4D6PAnuAwIZ35vtZNb0237w6FOxDkbf6sQ=;
 b=R4DJent+02RZGiK6yTsFR7hy/NOaQZJb6oAIVEZtw+SUQzSVIp/tB086RR7qDXIjM+
 YPmVtVQtu47FE9rJlM3zIbfv7DhoUl+8lHR/KGMXKMwnNGOX/ydhIk9X51ga7ddqt0x/
 fFgHSnPDplWM+gIK2AWIQzAJ32fBrsMlzbHbXz5WSMjt0HupPap392oubNa3oy6PeC4F
 QV//8eSxXbUIPOE3XjWwynfyperOIEk8tndrplkUAQp4ZniB2oQD7BfbnzFHN1iI4DeL
 UhFhXTvUbMiizUeS09euH3LOcQzbG8nWhIGeTebZZZEGx6REBx9TsR11VE5b6zss0eyV
 xKZA==
X-Gm-Message-State: AOJu0YxEGYOgCcygonixfqkdg4aAIqFdcAkh2HucyMv+vHSC5ycW3T1k
 heZDMnzsahV9BO6itZjSvTJo/4G/U4XdDu3C0BtfuIwWEbwLfg8rFqiyMwrSlFKfUGcUFVaZDbE
 s1BLH
X-Gm-Gg: AfdE7clbUPWJGnQzDQw+4MQ/thX0C7D6pB3wtI+fFfwcnoYEnZx3CtQFrqDc6fMo873
 bpKTD6dXrAJsr5bGsk+crgAioHPWrEPlQLZjKo3lXRvp7mjouAmSTnEV/W6Da7EnBLw2h4rS3Ir
 U+apNCM+avBQfdUVgzUQTyKLPFbEzfEp5r9ezTi2IcFc2OVcoO2UJznXdB4cwud7HuwDuSiIAw+
 EhlFEPEMDgWv9lHCXaJ9iDOucbWMYG3kQHmIT9k5CMMv4DPe1bGngN//uwFDc4CxlhL2TqA96WY
 6pR2RQHWR9m57uyXHjBIR6ahhUbolq5etzDEAu0i+lozUc4Kj4UItuy7uv5pLRBSiS6RZmg6iDh
 wBQpyComwnsDFJ5qLc5BhXk0+ulPq15DNTQui5ng2AVowMHnozzgn3vlveHQr33IhFr9H/diEe8
 CE0+2X7AeTJrt4nJxBIZ3vy6EMQZBeTAJ8V6j6EqA3bzdPBY1Gt6OWPzQ5x7Xz
X-Received: by 2002:a17:90b:1dc8:b0:36b:769c:c037 with SMTP id
 98e67ed59e1d1-37ca685fad6mr247345a91.5.1781644871487; 
 Tue, 16 Jun 2026 14:21:11 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 10/13] common-user: Implement read_self_maps for FreeBSD
Date: Tue, 16 Jun 2026 14:20:51 -0700
Message-ID: <20260616212055.334466-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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


