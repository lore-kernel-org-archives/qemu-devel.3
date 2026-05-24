Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF03CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR937-0004ka-6B; Sun, 24 May 2026 09:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3MY-0008N5-9I
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:06 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3MV-0002Df-N1
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:06 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 07D952020282; Sun, 24 May 2026 16:34:56 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/5] socket: add TCP_USER_TIMEOUT,
 fix -netdev stream option docs
Date: Sun, 24 May 2026 16:34:37 +0900
Message-ID: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=Mitsuru.Kariya@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 24 May 2026 09:39:18 -0400
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

The default Linux TCP retransmission timeout for unacknowledged segments
is on the order of 15+ minutes and can stretch well past an hour with
exponential backoff.  For QEMU live migration over TCP that means a
silently disconnected peer (cable pulled, peer host crashed, NAT idle
flush, firewall reset) can leave the source QEMU "migrating" for many
minutes with no diagnosis.

TCP keep-alive options already help, but they only trigger on idle
connections; they do nothing when the connection has unacknowledged
in-flight data, which is the common case during a live migration push.

The Linux TCP_USER_TIMEOUT socket option bounds this: the kernel
forcibly closes the connection and returns ETIMEDOUT after the
configured number of milliseconds of unacknowledged data, regardless of
keep-alive state.

This series adds TCP_USER_TIMEOUT as a new optional InetSocketAddress
member.  Two parsing paths feed into InetSocketAddress in QEMU, and
both need separate plumbing to accept a new option:

  - the QAPI keyval visitor used by modern syntax such as
    -netdev stream, -chardev socket, -incoming <channel>, and any
    QMP command that takes a SocketAddress argument.  This path
    automatically picks up the new member once it is declared in
    qapi/sockets.json.

  - the legacy URI parser (socket_parse() -> inet_parse()) used by
    -incoming tcp:, migrate tcp:, and HMP nbd_server_start, which
    has its own option table (inet_opts) and needs an explicit entry
    plus a copy into the QAPI struct.

This series adds the qapi/sockets.json declaration and the inet_opts /
inet_parse() plumbing so that user-timeout is available through both
paths.

While preparing it I noticed two pre-existing qemu-options.hx issues
that had never been caught because nothing tested those options'
acceptance through the QAPI path:

  - The -netdev stream synopsis listed several InetSocketAddress and
    UnixSocketAddress members without the required "addr." prefix
    (to, numeric, keep-alive, mptcp, ipv4, ipv6, abstract, tight).
    These names are actually rejected by the QAPI input visitor with
    "Parameter '...' is unexpected".  Broken since bb1326abd9df ("net:
    update netdev stream/dgram man page", 2024-07).

  - keep-alive-count/idle/interval (added to InetSocketAddress in 10.1)
    and keep-alive/numeric/mptcp (older) were never documented in the
    -incoming tcp: synopsis, despite inet_opts accepting them.

The series is therefore split into:

  1/5  bug-fix only: add the missing "addr." prefix to -netdev stream
       inet/unix option docs (separated so it can be considered for
       stable backport)
  2/5  pure docs: keep-alive-count/idle/interval for -netdev stream
  3/5  pure docs: keep-alive*/numeric/mptcp for -incoming tcp:
  4/5  the feature itself: meson HAVE_TCP_USER_TIMEOUT check,
       qapi/sockets.json schema addition, inet_set_sockopts() and
       inet_parse() plumbing, qemu-options.hx user-timeout entries for
       both -netdev stream (addr.user-timeout=...) and -incoming tcp:
       (user-timeout=...), and test_inet_parse_all_options_good
       extension
  5/5  new qtest /netdev/stream/inet/options that smoke-tests the
       complete optional InetSocketAddress member set on the QAPI
       keyval parsing path; catches the class of schema/synopsis drift
       described above

Each commit builds and passes test-util-sockets and
qtest-x86_64/netdev-socket independently, verified with
git rebase --exec.  checkpatch reports 0 errors / 0 warnings for every
patch.

A companion libvirt change to expose this option through the QEMU
driver's migration parameters is in preparation.

Mitsuru Kariya (5):
  qemu-options: fix missing addr. prefix on -netdev stream inet/unix
    options
  qemu-options: document keep-alive-count/idle/interval for -netdev
    stream
  qemu-options: document keep-alive*/numeric/mptcp for -incoming tcp:
  util/qemu-sockets: add TCP_USER_TIMEOUT support
  tests/qtest/netdev-socket: smoke test -netdev stream inet option set

 meson.build                    |  2 +
 qapi/sockets.json              |  7 ++++
 qemu-options.hx                | 47 +++++++++++++++-------
 tests/qtest/netdev-socket.c    | 71 ++++++++++++++++++++++++++++++++++
 tests/unit/test-util-sockets.c | 13 +++++++
 util/qemu-sockets.c            | 24 ++++++++++++
 6 files changed, 149 insertions(+), 15 deletions(-)

-- 
2.43.0


