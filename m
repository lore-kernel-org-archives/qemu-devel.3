Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5197AD61011
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlS8D-0007rb-8j; Thu, 29 Jan 2026 08:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vlS7R-0007bA-4q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:31:44 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vlS7N-0002Fn-IS
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:31:32 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 f1223ecced80858bbad775d175c50b6e91ebe3fce9827e5e39109b33fe32f804 with SMTP id
 697b612581f2605e8a538296; Thu, 29 Jan 2026 13:31:17 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1769693476;
 bh=7XHdmo/w/oDM7ux7SI3ABwML3SpbgqiGCC6OLRzvuZk=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=jVEDKIG8YloTkdK14pNg6myRBc2Fm7f3ntBslf1f0yAW4g8GpUSHFNuweXJ3YGufG
 /qQNvMUCCaR7CO0zHzJZErp78EsQC3InNivMerxwbMEkudcN3CYaWyyRAYie21C9bf
 X0Pu5rFw3HVD1iAc8yWcgh8pdWE0y9gHqCudaOFZLYYJcNYdeV56EehEgT8A0cY73F
 8z5DB8JzDLa6odZaA9oF5Sy+7XsG9sZuSl1XHBJEu2yBaYC3gIMxqWRI4P36YHzY7q
 xJjnH4XYlCMHryj85VQfWmRnJLtMJrZlhmT0yqJ9QZThFWQBfi74mnZ/EXKv6GForl
 CxyfkITrBO9MQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v4 0/3] vhost-user-bridge housekeeping and test
Date: Thu, 29 Jan 2026 07:30:46 -0600
Message-ID: <20260129133049.119829-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

The existence check of the vhost-user-bridge file checks for None
when it should check for False to determine whether the test should be
skipped; a trivial fix.

Changes since v3:
--------------------
- Fix is_readable_executable_file() check of vubr for skipping test

Link to v3:
-----------
https://lore.kernel.org/qemu-devel/20260120215021.30711-1-yodel.eldar@yodel.dev/

Thanks,
Yodel

Cover letter from v3:
=====================

This series (1) moves vhost-user-bridge (vubr) from tests/ to
contrib/vhost-user-bridge/, (2) introduces a basic functional test of
vubr, and (3) adds UDP receive packet logging to vubr:

Patch 1: Moving vhost-user-bridge
---------------------------------
After the introduction of vhost-user-bridge and libvhost-user, new
vhost-user backend daemons were placed in dedicated subdirectories of
contrib/. An F: line under the vhost section in MAINTAINERS grants these
daemons coverage; in tests/, however, vhost-user-bridge lacks coverage
and appears orphaned there. So, let's give it a home with the rest of
the vhost-user backend family.

As part of the move, vhost-user-bridge also gains a section in the
vhost-user-contrib document. More can be said about vubr there, like its
client mode feature added in aef8486ede8b by Marc-André, but for now a
short description and usage example will help folks interested in using
the daemon to expand vhost-user support in QEMU.

Lastly, Patch 1 makes the necessary changes to the meson build files in
tests/ and root, and the new one in contrib/vhost-user-bridge/.

Patch 2: Introducing a functional test
--------------------------------------
This test was inspired by discussions with Cédric regarding build errors
from recent glibc const changes and was the subject of the first RFC.

The functional test introduced in the second patch starts vubr as a
subprocess, then launches a single QEMU instance that provides a slirp
stack and serves as the frontend of the vhost-user protocol, much like
the testing setup described in vhost-user-bridge's initial commit in
3595e2eb0a23.

For additional details about the test, please see Patch 2's commit
message and/or the test's header; in short: the host serves a file to
the guest via tftp, then the guest serves a file to the host via http.

The guest's kernel image was built with Buildroot in a Containerfile
that is based on a snapshot Debian container image, so that the kernel
image remains bit-for-bit reproducible indefinitely. For the image and
its build files, please see:
    https://github.com/yodel/vhost-user-bridge-test
The repo will be placed in archive (read-only) mode if/when the series
is pulled.

Patch 3: Adding UDP RX logging
------------------------------
An existing transmit hexdump of UDP packets provides valuable data;
adding a receive hexdump to complement TX doubles the fun (read:
visibility). Like TX, the RX hexdump is gated behind a currently
hardcoded-on macro. Another new debug print separates transmit blocks
from receives.

Changes since RFCv2:
--------------------
- Promoted to PATCH
- Collect R-b's (thanks to Marc-André and Thomas)
- Add test to .../x86_64/meson.build thorough suite (Marc-André)
- Add encoding= args to open() (Thomas)
- Add pylint disable=unbalanced-tuple-unpacking on find_free_ports()
- Minor commit message rewording

Changes since RFCv1:
--------------------
- Remove external host dependency (Marc-André)
- Use user netdev tftp feature (Thomas)
- Use check_http_download (Thomas)
- Remove wget
- Inherit from LinuxKernelTest instead of QemuSystemTest
- Use hardcoded UUIDs in files on the guest and host for data transfer
- Use a Popen context manager to terminate and wait on vubr
- Add test to MAINTAINERS under the vhost section (Michael)
- New patch to move from tests/ to contrib/vhost-user-bridge/ and add
  docs section
- New patch to add RX debug logging in vhost-user-bridge.c

Links
-----
RFCv2:
https://lore.kernel.org/qemu-devel/20260112230127.99125-1-yodel.eldar@yodel.dev/
RFCv1:
https://lore.kernel.org/qemu-devel/20251230002604.113632-1-yodel.eldar@yodel.dev/

Yodel Eldar (3):
  tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
  tests/functional/x86_64: Add vhost-user-bridge test
  contrib/vhost-user-bridge: Add UDP receive hexdump

 MAINTAINERS                                   |   1 +
 contrib/vhost-user-bridge/meson.build         |   4 +
 .../vhost-user-bridge}/vhost-user-bridge.c    |   7 +
 .../devices/virtio/vhost-user-contrib.rst     |  39 +++++
 meson.build                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
 tests/meson.build                             |   6 -
 8 files changed, 200 insertions(+), 6 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/meson.build
 rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py

-- 
2.52.0


