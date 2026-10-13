Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B035DCC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcgL-0000jg-Ox; Tue, 13 Oct 2026 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgI-0000hy-6n
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgF-0006O5-8g
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791898594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKyJjSu4Mfwqvvmj4TnKSTox1Bq2unv4lt2zjKfHXTU=;
 b=Q8eQr7aC963sEwP6kAcrw3sQcV6Na1+eAN0DivHMPW1KUYr+Gv5rfeP0kaoIkuMm+4SnK5
 iZmhy6jeAMedxOAXMx6omNNT6tfbIJVBkkoo/xEpsS8MGgGGquFcOQNdCf0DhORWHkjwZ4
 liS9rmOBi6+Uvvw1w+nS0eAQ0uJ0WxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-AQyufAOJO6m_XclH20HIRw-1; Tue,
 13 Oct 2026 13:36:29 +0000
X-MC-Unique: AQyufAOJO6m_XclH20HIRw-1
X-Mimecast-MFC-AGG-ID: AQyufAOJO6m_XclH20HIRw_1791898589
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5131828AEC; Tue, 13 Oct 2026 13:36:28 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D82B195604B; Tue, 13 Oct 2026 13:36:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/4] Revert "io: add support for activating TLS thread safety
 workaround"
Date: Tue, 13 Oct 2026 14:36:20 +0100
Message-ID: <20261013133622.993935-3-berrange@redhat.com>
In-Reply-To: <20261013133622.993935-1-berrange@redhat.com>
References: <20261013133622.993935-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit edea818371bd7179b55f38d3b113d342251d8f9b.

The workaround for the GNUTLS bug was not correct and it was
decided to rely on GNUTLS being patched by distros instead,
or users manually disabling use of the problematic ciphers.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel.h | 1 -
 io/channel-tls.c     | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index c90ace20d53..834ba7c3098 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -47,7 +47,6 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY,
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
     QIO_CHANNEL_FEATURE_SEEKABLE,
-    QIO_CHANNEL_FEATURE_CONCURRENT_IO,
 };
 
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 05317ed5a38..5b0524e68dd 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -261,11 +261,6 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
 {
     QIOTask *task;
 
-    if (qio_channel_has_feature(QIO_CHANNEL(ioc),
-                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
-        qcrypto_tls_session_require_thread_safety(ioc->session);
-    }
-
     task = qio_task_new(OBJECT(ioc),
                         func, opaque, destroy);
 
-- 
2.56.0


