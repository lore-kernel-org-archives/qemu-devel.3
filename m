Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33911C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 15:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmmW-0007hh-2w; Fri, 18 Jul 2025 11:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeQ-0007re-BF
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucmeO-0003s2-MK
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 11:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752851127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrUJlEOorQbHvh83SNkO7ZBNjTydwLWg58kyqYGSj+I=;
 b=T1Cv0A2EVaS9aShPWd6R07aaxAZ3LPgyIf25MSU7LUOJOtqHlF/TP9soJmpxdPVj9lbUSs
 4M8LQLK9sxh/Cndt55ausYQ4J8AmngDDJq3TGFgs1q1ACp7aDJRd6dgRrbttVZ3qEjXSPm
 KwkPPWtEg1FAHgoVc6gREoufTvkbo2c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-AEUEBz47OTqQYJjvsYOtsg-1; Fri,
 18 Jul 2025 11:05:25 -0400
X-MC-Unique: AEUEBz47OTqQYJjvsYOtsg-1
X-Mimecast-MFC-AGG-ID: AEUEBz47OTqQYJjvsYOtsg_1752851125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 090211800368; Fri, 18 Jul 2025 15:05:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8678B195608D; Fri, 18 Jul 2025 15:05:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/4] io: add support for activating TLS thread safety
 workaround
Date: Fri, 18 Jul 2025 16:05:12 +0100
Message-ID: <20250718150514.2635338-3-berrange@redhat.com>
In-Reply-To: <20250718150514.2635338-1-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a QIO_CHANNEL_FEATURE_CONCURRENT_IO feature flag.

If this is set on a QIOChannelTLS session object, the TLS
session will be marked as requiring thread safety, which
will activate the workaround for GNUTLS bug 1717 if needed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel.h | 1 +
 io/channel-tls.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 62b657109c..234e5db70d 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -46,6 +46,7 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY,
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
     QIO_CHANNEL_FEATURE_SEEKABLE,
+    QIO_CHANNEL_FEATURE_CONCURRENT_IO,
 };
 
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index db2ac1deae..a8248a9216 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -241,6 +241,11 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
 {
     QIOTask *task;
 
+    if (qio_channel_has_feature(QIO_CHANNEL(ioc),
+                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
+        qcrypto_tls_session_require_thread_safety(ioc->session);
+    }
+
     task = qio_task_new(OBJECT(ioc),
                         func, opaque, destroy);
 
-- 
2.50.1


