Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38212C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taB40-0001Ic-7S; Tue, 21 Jan 2025 05:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1taB3t-0001IB-7Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:00:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1taB3q-0005ok-Ay
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737453639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M4H+TKaSnMmZT7BBnMw3xJyInDC4K0UjFRJ3slxO+5I=;
 b=NSWtI+wmRzN4c0UKEf/aoM2S2BeAOhXoBQHi0eVBUd1mFJhyLN25FV4M9xjLioxuEXcHAq
 5wBn+PwoyFgz11qccYoGURXFHwedg1hqFrRMQ4oppQTBxvzYvhdzJi4RFcbECR9X0DJBsh
 JwVNz8H0pvzQ5zVXDCA9vp9l7ZMO7pQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-tn8H6gYAOq-KW_sn22Tp4g-1; Tue,
 21 Jan 2025 05:00:35 -0500
X-MC-Unique: tn8H6gYAOq-KW_sn22Tp4g-1
X-Mimecast-MFC-AGG-ID: tn8H6gYAOq-KW_sn22Tp4g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 393B819560B8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:00:33 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.193.207])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE3D019560BF; Tue, 21 Jan 2025 10:00:30 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user: Silence unsupported VHOST_USER_PROTOCOL_F_RARP
 error
Date: Tue, 21 Jan 2025 11:00:29 +0100
Message-ID: <20250121100029.1106973-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

In vhost_user_receive() if vhost_net_notify_migration_done() reports
an error we display on the console:

  Vhost user backend fails to broadcast fake RARP

This message can be useful if there is a problem to execute
VHOST_USER_SEND_RARP but it is useless if the backend doesn't
support VHOST_USER_PROTOCOL_F_RARP.

Don't report the error if vhost_net_notify_migration_done()
returns -ENOTSUP (from vhost_user_migration_done())

Update vhost_net-stub.c to return -ENOTSUP too.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c | 2 +-
 net/vhost-user.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e4d..875cd6c2b9c8 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
 
 int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
 {
-    return -1;
+    return -ENOTSUP;
 }
 
 VHostNetState *get_vhost_net(NetClientState *nc)
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 12555518e838..636fff8a84a2 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
 
         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
 
-        if ((r != 0) && (display_rarp_failure)) {
+        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
             fprintf(stderr,
                     "Vhost user backend fails to broadcast fake RARP\n");
             fflush(stderr);
-- 
2.47.1


