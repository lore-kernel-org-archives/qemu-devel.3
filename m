Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA8DD2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KEG-0001iI-Fa; Thu, 17 Oct 2024 02:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KEF-0001ht-Cs
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:23 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KED-0005Jr-Tr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:23 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2cc469c62so432760a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147400; x=1729752200;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMnx/3A6xdIIvLj6aaYgJOG0jaU0Jmn5Vj6VTmTpdGs=;
 b=aI50HVv4AdtwNXttA48piL7jfY5t3jVZL+kmw9UY3534Zj8pRgZQwM7w42ME22blQ5
 jN6l92AIySgcWW5o5jK9HK/UpxqP7KLpHKwbczOEyQLB9tMtqrZNUQTz0yiA5u0/x+1P
 vqmC/8ub8C9lwxXDr9a6iHQL21dA3/8gdoWzVPtEvKCwDcfdqNKyZZmAb7NC18/WbMj4
 G7u5zt78cPvH5a+OVluww7R9vt7zwzLZY7JojqCD63auL5LNNJhY9JEK0L0PouLxXDML
 7ryJJpTjFNEmnWxT9e/aksZuopQQuO8y+3fH13/kj8MutLOaddfJ/++6KUO2iW9/c3j3
 gkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147400; x=1729752200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMnx/3A6xdIIvLj6aaYgJOG0jaU0Jmn5Vj6VTmTpdGs=;
 b=Po1zzMxOVmBAft6d9Xo7HH4JrxJIpJdJXGzWmVKzlrpZ+HkXlYxVYP9hNt+lCV3G5+
 pZ4q+Zkh8RBFN9CthZceqT8IBbpbqWygrgnqVZgvmJBLRuvm47Wtkkw8aPz1p3QMMXG7
 1he68Rq0N+zdzaUx+soT8zxsETM66CIWSL3aXrg89I/swsksN8y0ekZgJyvDo1I569Yg
 GJak3XL9gTAcrdJfLoVE08/BaVzcdHayC5uCCNp5V6CfIPCxIwqAC6ThtaVpbmpEtiD6
 wq09U5zZAhs33Mk8jpm87Mi3g1fE0shcf7pOnZzIke0nrjwo8hG7Z9DRAClYvz3hCWt0
 dlWA==
X-Gm-Message-State: AOJu0YwSkx8ifvDhAjHA837SOa4TnYMdOtEZoCzuYFE4NeADTww4x4y/
 2jrY2naP93b2AAYov2JyLo3cfwNyvAWDEBZU0qDgRd8fYxI4WPwYmLtwmv5ozncMnfRWQAYt/Ju
 bC+wQ1g==
X-Google-Smtp-Source: AGHT+IGWcofpFCaTqLPfkIlm95VBexhfdRfXYNh+PzP11VZ1wqGjquG/JE0np6sJ2+Ku4YY6POBEIg==
X-Received: by 2002:a17:90a:8a92:b0:2e2:e660:96d5 with SMTP id
 98e67ed59e1d1-2e3152f4b3bmr22148378a91.24.1729147399890; 
 Wed, 16 Oct 2024 23:43:19 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:19 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 6/6] tests/migration: Add case for periodic ramblock dirty
 sync
Date: Thu, 17 Oct 2024 14:42:55 +0800
Message-Id: <cb61504f1a1e9d5f2ca4dac12e518deb076ce9f3.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 95e45b5029..e6a2803e71 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2791,6 +2791,8 @@ static void test_migrate_auto_converge(void)
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
+    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
+    int max_try_count, hit = 0;
 
     if (test_migrate_start(&from, &to, uri, &args)) {
         return;
@@ -2827,6 +2829,36 @@ static void test_migrate_auto_converge(void)
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
+
+    /*
+     * End the loop when the dirty sync count greater than 1.
+     */
+    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
+        usleep(1000 * 1000);
+    }
+
+    prev_dirty_sync_cnt = dirty_sync_cnt;
+
+    /*
+     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
+     * the timeout to 10 seconds to ensure it changes.
+     *
+     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
+     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
+     * to complete; this ensures that the RAMBlock dirty sync occurs.
+     */
+    max_try_count = 10;
+    while (--max_try_count) {
+        dirty_sync_cnt = get_migration_pass(from);
+        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
+            hit = 1;
+            break;
+        }
+        prev_dirty_sync_cnt = dirty_sync_cnt;
+        sleep(1);
+    }
+    g_assert_cmpint(hit, ==, 1);
+
     /* Now, when we tested that throttling works, let it converge */
     migrate_ensure_converge(from);
 
-- 
2.27.0


