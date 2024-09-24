Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC30CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5FZ-00085O-AN; Tue, 24 Sep 2024 09:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5FC-0006Sa-Sq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5FA-0000RM-T3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juoBgupwWMoqhWmjH7vChMoVIcRlJCGErn3vcRAITy4=;
 b=gxPmpS96o9H7ubJO1cGeKsXLc/0lEAZ2thxmSOP8fV9EJ9sdfSkvzdqWPmBELVgbSW55Ed
 0jsxFceyFYPek/ImV+8FhdP43Tdu2vZTM3l1KA0x91JF5JxtG7NsujUbyClR/aIlXtsif4
 K0tDXGfEmGYiT+OfV16+xMg4XHoHE58=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-dDU3-l5jOiWcQ0VgRnqZ0Q-1; Tue,
 24 Sep 2024 09:06:12 -0400
X-MC-Unique: dDU3-l5jOiWcQ0VgRnqZ0Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04F3B18DB8CE; Tue, 24 Sep 2024 13:06:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.3])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E53E01956054; Tue, 24 Sep 2024 13:06:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Hyman Huang <yong.huang@smartx.com>, Klaus Jensen <its@irrelevant.dk>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Keith Busch <kbusch@kernel.org>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 02/22] util/timer: fix -Werror=maybe-uninitialized
 false-positive
Date: Tue, 24 Sep 2024 17:05:33 +0400
Message-ID: <20240924130554.749278-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-1-marcandre.lureau@redhat.com>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 util/qemu-timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..c948cb1b72 100644
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


