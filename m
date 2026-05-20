Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604A9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYV-00012z-UR; Wed, 20 May 2026 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYU-00012c-UG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYT-0007C3-2J
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vn9S4YWBBUyNsbzK7Kv4pTmuJjtbGCJAtYj1xtt9Mvo=;
 b=KiIQwos/Jj9Ns/IOc0HdKtxwjyD+4Re1YEvakz594H/jSLNb6DmuFbN1PKD2rA/89TU6xq
 rC95xNmX6VGqvSArr/BbRxtdMW+YCD5lbGvbPN1MZooO8eATer1dO+KTpreu/TzoGHklKU
 mjx681q+nmR8QqtVL5COuj+ot1R2JrQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-MW-x2jRGMKqzZQgNlXaeHQ-1; Wed, 20 May 2026 17:34:15 -0400
X-MC-Unique: MW-x2jRGMKqzZQgNlXaeHQ-1
X-Mimecast-MFC-AGG-ID: MW-x2jRGMKqzZQgNlXaeHQ_1779312854
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b1f39c5827so130261506d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312854; x=1779917654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vn9S4YWBBUyNsbzK7Kv4pTmuJjtbGCJAtYj1xtt9Mvo=;
 b=iV4wAd1k3Kewims2vOEYUxmMA35gXGFCxd+tHvnGVJrmzn6a1aKQwy+B4keJCsyoXv
 g/xn9MGhdClh5DJi3S7r3dhaOzjjR2lk5sBMoZiZxYaX83T24Qy5ufbWjc7UOaWduBjr
 Vy5wdV5vF6x1Eaj08u6oKekiqTF5hjMVeeFryMycYvegRYa+rYZtLGA3PpVxzxHQjz0M
 n/HtM8uBHwsHNqJbXE+BDquJReZFZehgzzGRa0iBTBpTPLd6evuajgVGM02Y9pVRIyFJ
 WVZsDE8PX5MDGouqpk3s/NLT6Iy85r0J1Z6ZU5u48j6L45oR8wiH2ctkpa5KRFZnFFIp
 Ozrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312854; x=1779917654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vn9S4YWBBUyNsbzK7Kv4pTmuJjtbGCJAtYj1xtt9Mvo=;
 b=FreC9c4/4TB0EUw/sQwAmPqnngnt+nvHPGBsvnvk3AcHwJVM5z4XY0+uE/tLST/OoQ
 rdviEuTp6NoGImYpPzMQG3iek+JaTf/6wKWil1TY89xXk+hn6rZGCgkaJ1v3Pa3eDiIN
 yfkn9Dr3AAKyzS/A8lCnkMd2iYxcm3p1gPzgeowAJXywkaXg57GB+ehKYIYn99RLo/7d
 VK0Q+zjer08/n7D8yDz+zfOWsw4/WhJ38fKkcvHhF/pz7A+Y1+9tM1WviiWCvuTZtkUE
 /X7esqxQoPNUDWDqAMB0dp5I/akAFzXtOpBtjsGsTpIUkJ3e4FJEZA3+nAkwX11sd2TV
 gW3Q==
X-Gm-Message-State: AOJu0YyzGmdWPT2f/mWb6zWS6TjcGayP3H5XHNAkOicN4sW1WYcj0hGw
 UFk+6Kbad/a+7Ov7Iuou9+YsJfnL025K3LJG9IZeL2XZix6LV0qQSvMo8a+ahGQpVr5WIQzHw6t
 N12LIRIE8ZqNtnda01COrzlgFjoo91HhttdhCW4omsVNYoupr6xWZ5/JW+vWjf0pP4Ic4IPl4/V
 SK/DKFq5ACgkICe2WRs1pZn+0oRa1mOW+O75YDVw==
