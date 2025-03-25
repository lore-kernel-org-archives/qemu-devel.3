Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E76C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy9H-0005py-Bo; Tue, 25 Mar 2025 02:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8J-0004xe-VR; Tue, 25 Mar 2025 02:51:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8I-0001jP-77; Tue, 25 Mar 2025 02:51:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27CA4107D6E;
 Tue, 25 Mar 2025 09:49:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BEA311D5E7B;
 Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B7E5D5703E; Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 47/51] vdpa: Allow vDPA to work on big-endian machine
Date: Tue, 25 Mar 2025 09:50:33 +0300
Message-Id: <20250325065038.3263786-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

Add .set_vnet_le() function that always returns success, assuming that
vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
outputs the message:
"backend does not support LE vnet headers; falling back on userspace virtio"

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit b027f55a994af885a7a498a40373a2dcc2d8b15e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 94b68063e4..0d82205576 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -258,6 +258,18 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
 
 }
 
+/*
+ * FIXME: vhost_vdpa doesn't have an API to "set h/w endianness". But it's
+ * reasonable to assume that h/w is LE by default, because LE is what
+ * virtio 1.0 and later ask for. So, this function just says "yes, the h/w is
+ * LE". Otherwise, on a BE machine, higher-level code would mistakely think
+ * the h/w is BE and can't support VDPA for a virtio 1.0 client.
+ */
+static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool enable)
+{
+    return 0;
+}
+
 static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
                                        Error **errp)
 {
@@ -421,6 +433,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
+        .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
-- 
2.39.5


