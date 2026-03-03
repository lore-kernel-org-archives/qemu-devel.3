Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABEBEDA681
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKt-0006hw-Cz; Tue, 03 Mar 2026 10:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKr-0006hU-DG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKp-00028x-VH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9OSKcd31lWikFWaURufmE/FEdairRVtIzQDpvvKKEY=;
 b=ibNzSMwFRlWlbm4Gq8ICtLZ1iNpuLm0EVOo6CRwVb01rMRr1WKSOFoOr01mSFL/nqJcpwd
 brLYVD3vIShmqHe5iy5tceb5XZx8ce5MJoFyBSvCraJEvcf7vmgDbStg1bTdTeWVSWRiD7
 B5Qv6yJG1ikV6TFEIii4fSe/ptFdBPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-Y__UiPWKNNK_n4pzv8jswQ-1; Tue,
 03 Mar 2026 10:06:53 -0500
X-MC-Unique: Y__UiPWKNNK_n4pzv8jswQ-1
X-Mimecast-MFC-AGG-ID: Y__UiPWKNNK_n4pzv8jswQ_1772550412
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F9611956060; Tue,  3 Mar 2026 15:06:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDCC31800348; Tue,  3 Mar 2026 15:06:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 21/27] monitor: refactor error_vprintf()
Date: Tue,  3 Mar 2026 15:05:58 +0000
Message-ID: <20260303150604.2402872-22-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The monitor_vprintf() code will return -1 if either the monitor
is NULL, or the monitor is QMP. The error_vprintf() code can
take advantage of this to avoid having to duplicate the same
checks, and instead simply look at the return value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 4d26cd9496..64c552a047 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -269,16 +269,21 @@ void monitor_printc(Monitor *mon, int c)
 }
 
 /*
- * Print to current monitor if we have one, else to stderr.
+ * Print to the current human monitor if we have one, else to stderr.
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
     Monitor *cur_mon = monitor_cur();
-
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
+    /*
+     * This will return -1 if 'cur_mon' is NULL, or is QMP.
+     * IOW this will only print if in HMP, otherwise we
+     * fallback to stderr for QMP / no-monitor scenarios.
+     */
+    int ret = monitor_vprintf(cur_mon, fmt, ap);
+    if (ret == -1) {
+        ret = vfprintf(stderr, fmt, ap);
     }
-    return vfprintf(stderr, fmt, ap);
+    return ret;
 }
 
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
-- 
2.53.0


