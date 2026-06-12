Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13379CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5F6-0005E6-DN; Fri, 12 Jun 2026 13:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eo-00052p-SX; Fri, 12 Jun 2026 13:00:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Em-0005ud-AF; Fri, 12 Jun 2026 13:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=x2ze/TUTv2U7VDOjDq7Vmk/XORxJT4W40E0/zxPPzXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JF8S2RvRyQyKnAjIm/Gm5WjtOs59xacpHB2tJIZ03GQdHS+cVA/tb4Mr4IsBqXO+4
 0xh4iw/zcZV0HptHrTrxHIyy5Q4zDrFQHb1+VjWc6uudoPGwpWvrAgZUa+w3Qg+5Ko
 5i+RRIZqX3tWrUBc0783DSfPV3R6eN5UAdfBUhNmd5FUnB9+hXUGm/+bIx4vde0yrN
 ZDsnG9f32s6X9G8a6QO67Q4aC6bPQ8Lq5y9ytwomvWfk+abCl7MkhBmCP222tkBYwN
 b/f/Ot1rVgvYWorQFz1/+vABacfJB1JmYYX4CxJz6lzSb3PN6hdWSLQc4p9VoPUXIO
 iXjU0bjiqpxAw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1217D1B6BC8;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD5BF3CE165;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/8] system/rtc: Fix a possible year-2038 integer overflow
 problem
Date: Fri, 12 Jun 2026 19:59:47 +0300
Message-ID: <20260612165957.1779082-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

rtc_realtime_clock_offset is initialized with:

  rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;

And QEMU_CLOCK_REALTIME might be based on gettimeofday() in certain
cases (see get_clock_realtime() in include/qemu/timer.h). So this
counter will exceed 32 bits in the year 2038, thus we should not
store this value in a normal integer variable. Change it to a time_t
to fix the problem.
And while we're at it, also adjust the nearby rtc_host_datetime_offset
variable to be on the safe side in the related code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/rtc.c b/system/rtc.c
index f13dd392a7..018609a4f9 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -41,8 +41,8 @@ static enum {
     RTC_BASE_DATETIME,
 } rtc_base_type = RTC_BASE_UTC;
 static time_t rtc_ref_start_datetime;
-static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
-static int rtc_host_datetime_offset = -1; /* valid & used only with
+static time_t rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
+static time_t rtc_host_datetime_offset = -1; /* valid & used only with
                                              RTC_BASE_DATETIME */
 QEMUClockType rtc_clock;
 /***********************************************************/
-- 
2.47.3


