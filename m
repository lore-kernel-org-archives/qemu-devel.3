Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF4C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WzA-0004yw-31; Mon, 07 Sep 2026 06:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wyl-0004XX-5d
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3Wyf-00007Z-Ju
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24q1MZ0ugZdhngBNFVmvW75PJPqXcwOs83tFjUN7CUc=;
 b=cvP0yy8s4yiFuOr1tAi5DcdpBVHaIVtGf3JePvw0Qy01TFnJeImRw3GAO+3HURKNwf75E2
 3i9eE7oW6tZeUcvG55mA6JLg0PctcyvKMEd9GI07BFDFa4TZexCuy/twplhQ7ZjCZadqcf
 3SMi7cGOZfkMn8oPDHkik23BbZMtDGw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-s8QvkmhwMiqDKCpIJvSo1A-1; Mon,
 07 Sep 2026 06:53:26 -0400
X-MC-Unique: s8QvkmhwMiqDKCpIJvSo1A-1
X-Mimecast-MFC-AGG-ID: s8QvkmhwMiqDKCpIJvSo1A_1788778405
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9372A1954105; Mon,  7 Sep 2026 10:53:25 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 669BD1956042; Mon,  7 Sep 2026 10:53:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PULL v3 05/12] io/channel-websock: send an HTTP 400 when the
 greeting has no space
Date: Mon,  7 Sep 2026 11:53:03 +0100
Message-ID: <20260907105310.497730-6-berrange@redhat.com>
In-Reply-To: <20260907105310.497730-1-berrange@redhat.com>
References: <20260907105310.497730-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qio_channel_websock_extract_headers() returns 0 without queueing a
response when the request line contains no space, unlike every sibling
check which jumps to bad_request. encoutput stays empty, yet
qio_channel_websock_handshake_read() still reports success and the
caller arms a G_IO_OUT watch to flush nothing.

Flushing that empty buffer is where QEMU crashes. Any client can
trigger it before authentication on a VNC websocket port:

  printf 'stats\r\nx\r\n\r\n' | nc $host $port

Fixes: 07e95cd529af ("io: fully parse & validate HTTP headers for websocket protocol handshake")
Fixes: f69a8bde2935 ("io: send proper HTTP response for websocket errors")
Fixes: CVE-2026-84788
Cc: qemu-stable@nongnu.org
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 1929abf56a..66c91ed2a2 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -230,7 +230,7 @@ qio_channel_websock_extract_headers(QIOChannelWebsock *ioc,
     tmp = strchr(buffer, ' ');
     if (!tmp) {
         error_setg(errp, "Missing HTTP path delimiter");
-        return 0;
+        goto bad_request;
     }
     *tmp = '\0';
 
-- 
2.55.0


