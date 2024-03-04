Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223B3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6Q-0001Aa-9S; Sun, 03 Mar 2024 20:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6O-0001AR-OL
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6M-0002Cc-SF
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bPpPX4VKwwr50UkRqlv82JfnKao9192AMEgKngY6V9Y=;
 b=iRL+KYiGqt19ty7elhNy4505CgKJOEBpma+/DjQcpMMjV3qYFBaDcXK//TfrYf1d/ajhHL
 y3xjLPbvCtM0pa6feMbbPAf8eUVnyOKLfL+SYnRXMSUoekOVkpCaiEadeRF3NQzTKeETCl
 JkL79tn+W8422vIvmt+PFCEYZyUqqmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-iVDEuUFCPS-VENf5exO9Mg-1; Sun, 03 Mar 2024 20:26:40 -0500
X-MC-Unique: iVDEuUFCPS-VENf5exO9Mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992C5185A783;
 Mon,  4 Mar 2024 01:26:40 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 405C240C6EBA;
 Mon,  4 Mar 2024 01:26:36 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/27] Migration next patches
Date: Mon,  4 Mar 2024 09:26:07 +0800
Message-ID: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:

  Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-next-pull-request

for you to fetch changes up to 1a6e217c35b6dbab10fdc1e02640b8d60b2dc663:

  migration/multifd: Document two places for mapped-ram (2024-03-04 08:31:11 +0800)

----------------------------------------------------------------
Migartion pull request for 20240304

- Bryan's fix on multifd compression level API
- Fabiano's mapped-ram series (base + multifd only)
- Steve's amend on cpr document in qapi/

----------------------------------------------------------------

Bryan Zhang (2):
  migration: Properly apply migration compression level parameters
  tests/migration: Set compression level in migration tests

Fabiano Rosas (20):
  migration/multifd: Cleanup multifd_recv_sync_main
  io: fsync before closing a file channel
  migration/qemu-file: add utility methods for working with seekable
    channels
  migration/ram: Introduce 'mapped-ram' migration capability
  migration: Add mapped-ram URI compatibility check
  migration/ram: Add outgoing 'mapped-ram' migration
  migration/ram: Add incoming 'mapped-ram' migration
  tests/qtest/migration: Add tests for mapped-ram file-based migration
  migration/multifd: Rename MultiFDSend|RecvParams::data to
    compress_data
  migration/multifd: Decouple recv method from pages
  migration/multifd: Allow multifd without packets
  migration/multifd: Allow receiving pages without packets
  migration/multifd: Add a wrapper for channels_created
  migration/multifd: Add outgoing QIOChannelFile support
  migration/multifd: Add incoming QIOChannelFile support
  migration/multifd: Prepare multifd sync for mapped-ram migration
  migration/multifd: Support outgoing mapped-ram stream format
  migration/multifd: Support incoming mapped-ram stream format
  migration/multifd: Add mapped-ram support to fd: URI
  tests/qtest/migration: Add a multifd + mapped-ram migration test

Nikolay Borisov (3):
  io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
  io: Add generic pwritev/preadv interface
  io: implement io_pwritev/preadv for QIOChannelFile

Peter Xu (1):
  migration/multifd: Document two places for mapped-ram

Steve Sistare (1):
  migration: massage cpr-reboot documentation

 docs/devel/migration/features.rst   |   1 +
 docs/devel/migration/mapped-ram.rst | 138 +++++++++
 qapi/migration.json                 |  42 +--
 include/exec/ramblock.h             |  13 +
 include/io/channel.h                |  83 ++++++
 include/migration/qemu-file-types.h |   2 +
 include/qemu/bitops.h               |  13 +
 migration/fd.h                      |   2 +
 migration/file.h                    |   8 +
 migration/multifd.h                 |  27 +-
 migration/options.h                 |   1 +
 migration/qemu-file.h               |   6 +
 migration/ram.h                     |   1 +
 io/channel-file.c                   |  69 +++++
 io/channel.c                        |  58 ++++
 migration/fd.c                      |  44 +++
 migration/file.c                    | 149 +++++++++-
 migration/migration.c               |  56 +++-
 migration/multifd-zlib.c            |  26 +-
 migration/multifd-zstd.c            |  26 +-
 migration/multifd.c                 | 417 ++++++++++++++++++++++------
 migration/options.c                 |  47 ++++
 migration/qemu-file.c               | 106 +++++++
 migration/ram.c                     | 351 +++++++++++++++++++++--
 migration/savevm.c                  |   1 +
 tests/qtest/migration-test.c        | 137 +++++++++
 migration/trace-events              |   2 +-
 27 files changed, 1666 insertions(+), 160 deletions(-)
 create mode 100644 docs/devel/migration/mapped-ram.rst

-- 
2.44.0


