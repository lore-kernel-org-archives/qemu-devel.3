Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976CECF45D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 23:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQvW-0003Mp-HF; Mon, 12 Jan 2026 18:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvS-0003L1-0L
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:18 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vfQvO-0006IB-Qw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 18:02:17 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 15297539a2ede0681a8f567990a433e7a92368a64e971dcb4b220593225b4888 with SMTP id
 69657d6eb6eaa267982c3d01; Mon, 12 Jan 2026 23:02:06 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768258924;
 bh=iqVPn8e+06BTG8i3qFmUc7jS7m5cDGRjlSNFSy+xDBU=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=LV6M75vjrKkJEqcJuoAmBdtdOHhntdb8hsAGBwgv447KXaVAypOCpI203W6Zau7ZT
 PjjRWutuELI6IvPhCg9tPezYZwL+OAcbnCodwbDm3RT8KJFJGhA18LTUYQbVYeBYc7
 wtZYeVbnuf8jKqtZ1jUzhuky8Hqp5XULOv8/v8QifMxx4OCPeUziRX3oxNy+yFN2LJ
 Jsppe6N1DiPlrWmmi3d34Sz8uUcn8VrZMmu3Dj36IRL0+13b5oDbMZ5xKwOhR7qO14
 HBJHPh6q6C8yKs478N31/5fP+DXpAZG0DPWc2V9TeITTdq6OYOFHpDRoIO/NCP0jwA
 stMZTOJsTibrQ==
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
Subject: [RFC PATCH v2 0/3] vhost-user-bridge housekeeping and test
Date: Mon, 12 Jan 2026 17:01:24 -0600
Message-ID: <20260112230127.99125-1-yodel.eldar@yodel.dev>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

vhost-user-bridge was introduced prior to the first vhost-user daemon in
contrib/, and has remained in tests/ ever since. Let's join it with its
friends. By moving it into its own subdir of contrib/, it's granted
coverage in MAINTAINERS under the vhost section, whereas in tests/ it
remains uncovered and somewhat out of place.

Since vhost-user daemons in contrib have sections in the
vhost-user-contrib doc, let's add a section for vubr there. The section
as proposed doesn't fully cover all of vhost-user-bridge's capabilities;
for example, in aef8486ede8b Marc-André added a client mode to vubr that
is, for now, left unmentioned in the doc.

To complete the move, changes were made to the tests/ and root
meson.build files in addition to the new one in
contrib/vhost-user-bridge/.

The second patch was the subject of the first RFC. It introduces a basic
functional test of vubr in the same spirit as the testing mentioned for
it in vubr's initial commit, 3595e2eb0a23 (I had the wrong commit hash
in v1 of the RFC, my apologies). Initially, we used wget in the guest to
make an http request to an external host. This proved to be the wrong
tack, and I want to thank Marc-André for pointing that out and Thomas
for suggesting the alternative methods to eliminate the external host
dependency that are now used by the test.

The test is described in its header and commit message, but in short:
the guest serves a file to the host via http, and the host serves a file
to the guest via tftp.

I should mention that the guest kernel image has since been modified to
add python in the guest to be able to serve http. Also, the buildroot
option to enable DHCP on boot is now included. As before, please see:
    https://github.com/yodel/vhost-user-bridge-test
for the kernel and initramfs combined image and associated build files.

For the last patch, adding an RX hexdump to complement the existing
transmit hexdump proved helpful to me when I was going through vubr's
logs, and I think it may be helpful to others. I'm not sure if there's a
reason for its omission besides time-constraints or simply being
overlooked, so please let me know otherwise?

I think the test patch (two) is probably ready for pulling but am, as
always, open to suggestions for improvements/fixes; as for its line in
MAINTAINERS, I placed it under vhost after Michael's comment in the RFC
(thank you, Michael), but perhaps the suggestion was meant only for
vhost-user-bridge.c and not the functional test. Please let me know if
the vhost section is the right place for the test or not?

And as before, thank you Cédric for having encouraged me to write the
test in the first place, and now for having Cc-ed Marc-André.

Link to RFCv1:
https://lore.kernel.org/qemu-devel/20251230002604.113632-1-yodel.eldar@yodel.dev/

Changes since RFCv1:
- Remove external host dependency (Marc-André)
- Replace wget to external host with http and tftp between guest and
  host (Thomas)
- Use hardcoded UUIDs in the guest and a scratch file on the host for
  data transfer
- Use a Popen context manager to terminate and wait on vubr (this isn't
  necessary now, because vubr terminates when the connected guest shuts
  down, but I suppose it could be with future changes to vubr)
- Add line in MAINTAINERS (Michael?)
- New patch to move from tests/ to contrib/vhost-user-bridge/ and add
  docs section
- New patch to add RX debug logging in vhost-user-bridge.c

Thanks,
Yodel

Yodel Eldar (3):
  tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
  tests/functional/x86_64: Add vhost-user-bridge test
  contrib/vhost-user-bridge: Add UDP receive hexdump

 MAINTAINERS                                   |   1 +
 contrib/vhost-user-bridge/meson.build         |   4 +
 .../vhost-user-bridge}/vhost-user-bridge.c    |   7 +
 .../devices/virtio/vhost-user-contrib.rst     |  39 +++++
 meson.build                                   |   1 +
 .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
 tests/meson.build                             |   6 -
 7 files changed, 199 insertions(+), 6 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/meson.build
 rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py

-- 
2.52.0