X-Gm-Gg: Acq92OGuyYk8V3LMTjerGB08VHeCmqLLToM8Zs8HV2YsO1v+qn569Lue2/NWCnOCog/
 TX1PAmKrXiuxrySN2I1hA6xQvhy2Cma9vGm9p3YVhthxKIADmTclP/5xGUmioZ3UAiHtgIvEN9b
 RSX8uTWEIu2D4zr/AqlvgHma3DkCDmyFqfWy+EV/n4TRxev0bDpgYdbXgFlPTG5mjss3anWAAaR
 u7gZM9+yzjeiyMP5qK8gVcxliMgotg+uujM0pVLGNn35uHHoA619HCODV2FinT2SvcAHNTApDN5
 k3x3fuhZYIID7DeCG9n1xenaGzzj+c06mc12E6OOhlmrskirw560C1rv32o/XNefTdGZE3+q63G
 CAgFumU2NYWjWtZfAthssMPgXqJzIpZqWsjLnLWNSzLri
X-Received: by 2002:a05:6214:590f:b0:8c7:76cf:5088 with SMTP id
 6a1803df08f44-8cc6e205d13mr6147816d6.0.1779312853806; 
 Wed, 20 May 2026 14:34:13 -0700 (PDT)
X-Received: by 2002:a05:6214:590f:b0:8c7:76cf:5088 with SMTP id
 6a1803df08f44-8cc6e205d13mr6146886d6.0.1779312853038; 
 Wed, 20 May 2026 14:34:13 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 04/29] tests/qtest/migration: Fix auto-converge test
Date: Wed, 20 May 2026 17:33:32 -0400
Message-ID: <20260520213357.40646-5-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

We fixed the cpu throttling sync thread affecting the
dirty-sync-count, but the test still relies on it to gauge for
progress. Remove that block from the test with no replacement.

While here remove several incorrect or redundant comments.

Fixes: 9519d3667a ("migration: Move iteration counter out of RAM")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260512141338.10089-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 62 ++-------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index e65d9e04a5..0426319199 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -291,35 +291,12 @@ static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 }
 #endif /* _WIN32 */
 
-/*
- * The way auto_converge works, we need to do too many passes to
- * run this test.  Auto_converge logic is only run once every
- * three iterations, so:
- *
- * - 3 iterations without auto_converge enabled
- * - 3 iterations with pct = 5
- * - 3 iterations with pct = 30
- * - 3 iterations with pct = 55
- * - 3 iterations with pct = 80
- * - 3 iterations with pct = 95 (max(95, 80 + 25))
- *
- * To make things even worse, we need to run the initial stage at
- * 3MB/s so we enter autoconverge even when host is (over)loaded.
- */
 static void test_auto_converge(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
     int64_t percentage;
-
-    /*
-     * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
-     * so we need to decrease a bandwidth.
-     */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
-    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
-    int max_try_count, hit = 0;
 
     if (migrate_start(&from, &to, uri, &args->start)) {
         return;
@@ -330,21 +307,16 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
 
-    /*
-     * Set the initial parameters so that the migration could not converge
-     * without throttling.
-     */
     migrate_ensure_non_converge(from);
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
 
-    /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
-    /* Wait for throttling begins */
+    /* Wait until throttling begins */
     percentage = 0;
     do {
         percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
@@ -357,36 +329,8 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
 
-    /*
-     * End the loop when the dirty sync count greater than 1.
-     */
-    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
-        usleep(1000 * 1000);
-    }
-
-    prev_dirty_sync_cnt = dirty_sync_cnt;
-
-    /*
-     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
-     * the timeout to 10 seconds to ensure it changes.
-     *
-     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
-     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
-     * to complete; this ensures that the RAMBlock dirty sync occurs.
-     */
-    max_try_count = 10;
-    while (--max_try_count) {
-        dirty_sync_cnt = get_migration_pass(from);
-        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
-            hit = 1;
-            break;
-        }
-        prev_dirty_sync_cnt = dirty_sync_cnt;
-        sleep(1);
-    }
-    g_assert_cmpint(hit, ==, 1);
-
-    /* Now, when we tested that throttling works, let it converge */
+    /* throttling always ignores the first pass */
+    assert(get_migration_pass(from) == 2);
     migrate_ensure_converge(from);
 
     /*
-- 
2.53.0


