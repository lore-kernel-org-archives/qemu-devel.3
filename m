Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C36606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ce/K8cwk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9E-0003dx-Qc; Fri, 27 Nov 2026 01:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8H-00077d-Rp; Fri, 27 Nov 2026 01:08:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8E-0008Nk-Pm; Fri, 27 Nov 2026 01:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=frGjnXE5JQHay74XKU8NgRMJ1W0cJlPXyib8oqH4hgA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ce/K8cwk6PVu8uyRR4/yBBtw3isdnjA7mT1Qxr0GwWseHUfWAnYpmDMvjGr0GogaL
 rt+02WhV9v+ZsJE2fGeWt6cCE7+T51d3NIX1Xxr/3EYbKhoeApj1emJGwwePbgLbtt
 e716hQPOUd5rvmyJyTbbLHPdaQhbz3GVkzsT4k+AXnHBqk74bsBopzeWEpEnM8GB8P
 giF5x47dSe5BPqoyM73ug278ocychxtVVI+OVdf+Tlc+8DkftzQpirDJgqwbGSrQAw
 E2Rt3G7L8HHu8h+x07h2OaC8rSFQJW9rgWBETZc/khsz3AeauZMSo46urXiWPSDuGS
 3/xM9A/kpt9OQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3766B1EA36C;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 353E1469997;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 149D4CF326; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Nikolay Kuratov <kniv@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 122/152] qapi/monitor: Handle missing vhost-user
 protocol features
Date: Fri, 27 Nov 2026 08:54:20 +0300
Message-ID: <20261127055709.39630-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Commit f9a8f5812607 moved protocol_features to the vhost-user backend.
As a result, VhostStatus.protocol_features is only populated for
vhost-user devices.

For an active kernel vhost device, HMP info virtio-status and QMP
x-query-virtio-status crashes now because of unset protocol-features.

Make protocol-features optional in VhostStatus and skip dumping a
missing object in HMP.

This is a compatibility break.  Okay, since VhostStatus is only used
by x-query-virtio-status, which is unstable.

Fixes: f9a8f5812607 ("vhost: move protocol_features to vhost_user")
Co-authored-by: Nikolay Kuratov <kniv@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260922213210.1429435-4-vsementsov@yandex-team.ru>
(cherry picked from commit 8e4906087e874d94a31774bbce8ba35157db6d46)
(Mjt: back-port across v11.1.0-816-gf3900cfb0cdd
 "monitor: tighten monitor_printf*()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index a91bb7dbeda..c4adb6eb7bb 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -176,8 +176,10 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         hmp_virtio_dump_features(mon, s->vhost_dev->features);
         monitor_printf(mon, "    Acked features:\n");
         hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
-        monitor_printf(mon, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
+        if (s->vhost_dev->protocol_features) {
+            monitor_printf(mon, "    Protocol features:\n");
+            hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
+        }
     }
 
     qapi_free_VirtioStatus(s);
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44d..f8e699a0e4e 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -85,7 +85,8 @@
 #
 # @acked-features: vhost_dev acked_features
 #
-# @protocol-features: vhost_dev protocol_features
+# @protocol-features: vhost-user protocol features.  Present only for
+#     vhost-user devices.
 #
 # @max-queues: vhost_dev max_queues
 #
@@ -104,7 +105,7 @@
             'vq-index': 'int',
             'features': 'VirtioDeviceFeatures',
             'acked-features': 'VirtioDeviceFeatures',
-            'protocol-features': 'VhostDeviceProtocols',
+            '*protocol-features': 'VhostDeviceProtocols',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
             'log-enabled': 'bool',
-- 
2.47.3


