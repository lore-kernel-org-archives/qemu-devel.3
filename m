Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A107BC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKy-0006VN-7M; Tue, 11 Feb 2025 09:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKx-0006V1-DA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKu-0001uT-TK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YQ8mdHXSFhetMqSxe6PkRlVoRM9a4K3E1Ld8Ii1BeM=;
 b=fxqMktgIKTSu/1EBiVTDg0RY9xZUWo29MpplpoRG6BYt/W9U9zNXJjKGuKbIzmKUr2Pz/L
 51nousy9l2AG1WDTgspmgpxc6UHSWl+LiZ2GW2ylKjMFf9UZdILDo7DSCSL6LC01jasakc
 uO+XfZmREBZQYpc2CsToCHuuQGwlUt4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-SPCJcRBoNuyybUiP0QD7Hw-1; Tue,
 11 Feb 2025 09:34:01 -0500
X-MC-Unique: SPCJcRBoNuyybUiP0QD7Hw-1
X-Mimecast-MFC-AGG-ID: SPCJcRBoNuyybUiP0QD7Hw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C2561800981
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:34:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEEC91800115; Tue, 11 Feb 2025 14:33:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 06/12] util/error: Introduce warn_report_err_once()
Date: Tue, 11 Feb 2025 15:33:34 +0100
Message-ID: <20250211143340.787996-7-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Depending on the configuration of the host and VM, a passthrough
device may generate recurring DMA mapping errors at runtime. In such
cases, reporting the issue once is sufficient.

We have already the warn/error_report_once() routines taking a format
and arguments. Using the same design pattern, add a new warning
variant taking an 'Error *' parameter.

Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250206131438.1505542-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qapi/error.h | 12 ++++++++++++
 util/error.c         | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 71f8fb2c50eee9a544992d0c05263c9793956fe1..f5fe2162623e5770d652f7415ebc25172d97616e 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -466,6 +466,18 @@ void warn_reportf_err(Error *err, const char *fmt, ...)
 void error_reportf_err(Error *err, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/*
+ * Similar to warn_report_err(), except it prints the message just once.
+ * Return true when it prints, false otherwise.
+ */
+bool warn_report_err_once_cond(bool *printed, Error *err);
+
+#define warn_report_err_once(err)                           \
+    ({                                                      \
+        static bool print_once_;                            \
+        warn_report_err_once_cond(&print_once_, err);       \
+    })
+
 /*
  * Just like error_setg(), except you get to specify the error class.
  * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
diff --git a/util/error.c b/util/error.c
index e5e247209a9e0796074a9794f5598325f22f8d35..673011b89e95f488817b86c31cd389386b2558bb 100644
--- a/util/error.c
+++ b/util/error.c
@@ -247,6 +247,17 @@ void warn_report_err(Error *err)
     error_free(err);
 }
 
+bool warn_report_err_once_cond(bool *printed, Error *err)
+{
+    if (*printed) {
+        error_free(err);
+        return false;
+    }
+    *printed = true;
+    warn_report_err(err);
+    return true;
+}
+
 void error_reportf_err(Error *err, const char *fmt, ...)
 {
     va_list ap;
-- 
2.48.1


