Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26117C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcA9-0005l1-LB; Mon, 10 Mar 2025 08:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trcA4-0005ju-5S
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trcA0-0004zG-Iy
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741609387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WQlBLlp4ltXr/SfUXVELPpmGEbHirnEhHyZVd5u19w=;
 b=BZQXhDZbQCQNnyZKkODD4/3pBPZ4dUUmev45UpWry8vNC3HRSQXufZFIJcaDzvdWp2MEKH
 a0st466CA2p7TCjFt8kV3ri8RJaW2x349VeaS60nFiy2NqdV/pX7MKPGeYpQxtudnNjiUa
 CH0XsedaIjkE0oKyQvfC9PFsjjhH5zU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-P7ZMbLWWO1O1I9Ymd_ryaA-1; Mon,
 10 Mar 2025 08:23:06 -0400
X-MC-Unique: P7ZMbLWWO1O1I9Ymd_ryaA-1
X-Mimecast-MFC-AGG-ID: P7ZMbLWWO1O1I9Ymd_ryaA_1741609385
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F3631955DCC; Mon, 10 Mar 2025 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FA551800370; Mon, 10 Mar 2025 12:23:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 5/5] tap-linux: Open ipvtap and macvtap
Date: Mon, 10 Mar 2025 20:22:40 +0800
Message-ID: <20250310122240.2908-6-jasowang@redhat.com>
In-Reply-To: <20250310122240.2908-1-jasowang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

ipvtap and macvtap create a file for each interface unlike tuntap, which
creates one file shared by all interfaces. Try to open a file dedicated
to the interface first for ipvtap and macvtap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap-linux.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index 1226d5fda2..22ec2f45d2 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
     int len = sizeof(struct virtio_net_hdr);
     unsigned int features;
 
-    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
+
+    ret = if_nametoindex(ifname);
+    if (ret) {
+        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
+        fd = open(file, O_RDWR);
+    } else {
+        fd = -1;
+    }
+
     if (fd < 0) {
-        error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
-        return -1;
+        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
+        if (fd < 0) {
+            error_setg_errno(errp, errno, "could not open %s", PATH_NET_TUN);
+            return -1;
+        }
     }
     memset(&ifr, 0, sizeof(ifr));
     ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
-- 
2.42.0


