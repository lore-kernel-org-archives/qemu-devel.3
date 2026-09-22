Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB5CC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x986A-0004tP-Qm; Tue, 22 Sep 2026 17:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x9869-0004sl-NJ; Tue, 22 Sep 2026 17:32:21 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x9866-0007Ee-9j; Tue, 22 Sep 2026 17:32:21 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id C843080908;
 Wed, 23 Sep 2026 00:32:14 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:126::1:23])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BWjvhxGXtiE0-TCD7XwHe; Wed, 23 Sep 2026 00:32:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1790112734;
 bh=tzYE8XD4llxLxWjfhOS1JgAPPaMrLBLyZ19/qcfhhsE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=zuxOI05hH3XLR1vtI8hE1ivZXCkJsHdSrb80q2ieDTHZ8L5N4b4Y3+TXJw8CEh+B9
 S1AnVz4Q57Cf3y0xlIxuNdzpEhDdzaQnD2aFRgzLbIwBUYayIgO6lI8nPOThivo6fo
 AywW1z0mCO5EptshRvYFAe4SoJLiAdReq+NKCrpU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] qapi/virtio: Restore backend features in
 x-query-virtio-status
Date: Wed, 23 Sep 2026 00:32:09 +0300
Message-ID: <20260922213210.1429435-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

Commit 1ee0bc0c9bf0 removed vhost_dev.backend_features and its
representation in VhostStatus. It also removed the assignment to
VirtioStatus.backend_features, although both that field and its source,
VirtIODevice.backend_features_ex, still exist.

The resulting NULL pointer causes HMP info virtio-status and QMP
x-query-virtio-status to crash. This affects virtio devices even without
an active vhost backend.

Restore the assignment from VirtIODevice.backend_features_ex and
enable corresponding test, which becomes fixed.

Fixes: 1ee0bc0c9bf0 ("vhost: drop backend_features field")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-qmp.c                        | 2 ++
 tests/functional/x86_64/test_virtio_status.py | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 5aaeebdd96a..8b7cd7a3106 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -713,6 +713,8 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
                                                  vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
                                                 vdev->host_features_ex);
+    status->backend_features = qmp_decode_features(vdev->device_id,
+                                                   vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
diff --git a/tests/functional/x86_64/test_virtio_status.py b/tests/functional/x86_64/test_virtio_status.py
index c8cbdf7c42e..1e72c713cc6 100755
--- a/tests/functional/x86_64/test_virtio_status.py
+++ b/tests/functional/x86_64/test_virtio_status.py
@@ -84,7 +84,6 @@ def test_vhost(self):
 
         self.check_commands(vm)
 
-    @skipIfMissingEnv("QEMU_FAILING_TESTS")
     def test_no_vhost(self):
         self.vm.add_args("-accel", "kvm",
                          "-S", "-net", "none", "-device",
-- 
2.43.0


