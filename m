Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9511ECF649D
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 16:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suwNh-0001Eo-5l; Sun, 29 Sep 2024 12:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1suwNI-0000uN-Ju
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 12:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1suwNH-00053V-09
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727625738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD94lcvC8v6wGaXgi9MNfUlyhI2EIb4wEelTESyzNSU=;
 b=B9jJFkUoT/7edQ8VAD85X2oyItfa9DelPQMh5YbugVx8B3q1/O0BNRvl1CvOZIee+3V+KA
 qhmPs++jDlGa8zZPTMJ59+PcYzC7mRnkvS9NCu2QQmeQhgBQYVM41Q+uodf0uQBmoZdGLJ
 qbTCbt4xOGCz2q12+mVR5uRKVxMu7z4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-P__mMd4gMyiVbFJMdslqUA-1; Sun,
 29 Sep 2024 12:01:11 -0400
X-MC-Unique: P__mMd4gMyiVbFJMdslqUA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0123C1933B73
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 16:01:11 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D755F19373D7; Sun, 29 Sep 2024 16:01:07 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] virtio_net: Add the 3rd acceptable situation for Mac
 setup.
Date: Sun, 29 Sep 2024 23:59:57 +0800
Message-ID: <20240929160045.2133423-4-lulu@redhat.com>
In-Reply-To: <20240929160045.2133423-1-lulu@redhat.com>
References: <20240929160045.2133423-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

While the hardware MAC address is 0 and the MAC address in
the QEMU command line is also 0, this configuration is
acceptable.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5c610d8078..668fbed9f2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3620,6 +3620,17 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
             return true;
         }
     }
+    /*
+     * 3.The hardware MAC address is 0,
+     *  and the MAC address in the QEMU command line is also 0.
+     *  In this situation, qemu will use random mac address
+     */
+    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) == 0) &&
+        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
+        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
+
+        return true;
+    }
 
     error_setg(errp,
                "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
-- 
2.45.0


