Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1B0CF319C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svur5-00015j-UJ; Wed, 02 Oct 2024 04:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svur4-00015N-By
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svur3-0005ef-1l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEGksA9KrAjdYdb0jvqfGMpZ0DaihQHvTeMRO5FF8lk=;
 b=ihn2R/08XC5ooKow+ripN/uwZ2Z7eso+eFrPq+hru/fp68WKSX1M9Srag2vdOK6wwhmXic
 U7q2dFoz0lzDp30WOg5jFqmXW7Lmvng7eWiV57YoQTHyDbHVp8Lipiiwu6TwBis2Nk0AaS
 vrIq0o6YywEkkCvJrIMLnMe8ZVPmNRo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-qUXiNrP8N0uo2_z0BlOHlg-1; Wed,
 02 Oct 2024 04:37:01 -0400
X-MC-Unique: qUXiNrP8N0uo2_z0BlOHlg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F4C1955D80; Wed,  2 Oct 2024 08:37:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EA1919560A2; Wed,  2 Oct 2024 08:36:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/22] util/timer: fix -Werror=maybe-uninitialized
 false-positive
Date: Wed,  2 Oct 2024 12:36:25 +0400
Message-ID: <20241002083646.2893078-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../util/qemu-timer.c:198:24: error: ‘expire_time’ may be used uninitialized [-Werror=maybe-uninitialized]
../util/qemu-timer.c:476:8: error: ‘rearm’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/qemu-timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 6b1533bc2a..d5e33490fc 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -182,7 +182,7 @@ bool qemu_clock_has_timers(QEMUClockType type)
 
 bool timerlist_expired(QEMUTimerList *timer_list)
 {
-    int64_t expire_time;
+    int64_t expire_time = 0;
 
     if (!qatomic_read(&timer_list->active_timers)) {
         return false;
@@ -212,7 +212,7 @@ bool qemu_clock_expired(QEMUClockType type)
 int64_t timerlist_deadline_ns(QEMUTimerList *timer_list)
 {
     int64_t delta;
-    int64_t expire_time;
+    int64_t expire_time = 0;
 
     if (!qatomic_read(&timer_list->active_timers)) {
         return -1;
@@ -461,7 +461,7 @@ void timer_mod_ns(QEMUTimer *ts, int64_t expire_time)
 void timer_mod_anticipate_ns(QEMUTimer *ts, int64_t expire_time)
 {
     QEMUTimerList *timer_list = ts->timer_list;
-    bool rearm;
+    bool rearm = false;
 
     WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
         if (ts->expire_time == -1 || ts->expire_time > expire_time) {
-- 
2.45.2.827.g557ae147e6


