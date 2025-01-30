Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E89C02194
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUpt-0000iQ-OM; Thu, 30 Jan 2025 08:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUpp-0000gx-Tr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUpo-0003ON-IV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738244635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55ZBXel4IZrwYGquIHw+t8dMmO4wIp7lp1UiZQ+QE78=;
 b=PD8pA13fWVJlPiGdAPEaLmNTFLDMMuJi685WUur0mhqbGQd7owS7WsIPlsC+QxuTsaknYR
 ZbV1U1cWu/eO768bn56C6c69V+5PmUOedg/feIWHbMjIZdDF6W5QjRaH1H3sUlbJjdzrK5
 4ZruzdxA7Q/ohwcpHqK5BEpsZl4la4E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-vXgtBc1dOdCa0Tsc2YXOgQ-1; Thu,
 30 Jan 2025 08:43:54 -0500
X-MC-Unique: vXgtBc1dOdCa0Tsc2YXOgQ-1
X-Mimecast-MFC-AGG-ID: vXgtBc1dOdCa0Tsc2YXOgQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 304C71801F19
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:43:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF5A0180095D; Thu, 30 Jan 2025 13:43:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/9] util/error: Introduce warn_report_once_err()
Date: Thu, 30 Jan 2025 14:43:38 +0100
Message-ID: <20250130134346.1754143-2-clg@redhat.com>
In-Reply-To: <20250130134346.1754143-1-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

Depending on the configuration, a passthrough device may produce
recurring DMA mapping errors at runtime and produce a lot of
output. It is useful to report only once.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qapi/error.h | 5 +++++
 util/error.c         | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 71f8fb2c50eee9a544992d0c05263c9793956fe1..b6ea274882b9788b64d4bb213c3458d7c674a881 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -448,6 +448,11 @@ void error_free_or_abort(Error **errp);
  */
 void warn_report_err(Error *err);
 
+/*
+ * Convenience function to call warn_report_err() once.
+ */
+void warn_report_once_err(Error *err);
+
 /*
  * Convenience function to error_report() and free @err.
  * The report includes hints added with error_append_hint().
diff --git a/util/error.c b/util/error.c
index e5e247209a9e0796074a9794f5598325f22f8d35..b8a211cccaa609a93091b86316144a0ad0a02662 100644
--- a/util/error.c
+++ b/util/error.c
@@ -247,6 +247,15 @@ void warn_report_err(Error *err)
     error_free(err);
 }
 
+void warn_report_once_err(Error *err)
+{
+        static bool print_once_;
+        if (!print_once_) {
+            warn_report_err(err);
+            print_once_ = true;
+        }
+}
+
 void error_reportf_err(Error *err, const char *fmt, ...)
 {
     va_list ap;
-- 
2.48.1


