Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A1DC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEvP-0007tw-PC; Wed, 30 Jul 2025 18:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEuq-0007Kb-LR
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEun-00020m-Pm
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so3324515ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913088; x=1754517888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6X1CoA2MgT2UDXjHtgYe1Dd844yiDM2yHYqoaWtzog=;
 b=Vxoev6Yuvj8l13PYBU9bpD3sgueG/jJNCVT9LaE+UMwQ2dBrMhJg+sXBfh/K0J1jJC
 04ar8Z8K1EoYtIJ5TG3hH3okvllJ7umLGl8WTIRm8vbu9rTdsEwUdNEq7XNaSxiVS+FP
 P0Dl0ea6Mh9JpzYgf0FJUeJuDm1UgelM2O1X71Pxa2e7vViEl+KsIUs5WE43PWUGE9VT
 ShNuH6jb+5xg2YRys55a8AqWFuUZ/vV1PB75EO6PvcaH/Psi6NDOBwCqmrmLgL8B43b5
 Z8LcXEjYUZhVNz4cnmlHt8xFrdZilF8LKnKn2v6DeCgJFO3fxpCdCdITG3p7nahJ67sM
 lz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913088; x=1754517888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6X1CoA2MgT2UDXjHtgYe1Dd844yiDM2yHYqoaWtzog=;
 b=h68tyvOyMa2SkmP7dDiBMaLpKBKA7SuSa1YbGnpLX5qdVObcPUbb9F3JuQLGLAxL91
 okVlQRolRg9BijXaPm0MjE9Wc6p5mYCJcn9BUy6RUkdwbxhRTv5Qvdcce6ok09mmJrsA
 RkSwFDSArBgE2OYd5DYPjQv8f+CUl8eQcMmPHv0Rhmfng3NLzqE7uFmJa+h3bUYCr2jU
 qDBw+ZusrU2KTuyDkVfU5Vns1WnMV2xJyQjR7//oO8JhT3YCTAMEF94eEpdcMH87lOG8
 yqsWaHnJlqV82Vej43YsPUaYsWqjp7IgdeBbRlFPqADG+6eocmIggy7GE2RGTEOLcfzq
 6HrQ==
X-Gm-Message-State: AOJu0Yx/KlsDPOJXf6wujKjqNSf99sQBjZmAAZj5UxXDaNDKBrSmOqJj
 JNHNXiUzaMKVg1cJs/ONm0FFIdAXjgtiq24ZpbulaZ5dorfjc+QcUqJtzN33+gfijXISBg2BWyl
 f1RQG
X-Gm-Gg: ASbGncvUin2GvOOIJLz4HhdUIV74avYmNtk+hfB7hkavVzfpq26uBb5FHvk46WbOTUZ
 kpeiWJoOLaCQO7KaR9IP8COQDUobI+jzpN7lQ6+h4ndVYCBBOQMza2TJrK0mQomyq7GuFLJ/1tk
 q/nUPfqJ/3beYOeKNlep3sDIhkqogdxVaSxnghuunUsMIbet/rIQga9Nw9hlJRnIV2BZYvkK5L+
 Avj4XQWXQqq/eqOn09yLf2IJbh8Sr8td6nE6A/F+J+uCyDUnxq0IQXaSVS/8Gse18Qy5HJZl2z6
 //d+HUJM6n4B3ocoPjN69MhGD3y3/OPMnSak9MAbEZjSH2q7brPcWxgIR6TDw5Z9NmZE9+6O0af
 AXToaAcjSlql2BZdDXNJlWDb18WfNpj3b
X-Google-Smtp-Source: AGHT+IGqCd1xW1yq8SvtX26K5x9DAetlgToaZJXlxbmoNQXf9DBgGPSaEqTOuI6NbYAGmBENgb4q/w==
X-Received: by 2002:a17:903:3c70:b0:240:2145:e53b with SMTP id
 d9443c01a7336-24096a72c1cmr72214325ad.9.1753913088177; 
 Wed, 30 Jul 2025 15:04:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e757sm1095645ad.55.2025.07.30.15.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:04:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] migration/vfio: compile only once
Date: Wed, 30 Jul 2025 15:04:35 -0700
Message-ID: <20250730220435.1139101-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/vfio-stub.c | 16 ++++++++++++++++
 migration/vfio.c      | 14 --------------
 migration/meson.build |  6 +++---
 3 files changed, 19 insertions(+), 17 deletions(-)
 create mode 100644 migration/vfio-stub.c

diff --git a/migration/vfio-stub.c b/migration/vfio-stub.c
new file mode 100644
index 00000000000..f59ebe075dc
--- /dev/null
+++ b/migration/vfio-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU live migration - stubs for VFIO
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration.h"
+
+void migration_populate_vfio_info(MigrationInfo *info)
+{
+}
+
+void migration_reset_vfio_bytes_transferred(void)
+{
+}
diff --git a/migration/vfio.c b/migration/vfio.c
index 0b64e49ef06..af6ae2c1e19 100644
--- a/migration/vfio.c
+++ b/migration/vfio.c
@@ -8,13 +8,8 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-types-migration.h"
 #include "migration.h"
-#include CONFIG_DEVICES
-
-#ifdef CONFIG_VFIO
 #include "hw/vfio/vfio-migration.h"
-#endif
 
-#ifdef CONFIG_VFIO
 void migration_populate_vfio_info(MigrationInfo *info)
 {
     if (vfio_migration_active()) {
@@ -27,12 +22,3 @@ void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_migration_reset_bytes_transferred();
 }
-#else
-void migration_populate_vfio_info(MigrationInfo *info)
-{
-}
-
-void migration_reset_vfio_bytes_transferred(void)
-{
-}
-#endif
diff --git a/migration/meson.build b/migration/meson.build
index 45e9445f97d..0f71544a825 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -49,6 +49,6 @@ system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('vfio.c'))
+system_ss.add(when: 'CONFIG_VFIO',
+              if_true: files('vfio.c'),
+              if_false: files('vfio-stub.c'))
-- 
2.47.2


