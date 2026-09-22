Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B07C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x986E-0004wu-Ah; Tue, 22 Sep 2026 17:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x986A-0004tQ-MK; Tue, 22 Sep 2026 17:32:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x9866-0007Ek-9i; Tue, 22 Sep 2026 17:32:22 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 9327780892;
 Wed, 23 Sep 2026 00:32:15 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:126::1:23])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BWjvhxGXtiE0-ehkC0chY; Wed, 23 Sep 2026 00:32:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790112735;
 bh=FvqVXcBKgWH+uWCBinN65HrAd3xMQ6F5Q3jF9ezgjS0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VW+xt3h+F8UsWtzkpt7FrSFdyG5OrrCp73OI4v+85TWutFK5lqagsmuomf5UNIGvH
 ClUXGiOQyST2XuQqFUqi29Q0QlU89HJDRwbIWE/yt/Zc8P15g7Tw8W6VTWbgP5hPV1
 bq6RpeXgSujXMse6VArTdlFq4pIeIE/PtVQkiidI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org, Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 3/3] qapi/monitor: Handle missing vhost-user protocol features
Date: Wed, 23 Sep 2026 00:32:10 +0300
Message-ID: <20260922213210.1429435-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit f9a8f5812607 moved protocol_features to the vhost-user backend.
As a result, VhostStatus.protocol_features is only populated for
vhost-user devices.

For an active kernel vhost device, HMP info virtio-status and QMP
x-query-virtio-status crashes now because of unset protocol-features.

Make protocol-features optional in VhostStatus and skip dumping a
missing object in HMP.

For QMP we can change the x-query-virtio-status command semantics
because it is unstable.

Enable corresponding test, it works now.

Fixes: f9a8f5812607 ("vhost: move protocol_features to vhost_user")
Co-authored-by: Nikolay Kuratov <kniv@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-hmp-cmds.c                   | 6 ++++--
 qapi/virtio.json                              | 5 +++--
 tests/functional/x86_64/test_virtio_status.py | 1 -
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index e5da6f00699..5b08a06ec42 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -176,8 +176,10 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
         hmp_virtio_dump_features(hmp, s->vhost_dev->features);
         monitor_hmp_printf(hmp, "    Acked features:\n");
         hmp_virtio_dump_features(hmp, s->vhost_dev->acked_features);
-        monitor_hmp_printf(hmp, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
+        if (s->vhost_dev->protocol_features) {
+            monitor_hmp_printf(hmp, "    Protocol features:\n");
+            hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
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
diff --git a/tests/functional/x86_64/test_virtio_status.py b/tests/functional/x86_64/test_virtio_status.py
index 1e72c713cc6..a88823004f8 100755
--- a/tests/functional/x86_64/test_virtio_status.py
+++ b/tests/functional/x86_64/test_virtio_status.py
@@ -45,7 +45,6 @@ def check_commands(self, vm):
         vm.cmd("x-query-virtio-status", path=self.VIRTIO_PATH)
 
     @skipIfMissingCommands("unshare")
-    @skipIfMissingEnv("QEMU_FAILING_TESTS")
     def test_vhost(self):
         self.require_netdev("tap")
         for device in ("/dev/net/tun", "/dev/vhost-net"):
-- 
2.43.0


