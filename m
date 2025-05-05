Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32907C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl16-0004FO-SZ; Sun, 04 May 2025 21:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0i-0003ut-LH
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0Z-0002Vb-Q9
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e16234307so17451065ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409958; x=1747014758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=gyxGooicRajWLobYPeCsOYnDu/1pnA5q96DbVSye1orCzn/hAyTayR6vmJVXo4mlKj
 8BKtnbXI+QqZERZ87v33NyMJZQKD+Mn1Ttc/aOIiSp/QHej/86ijo/8mJXH4PqNjzAN4
 jf/rGhPb5+QEsc5sKFUF6LZafhxa4WHkZWfDBd0T42h8HukoVsAlIlzDElposK2Gsqxx
 tDE+dgfNZNpFiwku/i5Rie41HwLWoZBgUMW9Pyt2mE5Ih7h0KoctMooIOLYp2amTCxd+
 RY2+9pGKqRExholDaFZJOUm+n1wcdBjTMt/Apy7J4aJMK4nRt5JpR+VPuqVI8bVK6EO7
 dnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409958; x=1747014758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=e8xotB+0jc02D7ijGorIVh4k6McwQXznsjWPV+yv9pe9tO9kCHedEeLFTHbfO8/pLX
 91+Q11oZgeIpq6bDOgruz7Spnd8qDbSSru63kSbwbC/1mldGeKQmJOUNQKpj9v4Q+A/I
 vmT3sl3sgpCzkOZWdNtRNQhFsHf4t/3LM0NAfVrFlclxvwX8v4flg8UA4i4AgM9AAxev
 PKRwv3ZfcMygkP2NKaNhBEOaJRNXoILVnsR8JhGRJIMhiGyxDeF/0cibZ9y6TpJq//C+
 GdoCGMHv/ZwNL6ytuJhzYleqQMj0BvCXkVEaykcJGiZBnTLbKJ/4yPwYqhfjUNbLaD2Z
 9IbQ==
X-Gm-Message-State: AOJu0YxW7GtCRAqA1Zs3d4FrSc5mYaGU6v1GouwJD0yKeb/r0qwRzWkM
 uWGUnHVICIMpoe4OpLAVUtf6QiYnZrZYvwTAF6g3N6jl7U226mW/KTegncVHLPnX7u6UezGdiKi
 UeQg=
X-Gm-Gg: ASbGncuNj0onwod6ZcoMCg9xwTO6qsB8WA33/V8UZC3ALuHgT8Ii0WSfwFsnnLCTYXb
 PVH/yPoW9MLUBBTPzWtDG88Dt/dqdBBVXEkDJFSi8S5xc6K/G5rvCJ95svBLSTf474AZYPNBzzp
 Km13raLEWqyIyPSb7FbeN83Rd9DjDwXXEypG6vg4mn8fnYqYZjYnbyC4ivtnr9l9t2JSy16SPG4
 3z4u/oZinPeFaoSAqDM00DA5pzoKYJCH8nPESRyXov0Vz/5hjALqHwMJoXsnB2lZ5IfNE73YzJB
 Hxb7/AxX/tIi5MUbF1qdvF40d/JO0eRTaeGBZhrL
X-Google-Smtp-Source: AGHT+IEtIVHuMX4JePWDBmODChoDsS023u64Klr4UMTovaWNd58dYG/vCBHgFErrNE7uDGnIEc9MDA==
X-Received: by 2002:a17:902:e541:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-22e0863a1cbmr212774085ad.16.1746409958142; 
 Sun, 04 May 2025 18:52:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 11/48] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Sun,  4 May 2025 18:51:46 -0700
Message-ID: <20250505015223.3895275-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
index 00ae2778058..c3a1e8e284d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1878,7 +1878,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1914,7 +1913,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
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


