Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA22C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MRF-00065c-A4; Thu, 17 Apr 2025 06:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MRB-00064l-AJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MR8-000751-4E
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744885534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQTfnMByU8MnkTwicEltHqnzuHODFDc3zPKI3tdjsME=;
 b=bXNtHm/TBu7Vr6yr8NQdV82+Of3fFFyfyP0Q3sLZS/2zb7+KDZsbFOQZ6x0Odl1hbOrxEN
 Ce7kYJlhMpk/02EA8VVtZS59GPXN6mFuFpEfn3hoNLmRPEJ2oE3BSjO+OtTfKynBN0fNl5
 UZ7XzQ5RMvfUmUE1zuDXL8q7m2r+k1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-R1egKHK2M2StLf-5ebdLIg-1; Thu,
 17 Apr 2025 06:25:33 -0400
X-MC-Unique: R1egKHK2M2StLf-5ebdLIg-1
X-Mimecast-MFC-AGG-ID: R1egKHK2M2StLf-5ebdLIg_1744885532
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC0C018004A7
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:25:32 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D9161800965; Thu, 17 Apr 2025 10:25:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 1/4] vhost_vdpa : Add a new parameter to enable check mac
 address
Date: Thu, 17 Apr 2025 18:24:15 +0800
Message-ID: <20250417102522.4125379-2-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-1-lulu@redhat.com>
References: <20250417102522.4125379-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
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

When using a VDPA device, it's important to ensure that the MAC
address is correctly set.
This patch adds a new QEMU command line parameter to enable MAC
address verification,  which is enabled by default.

Usage example:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,check-mac=true\
-device virtio-net-pci,netdev=vhost-vdpa0\
....
To disable this check:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,check-mac=false\
-device virtio-net-pci,netdev=vhost-vdpa0\
....

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h | 1 +
 net/vhost-vdpa.c  | 5 +++++
 qapi/net.json     | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0..fac1951b6e 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -112,6 +112,7 @@ struct NetClientState {
     bool is_netdev;
     bool do_not_pad; /* do not pad to the minimum ethernet frame length */
     bool is_datapath;
+    bool check_mac;
     QTAILQ_HEAD(, NetFilterState) filters;
 };
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7ca8b46eee..7dbe6cf65c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1871,6 +1871,11 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
         if (!ncs[i])
             goto err;
     }
+    /* Enable the mac check by default */
+    if (opts->has_check_mac)
+        ncs[0]->check_mac = opts->check_mac;
+    else
+        ncs[0]->check_mac = true;
 
     if (has_cvq) {
         VhostVDPAState *s0 = DO_UPCAST(VhostVDPAState, nc, ncs[0]);
diff --git a/qapi/net.json b/qapi/net.json
index 310cc4fd19..0607c83833 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -510,6 +510,10 @@
 # @queues: number of queues to be created for multiqueue vhost-vdpa
 #     (default: 1)
 #
+# @check-mac: Enable the check for whether the device's MAC address
+#     and the MAC in QEMU command line are acceptable for booting.
+#     (default: true)
+#
 # @x-svq: Start device with (experimental) shadow virtqueue.  (Since
 #     7.1) (default: false)
 #
@@ -524,6 +528,7 @@
     '*vhostdev':     'str',
     '*vhostfd':      'str',
     '*queues':       'int',
+    '*check-mac':    'bool',
     '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
 
 ##
-- 
2.45.0


