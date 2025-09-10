Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C47CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBl-0008Eg-8E; Wed, 10 Sep 2025 14:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBg-00088x-BG
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBa-0004jd-8N
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSmmeE4LX6+dAdVzSESwN9nzUTHN9b8kMqEf0jlqxZU=;
 b=ZmmRqsCdcwo5GVirF6sbdFAjqUwH8DzzjQ0s5kEWGSmdO9+BvXdKwSAqxkkFfv8eJc/Seq
 uDSPCPcFbDdqRyjJzmNMPXzkEqcXxu79usxcoB37QVG3xJ+26GcOWrGGfaAKZAf/SGV50f
 74dXMsCFFmSXvQ21ctikFA7psTJPMvI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-ueaW2QoiPnebkgk45w3TvA-1; Wed,
 10 Sep 2025 14:04:47 -0400
X-MC-Unique: ueaW2QoiPnebkgk45w3TvA-1
X-Mimecast-MFC-AGG-ID: ueaW2QoiPnebkgk45w3TvA_1757527486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3070C180045C; Wed, 10 Sep 2025 18:04:46 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A807F1800447; Wed, 10 Sep 2025 18:04:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 10/20] monitor: remove redundant error_[v]printf_unless_qmp
Date: Wed, 10 Sep 2025 19:03:47 +0100
Message-ID: <20250910180357.320297-11-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These functions only had one caller which was easily converted to
the normal error_printf() function. Remove them as they don't add
sufficient value.

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
index da54e1b1ce..03dbe5d131 100644
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
2.50.1


