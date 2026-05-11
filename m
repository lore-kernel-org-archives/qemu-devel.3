Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F209CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8q-0003eU-Pm; Mon, 11 May 2026 16:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8p-0003aV-Vq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8o-00021Q-ED
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck9oxXsPwba+56Bsnnc0jVTBh7LdjgqMRrXXUMKXUi4=;
 b=C26PDXvCYR1jENLIWrdaEn+ROqCoHDXDh5WVQIhYFnb0WLu8djL6pcZVYlcAIvSGU8zoVv
 T7aDSDVzGqZ6J1BdVzKT/iTCbI3jG9uXYP5OXCUHKzpYVLOIyCgqSWuZ17xrG0ujA6rHKD
 XWjvnst3TvesTK+9KihOpk8C91UwJwo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-UwxJ-exRNgq0wMN5VK5i0Q-1; Mon,
 11 May 2026 16:22:11 -0400
X-MC-Unique: UwxJ-exRNgq0wMN5VK5i0Q-1
X-Mimecast-MFC-AGG-ID: UwxJ-exRNgq0wMN5VK5i0Q_1778530930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F68F1956066; Mon, 11 May 2026 20:22:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6291F1955D84; Mon, 11 May 2026 20:22:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/24] net/can: free ifname on socketcan finalization
Date: Tue, 12 May 2026 00:20:56 +0400
Message-ID: <20260511202111.3091440-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

can_host_socketcan_set_if allocates ifname via g_strdup, but no
instance_finalize existed to free it.

Fixes: ea15ea8a7c67 ("net/can: support for connecting to Linux host SocketCAN interface.")
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/can/can_socketcan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 8a57ae07178..be67ed7f5a9 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -319,11 +319,19 @@ static void can_host_socketcan_class_init(ObjectClass *klass,
     chc->disconnect = can_host_socketcan_disconnect;
 }
 
+static void can_host_socketcan_finalize(Object *obj)
+{
+    CanHostSocketCAN *c = CAN_HOST_SOCKETCAN(obj);
+
+    g_free(c->ifname);
+}
+
 static const TypeInfo can_host_socketcan_info = {
     .parent = TYPE_CAN_HOST,
     .name = TYPE_CAN_HOST_SOCKETCAN,
     .instance_size = sizeof(CanHostSocketCAN),
     .instance_init = can_host_socketcan_instance_init,
+    .instance_finalize = can_host_socketcan_finalize,
     .class_init = can_host_socketcan_class_init,
 };
 
-- 
2.54.0


