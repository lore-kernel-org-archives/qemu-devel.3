Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B126C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2W-00046T-P9; Tue, 14 May 2024 09:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2M-0003xa-VM
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2J-0002HT-Df
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6QkAB8f3D8Lwd7g7W+ovSdSL9dB5FytpcbJQS6xt/A=;
 b=ClKbXNI9hAg+52Suv9TF9fusraFKGeJQ22hONFXzospPcR1/XmCYdiUmc5OLn0OlasZWQV
 NOVXDJL/qnDrpXtoyZYOCqTuuk8VkTrVMHVWiMYyo6bb20ZXNTCB9wz2e7I298LxQc6St9
 ZKAhAVEaa6lAYr7rmm1fPUF+JZzi8aM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-13f8JdwiPpaNGOKEiY6BDQ-1; Tue, 14 May 2024 09:17:33 -0400
X-MC-Unique: 13f8JdwiPpaNGOKEiY6BDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CCD58016E9;
 Tue, 14 May 2024 13:17:33 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1407421EE56B;
 Tue, 14 May 2024 13:17:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Sergii Zasenko <sergii@zasenko.name>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/11] Allow UNIX socket option for VNC websocket
Date: Tue, 14 May 2024 17:17:15 +0400
Message-ID: <20240514131725.931234-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sergii Zasenko <sergii@zasenko.name>

- Remove unix socket option limitation for VNC websocket
- Reflect websocket option changes in documentation

Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230724100353.16628-1-sergii@zasenko.name>
---
 ui/vnc.c        | 5 -----
 qemu-options.hx | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index b3fd78022b..dd530f04e5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3734,11 +3734,6 @@ static int vnc_display_get_address(const char *addrstr,
         addr->type = SOCKET_ADDRESS_TYPE_UNIX;
         addr->u.q_unix.path = g_strdup(addrstr + 5);
 
-        if (websocket) {
-            error_setg(errp, "UNIX sockets not supported with websock");
-            goto cleanup;
-        }
-
         if (to) {
             error_setg(errp, "Port range not support with UNIX socket");
             goto cleanup;
diff --git a/qemu-options.hx b/qemu-options.hx
index f5c01eeeb4..4d19660336 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2516,6 +2516,10 @@ SRST
         host. It is possible to control the websocket listen address
         independently, using the syntax ``websocket``\ =host:port.
 
+        Websocket could be allowed over UNIX domain socket, using the syntax
+        ``websocket``\ =unix:path, where path is the location of a unix socket
+        to listen for connections on.
+
         If no TLS credentials are provided, the websocket connection
         runs in unencrypted mode. If TLS credentials are provided, the
         websocket connection requires encrypted client connections.
-- 
2.41.0.28.gd7d8841f67


