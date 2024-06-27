Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F4AC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 22:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMxhl-0004OB-FJ; Thu, 27 Jun 2024 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhj-0004Nf-LO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhi-0001iF-4M
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so25005b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1719527695; x=1720132495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOAT5gDyAvXabU/mbHXnK4mX1K+SUZSTrna0ZkHJn74=;
 b=AYYWtyTR184/Bqa8AqXbr0Ac8RwgoOTfy7ErOF/XExgf9MwVOfBdvVasgv1Jpx1YRF
 OCTOKdWBzP98a3bbNvuon7YTRBSX9RitKmh3vPODtOb7toWLsibyQ/WUMQtglFFta5/X
 WHYsg1pGXlTYQAznEg513wkiYW8OWJlyd0dGHr02k9IGqS6r9YSdp//kx3+TsJyJKCZV
 1/1iS7BuSLFjiICUBKwlf+ix/DkAjn7cDIyFncTqDK5h0yoFGdvEJfP9JBb0jbwG8ZPO
 t+qOQrF3naRjjJsRj4TktLWAQMAPrtn9N1UX9BJ9zTY2FIZqOSBvi/Uqm4ufrKwcDVty
 0Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719527695; x=1720132495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOAT5gDyAvXabU/mbHXnK4mX1K+SUZSTrna0ZkHJn74=;
 b=o1dtFgo6TtMheZ3t5keC7+CnD9m4WKUjqTyeZptfgfC5q6mcwisn1CBLgvfderRkJY
 RijjwZ9JN3ehreUYa4DzzYN8ZP+KNx1Gno8A4RHMQH4LzxzX0EsFXVQg7TT80wZzELfN
 0kgeEAG5RUDDwMvxZAGR2aLfWJUFVLRHnQroiHsKL+5jWiI1BvnVXFF0XiAu12QWfHXJ
 WRXDGp3Ytfm5uz6qzNHNYwvzvQ+XZrWU8foC1Zs23kj+w5mvrqcap2Ar16kl4f+udBs6
 5MoRg5+M/FQBXMEePN/8lqYcVZj1YnNWgxxMmyB+kdlSNTyJCsaZeTxlgtQVWBm94L9v
 CFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH/Q1i04YIraUZyZcF1OUD5kZVKGlUIYEjmZz+IO1Xwna0mc+e0VXXznNs9BQXTAiNM18GHwDrELd/xoD7ZW2LBfulVO8=
X-Gm-Message-State: AOJu0YwI73N7cqU3nZWYQREYbwVYHjW+j9zKjv8hY/GyWUDRuIF0Pq/q
 X9+0VOGvvfqi+8gfVJuZIEGr/n3zZd8wqkuAxPZEmq3o8KoJKZO9Nyuplv8+F28=
X-Google-Smtp-Source: AGHT+IFHddC9CuuSRYkX/aFXfiWmf8bNUG0d/0MSlFvqOoOccuZZVTwSaxb6MOkLYjXBrOcsEyhWrg==
X-Received: by 2002:aa7:908f:0:b0:705:bc32:5357 with SMTP id
 d2e1a72fcca58-7067459c765mr14693727b3a.1.1719527695008; 
 Thu, 27 Jun 2024 15:34:55 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080498a02csm226900b3a.199.2024.06.27.15.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 15:34:54 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v3 4/4] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Thu, 27 Jun 2024 15:34:45 -0700
Message-Id: <20240627223445.95096-5-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240627223445.95096-1-yichen.wang@bytedance.com>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=yichen.wang@bytedance.com; helo=mail-pf1-x433.google.com
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 571fc1334c..cc4a971e63 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -32,6 +32,10 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
+#ifdef CONFIG_QATZIP
+#include <qatzip.h>
+#endif /* CONFIG_QATZIP */
+
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
@@ -2992,6 +2996,22 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3089,6 +3109,17 @@ static void test_multifd_tcp_zstd(void)
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
 #ifdef CONFIG_QPL
 static void test_multifd_tcp_qpl(void)
 {
@@ -4002,6 +4033,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                test_multifd_tcp_qatzip);
+#endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
                        test_multifd_tcp_qpl);
-- 
Yichen Wang


