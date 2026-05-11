Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C797CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRLY-0001Yy-8a; Mon, 11 May 2026 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMRLW-0001Yh-DS
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMRLU-0000L9-Ek
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778508655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HcAPiqx5eJPPFOYNfGrebOm8/lyFxBK3BtHtCBUaDzg=;
 b=ClGHqrBzEFgfaMMEFwd5HVAuAg2NxpvRoCok1FyFrccWff/6fyBwMRAxWm867VxbflCpJR
 zvl8GvAROSlTO/clZYbjAHShOmGCLnPxB1peiPzLIttYf6oKPs5z5Gd+shXxbDickfJh5/
 W5G6aSlZRfsETWr5qiR5bpBFZsMxcCI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-s77cXyIxNkeM7jN9Tr9XCw-1; Mon, 11 May 2026 10:10:54 -0400
X-MC-Unique: s77cXyIxNkeM7jN9Tr9XCw-1
X-Mimecast-MFC-AGG-ID: s77cXyIxNkeM7jN9Tr9XCw_1778508654
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d5b5d607d1so818083585a.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778508653; x=1779113453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HcAPiqx5eJPPFOYNfGrebOm8/lyFxBK3BtHtCBUaDzg=;
 b=okWiApubFu0Ezz64k1XKYrCmcMorJmfLCLX0zW8WOqk9LM1s6cMl4mb0CuXcWPfUjs
 ntyeBjPIxCqglKMcFSQNSGSCOcVjOsx0bMD2W+uQpx7pEnVGODX5XLXczeK1rVXSYwtP
 X2NV4zaOMZMuiIoJMoARc5RVoHSCV4/fYznC112jRXxjdLu2wueEq+wbFjbzoo6G73tG
 MzLrWO8SeE4LLWvMRARhGiOhiHRRXdiRzeEW53EGKf/lL9osfW4ilit2uUKKAgbw8d0R
 zvRpQX82EhzUK+K60h6Q3uFva7wTHdJtkISce9ZXXx9Tcb+bcrwT6mAdQOXlP9LVBbB9
 vDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508653; x=1779113453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcAPiqx5eJPPFOYNfGrebOm8/lyFxBK3BtHtCBUaDzg=;
 b=QaQk0TThpKDw69PTcSkru0RD4O8/ijIHV6crelgveJHJVSO3eNeMLmUeSu5iqii6Id
 YXgtnEv/HtxI6bKeyYmmjqNu6/fflmfuOMyQWkiUQ9AFWWLKfeHEpA3X/ChVG+KkbZmL
 YLqvPF1K9cDrggxL+5coa6FbeLkodvjoBA1BYULVTIlM3WTExx6ptOX6npbK3orMRQkV
 bHfUTwvEIU5/EJIl2UbXE02m1RS3T8XPYhy0F0XHOc/9+KZDSYQfGrV/QqoB7Mzvo7Lu
 Vs5+aQwRNyENuiPmnLBdV/6Mi0Na0GJJEGdVG8vCmgfL4knlb15bd7WfqHM76uMWcAD4
 Ww1A==
X-Gm-Message-State: AOJu0Yz7qjtCub+01JsPDrtzW23pSpDE0RBYSV4+ZJjyi36kEPuNju3B
 cYUq1Ed0rpXBTnQSoj6ca0Q/EomMpFlaY82KiHd2KliXmxm+2OqWpEWgzb/4Fl9EPTVOY33+iOt
 mhklhUNq6wdF5S3cfBWhXLT7c97K62fGqVzkjIRlJwQWwlNK4///4u+SQDye4HnyZxWOQb+h64F
 mqZ8jLCdDyknUFhuYOa/HKCqc12Z04Yi55OhM7CQ==
X-Gm-Gg: Acq92OG9UcA5tukIik+3424YtTOWJzqHxVhrZZKxJfFU/rMQaKm9VpeuPqcTKR6Hjc4
 nuh5j8u2O7Z/im2SGBvTCt4wL359d7mgXA/aeNPHRBAfIOAXlfBJAr3COVKnqM5SHeDhSSaPvgt
 bFuPXkT1/Wlv/k4pal3mfWAOCvv2cNKhE5AD9zDslpE3PBV+hG/3zzosBupWtRXcT6qEcw69rSM
 2SnKZhPsAZ3Q5RyDG5KUhJoRHRzjd141ASASBlEIHrzIbrO0fHol6uR1jIyWIk65PWfKvgWnlFr
 OJ2i/TLsbzzKbHpyepjjZhfhJJkPlUk1CbAXGX7rs6IajTjHSrgQD2+HWFu5L/V9a0dEQWlTkw4
 aqDxBkeUS3zGNmds79SwBQx5utMdkLf/mdjWoQL8v0Ao4
X-Received: by 2002:a05:620a:29cf:b0:8eb:cbf8:85e7 with SMTP id
 af79cd13be357-904d61ef7d4mr3535809585a.34.1778508653403; 
 Mon, 11 May 2026 07:10:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29cf:b0:8eb:cbf8:85e7 with SMTP id
 af79cd13be357-904d61ef7d4mr3535800885a.34.1778508652535; 
 Mon, 11 May 2026 07:10:52 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b8e99ccfsm1073742385a.16.2026.05.11.07.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:10:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] migration: Fix possible division by zero on calc expected
 downtime
Date: Mon, 11 May 2026 10:10:49 -0400
Message-ID: <20260511141049.1293449-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
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

Commit dd4fe8844b changed the reporting of expected downtime behavior, so
that the value will be calculated on-demand.  One side effect on the change
is QEMU will allow the calculation to happen anytime even if there's no
transfer happening for a short while.

PeterM reported an ubsan report from clang when running migration-test with
aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
concurrently so some of the src QEMU may not get chance to push any data,
causing mbps to be 0:

../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'

Fix it by checking mbps non-zero before the devision.

Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b6f78eb3ac..b06e577328 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1044,12 +1044,18 @@ static bool migrate_show_downtime(MigrationState *s)
 /* Return expected downtime (unit: milliseconds) */
 int64_t migration_downtime_calc_expected(MigrationState *s)
 {
+    double bw;
+
     if (mig_stats.dirty_sync_count <= 1) {
         return migrate_downtime_limit();
     }
 
-    return mig_stats.dirty_bytes_last_sync /
-        migration_get_switchover_bw(s) * 1000;
+    bw = migration_get_switchover_bw(s) * 1000;
+    if (!bw) {
+        return INT64_MAX;
+    }
+
+    return mig_stats.dirty_bytes_last_sync / bw;
 }
 
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
-- 
2.53.0


