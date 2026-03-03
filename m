Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D07EDA681
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKt-0006i1-PS; Tue, 03 Mar 2026 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKr-0006hT-DE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKp-00028t-V3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MgZnSu8FpgfVyxgsvWX6ruETMQfEejfRnUI7Ndvo2E=;
 b=gG6E7DTR4dEoFR6QPHCYJ1O9vF1ZWxHaCk9rVozpv1VVfvqqAOSksQIkQMx+ejN5TM9g22
 tPiG7VgFYIVAtkICSRzsnIzB0z3stRX7AQpxBrsJ/CT1EJYgsck8kfFbrng2jt7uzY9bkS
 8/PlSigtL7XFLfPqrnr75nrz/P1dUaQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-z8g_suQePX-zlLZ1UEX6Rg-1; Tue,
 03 Mar 2026 10:06:51 -0500
X-MC-Unique: z8g_suQePX-zlLZ1UEX6Rg-1
X-Mimecast-MFC-AGG-ID: z8g_suQePX-zlLZ1UEX6Rg_1772550410
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D4DD19560AD; Tue,  3 Mar 2026 15:06:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55AEA1800370; Tue,  3 Mar 2026 15:06:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/27] monitor: remove redundant error_[v]printf_unless_qmp
Date: Tue,  3 Mar 2026 15:05:57 +0000
Message-ID: <20260303150604.2402872-21-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The only callers of these functions have been removed. Adding any
new usage of them is highly undesirable, so they should be entirely
removed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h |  3 ---
 monitor/monitor.c         | 24 ------------------------
 stubs/error-printf.c      |  5 -----
 3 files changed, 32 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c3740ec616..296690e1f1 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -59,7 +59,4 @@ void monitor_register_hmp(const char *name, bool info,
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
 
-int error_vprintf_unless_qmp(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
-int error_printf_unless_qmp(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
-
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index dd2c45ded0..4d26cd9496 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -281,30 +281,6 @@ int error_vprintf(const char *fmt, va_list ap)
     return vfprintf(stderr, fmt, ap);
 }
 
-int error_vprintf_unless_qmp(const char *fmt, va_list ap)
-{
-    Monitor *cur_mon = monitor_cur();
-
-    if (!cur_mon) {
-        return vfprintf(stderr, fmt, ap);
-    }
-    if (!monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return -1;
-}
-
-int error_printf_unless_qmp(const char *fmt, ...)
-{
-    va_list ap;
-    int ret;
-
-    va_start(ap, fmt);
-    ret = error_vprintf_unless_qmp(fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 0e326d8010..1afa0f62ca 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -16,8 +16,3 @@ int error_vprintf(const char *fmt, va_list ap)
     }
     return vfprintf(stderr, fmt, ap);
 }
-
-int error_vprintf_unless_qmp(const char *fmt, va_list ap)
-{
-    return error_vprintf(fmt, ap);
-}
-- 
2.53.0


