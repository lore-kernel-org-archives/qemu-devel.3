Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51867C7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzNk-000316-8J; Thu, 26 Jun 2025 23:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uUzNc-00030s-Mh
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:03:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uUzNa-0000mX-Os
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:03:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-313910f392dso1410803a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750993433; x=1751598233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCaT80+woPzPW811tJJDtvGMU03636VebjfcJA5zUmA=;
 b=e0hdSyVoMixVcLG24ILgeJIcYw0WdTV2jUz5OZ4EyTQ6ginfKT7DriCCepdZMtqetw
 z28gotub/jXI2BIZ1AeUBtFTExAyjdALcXaUoaYLANHnE6M2eN/2qHz4WC9u2nw+cQGI
 h8yavGvEQ4IwEnMSsoemNY23Rv2V6BaQKevTO3ikgujTKq46VAfbiycTYXzyMGGzEuSS
 L8ECQoZyykODf9tER9XW5EHUrn45eZwhW24WmfQyL0n/iX9evjeAJf4eJiQY9HumCvJl
 MKDDGQRFuRTJX101pW2k20d5jL9gEVm3YTXjerjvguublRBTHW/1IWawEWhQeFfsIbo7
 8/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750993433; x=1751598233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCaT80+woPzPW811tJJDtvGMU03636VebjfcJA5zUmA=;
 b=NBS9n4yikFVGIwhDNXbYjyh6LEybIvBV27D944GWF8bceblnWXMc5IjwCqV4Hmctzp
 5uom7caUzOyHsrf+5YKgLiU/LirDNh4ysoTZS0Mlf2z21evFc7p/81QUjFG8zYpuGWgr
 FuaLaMRyiWtlk5qy2/BbgBbaefSreae1GziBOF8HWUYPi9JfuFRhDGzfWGdIPKLs6NpN
 JO1LWjPtxVmdb77EHdkJQ+myGhDChD+rC4IsAGlSIkM1Zork/fvuKsOMG7mvpOqfiZEi
 PDH6k099eLoXq9csaZM+57lQO8PqPZQnhWG2fohqNJIHGFPkv/PWuH0FZfEfg1W/HsRl
 d8RA==
X-Gm-Message-State: AOJu0Yye/0vc9+WGFGBJZqLKwPZJe+pt6kWDSgqFQe8cAlBRP8AjABG0
 bPyN4KFGq1LPTQpdm0aeFfB0Fy9IzFUDEi7sKje/1PQo5dPfys6FC6XHw7H5+GvMc/U=
X-Gm-Gg: ASbGncvjQxR769QwnoispjG912hDHKb1fEHOZtGRnbr5ojEGqjinOfbsBsFRP8khKnL
 Y6Wg3ctptGjEKM69knQlE9MUYdDFQTWxqtI7PFEYAgFayv+7E3ZM5Fa7tWJhDFu19bWyi7amjoD
 DVS81wRrcq3mrf0No4Aq6exPZQu9tedxZIB0HCYuNdo69CU6RcOgaCRnUjiOCmapdW+EvRSswi9
 pB/ougDXBy+fLBemcnLyp2yd08doNOFuSGCKoTh0Nqtxi5gjsU/QabIz8PFn4tTN5wVavvu8DkP
 hYMv1T5avoa2XY/V+qfuVQkSzwmq7Mu/13aCFGGj84HwKYRUHRD3YkN2JpsB8oWybRTTgGbHN0Q
 UWlzoV4Z0wwGMMkQOAj0ymuY20TX/dLlwjklBu76dwpyEhmk5WkIM8P4jAEZlWf87sNPu
X-Google-Smtp-Source: AGHT+IEHqtnnYC3vmlbkWvlmvNiqANimQMPgA+tKM3OKavILUjWF+KueOcwjHyXLQuGoKuVZWm9ngg==
X-Received: by 2002:a17:90b:2dcc:b0:313:14b5:2538 with SMTP id
 98e67ed59e1d1-318c93131damr1923137a91.35.1750993432640; 
 Thu, 26 Jun 2025 20:03:52 -0700 (PDT)
Received: from localhost.localdomain (awork062199.netvigator.com.
 [203.198.28.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318ca222dcdsm563448a91.39.2025.06.26.20.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 20:03:52 -0700 (PDT)
From: xjdeng <micro6947@gmail.com>
To: qemu-devel@nongnu.org
Cc: xjdeng <micro6947@gmail.com>
Subject: [PATCH] qtest/migration: Fix potential NPD through getenv
Date: Fri, 27 Jun 2025 11:03:19 +0800
Message-Id: <20250627030319.470-1-micro6947@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=micro6947@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


