Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74C8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F1w-0006nv-Ld; Tue, 22 Apr 2025 10:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1u-0006nX-MY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1s-0005BB-Oi
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso45207115e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333718; x=1745938518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydE2KK63QljieXni2VjK8GOTNoowF9wO+YxCs0gln0U=;
 b=FwbGXz4Kjg14+YEboUlNCy520yejgWJitGGHzUizf5CuJ8Itv4rQg0fHqSOfXrvJG4
 49Tq4ho0teMOGBO2lp3TJsJk1ZorLGbMSRnAk40/JwT+lOt3Stl6HVt92UW6BKlvc6rs
 erM6VN55WndIqZeirINjHYaHw+tH1pzkGb1bXK5FHgQIGYoAn/6kJimU7ZZVznEjA2+K
 cUhYJ6Sfad8Rb/KTTZ3QCmCM571KbJwh0DmtR4Y+kTs9SZ9rPclBPszNdvKozdRJXngQ
 kd2KlcQhqBlsA8c6t8FTB7k7dhVJQtzTEVStx8w6r6Z0uqHz6GFcpBbRwfgXfYlszI4c
 c1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333718; x=1745938518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydE2KK63QljieXni2VjK8GOTNoowF9wO+YxCs0gln0U=;
 b=aB8j0jZ+w23bC9XpLQ9Ctu0XRTjUI217Ui/vjxndxqoZSBorzLNd8JPBcW1sO0da2d
 aR4MBKxQQFvr31I0jOVG5stjbobcb9k0jetkQdPJQuiTp30+RMfL5E/u2yqqqlaXHeSK
 IwQxVg3dt5dkGbR7teT/vpzs2+WLOenMtsOb0DKdTykhvTTcVSoic2CWnHPCdzKpheNZ
 oU2LpHuYwrP0JWR/aDx+5VDJCGqvI5uSub7mA3JmEbUl9eSW7ReLpRNAvrBneKqLRNGL
 A6b3R7JVh8zHd5JEVtCgVhTTz7IYk2p/yH+rAYTBEKYO1ojBhUndgOkX/rdZO1akyd6f
 JIvQ==
X-Gm-Message-State: AOJu0Ywz/hjpHDArxJa2jh9qJcun5ZVp/VvEUGRbRVyZIMnAvb4E4yRJ
 3u9TIFZTfjjOrDlrplYdWSGhXc7oeD1uWFcoNJ8nw+7bVifHkBG1OcELg0EwV36Yuu7gNE4pCjo
 n
X-Gm-Gg: ASbGnctE8t5O8zb/9jvBFucIxGs6GbLjUQjLEVzvoW680r4PIk5lNl1qAlY0m7ZyTAA
 1vKroXGPO098IUsXAGSUfwo5Zr9bBkpBoi06uDZu9W9djj1XwNOB6E9hJ4r2hoFl9xk9WhHUHPX
 CIaF7VQR44g6Ufa73WEgDJI/xttqCMdc4GGI29lPV5QFpnTGPkDy8jpjyCzO4GQshPqRjGch5qA
 nqBttetNIVBmaXeXJB5GuPck0FZKUAlcdq6sZleyHPacGkapjQn1AjlKd6UKI0SalTjmyJqhPUp
 p4yrf55LIqVzxbxTF59ZihHCuyPyEZjiPXSmmdi86wJI/03Yi2QhjGKsD3RLoJBednc1slJjSoj
 8m+p74ZunkY4FgRY=
X-Google-Smtp-Source: AGHT+IHtTb2TjgjbZiWl0FGnqiMWCBMZTjbg28nl0sVW6dlhpLV71JKnJ4Ie+yepxbXuNr/3SXawbQ==
X-Received: by 2002:a05:600c:154d:b0:43c:f4b3:b094 with SMTP id
 5b1f17b1804b1-4406ab7a726mr124073815e9.6.1745333718382; 
 Tue, 22 Apr 2025 07:55:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d19ffe8sm10525865e9.3.2025.04.22.07.55.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 03/19] system/vl: Filter machine list available for a
 particular target binary
Date: Tue, 22 Apr 2025 16:54:45 +0200
Message-ID: <20250422145502.70770-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

This can be used by example by main() -> machine_help_func()
to filter the machines list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                     |  1 +
 include/qemu/target-info-impl.h |  3 +++
 include/qemu/target-info.h      |  8 ++++++++
 system/vl.c                     |  3 ++-
 target-info-qom.c               | 15 +++++++++++++++
 target-info-stub.c              |  2 ++
 target-info.c                   |  5 +++++
 7 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 target-info-qom.c

diff --git a/meson.build b/meson.build
index 09b16e2f7ae..a1109b6db3f 100644
--- a/meson.build
+++ b/meson.build
@@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
+system_ss.add(files('target-info-qom.c'))
 specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c276b84ceca..4ef54c5136a 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -16,6 +16,9 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *const target_name;
 
+    /* QOM typename machines for this binary must implement */
+    const char *const machine_typename;
+
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 1007dc9a5e4..0224b35b166 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -16,4 +16,12 @@
  */
 const char *target_name(void);
 
+/**
+ * target_machine_typename:
+ *
+ * Returns: Name of the QOM interface implemented by machines
+ *          usable on this target binary.
+ */
+const char *target_machine_typename(void);
+
 #endif
diff --git a/system/vl.c b/system/vl.c
index cdf6eb9ee49..e8706a9ce87 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -1564,7 +1565,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
+    machines = object_class_get_list(target_machine_typename(), false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
diff --git a/target-info-qom.c b/target-info-qom.c
new file mode 100644
index 00000000000..a6fd8f1d5a3
--- /dev/null
+++ b/target-info-qom.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU binary/target API (QOM types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+
+static const TypeInfo target_info_types[] = {
+};
+
+DEFINE_TYPES(target_info_types)
diff --git a/target-info-stub.c b/target-info-stub.c
index 076b9254dd0..218e5898e7f 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -8,9 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
+#include "hw/boards.h"
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .machine_typename = TYPE_MACHINE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info.c b/target-info.c
index 84b18931e7e..0042769e3a2 100644
--- a/target-info.c
+++ b/target-info.c
@@ -14,3 +14,8 @@ const char *target_name(void)
 {
     return target_info()->target_name;
 }
+
+const char *target_machine_typename(void)
+{
+    return target_info()->machine_typename;
+}
-- 
2.47.1


