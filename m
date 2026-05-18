Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D503CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0Rw-00057k-4X; Mon, 18 May 2026 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP0Rt-0004rN-DU
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP0Rr-0007SA-Jd
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zjBZEXc8Xf4ULSZsuieQsF8nx4sSrSvG7ZfuVe/yj98=;
 b=UQyZJZyxGNzpMR00xgZ2ACkNpm+RddeSmrl+SCWf5/2Y+qQG7+TipgzRCCJF9Y97sx2AIt
 MPxizEzob0KaiPsIhfNsEMryRrKugK8VBswmZgWVbvfrJI+yq6AVWEA2sp8HuKHNT6SIQa
 WPg+Lc0qAFcjUhMkHcxYVDSLJM6K7tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-LruNDJPLMqe_aJ15AInN-A-1; Mon,
 18 May 2026 12:02:59 -0400
X-MC-Unique: LruNDJPLMqe_aJ15AInN-A-1
X-Mimecast-MFC-AGG-ID: LruNDJPLMqe_aJ15AInN-A_1779120178
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A71180060D; Mon, 18 May 2026 16:02:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F60130001A2; Mon, 18 May 2026 16:02:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] system/rtc: Fix a possible year-2038 integer overflow problem
Date: Mon, 18 May 2026 18:02:55 +0200
Message-ID: <20260518160255.1844308-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
store this value in a normal integer variable. Change it to an int64_t
to fix the problem.
And while we're at it, also adjust the nearby rtc_host_datetime_offset
variable to be on the safe side in the related code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 system/rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/rtc.c b/system/rtc.c
index f13dd392a76..83b28088054 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -41,8 +41,8 @@ static enum {
     RTC_BASE_DATETIME,
 } rtc_base_type = RTC_BASE_UTC;
 static time_t rtc_ref_start_datetime;
-static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
-static int rtc_host_datetime_offset = -1; /* valid & used only with
+static int64_t rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
+static int64_t rtc_host_datetime_offset = -1; /* valid & used only with
                                              RTC_BASE_DATETIME */
 QEMUClockType rtc_clock;
 /***********************************************************/
-- 
2.54.0


