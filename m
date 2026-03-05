Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2671DF3D330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBk1-00062Z-Af; Thu, 05 Mar 2026 11:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjw-000623-MY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjo-0000YA-Vw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cU/zY+VJo7e7mlP38RPbCbmiFd4EjjN2KVaCXgm2+UU=;
 b=NYj7zsMS4nCuLbtzp6khvl7tsgKA48P32HT69JmHlRRHkQczLY3Dnj9oILqIs64eMcgsDJ
 fUFjEYgq6cLL/qQy8GL2vAsISwljUyzSRH0GrXKEoH8AZ8/KZIkJVkyur0tbBXA5YHO3Lz
 1SKNOXBcri9wHkdcAXrwoCLQ3R9V+90=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-UXBIbErbPVq41t54mUuvfg-1; Thu,
 05 Mar 2026 11:39:44 -0500
X-MC-Unique: UXBIbErbPVq41t54mUuvfg-1
X-Mimecast-MFC-AGG-ID: UXBIbErbPVq41t54mUuvfg_1772728783
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BD511956050; Thu,  5 Mar 2026 16:39:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7C3C1958DCA; Thu,  5 Mar 2026 16:39:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 0/8] Add vhost-vdpa and Shadow Virtqueue tests
Date: Thu,  5 Mar 2026 17:39:30 +0100
Message-ID: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Based on vhost-user tests, the qos register itself as a VDUSE device and
receives the events from QEMU.

The test infrastructure creates a thread that acts as a VDUSE device, while the
regular test thread is managing QEMU.

This enables automated testing of vhost-vdpa code paths that previously
required manual testing.

Changes from vhost-user test:
* Automatic cleanup of many things.
* Handle the vduse fd and timeout.
* VDPA device cannot be removed before deleting QEMU, killing QEMU in
  vhost_vdpa_test_cleanup.
* Read in enable callbacks, and the actual test_read_guest_mem is just waiting.
* Add vhost_vdpa_thread to abstract fd monitoring
* Use QemuMutex and QemuConf for scoped cleanup

RFC: I'm not sure if this is the right place to add the tests in meson. Also, a
few things are just with asserts() or g_spawn(), instead of more elegant code.
I can clean them if this result useful.

Also, I don't know how to include the libvduse.a library as meson complains
it's out of the tests/ directory, so I'm including the .c directly.  Ugly but
it works for now.

The test verifies SVQ correctly handles batched pushes where multiple elements
are filled before flushing the used ring.

With this test, gcov reported coverage is:
                   Total  Hit
Lines:     83.9 %    347  291
Functions: 90.3 %     31   28
Branches:  59.2 %    157   93

Apart from impossible banches like scoped cleanups, the missing blocks
are:
* Full queue situations, or use a full queue at once with IN_ORDER.
* Event idx.
* All SVQ CVQ handling.
* Hard to reproduce casuistics like a linear buffer in GPA that is
  split into more than one buffer in HVA, and then SVQ is saturated.
* Buggy input (no descriptors, used descriptors that are not available,
  moving indexes more than vq size).
* Unbinding device call notifier from QEMU vhost system.
* Malicious inputs.

This builds on top of
https://mail.gnu.org/archive/html/qemu-devel/2026-03/msg01366.html

Eugenio Pérez (8):
  tests: vhost-vdpa: add initial VDUSE-based vhost-vdpa tests
  tests: vhost-vdpa: parameterize VDUSE operations
  tests: vhost-vdpa: add TX packet transmission test
  tests: vhost-vdpa: test SVQ cleanup of pending buffers
  tests: vhost-vdpa: add descriptor chain tests
  tests: vhost-vdpa: test out-of-order descriptor completion
  tests: vhost-vdpa: introduce TestParameters struct
  tests: vhost-vdpa: add VIRTIO_F_IN_ORDER feature tests

 tests/qtest/meson.build       |   3 +
 tests/qtest/vhost-vdpa-test.c | 805 ++++++++++++++++++++++++++++++++++
 2 files changed, 808 insertions(+)
 create mode 100644 tests/qtest/vhost-vdpa-test.c

-- 
2.53.0


