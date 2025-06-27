Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FE6C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8ur-00010v-Eh; Fri, 27 Jun 2025 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uUz3X-0005t1-PP
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:43:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uUz3T-00048P-4y
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:43:08 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-313910f392dso1402720a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750992184; x=1751596984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCaT80+woPzPW811tJJDtvGMU03636VebjfcJA5zUmA=;
 b=VU4Zgpj6XGtp11pE+3Wp/NKpTdpJD79KO0mtw+ApbBgJ4HHliwdZ/LHVJhuuL/w3NY
 r3gXOypHsSFXtdGu0Pb3OxdLiH7tgwxks1Yz7mVysfcSZ0kHQuWvaPFy8KeQdiZh58O9
 I4rEL1KJCZpGVjaxPnXZTJsgT1F50BpYCbKt48ioBTgi3nhfTUa6GJ2q9Gy/lBqIV5SB
 LaS120+YJY+ymh3Hp77UQ9sCL63RpzokztUF+MoyisrZU/9sfHGp49Qj0aTve2B4cN/7
 NGyN+wIJ4JnqA2Nl0ksxTaO7YPkQzWzb2pdAY8dSdBuK/9zyaNeOOl6EdAaMi0UfcJVs
 UWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750992184; x=1751596984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCaT80+woPzPW811tJJDtvGMU03636VebjfcJA5zUmA=;
 b=fSYdPrVQ3QqUNuToofEtQsS8jSDHM0MZaxtJJ6K2YNNo613/V/OCtGhw6oIFXXbg26
 UMd/ssSa+PTR4Shlvv0fB1Nh5R8azqy1ragCB0ri0jXer0SYftXh7gnw01B2Dh+Gr92f
 lYWHtQSSQ6HhjWnsoLnWc5d9Wo63AE7gNgt/HKlTcDgv0pxAlidlndiU0zRjkzXVvS1R
 o4olKBSBswe62pn1LiEFeQD+xHRKwnXTRpjFxjFrDhPt9AblH5xJsiNuKUkIw9qRm8eN
 PvYC/k8UJV+sRaVcqLdF86u6pjQACskik9qAbdsqeyx1fqFStT74vGjhQbVMJBxCyxRM
 t0tg==
X-Gm-Message-State: AOJu0Yz9qQ3DNWc86MdMQC6ibwSqVRIcNyHRWaG/UKbrwXBvNuJnTuqG
 ISiljXr9E6rhBMeRkIqKvws2vuUkjB+35R/uUjJNhkA7JESYqYvvMSaXf3OVJoDrAHqctQ==
X-Gm-Gg: ASbGnctcqxHJ6eRPmjNafVs7U+RPph8EUviX1q2w1ncnqiV+NDLU8ml3bcbYA4GzDqD
 GnnUEyFJj7kcLw9soi5Fs3VXwKvKCembulo3FbqlrpFrKpI1YaqPvRivGumT0HyU3QyGXxRRZV9
 17tNst5yqAut6jvOBaz9k2Wm227feBoy0wzQUQ+tkfLIABK4mfVoIV0jG5eAEm3VKejKohfOqY3
 e3em6DiE1/QM2C06UXpjJptdfZ4c80WkH2//G4y5/bRE1dqNXgDUFPWfeJ0r5xpCOvUc7wBQRhW
 6oIMgB2MFwgN9xPpez2Xgggkponzd264K2Tiwnz58P07RCN7JSBHn0f95HOX7gcrmibe/os+EQp
 cKrcuPxmh
X-Google-Smtp-Source: AGHT+IGTo4EXOyszvbTKlWC99oSPrkLjOfzAq325Q7nBdkXqbPtDP9RpsJcW2nzqEkb19dDoUYzuzQ==
X-Received: by 2002:a17:90b:5347:b0:311:e8cc:4255 with SMTP id
 98e67ed59e1d1-318c930f93amr1555136a91.31.1750992183666; 
 Thu, 26 Jun 2025 19:43:03 -0700 (PDT)
Received: from localhost.localdomain ([1.203.169.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318ca222dcdsm529501a91.39.2025.06.26.19.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 19:43:03 -0700 (PDT)
From: xjdeng <micro6947@gmail.com>
To: qemu-devel@nongnu.org
Cc: xjdeng <micro6947@gmail.com>
Subject: [PATCH] qtest/migration: Fix potential NPD through getenv
Date: Fri, 27 Jun 2025 10:42:26 +0800
Message-Id: <20250627024226.1767-1-micro6947@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=micro6947@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Jun 2025 09:14:51 -0400
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

In `find_common_machine_version`, the code previously assumed that
`getenv(var1)` and `getenv(var2)` would always return non-NULL values.
However, if either environment variable is not set, `getenv` returns
NULL, which could lead to a null pointer dereference.

Tracing upstream usage: `find_common_machine_version` is called by
`resolve_machine_version` with `QEMU_ENV_SRC` and `QEMU_ENV_DST`.
`resolve_machine_version` is used by `migrate_start`, which is called
by `migrate_postcopy_prepare`, and ultimately by `test_postcopy_common`.

In `test_postcopy_common`, after `migrate_postcopy_prepare`, the
function `migrate_postcopy_complete` is called. Inside, 
`migration_get_env` checks if `QEMU_ENV_SRC` and `QEMU_ENV_DST` are
set before use. Thus, these variables can be NULL, leading to a
potential null pointer dereference in `find_common_machine_version`.

Signed-off-by: xjdeng <micro6947@gmail.com>
---
 tests/qtest/migration/migration-util.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 642cf50c8d..45c9e164e2 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -203,8 +203,25 @@ char *find_common_machine_version(const char *mtype, const char *var1,
         return g_strdup(type2);
     }
 
-    g_test_message("No common machine version for machine type '%s' between "
-                   "binaries %s and %s", mtype, getenv(var1), getenv(var2));
+    char *varstring1 = getenv(var1);
+    char *varstring2 = getenv(var2);
+    if (varstring1 && varstring2) {
+        g_test_message("No common machine version for machine type '%s' "
+                       "between binaries %s and %s",
+                       mtype, varstring1, varstring2);
+    } else if (varstring1) {
+        g_test_message("No common machine version for machine type '%s' "
+                       "between binary %s and environment variable %s",
+                       mtype, varstring1, var2);
+    } else if (varstring2) {
+        g_test_message("No common machine version for machine type '%s' "
+                       "between binary %s and environment variable %s",
+                       mtype, varstring2, var1);
+    } else {
+        g_test_message("No common machine version for machine type '%s' "
+                       "between environment variables %s and %s",
+                       mtype, var1, var2);
+    }
     g_assert_not_reached();
 }
 
-- 
2.27.0.windows.1


