Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903C2C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh75-0001Jf-Jr; Mon, 26 Feb 2024 14:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh74-0001J9-VY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:10 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6r-0004ur-Nc
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:58:10 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe592dso1778250241.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977477; x=1709582277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hq1QawsT8MllTo+xYm9OfKbj2az/Aa/YOrPNVEv9ZhE=;
 b=RBAUA095LBaDjfyIwaS7KyXQGvtrZLmHb2F5ZKnbGt1qUOdwwIumJao6JWiOIDX1I1
 J/sMmZB8x4PgFGonLWE+j0pRku3Hp+yGkwXsNIWELfN/jkp1ZCt4VgiMzIXZ/+KtmrEh
 H5cjAMG/bke6GqaUFDbPVrI4F+fcX6rfHgOhXZbKXyXpwDsJUydnBSxZn30LXdUt+BZF
 yUX2GnLtXt25I+KnLG6jnXmaHJK7IZNdWP+7FYoR6mr6ER7ZjAIKrcsKZu2IYP5fvUO7
 lYsdEtiOa6hDxG8o/6gsKKirpdmsLCpabP7g+HSy3y2ijClI6x0IwVC57c0cUFrPCl2t
 LHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977477; x=1709582277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hq1QawsT8MllTo+xYm9OfKbj2az/Aa/YOrPNVEv9ZhE=;
 b=E0lIpGLa0EPZAfRgV71wVV2R+TNQmFPPpH4DAiGGIqx9P3syDxhcO62FKjxq5UPoKv
 ANF3tTafqZpbq75tIlHfyPnUjN3pWUMQzJasGCOM6KDPrlXOrby27cQYIvy36ImSMIOh
 i/nHbzjxz33Jbd6lgco7ECO0GBllqera8MVRDvIXPjeB8Iz1LhBkmVyTEq6s1n1vROJj
 rHi2PgYCsNN+VlvGiq2U4r/wQdoGFTAbZz1sSFyymTUici6XGvf6deLmH0Q+vRAQcgi6
 3CN4eFhCL7Oh6vdNkSAq7bvIfObqkZZXWNM4zh33RF1cwZPIsHJpC8gKUE9LomL7wb33
 MRRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBor/661B7NXlGhyB2O3hSrjFmZ4oT7O6FgYfD4juhSkx4fh1Y3V2/eosmhgmJ+RACZ3RcnnafXo8niNih4hIx5T13Lic=
X-Gm-Message-State: AOJu0YzYwnVPGzzd39mNcKNw99jXtRrl5SL125zpD9xuZDwBdN0/szrB
 JMH2dwMPuqA8Y/KxXQ+DYsYMmMY08wU5h/2rLrpVyISqsFzIKhEB5S7Ag0Q1UFM=
X-Google-Smtp-Source: AGHT+IHwXlE6BMlZKOQaMqVrymYi8lbN7eUUWEWsl89k9I0iGew2eAnv5xZ4bqamtlTUD3A/ev728w==
X-Received: by 2002:a1f:e701:0:b0:4c9:c252:6afb with SMTP id
 e1-20020a1fe701000000b004c9c2526afbmr4506850vkh.10.1708977476783; 
 Mon, 26 Feb 2024 11:57:56 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:56 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 5/7] migration/multifd: Add new migration test cases for
 legacy zero page checking.
Date: Mon, 26 Feb 2024 19:56:52 +0000
Message-Id: <20240226195654.934709-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that zero page checking is done on the multifd sender threads by
default, we still provide an option for backward compatibility. This
change adds a qtest migration test case to set the zero-page-detection
option to "legacy" and run multifd migration with zero page checking on the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..65b531d871 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2621,6 +2621,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+                                                        QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
+    return NULL;
+}
+
+static void *
+test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
+                                                      QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "none");
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2652,6 +2670,36 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_zero_page_legacy(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_no_zero_page(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3550,6 +3598,10 @@ int main(int argc, char **argv)
     }
     migration_test_add("/migration/multifd/tcp/plain/none",
                        test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
+                       test_multifd_tcp_zero_page_legacy);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
+                       test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.30.2


