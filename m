Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4FBCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWj5-0004Sf-JJ; Fri, 05 Jun 2026 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWix-0004Rl-Dm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWiw-0005qy-4x
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lytCdpvdiMPurS2UAPPEkSbXcRb49Mlw8+CgeQ0/TBc=;
 b=cRHSCc+GF5CbPFwLmtXKquhCokNockVwxbRd9RVB/cp/jdjsJAE5tCZ8VdbkGqg4Z0iwru
 Ov1MnKHn/+TK/ZrzHNGdueJWZrmWyhrzEOCiFmUoXNj0JCAA2EAo49xxDwYFgRfgYBcj1+
 oMYcwc9U0P3LNnrVYJY4EgwwXnzBAD8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-XAHkhhkAMDOS3xpdNJxVyg-1; Fri,
 05 Jun 2026 11:44:39 -0400
X-MC-Unique: XAHkhhkAMDOS3xpdNJxVyg-1
X-Mimecast-MFC-AGG-ID: XAHkhhkAMDOS3xpdNJxVyg_1780674278
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD211956046
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15705195608E; Fri,  5 Jun 2026 15:44:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:22 +0400
Subject: [GIT PULL 02/23] chardev/char-socket: handle NULL addr in
 char_socket_get_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-2-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wplotIDRIQizQ4vLWFXXRZnYhLKWxLjUBChA2au34a0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7UnZJIbnbiOGwoQ8gZBfzXGLLK5wS1rlb8M
 pxE3b6VbluJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5VnjEACrWYDeNQ4CWBbjsVQeWxpIxQ/DxcljWMOVYyogxESW6r7MNLw09lBT20WruwnKEgxxYyG
 pq8dIy8sD3YkzZO1cwQCFZQkf0UZ4XgNvJ1/8n8oeC6/e1/BMzPbdS+sZFhUPhAtvKlFTSyyL4p
 l4UiHYP0sfEMTD5c5bG1SshtUoISe5nTdmk9eIaYw4TIshJKkl5AuwmB5iQISMJCb4AGQjJ94ht
 Yi7c3PCywcA+FvG34uuCBWEW0NEEKDRHxOGRTRCHy7EZu7ER9+fcY8CJdYY3lDSirfg5XHPlQrO
 hcrJL7CpErp8UEs0Ih+T+okUQKXw1I4K1g0bjS/GVmKpHY75tVcNtgz9SzRrL8botlkqZI0an3P
 5FG0XfnvkV5wRimNXGqn7T7HmNZZIq/2KNdDvkL8HlZFWeRw0iw4ff/fCgulR6NbFt4V9Ulj4bE
 CJZTstm9naMW6anFBn+fPF9pEH8XRQVdQhE4vHIpLzIYyNzUSOF8PlCLNT4vSdAZIfmElHbu8hK
 R6w61uUkgtke4cTLaG8H/PdU+j7oQLyEM2DyWKVUC66aMBkZaha6xfHBuk+5MKGpbO6+IB3st4n
 KSxV7HptLQM/9zAv9VvEhE61ODu5RHJKjf3/Ns7sYESOqOkrYsI9MIoCjhizZXkYziMpOJL8TLQ
 xqFsQ4WlZorxDQg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When called on an unrealized chardev (e.g. from
qmp_qom_list_properties), s->addr is NULL. Return an error instead of
assert().

Fixes: 123676e9894f ("char-socket: add 'addr' property")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c50..b629575fcf8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1529,6 +1529,10 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
 {
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
+    if (!s->addr) {
+        error_setg(errp, "socket not connected");
+        return;
+    }
     visit_type_SocketAddress(v, name, &s->addr, errp);
 }
 

-- 
2.54.0


