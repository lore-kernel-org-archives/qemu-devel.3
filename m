Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08893CD1283
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFWN-0006B2-Ri; Tue, 26 Mar 2024 18:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWM-0006At-Q3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:54 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWL-0007dK-4d
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:54 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-60a0599f6e5so54655377b3.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493031; x=1712097831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvvN9bWVZWWSbtgiZ4urL26zjFTj2quV6f4+ZK80U+M=;
 b=Q7p0B/RZWDBWOEKBNZoxdP6IFrrF48xdjT9FsAWpd37PdChQjjNemDGf3WBDcmgw17
 Ye2MNZ9zRgg+/JVIw82MFnjiy1pFteBNt3JDgtEFCJZZl0AHCLj/LlstIW1P+xXx18JK
 wNy8sPq2ZfzjDe4qFnlhOd0sI099Zomw4MOp55E8XH0SKzvd8g9Ceh2A1tEsPMG+gmsr
 64reDAzstq7RokxQWTd+vV6raLvQm/UWNJg96pngpAup05/O0d0RGjUMnWzNzFBPHJdf
 BWupbpAnd36l0MOKyVLtK9DMxGyELzu2kMEpWUUiJb13lGlUOp54PK2Ghg2/yGoZ7t5j
 G2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493031; x=1712097831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvvN9bWVZWWSbtgiZ4urL26zjFTj2quV6f4+ZK80U+M=;
 b=oODE/Qs93SZJBb+RWwx6MOLFSASY1iJkXJkGTyCrPoegbk76PIOXcl0ngXlEc7WVtm
 QM19yY/UMN3zr3q5Oiq5vfVxzH7aNTI1egjvuE5RdccajjhqIYd5+yfKhN5GmtX/mV5b
 bMbmkyT922VISex8WmYekFZXLJCnwla3h/mYmUe1CpX5iPSe5HRIrX08WkhcUZJ8EVTw
 hvnGze+pL7j4rx0rRIJ/RRndIuwpjK1z1KDXmD+UMKeC0NQOEnYdYgTBA/FioRi5dpXB
 l+GGrW6qGiWFkk6uYRyK/Gw+1fEzlrkJQpNltMn9G+7h3L1fgzqdXOp7iDVCRfN0AA2k
 h+xw==
X-Gm-Message-State: AOJu0YzhzbevKQxOQo+pxupO1ghUON1Y7qBAXpgHyJYTcmPYNFbdAKVK
 4ZxeAl5Q92EOXNbRcyx5nZ9WX9Yjavets7QEy8Ac6UCfjvogslFCtjuKvqgKhWy5vWSSjG8jsBT
 r
X-Google-Smtp-Source: AGHT+IHh1GOjlCNE6QSHQSYThThivrzCEZ3N2EXgN9Xc2LvH3iZonEYmqLMfJbwP3QpCwMPjLiWt0Q==
X-Received: by 2002:a81:6c04:0:b0:60f:ff19:fde1 with SMTP id
 h4-20020a816c04000000b0060fff19fde1mr1103549ywc.36.1711493031410; 
 Tue, 26 Mar 2024 15:43:51 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:51 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Tue, 26 Mar 2024 22:42:21 +0000
Message-Id: <20240326224221.3623014-6-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-yw1-x1131.google.com
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

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
Revision: This commit now does some parameter setting to test that
changing the 'multifd-qatzip-level' parameter works, and to enable
software fallback so that the QATzip test can be run even if the test
machine does not have QAT.

 tests/qtest/migration-test.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 83512bce85..997f0aa323 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -35,6 +35,10 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
+#ifdef CONFIG_QATZIP
+#include <qatzip.h>
+#endif /* CONFIG_QATZIP */
+
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
@@ -2676,6 +2680,22 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QATZIP
+static void *
+test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                              QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    /* SW fallback is disabled by default, so enable it for testing. */
+    migrate_set_parameter_bool(from, "multifd-qatzip-sw-fallback", true);
+    migrate_set_parameter_bool(to, "multifd-qatzip-sw-fallback", true);
+
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 static void test_multifd_tcp_none(void)
 {
     MigrateCommon args = {
@@ -2711,6 +2731,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QATZIP
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_GNUTLS
 static void *
 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
@@ -3600,6 +3631,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                test_multifd_tcp_qatzip);
+#endif
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/multifd/tcp/tls/psk/match",
                        test_multifd_tcp_tls_psk_match);
-- 
2.30.2


