Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C3AD116F5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 20:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP4j5-0002VP-3z; Fri, 28 Nov 2025 15:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4j1-0002UM-Iq
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vP4ix-0000Rt-D2
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 15:05:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7791B81174;
 Fri, 28 Nov 2025 23:05:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:894::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b5mcgZ0FDuQ0-84gYId7K; Fri, 28 Nov 2025 23:05:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764360339;
 bh=9prDWx4Tuh5NMXxULCIsUGRu46D0miCzYKR+fy/XRzY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wIoSgjM04UDPqUjcVmUHFmJXUhx1qwAfhzOe0Ub+oqcViNue/PQjUIlv9685ULEWM
 oHr8I+pzpAySMfo2RNv1k0H0WH0tHPMYVLMLiLo7fLXCLa8c+koIanIOymYlC0yHP2
 aiNhm35uw+5RzX7LWc0PRiajaltToMM1fUTtX3CU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org
Subject: [PATCH 2/3] error-report: move real_time_iso8601() to header
Date: Fri, 28 Nov 2025 23:05:34 +0300
Message-ID: <20251128200536.207344-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251128200536.207344-1-vsementsov@yandex-team.ru>
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To be reused in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/error-report.h | 6 ++++++
 util/error-report.c         | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3ae2357fda..412b705898 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -74,4 +74,10 @@ extern bool message_with_timestamp;
 extern bool error_with_guestname;
 extern const char *error_guest_name;
 
+static inline char *real_time_iso8601(void)
+{
+    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+    return g_date_time_format_iso8601(dt);
+}
+
 #endif
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..20618640e8 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -169,13 +169,6 @@ static void print_loc(void)
     }
 }
 
-static char *
-real_time_iso8601(void)
-{
-    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    return g_date_time_format_iso8601(dt);
-}
-
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
-- 
2.48.1


