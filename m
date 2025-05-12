Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD41C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXP-0003Kw-Sr; Mon, 12 May 2025 14:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWo-0002RH-Lt
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWj-0008TC-N4
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:25 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b2325c56ebdso3605507a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073120; x=1747677920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtoWRnhexqhEbtmi9AyX1L5MqLgfQdzBe/SXZsSvaEY=;
 b=wY70rSB2NKao29XyXFN2HeTdjAJ6a3OYTOFbUi9VU0+yW+X8u38nnGV/JNNS2ETDkK
 L8Au3TBbJRpNWZNg+RQhFbqS9OGVnTGPYmwjUHhQjsyK1wxplt0/lYNOjlZUMphBE6mu
 V/LEFucRv/YmLpFBkR7CKhEXZKTT8OWfdxJjUnRWsQvhawG/ANl6l5DQmss6bJjIuaFH
 Yz7Tst2EcEaU7JVZuB8KW00tdWcFXWwcqz4wll9gPtlqKE8hlkLceR+Dc6cDwOHWASYU
 C2qB79hn4p8vj3DPB7E6qURDqhYd9xlg8RtNZjbqMAG23Ir5HzKobe1lZ1Ze0lJNgDQc
 kX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073120; x=1747677920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtoWRnhexqhEbtmi9AyX1L5MqLgfQdzBe/SXZsSvaEY=;
 b=CBixsHwNgQigGPlBdittViS5h5KP8bo3Ws0qoWTvuKfPVI015hE82rCGNc/M3wJhfN
 ny7BEMZ2ldDPt8HheHO5aVskvRHAwYsRrIBbwwnfgpOLobNIN4UXKuy7VXnAWeWuYH0a
 /tGviJ+1xNA/wpbFGX0kkCEaWWCfavTfS++DGoNNY1IExcDEElyz7aN2UN3CohPDX+8z
 hSn4S+LRBhASJ6vyT0qI86qXQ+/1wz3VlTtidjpZ9e2XIkFNp1h2AM6NHX4ZN3I6O3PC
 jMo7S5rzZ9VCY7/mbq4Ddcgr+J7YOoAd57PrsY5ojjRvbbpJ51lK18yPIes8nPxAPJzy
 syQQ==
X-Gm-Message-State: AOJu0YygXef8erl6W0mzKX51DZfJFZUUSmKtDDIWWUT5pVbbaar25vxk
 j/3aorBcwhMx8Y2SCzWmpWI4Il/JDj0mwg88C0gxsGQ8uv3KPPlZKKI/DlWFqE50CkVmCFHyKQH
 Y
X-Gm-Gg: ASbGncuWqRzw7cbr8jCScHwaPOs2RNBaygbdwEbFcLkqKhL8e11aY9l2mtofMDr6q7H
 w1mTpPq45Ts7NHcJHlfFn7DQBrGza7ZrN7b2Z7jOX9lrFL6aHhziN933DMaf42A0qy0/Y0gIQXs
 jJcdWGXz/KsLgAWVBG2JS3G6TStvhDv1opOGMvml83jQnbb3i5inUR7ZhYKd9sX/zlpO38ESF0/
 w9Q1Fn+A4GB75U+2c+ygFbfveZUhtD3p3C1CGdirYD2SMOn91/izcPv7Z7PgKHEWBAIxhKdTgW7
 fRwDg6sj7BSBynxxNeoaE2KdDSDeWyS7sBN1igZmI18fpQjl0lc=
X-Google-Smtp-Source: AGHT+IG//ZC2tU4+ufVtxaRs88BbVlF8JqsECFJysIZkUPjN2rUU+hJ5AjlLR0rJIxAeA0859MMfvg==
X-Received: by 2002:a17:902:e747:b0:22e:5e70:b2d3 with SMTP id
 d9443c01a7336-22fc8afeec8mr204881035ad.1.1747073119969; 
 Mon, 12 May 2025 11:05:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 09/48] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Mon, 12 May 2025 11:04:23 -0700
Message-ID: <20250512180502.2395029-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Need to stub cpu64 finalize functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b97746faa87..a604e4ccac8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1877,7 +1877,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1913,7 +1912,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
-#endif
 
     if (kvm_enabled()) {
         kvm_arm_steal_time_finalize(cpu, &local_err);
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
new file mode 100644
index 00000000000..81be44d8462
--- /dev/null
+++ b/target/arm/cpu32-stubs.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include <glib.h>
+
+void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..c39ddc4427b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,10 +11,13 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_ss.add(when: 'TARGET_AARCH64',
+  if_true: files(
+    'cpu64.c',
+    'gdbstub64.c'),
+  if_false: files(
+    'cpu32-stubs.c'),
+)
 
 arm_system_ss = ss.source_set()
 arm_system_ss.add(files(
-- 
2.47.2


