Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F980D116F3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsg-0004TU-Ur; Thu, 27 Nov 2025 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rt-V7
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsX-0001GG-19
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D640080DF1;
 Thu, 27 Nov 2025 20:33:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-6LvukXpO; Thu, 27 Nov 2025 20:33:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264836;
 bh=JHAhwuo2n4HbMnqt206gdLWBdiRPW678482/oYIg4wM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oM+qDcYEa/PzVv3ijIB74FIStnKFhyKMSccO82PrNAJ+MIBjJSwoQ+g/vpOcJDnWk
 FFn86CJMpvWvxms/2he6EvNyEJIcrVFhgohMXEei+lbtpyXF44HVrVldU4AdkY7KNc
 /J36YMEd03bSMdLGRnYAvwzo3po4ESDljnKlRano=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 3/5] monitor: rework monitor_cur_is_qmp() into
 monitor_cur_is_hmp()
Date: Thu, 27 Nov 2025 20:33:50 +0300
Message-ID: <20251127173352.283731-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Condition in error_vprintf() becomes simpler. Also we are going
to reuse monitor_cur_is_hmp() in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/monitor/monitor.h | 2 +-
 monitor/monitor.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1..b531108eeb 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -15,7 +15,7 @@ extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
-bool monitor_cur_is_qmp(void);
+bool monitor_cur_is_hmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index b5007c1851..8ca17e9326 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -109,11 +109,11 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 /**
  * Is the current monitor, if any, a QMP monitor?
  */
-bool monitor_cur_is_qmp(void)
+bool monitor_cur_is_hmp(void)
 {
     Monitor *cur_mon = monitor_cur();
 
-    return cur_mon && monitor_is_qmp(cur_mon);
+    return cur_mon && !monitor_is_qmp(cur_mon);
 }
 
 /**
@@ -275,7 +275,7 @@ int error_vprintf(const char *fmt, va_list ap)
 {
     Monitor *cur_mon = monitor_cur();
 
-    if (cur_mon && !monitor_cur_is_qmp()) {
+    if (monitor_cur_is_hmp()) {
         return monitor_vprintf(cur_mon, fmt, ap);
     }
     return vfprintf(stderr, fmt, ap);
-- 
2.48.1


