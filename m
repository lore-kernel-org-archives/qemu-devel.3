Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA2DD148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6X-00073G-33; Thu, 08 Jan 2026 02:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6S-0006pN-PZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6R-0006cu-AJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQtRUV903LPCNVI5wTzSTshNcU6NvgG8VOOQh3qtDJM=;
 b=PeKmaCAnNZRhrtEfC3CUGIpnhmEW35msKScnbCT5WKokw43s/Z3LV/1TN22DKXEVjLzivo
 ELjb+/Ju8holYCI08BtuZmZ+5TNHIQNyWuUs+aDL1Qgu4vRIZaGAhoGzLimXfQKPopnh2u
 vfKMlCKxN7eOy82qksv8inj+rSlL2QM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-2KDUCSFYM-C2Nr5eM-UDtQ-1; Thu,
 08 Jan 2026 02:06:34 -0500
X-MC-Unique: 2KDUCSFYM-C2Nr5eM-UDtQ-1
X-Mimecast-MFC-AGG-ID: 2KDUCSFYM-C2Nr5eM-UDtQ_1767855994
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0617B1955F34; Thu,  8 Jan 2026 07:06:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8758180009E; Thu,  8 Jan 2026 07:06:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3129021E6147; Thu, 08 Jan 2026 08:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 16/17] qga/commands-win32: Use error_setg_win32() for better
 error messages
Date: Thu,  8 Jan 2026 08:06:24 +0100
Message-ID: <20260108070625.1586474-17-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We include numeric GetLastError() codes in error messages in a few
places, like this:

    error_setg(errp, "GRIPE: %d", (int)GetLastError());

Show text instead, like this:

    error_setg_win32(errp, GetLastError(), "GRIPE");

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121121438.1249498-15-armbru@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qga/commands-win32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index acc2c11589..0fd0c966e4 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1798,8 +1798,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     tf.dwHighDateTime = (DWORD) (time >> 32);
 
     if (!FileTimeToSystemTime(&tf, &ts)) {
-        error_setg(errp, "Failed to convert system time %d",
-                   (int)GetLastError());
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to convert system time");
         return;
     }
 
@@ -1810,7 +1810,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     }
 
     if (!SetSystemTime(&ts)) {
-        error_setg(errp, "Failed to set time to guest: %d", (int)GetLastError());
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to set time to guest");
         return;
     }
 }
@@ -1834,13 +1835,12 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
         (length > sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION))) {
         ptr = pslpi = g_malloc0(length);
         if (GetLogicalProcessorInformation(pslpi, &length) == FALSE) {
-            error_setg(&local_err, "Failed to get processor information: %d",
-                       (int)GetLastError());
+            error_setg_win32(&local_err, GetLastError(),
+                             "Failed to get processor information");
         }
     } else {
-        error_setg(&local_err,
-                   "Failed to get processor information buffer length: %d",
-                   (int)GetLastError());
+        error_setg_win32(&local_err, GetLastError(),
+                         "Failed to get processor information buffer length");
     }
 
     while ((local_err == NULL) && (length > 0)) {
-- 
2.52.0


