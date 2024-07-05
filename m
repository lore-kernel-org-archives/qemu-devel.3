Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71FC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnga-0003ms-8s; Fri, 05 Jul 2024 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngX-0003gI-6f
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:29 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngV-0006xa-Br
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:28 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b5daf5ea91so9705216d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204166; x=1720808966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KutmPWn994Np6PwDZgr/HazUDjFj/ksUem/XYsWNtpY=;
 b=IAWDghjRFARU/AM+0luOTyajmokwl7JGIk0VQ2wa32qCLqBuOa+nxu9TY8dpyHLdGa
 MudDcrMNVA5ljPPFmS3XLrPCqG0+816IJWVfWuykfCrKqylhGnq+bwo21qHR7jTamx48
 +jABA/66WCY6mJnDUk3LIhLERTiKyJ7qwPERsLu19tLhH87JnqVRwGFDMW9V1H5TtIBL
 8u4813WcVoyccn5EFRyZNbYQNvVxnjIhrMtrD42IMLq3iGGUgR+BwlrmfzF+dte07dtX
 FYoOCr1OEjI5ix55HPLc1ncFMaLId5SGbVHkBCyCadyT7IU1tZWMZSn0+a0kbf87TPS1
 SKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204166; x=1720808966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KutmPWn994Np6PwDZgr/HazUDjFj/ksUem/XYsWNtpY=;
 b=vK2Kfyer+HwSEQ07E0w17oCv5B7/c3HztFGmjf9V4Aug3YjTRo1CWNF8ntQZCzurY4
 f+PAAH5jAl8CcfhHtspVxIzPwrCTVNjAbOFI31FypmpTEXC0wLEfPq3NmgtY1pOWH1cw
 0gbr9LwZQXzfW50pT14gEN6zdhlH7OzSnYEYiWVl/SNtN37Iwq+Gc07iDwgYeudBsQWl
 pFtWfVEXN1vQmX+NGdCICYlnG2qF9gRlR5Obli3SDM4y0mT7NLhWC/XeSf/UDTE6abvm
 m/g044YiUz9lEg4Cty7tQXBMLj0K3b6nxOHhMcsIKyysHieFjJu/G3t08arV5ARx2TSC
 +opQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV86SZQmXLYu9bGeaIenENyPEpfTDa+6pQ930LkTr77JVrG+ofCFXwV67VsCSljONJskghjnFXZQYYiQMhytOCfcOy7KPE=
X-Gm-Message-State: AOJu0Yyr47XaCXpdWQSAIqD9R1i7hzZ2FTqTEDEMBuJ3zpw1MpcHzEfi
 QTTerGh+QZlm9+H43Qrgie21aMYliPNDrINkn51w07VJx76Lqypr/DnnnThsX1Y=
X-Google-Smtp-Source: AGHT+IGknK7Z9BKSWOdjzkCKNSYw2Wt1JecgJEcUV+fkjFSBLmajhLxI2csWhgbj1/Hx9wSxxQFQrA==
X-Received: by 2002:a05:6214:2483:b0:6b5:db5e:e20a with SMTP id
 6a1803df08f44-6b5ecfb1fa4mr70822456d6.4.1720204166264; 
 Fri, 05 Jul 2024 11:29:26 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-54-152-246-50.compute-1.amazonaws.com. [54.152.246.50])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5fb7e316esm4972936d6.30.2024.07.05.11.29.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 11:29:26 -0700 (PDT)
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
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 4/4] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Fri,  5 Jul 2024 11:29:01 -0700
Message-Id: <20240705182901.48948-5-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240705182901.48948-1-yichen.wang@bytedance.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf31.google.com
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
index 70b606b888..b796dd21cb 100644
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
@@ -3992,6 +4023,10 @@ int main(int argc, char **argv)
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


