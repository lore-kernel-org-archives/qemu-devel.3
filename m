Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DBBCA101A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 23:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skB29-0002Fy-BU; Fri, 30 Aug 2024 19:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB27-00026o-1g
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:59 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB25-0001rX-Gn
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:58 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e13d5cbc067so2518597276.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725060476; x=1725665276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwTaXma1P8wCOFOi5BsJFNvgHenJODlA3HdTsBM5hh8=;
 b=lPnFn0oXjI9eH0trUQGYNpTF4+8gfK1NmL48BvMxc/+mgtG376l+BSSPyLaai01RJ9
 Y4+AYOMAd0o1RP02TtEKR747I3CYqzaK3AymWDIaE3BY27cwBBxxEHmtlx2wOe8Ih6Kq
 BRWDLIkG1zSg5gLActOF+5uTFlmriPECCjclZAJs6ZRuCMqc0u1+Yf+0jJb1913DXR3z
 1zlxThaeNiLIraUGIOYWngtj4qtlFnJbbqbT8an7X8MhYeoAN2uTSWERI6p2o4+C9nfy
 LQfexdTk8Upd387L06hczYt1l+lssMoZMa0bcgSSjMDZtUTxC8lXOVvVrCUwoCi3K22l
 yV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060476; x=1725665276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwTaXma1P8wCOFOi5BsJFNvgHenJODlA3HdTsBM5hh8=;
 b=UP4wO18Dqq4Rxp4k6ymrOsQAyKgy90BmxcE5fRKS4yCs0IJMR8ytBVXRa20dy8wwIH
 ni/PhL0h2f/cLDL5rrB2wxPaYak6oqtrXU/d6n0WOab0XpxHacCPr2O6mnjbxEDuN6f7
 MO+BNKXiOirGKMWu4X9bFKh1T6uDDEXk5We1Mku3eEatQDJ15oOQ69O+kEtDPGz5nPr/
 Bc26C87/Ok4HuTDGJqywYdvBHB+i3RRdS/Bmqa6Ggt4W6fdXBIcLrZbZ90Oi4FgGz7zo
 ljtckz9oDLPQDKnQ79hMBLkSY0P6Rx9yzeTtwmCuxrJj6DnL/Z7mWksOfZtjBM3m224u
 4x1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkMKAZl7pQoiYX3YEKGrQ3uOB2JeammjjK/02d1BoBwL80giheOKvLMvV0VvmkLPtyOsIEWGTf12ij@nongnu.org
X-Gm-Message-State: AOJu0Ywsi1s+RmJSlo9w/loT6nx48fvgLmD5UtOzCUprIT5YbkLGdu5q
 E7uX1MJVuP3nd/+V40cHs2j4Xanrdj8CSjqFDKkculJPyQzUAqwKElp8gnYp3UM=
X-Google-Smtp-Source: AGHT+IHCOpvKqBz5shhbJntWKk8hIPq+ozwk0BCKFeFthiqNmlaEC2OsiLL1rpJGMD/Ama8wvsVPSQ==
X-Received: by 2002:a25:ce50:0:b0:e1a:8026:e71b with SMTP id
 3f1490d57ef6-e1a8026e893mr2736340276.54.1725060476556; 
 Fri, 30 Aug 2024 16:27:56 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca689asm19129176d6.109.2024.08.30.16.27.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Aug 2024 16:27:56 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v9 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Fri, 30 Aug 2024 16:27:22 -0700
Message-Id: <20240830232722.58272-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240830232722.58272-1-yichen.wang@bytedance.com>
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6c06100d91..9f74b1722c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2996,6 +2996,18 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3093,6 +3105,17 @@ static void test_multifd_tcp_zstd(void)
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
@@ -3996,6 +4019,10 @@ int main(int argc, char **argv)
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


