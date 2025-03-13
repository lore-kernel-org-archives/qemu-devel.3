Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB36AC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWV-0004nN-Pq; Wed, 12 Mar 2025 23:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWE-0004hR-KM
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW0-0007oT-Ug
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so9038665ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837546; x=1742442346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK//rMFZS5m/xTF4BT0rTuKgEK3G2LafBMbe8sULGLA=;
 b=jC5lTGaBczqXxsLMDHm5SmCR/pH5oPwBBpA3c50D7OLUpTzyRBYoxwNxQ0dlyo/dd1
 ij/d7jmkrgHy70+8W/We0WwiaET8Tm8FSztXJfwnyGG/U8iGtEjuYHbtUT+dEcz1ALCY
 62jnZUmNOtkWwrK8f4p4nwBHlFOoGZ76gx54PGNP93z/zY4F3uYEIyn2zNNvhYBQF8t5
 MG5CWkKCDlE8JVmA2cvL7q4XRrLhdUmOn1MT1HNh4ezdoiJudMRZ3b2lGR8+2Iwrdda8
 XAthbazNBbjqq9QH5TElsr74IIZw+1S+cBE+WnllFHrXrXQe55nbzFR/+tRQqO3w0zIm
 gWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837546; x=1742442346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aK//rMFZS5m/xTF4BT0rTuKgEK3G2LafBMbe8sULGLA=;
 b=Y+GGMecYfuIvmXKrx+YB4ivCS4hlaSZwIZlPAjewy0hTFkRv8c/jCc9HvT65xxfGlg
 uNWnvqblbelm023zcQL3723ovY7cMXFC7V/dnenveE5yzxCPRn/pQtlgO//D0HxtnTVE
 PRQOZ66Dcr1ueDRty6/hs5B6H4lnF1jQpJ7ctf1X920TIAzRC2CRQ8hF7IzZwm117vee
 WBPeYDuz9pv6HXfOohphwr5bQ+mp16lv1QTmkw3yxM0ZlQC69QAJ3o3/2iVJB1JDjruC
 VAlbnvibiiw1niKTtEGQ7yyCOSEoZUal4bhquK8BCmJYlgR7T4UbQk8Zsmgi7DABTyjW
 fxeQ==
X-Gm-Message-State: AOJu0YyDJVDMhNOIm3j5TmCUTOSqxXZ4+o3LLxdyYs6bXpxSQlBlO3RT
 QN1aQ+vzyJuk7TQJgou3PSgAr0GaPkA9ZvRLxrhHdQDA+kfMKjSFhOh4+zCkAjaB3cGJILCLWbn
 t
X-Gm-Gg: ASbGncsDtVpoO3BwubwB0wCaJbC00yy36g0Dh9Y8DBDTyoQqBHn0JTxAxndwd2631o7
 rVKAHPjP4cHNyrWG+u9s7lOn+/iKWrg2mMuwkE1bsDzf4yALNHF1fBmSRkNbGh/lf/wJ7DRmFwl
 TNH9jdIj/UgIbxXBHEgolzrkwSORTaXEVxfxtkZUNkTOzrYJDVPmjbS34yvqVtRpNMl301Mk4W8
 uyd1sTw4xKI8ek/+33cFBtSPNmaJf1iv6jXXDFeY4P1Wqe3o2mrFddTrRqpn42uBuEWt7zD9eyM
 JRiV+D5yKFKfKXFpqZl6L/onp9Cgwnj3xGUKh045WAiJvkxOZqKCiwWZ9xuYMCEamtkwSDUrFEA
 T
X-Google-Smtp-Source: AGHT+IGhq906jz/uvY1AWRPOwbMBifTyXFWqkHWaSfIHQrBAwAUjVgP0grYuoKfQwURVRLuCtL7VaQ==
X-Received: by 2002:a05:6a00:1395:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-736eb8a2cfemr15070461b3a.24.1741837546508; 
 Wed, 12 Mar 2025 20:45:46 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 25/37] common-user: Split out watchpoint-stub.c
Date: Wed, 12 Mar 2025 20:45:05 -0700
Message-ID: <20250313034524.3069690-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Uninline the user-only stubs from hw/core/cpu.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h         | 23 -----------------------
 common-user/watchpoint-stub.c | 28 ++++++++++++++++++++++++++++
 common-user/meson.build       |  1 +
 3 files changed, 29 insertions(+), 23 deletions(-)
 create mode 100644 common-user/watchpoint-stub.c

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556..2fdb115b19 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1109,35 +1109,12 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
     return false;
 }
 
-#if defined(CONFIG_USER_ONLY)
-static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                                        int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-
-static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                                        vaddr len, int flags)
-{
-    return -ENOSYS;
-}
-
-static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
-                                                CPUWatchpoint *wp)
-{
-}
-
-static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-}
-#else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
 
 /**
  * cpu_get_address_space:
diff --git a/common-user/watchpoint-stub.c b/common-user/watchpoint-stub.c
new file mode 100644
index 0000000000..2489fca4f3
--- /dev/null
+++ b/common-user/watchpoint-stub.c
@@ -0,0 +1,28 @@
+/*
+ * CPU watchpoint stubs
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
+{
+}
+
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
diff --git a/common-user/meson.build b/common-user/meson.build
index ac9de5b9e3..4dba482863 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -7,4 +7,5 @@ common_user_inc += include_directories('host/' / host_arch)
 user_ss.add(files(
   'safe-syscall.S',
   'safe-syscall-error.c',
+  'watchpoint-stub.c',
 ))
-- 
2.43.0


