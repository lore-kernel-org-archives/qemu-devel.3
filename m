Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAE9FED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aHN-0006Op-5A; Thu, 12 Mar 2026 03:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aH2-0006Dh-TJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aH0-0001t1-8O
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7TP4pcyGvQDh1DUUtvcRt7y8rlEbVtZORgehPcPMHGA=;
 b=MiN+78PGb56Rt1v45TvmZ03Q0n6BdUYxTyDo+FkLxCWwfVcS7QrobhhDcMYyUgeeW2lqCf
 tMsZftKIhGAvVLBZlaFsSg6DmfkDur7Gp/aFQ8fB3LMTRluWZkA5gBsxDbLqtngd5l/H+u
 udc6/fP5oM1tx7vH3v+v6eSBoqh0NHo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-9kIESzKbPmWOpEAJhjSnNw-1; Thu,
 12 Mar 2026 03:15:53 -0400
X-MC-Unique: 9kIESzKbPmWOpEAJhjSnNw-1
X-Mimecast-MFC-AGG-ID: 9kIESzKbPmWOpEAJhjSnNw_1773299752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D343518005B6; Thu, 12 Mar 2026 07:15:51 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3ABED1800107; Thu, 12 Mar 2026 07:15:47 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 9/9] net/filter-redirector: check CAP_NET_RAW before creating
 AF_PACKET
Date: Thu, 12 Mar 2026 15:09:37 +0800
Message-ID: <20260312071415.1836655-10-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Creating an AF_PACKET SOCK_RAW socket requires the CAP_NET_RAW
capability.  Without it the qemu_socket() call fails with EPERM,
producing a generic error that gives no hint about the missing
capability.

Add an explicit capget()-based check in filter_redirector_netdev_setup()
before the socket call.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index dabf52275a..a07ae61b2d 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -34,6 +34,8 @@
 #include <net/if.h>
 #include <linux/if_packet.h>
 #include <netinet/if_ether.h>
+#include <linux/capability.h>
+#include <sys/syscall.h>
 
 typedef struct MirrorState MirrorState;
 DECLARE_INSTANCE_CHECKER(MirrorState, FILTER_MIRROR,
@@ -690,6 +692,21 @@ static void filter_redirector_maybe_enable_read_poll(NetFilterState *nf)
     }
 }
 
+static bool filter_redirector_has_cap_net_raw(void)
+{
+    struct __user_cap_header_struct hdr = {
+        .version = _LINUX_CAPABILITY_VERSION_3,
+        .pid = 0,
+    };
+    struct __user_cap_data_struct data[2] = {};
+
+    if (syscall(SYS_capget, &hdr, data) < 0) {
+        return false;
+    }
+
+    return data[CAP_NET_RAW >> 5].effective & (1u << (CAP_NET_RAW & 31));
+}
+
 static bool filter_redirector_netdev_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
@@ -724,6 +741,13 @@ static bool filter_redirector_netdev_setup(NetFilterState *nf, Error **errp)
         return false;
     }
 
+    if (!filter_redirector_has_cap_net_raw()) {
+        error_setg(errp,
+                   "AF_PACKET raw socket requires CAP_NET_RAW; "
+                   "run with 'setcap cap_net_raw+ep <qemu-binary>' or as root");
+        return false;
+    }
+
     fd = qemu_socket(AF_PACKET, SOCK_RAW | SOCK_NONBLOCK, htons(ETH_P_ALL));
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to create AF_PACKET socket");
-- 
2.52.0


