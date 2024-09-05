Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11107CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smI1P-0006qK-7i; Thu, 05 Sep 2024 15:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1smI1D-00066X-KD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:19:48 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1smI1B-0000uA-1M
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=t+og4Y0w/JtOJuhpadAI2GAHSgewgHY7hWcudVSC4zM=; b=m+R7wQBszg9B
 7oD+LlwudctedCWu9a41si7AOuZ6+rFnDgV/tDwC6v67Dq3qW94rFhRhATmW/siOSoVJ+WKZuPGAk
 I1wW9XZZf79P/tq/cWRWpWBphYo0GzuWPtHFCA+sA6Wq8lGA4tz7JEMm6a/RBK5VV+ZuxRwP/Quvy
 DV4rLfegxKDtajrRvAQlNRBazUjHhqf/pWHouv9wf4bOwdVCFPM1viWlmdfcS1lZy5PfBnye1R00k
 tHpHz2lTB9BmsNtpyR/NmG5u04sA399ev5x7A+QnbDvAidlqBKMPUuu1SxuMAiCaR+gBFyu1ilHtZ
 PbXo+mb3V5kgKFNpoPDsLA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1smHyf-001HNM-0l;
 Thu, 05 Sep 2024 21:19:40 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/1] system: improve migration debug
Date: Thu,  5 Sep 2024 21:19:41 +0200
Message-Id: <20240905191941.310592-1-den@openvz.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Right now migration_throttle() tracepoint lacks very important
important information, i.e. no one could easily say how much the guest
is throttled. This makes difficult to debug guest quality of service
during migration.

This patch adds one more tracepoint into cpu_throttle_set() which is
actually doing this job.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
Changes from v1:
- adding tracepoint directly to cpu_throttle_set() as suggested by Peter

 system/cpu-throttle.c | 3 +++
 system/trace-events   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/system/cpu-throttle.c b/system/cpu-throttle.c
index c951a6c65e..7632dc6143 100644
--- a/system/cpu-throttle.c
+++ b/system/cpu-throttle.c
@@ -28,6 +28,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-throttle.h"
+#include "trace.h"
 
 /* vcpu throttling controls */
 static QEMUTimer *throttle_timer;
@@ -95,6 +96,8 @@ void cpu_throttle_set(int new_throttle_pct)
      */
     bool throttle_active = cpu_throttle_active();
 
+    trace_cpu_throttle_set(new_throttle_pct);
+
     /* Ensure throttle percentage is within valid range */
     new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
     new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
diff --git a/system/trace-events b/system/trace-events
index 2ed1d59b1f..074d001e90 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -44,3 +44,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+# cpu-throttle.c
+cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
-- 
2.40.1


