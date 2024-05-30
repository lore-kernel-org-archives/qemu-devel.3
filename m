Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF5C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcUV-00072m-KY; Thu, 30 May 2024 05:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUU-00072H-5J
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUS-000276-I1
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so612174b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717062871; x=1717667671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TK1ni0WgaIAGvB3Nq6LtzZBMjfwj1klth7CAx1fgods=;
 b=mInto20shjHDIpwG7z72lltSXa7pOXGVZIikZWw/Bi2rlBU4mU/hLXIRnQgrNCj5qj
 GpGNeGNgJMCs8E/w/trsTJk1HWZXpY+ckab98+Ms46iucDh7E1Qm6dIbX5QSwYqIiWsa
 8sdFB1FKfnoEVs5JA23eIQ+RmKgarsGtf8pfMpFi2tEOdd8jfTiFh7AYWhDJGonKFldW
 C8GL5nesiBLE9z3W1TlHwl3vSeBNKbdLD0ik86N7b6fJRGlAGsVHqLBxFUlf1mvGEAUk
 eNRUSK1IDDfUdGknRG4ssIpOdwIHq80Kgi7TceM8bpL1JktedwnjRL/xePoYHL5eDYQb
 FuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062871; x=1717667671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TK1ni0WgaIAGvB3Nq6LtzZBMjfwj1klth7CAx1fgods=;
 b=iaFEJCZ5O/9RPa4OfNDEE+V12T86kvuNnSx4vSJ3ZxBZOi2kn1gqnXKKB+g7c7C4XT
 hB//Sbkj5yy/mJgfVZpoOGCuYPo6tGDcxL5s84vgXSipjUwSS1KImsX1qEkd/RPNcfcD
 v50f34IyS/qt4MaSpiG/GjfDaj822l8xV5kai0ex1SakpodQkRCrEcL439DN/Fs0MS7J
 102OhDQzAtIT8OgWAPq+z45u9/oF2aLxHHaMANBrNIb1Mtvd0SfXAnub8F6VmYt/7eHe
 cTcrFDqsRZcVxjjKz28BbQ6WMSg1U4tniOkJWvJKXsZDzV31tO8WA1oc11rr26U0QWwj
 tDAA==
X-Gm-Message-State: AOJu0YyDHzMSXTT5Vz9jy2+Kt7RSOqFrJYhTT28EOvKqz7TvAwfxEtY+
 UIuN4bJXfE+AlWVKHOPbjo6tmhOIU6/yltijsKp3VEpA/+XmFw4hnst1QaUc
X-Google-Smtp-Source: AGHT+IHoJe6tacDUNBRIkkTeRjLeh1PkK1t9VXQmu8+akCLLS36F7490acIpv5ITjs41XxCRNd9Jog==
X-Received: by 2002:a05:6a20:9747:b0:1b2:2ed2:b80a with SMTP id
 adf61e73a8af0-1b2646905c1mr1367658637.61.1717062870748; 
 Thu, 30 May 2024 02:54:30 -0700 (PDT)
Received: from wheely.local0.net ([1.146.0.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d28asm1183626a91.8.2024.05.30.02.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 02:54:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 3/4] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
Date: Thu, 30 May 2024 19:54:06 +1000
Message-ID: <20240530095408.31608-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530095408.31608-1-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This test is already starting to bitrot, so first remove it from ifdef
and fix compile issues. ppc64 transfers about 2MB, so bump the size
threshold too.

It was said to be broken on aarch64 but it may have been due to the
limited shm size under Gitlab CI. Now that it uses /tmp, enable it.

Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index de380757be..86eace354e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1855,8 +1855,6 @@ static void test_precopy_unix_tls_x509_override_host(void)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-#if 0
-/* Currently upset on aarch64 TCG */
 static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -1865,7 +1863,7 @@ static void test_ignore_shared(void)
         .use_memfile = true,
     };
 
-    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
@@ -1890,11 +1888,11 @@ static void test_ignore_shared(void)
     wait_for_migration_complete(from);
 
     /* Check whether shared RAM has been really skipped */
-    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
+    g_assert_cmpint(read_ram_property_int(from, "transferred"), <,
+                                                   4 * 1024 * 1024);
 
     test_migrate_end(from, to, true);
 }
-#endif
 
 static void *
 test_migrate_xbzrle_start(QTestState *from,
@@ -3535,7 +3533,8 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
+    migration_test_add("/migration/ignore_shared", test_ignore_shared);
+
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_migrate_precopy_fd_socket);
-- 
2.43.0


