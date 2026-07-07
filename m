Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA55C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9xP-00079O-Ro; Tue, 07 Jul 2026 13:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wR-0005xx-Oe
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wO-0001MM-QX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783446639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rU5d0VbqexpaPUUC+IxxQyJPHnqRNZBfwNRtAC9/36U=;
 b=TBnlKJljUJLk2SpJdfHv58Kb4bNLgy6OZGGq+uToYZHvJ0oSRg/LsBQjeNAxbOQfh7hrGO
 N/hIw45++HXsJL0GGcnctPRD1WJmQQiHJk+HCXLLIs7+Z1tosdY9qam4bU4pjeigGvc4tY
 Q8hTBvOcu9tJEiVry9b9Qv2P8Sug/4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-3gIdN707PP2KpjhsgkbXOw-1; Tue,
 07 Jul 2026 13:50:38 -0400
X-MC-Unique: 3gIdN707PP2KpjhsgkbXOw-1
X-Mimecast-MFC-AGG-ID: 3gIdN707PP2KpjhsgkbXOw_1783446637
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 108DE180895C; Tue,  7 Jul 2026 17:50:37 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.142])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 819563692B; Tue,  7 Jul 2026 17:50:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] io/channel-socket: Document why we can ignore
 socket_set_cork() errors
Date: Tue,  7 Jul 2026 18:50:26 +0100
Message-ID: <20260707175027.3029620-4-berrange@redhat.com>
In-Reply-To: <20260707175027.3029620-1-berrange@redhat.com>
References: <20260707175027.3029620-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In qio_channel_socket_set_cork(), we call socket_set_cork() but
ignore its success/failure return value.  This is OK because we are
implementing qio_channel_set_cork() here, and that function's API
documentation states that the setting is merely a hint.  So even if
setting TCP_CORK on the underlying socket fails for some reason, this
isn't going to be a problem for the caller; correspondingly the
qio_channel_set_cork() function has no error return.

Add a comment in qio_channel_socket_set_cork() explaining why we
don't check for errors.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2254
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index ea2ec84108..12773b832c 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -946,6 +946,12 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     int v = enabled ? 1 : 0;
 
+    /*
+     * We can ignore the error return from socket_set_cork() because
+     * at the QIO API level set_cork is only a hint, and so
+     * qio_channel_set_cork() can never fail even if it didn't
+     * actually do anything.
+     */
     socket_set_cork(sioc->fd, v);
 }
 
-- 
2.55.0


