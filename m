Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C8C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf06G-00086f-E2; Mon, 03 Feb 2025 12:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06F-00086V-Fy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06D-0003xx-Ac
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738603143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5xoRNM5DOzxT+ieluKVhCnQ21L1IUmT4KKjQSMWy5hk=;
 b=V5uv2EUPI2pC4jijnX2i5sNt2SmCYm4tolHV5rc1g5XGU27dreqbbMKEyRvtpkUPbZGk3f
 7XDiABHzJevGM04vV2YQytIFT3+h9gZsMglQa0HEpJcIX1FnzunjrdeUqoNMZYpQqNho5A
 e0cKrOEjf++ajuUqz7EJ3PIyaQaB9KU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-UGXdOpq7MvGbVWD28bkVDA-1; Mon,
 03 Feb 2025 12:18:57 -0500
X-MC-Unique: UGXdOpq7MvGbVWD28bkVDA-1
X-Mimecast-MFC-AGG-ID: UGXdOpq7MvGbVWD28bkVDA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1562218002A5; Mon,  3 Feb 2025 17:18:55 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 976E619560AD; Mon,  3 Feb 2025 17:18:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PULL v2 0/8] Ui patches
Date: Mon,  3 Feb 2025 21:18:40 +0400
Message-ID: <20250203171848.686582-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 6fccaa2fba391815308a746d68f7fa197bc93586:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-02-02 11:09:10 -0500)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 19c628f2f579f2702dd13192b7c2de6bc8d665ce:

  dbus: add -audio dbus nsamples option (2025-02-03 21:16:07 +0400)

----------------------------------------------------------------
UI/chardev-related patch queue

----------------------------------------------------------------

Marc-André Lureau (4):
  ui/dbus: on win32, allow ANONYMOUS with p2p
  ui/dbus: clarify the kind of win32 handle that is shared
  plugins: fix -Werror=maybe-uninitialized false-positive
  dbus: add -audio dbus nsamples option

Roman Penyaev (4):
  chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
  chardev/char-hub: implement backend chardev aggregator
  tests/unit/test-char: add unit tests for hub chardev backend
  qemu-options.hx: describe hub chardev and aggregation of several
    backends

 qapi/audio.json            |  22 +-
 qapi/char.json             |  27 +++
 chardev/chardev-internal.h |  51 ++++-
 include/chardev/char.h     |   1 +
 audio/dbusaudio.c          |  29 ++-
 chardev/char-hub.c         | 301 ++++++++++++++++++++++++++++
 chardev/char-pty.c         |   4 +-
 chardev/char.c             |  23 ++-
 contrib/plugins/cache.c    |   2 +-
 tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
 ui/dbus-console.c          |   8 +-
 ui/dbus.c                  |  10 +-
 chardev/meson.build        |   1 +
 qemu-options.hx            |  49 ++++-
 ui/dbus-display1.xml       |  16 +-
 15 files changed, 923 insertions(+), 19 deletions(-)
 create mode 100644 chardev/char-hub.c

-- 
2.47.0


