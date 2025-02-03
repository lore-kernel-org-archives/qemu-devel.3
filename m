Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0305C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyk-0007zF-Ee; Sun, 02 Feb 2025 22:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyi-0007wq-3o
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyg-0002e9-Aq
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:27 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21661be2c2dso63485605ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552705; x=1739157505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1C9JfQ7GmNodpDRLscChLFNi4X9hLYpSI+5VG9BaRA=;
 b=d1nHx79hAdMfF+N94vntDlaKBmGfqaZWnvZxfhOFz6ilF3UuKJOjx3L62zEJFIW5HX
 F9MdwQQ/US6jkIZrU8OTaXVOVN6YYg94XotNilfTZObRMIELhQGubxEfFnZdqkjKID+F
 CA4MwMS5iDSF1ikgYt+OuJm3n0uv8nheEgsOBRZ6eMI1Ge8my47WiiPuqS0526COKmf0
 b7RV9l5cgEhNPUWl3XLnMeqMez60OZby2XfAok/n2AEoikkuDmMFbRxYrwlc8lPGQU+f
 2mw2j7rFDzdT7VTPzsxFV6x/vS46VMHglv98h0U/e2IEK8xbFw9A2TAupbn/R2Z6I4Fd
 cKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552705; x=1739157505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1C9JfQ7GmNodpDRLscChLFNi4X9hLYpSI+5VG9BaRA=;
 b=GeYSYXUXiZoawzTaeIZIImmzx8kBehofB+taqzVb7mlEmRIabQ3GSrbVd5HUu+RLH7
 y1PzFBvTOsWebiTvVkN10uQzSvOesV7gc9kYu3HiOK4GkyraAeTEBoVJ2TZnwBwHCM1r
 b+Ypl8s8Xuixdq4phX1bzaegpvs2Ur+WQvdELTFoeXk+fnH2RwBVKjOy14KVXE/9uWch
 oflyUdg+TpcHSO5P42s8XIuxrW8dxD5WmLwrFsgAXF3acphJM5a9g/bEesX8yvW26ksn
 5UEaYyjagN7/Nw6oKkCfz0A0ssJdgb5qnPTgaEa5MAg+4c0DrTZhFRcc0EHEZqlgsQVJ
 1zPA==
X-Gm-Message-State: AOJu0Yy5bnqORcwaN43ZA2idH+ZkOCEXFW8WlsN+Y8o662eGoX3Zp8cV
 E28Qp4kYNLMJjdKZti+iuzlOZGTqM8MnNtqkAsdjswGFjUF+1C6+L0D02uquQRpJzwEF8KG5KMj
 h
X-Gm-Gg: ASbGnctcCi/nzo5hD2FQSTyGaBMQlcauXNs8AnzJXgYKItiCjqvE1pnUyaZdiPiyUk0
 WF3SVDRzFogJRUvQbD4h9HAyHwqC4u+a/pYg7WWUaVz+CEuog+XigrxJDD/uyhhq87YWghSK3Hk
 rE+thSfCBsAec5GfuIJaimGwFbwiuEmPw+gYx6+2eWn3qdGQkSXsxScFbnDzrgUFUo953nQEFaC
 oISZCDUkCyt0eUAQh5ssGQrsuCrRvV7z7QhVEpOtJNTmVLOMxTRhJ6k2c9Ed7EuKDvC7CuqPK8c
 z7hmCl1FMeX66Jgfe9N1whjpaF8EH9gR1GRG/rrdgK2cQsg=
X-Google-Smtp-Source: AGHT+IF6z/mi0DT/HXeXsBL/mqISQL6qO4fUfO5SZL7Xuuivy264wqbFtsDI1E9iWkovkFRAfJiYEw==
X-Received: by 2002:a17:902:ec8b:b0:215:aee1:7e3e with SMTP id
 d9443c01a7336-21dd7c4e41dmr325483565ad.5.1738552704876; 
 Sun, 02 Feb 2025 19:18:24 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 02/14] tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
Date: Sun,  2 Feb 2025 19:18:09 -0800
Message-ID: <20250203031821.741477-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

These are not called so frequently as to be
performance sensitive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/perf.h | 23 -----------------------
 tcg/perf-stubs.c   | 26 ++++++++++++++++++++++++++
 tcg/meson.build    |  2 ++
 3 files changed, 28 insertions(+), 23 deletions(-)
 create mode 100644 tcg/perf-stubs.c

diff --git a/include/tcg/perf.h b/include/tcg/perf.h
index c96b5920a3..050ba855ab 100644
--- a/include/tcg/perf.h
+++ b/include/tcg/perf.h
@@ -7,7 +7,6 @@
 #ifndef TCG_PERF_H
 #define TCG_PERF_H
 
-#if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
 void perf_enable_perfmap(void);
 
@@ -23,27 +22,5 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
 
 /* Stop writing perf-<pid>.map and/or jit-<pid>.dump. */
 void perf_exit(void);
-#else
-static inline void perf_enable_perfmap(void)
-{
-}
-
-static inline void perf_enable_jitdump(void)
-{
-}
-
-static inline void perf_report_prologue(const void *start, size_t size)
-{
-}
-
-static inline void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
-                                    const void *start)
-{
-}
-
-static inline void perf_exit(void)
-{
-}
-#endif
 
 #endif
diff --git a/tcg/perf-stubs.c b/tcg/perf-stubs.c
new file mode 100644
index 0000000000..ce2dd1a4b7
--- /dev/null
+++ b/tcg/perf-stubs.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* TCG perf stubs */
+
+#include "qemu/osdep.h"
+#include "tcg/perf.h"
+
+void perf_enable_perfmap(void)
+{
+}
+
+void perf_enable_jitdump(void)
+{
+}
+
+void perf_report_prologue(const void *start, size_t size)
+{
+}
+
+void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
+                                    const void *start)
+{
+}
+
+void perf_exit(void)
+{
+}
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..2977df5862 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -25,6 +25,8 @@ endif
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
 if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
+else
+  tcg_ss.add(files('perf-stubs.c'))
 endif
 
 tcg_ss = tcg_ss.apply({})
-- 
2.43.0


