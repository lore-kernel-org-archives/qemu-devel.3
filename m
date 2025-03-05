Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246F3C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiT5-0002yV-2n; Wed, 05 Mar 2025 01:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSv-0002lU-Qa
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSt-0001lL-PN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9W1tJivdWNPooAUuBUtSOede854BhYMCV5PWynoL1ok=;
 b=fWEfTzmOuhUD/bbGjBLcf5B60Q5DWP2EC+Z4agnqzfiFUyRCa1tSaYC2Fd5MCIkifmsu+u
 mA+Ytwzq+B9PV7dcj6yVV4N6U4TWzY5qB3Xoi7CeIKURt8+meFCeXeQj54hA/KF5BdTDoo
 KxTcDyo4bck5VWT2QBnUTjtaG8wVbcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-aFa4LCzmNFCr0Hk-Hoix2A-1; Wed,
 05 Mar 2025 01:42:29 -0500
X-MC-Unique: aFa4LCzmNFCr0Hk-Hoix2A-1
X-Mimecast-MFC-AGG-ID: aFa4LCzmNFCr0Hk-Hoix2A_1741156948
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 727FD1955BC5; Wed,  5 Mar 2025 06:42:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0AAF180049D; Wed,  5 Mar 2025 06:42:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Haoqian He <haoqian.he@smartx.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 6/6] chardev: use remoteAddr if the chardev is client
Date: Wed,  5 Mar 2025 10:41:32 +0400
Message-ID: <20250305064132.87441-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Haoqian He <haoqian.he@smartx.com>

If the chardev is client, the socket file path in localAddr may be NULL.
This is because the socket path comes from getsockname(), according
to man page, getsockname() returns the current address bound by the
socket sockfd. If the chardev is client, it's socket is unbound sockfd.

Therefore, when computing the client chardev socket file path, using
remoteAddr is more appropriate.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250225104526.2924175-1-haoqian.he@smartx.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 91496ceda9..2f842f9f88 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -571,9 +571,13 @@ static char *qemu_chr_compute_filename(SocketChardev *s)
 
     switch (ss->ss_family) {
     case AF_UNIX:
-        return g_strdup_printf("unix:%s%s",
-                               ((struct sockaddr_un *)(ss))->sun_path,
-                               s->is_listen ? ",server=on" : "");
+        if (s->is_listen) {
+            return g_strdup_printf("unix:%s,server=on",
+                                   ((struct sockaddr_un *)(ss))->sun_path);
+        } else {
+            return g_strdup_printf("unix:%s",
+                                   ((struct sockaddr_un *)(ps))->sun_path);
+        }
     case AF_INET6:
         left  = "[";
         right = "]";
-- 
2.47.0


