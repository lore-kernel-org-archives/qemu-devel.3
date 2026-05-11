Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D7CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVJe-0007Wa-Fy; Mon, 11 May 2026 14:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVJ8-0006r2-Hy
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVJ1-0003El-8q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778523877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=elBLjgn6D7l43x4ORl+kmTYAAuQI7HGmQKDhrgl0DCs=;
 b=TSAzXceuidHr7ljLkgLS2gEKmaGUPGaQauFEXLPfPli+2ofH97XvOxBvconK+ajIJV0IsO
 /hOBcvnHrSQuCIMlBuP8K/rkGW8YUPyut5o19QM4vXVC1PjHVy7Hxs4c2oIPgXIYZOjZCA
 8CyGbL9AZddwWug7l0JiTZNhpOoXj6Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-x8w2fLJLOWKk9LS2NL1QCQ-1; Mon, 11 May 2026 14:24:36 -0400
X-MC-Unique: x8w2fLJLOWKk9LS2NL1QCQ-1
X-Mimecast-MFC-AGG-ID: x8w2fLJLOWKk9LS2NL1QCQ_1778523876
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-909120afff9so215137585a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778523876; x=1779128676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=elBLjgn6D7l43x4ORl+kmTYAAuQI7HGmQKDhrgl0DCs=;
 b=Sxuj/QuANhenU1jGZ9wj8SJR/ESADE0f2AJn1tBucHRca6vwY5U9RY2Cnx8c0joRC0
 pJtcxB1GkuDue5dQz+GTicwZrTAuS9n2efk0oVSPLS8jQKfU5AQ2fU4UTBJCDBnin/w2
 vPFflpyBTWXwmEM9Mmog9ZM6qH8KZKLzz2/ruW5UjbjxywxIOF7B/QXGFRj9qRLFv+G6
 UCax1s/O9r53rfIzo968E+HMzzmZOjtKn/hjObdefHynkCs6hXfGVYuP4TODge59kkoZ
 4vXRk9qLSU0tC9IXFXrymzFVd1Bik3yJRK2A6cjcrLRXDrIwVTB9Zeb9jtsCjHmn3x9L
 b+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523876; x=1779128676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elBLjgn6D7l43x4ORl+kmTYAAuQI7HGmQKDhrgl0DCs=;
 b=rJ+FxuHU+T9v01EmPwQMPZCDaA+ovVg6awzQzC4SujFg51FYfIVQRJPzwW39I18QLH
 nW5jCOzFPRZ1U2VcqMDzbONSEHMpgrvFNOHZ4iPQUMOW0gjB+Iao95NGIvP8qMP/HfEJ
 KzHai0VkXgvk+wJuac8WGKviBxMyl3YEUOlZh78j5JQ9gTdClgHNiPYTpGodByDWbicT
 2QIY1nhA0ioG2OULvixDVCYGMSWvvEbE15ZHFyeA01MUb8F8HpA+6UnSPtI+9J6X/YQB
 KJmbyk52NvVZVLyi+o5VwBJhaZIH9KzznRAWPyYe5q938BbPiWDQOrkw/YjIeQs4gaOX
 wRlQ==
X-Gm-Message-State: AOJu0YzePlKLr9HIGhnruQzTZwt6h8919aFAFrpIdEj6Xvr3AdvMtpj2
 7OgoO6ZbWVS5L+eS3PS2qQ5xCtsJV5FWZsypWWrPjAHK5c7cT6W/yjWu68vUqyv8fzP8YsfEZg2
 ArDfhZFr6nzqIl8+aqYALMCgb1zVhwHe/V0xtycOL2IQL9o1X4nJSCyM1tlIA/txpMmlY+lF9py
 auo3STsRhnGAHdItEXrWAmMY9PiT7L08yuxFegXA==
X-Gm-Gg: Acq92OFsOG3KAST8Ne1SwrK4JGprQhI15dD5fZ4JTC5SQ9vzIy1Om3pl4H7pzqIqFDJ
 WjjfhMaaEdRt9IcFGgYBkkzRh3qnBnOGdEu4QuWgpAxUcR0thafMyY75kMNe3xhZhONLm855NHO
 h81m4Z5g7C17THoi4QteYf2WwZgwzau56wDpWHAPdxEv7LRZgVUpGHwsekn+Bgb/6OOqPVdNfKf
 ps9sgr8r5ovNBe874xIqRzppOBYsCl5Fkz6o692n1KVUcU5Z9e3r1FoU36SXr5B+Yrq31SrVZ9m
 JRqL9ktOBpuX66mt4EdU1V607PZySa1SUBQmqjhMWoRbhlewxXNJLouzXGMUb5/yAb/l2gPBqun
 qtWFnDvrbp+HbZnoJ50RZRGr7Jl3ELyHXoTbnuVEn0wXW
X-Received: by 2002:a05:620a:4624:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-904d4a61a03mr3938113085a.17.1778523875476; 
 Mon, 11 May 2026 11:24:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4624:b0:8ef:3312:a150 with SMTP id
 af79cd13be357-904d4a61a03mr3938103685a.17.1778523874764; 
 Mon, 11 May 2026 11:24:34 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-90ccb338844sm19069885a.22.2026.05.11.11.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:24:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v3] migration: Fix possible division by zero on calc expected
 downtime
Date: Mon, 11 May 2026 14:24:32 -0400
Message-ID: <20260511182432.1333467-1-peterx@redhat.com>
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

Fix it by properly handle both Inf and Nan to return INT64_MAX.

Add a rich comment, per PeterM's suggestion.

Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b6f78eb3ac..05f10e4576 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -63,6 +63,7 @@
 #include "system/dirtylimit.h"
 #include "qemu/sockets.h"
 #include "system/kvm.h"
+#include "math.h"
 
 #define NOTIFIER_ELEM_INIT(array, elem)    \
     [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
@@ -1044,12 +1045,29 @@ static bool migrate_show_downtime(MigrationState *s)
 /* Return expected downtime (unit: milliseconds) */
 int64_t migration_downtime_calc_expected(MigrationState *s)
 {
+    double expected_ms;
+
     if (mig_stats.dirty_sync_count <= 1) {
         return migrate_downtime_limit();
     }
 
-    return mig_stats.dirty_bytes_last_sync /
+    expected_ms = mig_stats.dirty_bytes_last_sync /
         migration_get_switchover_bw(s) * 1000;
+
+    /*
+     * If we haven't been able to transfer any data, the result here could
+     * be NaN (for 0 / 0) or infinity (something else / 0).
+     *
+     * Return INT64_MAX as our best approximation to "this will take
+     * forever to complete". If the problem is transient (e.g. we just
+     * haven't started to transfer yet) we'll recalculate to a more
+     * accurate figure later.
+     */
+    if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
+        return INT64_MAX;
+    }
+
+    return (int64_t) expected_ms;
 }
 
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
-- 
2.53.0


