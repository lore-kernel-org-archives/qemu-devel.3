Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE4CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSMg-00087g-4W; Tue, 20 Aug 2024 13:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMM-0006VY-Bt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:31 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMK-0007iT-MH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:30 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6bf7ec5c837so23816396d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724173767; x=1724778567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fu2ytoXNSzEs6CAuET8jN7rfcutjHpuFFICtdDE+7w=;
 b=PsMdltztmF6ZmiUdqb911RhWRD9ucNfYdi437k9VewjWd0oorLWTPjZotf818prCK0
 ML/4tzVAXM38ejoDpY/jBcsictJ++vQY933VRwU4+M5H+9+yqYInv36H+DrwwJTjbd+L
 m3q3q6w9g18TPI8K0ZpGStLf8/do6dh0uLYcVchYx2OllY2n5H9lOq5TH7A9DY+w9n4F
 IJoifsxyYlSksx88FiROY8pOkxeKUbuSBrx8PNLxnvFC5YitEaAYgbjAiQ+l3bsdCCv3
 B8tPeOGt0IeykdQcR6n9EgIE+juT4jDcck0XsvWoAi9fG9val9op0m34crXBhuZH1N7Q
 LPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173767; x=1724778567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fu2ytoXNSzEs6CAuET8jN7rfcutjHpuFFICtdDE+7w=;
 b=lXQN85KEqIxVnFI61PpTbQ7xErIrn6QyOXqBTGuZtzygOPs6eHPyIIbOqYZAWnf4GI
 pg+/Nk59hYVqlkF+X2w+uJl5DItf2mLRVFlS1MEbuduEMOsYJFXX/wAl4lhrtSv6/m/P
 wlLv2Ai4BmVNtqoWmdVTmkyQ4CtPIRaLMTXmWPtWwd+VjG13zVx2AkIVYSMlRetnWom1
 bbswXV4q0AErkf9g/1qzeAAq9q06MehP+HKR/6oY1OZV2okwcI+CT4/Ca1hJYG5+mOBN
 vfVa1YZJFRH7eo4Cm72HaWDuX2at3nIR0UWNqomDqcF5KIQHr/36qVyVL2dHFFyhTsum
 6yQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM5xxtSx7XTUMQZ/sL2po6LQLOmttr2FqSvAFRqM7i/dzmX0xQ1ai681YF98vU/HIMCJt/BAWMoG0T@nongnu.org
X-Gm-Message-State: AOJu0Yyk/REQkbOSD3++AUbhA9d0syGtNZtj06EITJDM5bNvCnYwjX2Q
 1TyVjwXgt90HNjdUq4+hkGRh0c4ZeikSQvoIsSOloDg47CoGJSZC598JQ+xdYP8=
X-Google-Smtp-Source: AGHT+IFfSjDDBFTNg0f2v04lTAjUft1y+Qv8G3XUgkz97Hu9mADdq8djJK2gCofMbPE85HMxsUgmqw==
X-Received: by 2002:a05:6214:2f07:b0:6b2:d69d:a2d7 with SMTP id
 6a1803df08f44-6bf7cdb4237mr210875746d6.19.1724173766870; 
 Tue, 20 Aug 2024 10:09:26 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fef2372sm53599576d6.114.2024.08.20.10.09.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Aug 2024 10:09:26 -0700 (PDT)
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
Subject: [PATCH v8 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Tue, 20 Aug 2024 10:09:07 -0700
Message-Id: <20240820170907.6788-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240820170907.6788-1-yichen.wang@bytedance.com>
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2d.google.com
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
index 70b606b888..3aed5441f7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2992,6 +2992,18 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
@@ -3089,6 +3101,17 @@ static void test_multifd_tcp_zstd(void)
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
@@ -3992,6 +4015,10 @@ int main(int argc, char **argv)
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


