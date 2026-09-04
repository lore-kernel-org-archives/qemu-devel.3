Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A1BC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ReG-0004Yf-6X; Fri, 04 Sep 2026 06:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2ReE-0004YH-VL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2ReD-0007cd-Mv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788519593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMnbT3lrKNN1v0P6OiNnV9u3B7JZqFQBvQYeYiSjTh0=;
 b=ONfvNxD5ZVJj+6zhgz2X47+SyzOx9/5khX+kbHYZuw1oWUj4NCnbYcBmiFWJcC2rXzVkFu
 u0IhoMIAdGbxKdU8WtWN07VP+xM+wP6nKsW9/r0cn3hVCfER4BS/hl2YTiBaKDcmVYhB+B
 NQFnwA2lDTz4Ipfglv/dd0sTXqpdNVs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-YkzNJqT_PamMY10xsNzwfQ-1; Fri,
 04 Sep 2026 06:59:49 -0400
X-MC-Unique: YkzNJqT_PamMY10xsNzwfQ-1
X-Mimecast-MFC-AGG-ID: YkzNJqT_PamMY10xsNzwfQ_1788519588
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DA8194511C; Fri,  4 Sep 2026 10:59:48 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E4C518005BD; Fri,  4 Sep 2026 10:59:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PULL 06/13] io/channel-websock: handle a blocked write during the
 handshake
Date: Fri,  4 Sep 2026 11:59:22 +0100
Message-ID: <20260904105929.3450663-7-berrange@redhat.com>
In-Reply-To: <20260904105929.3450663-1-berrange@redhat.com>
References: <20260904105929.3450663-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Denis V. Lunev <den@openvz.org>

qio_channel_websock_handshake_send() treats every negative return from
qio_channel_write() as fatal and passes err to error_get_pretty().
QIO_CHANNEL_ERR_BLOCK is negative but leaves err NULL, so a socket
which cannot take the response immediately crashes QEMU before the
client has authenticated.

Keep the G_IO_OUT watch armed and retry instead.

Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")
Fixes: CVE-2026-84788
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 66c91ed2a2..8f27b1f12b 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -562,6 +562,11 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
                             wioc->encoutput.offset,
                             &err);
 
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        /* Socket buffer is full, the G_IO_OUT watch stays armed */
+        return TRUE;
+    }
+
     if (ret < 0) {
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
-- 
2.55.0


