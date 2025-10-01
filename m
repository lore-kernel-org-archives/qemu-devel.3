Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98A9CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qgo-0008M5-IL; Wed, 01 Oct 2025 02:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3qgl-0008KP-6G
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3qgY-0005Ji-Fm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hjy+GwXXOAIZu0k+E/X9kZ88e9fpkjlxtvZ5A3hFjVM=;
 b=gHDUWSXZdRiXGUewLJDUPWjx2bN900t6JtR+t8urqkppKokM8FM05A3mz+RLzYQy294tH9
 yhbKQNhISHckaffH1Rbhg00pq1V+H6eSM1uk3A2XuVQF+euEFCStDiuc0czWBeG+3f/Fy1
 cae4oUPjPeamGV7Mt9+X2V5ApYP5IL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-bPY7Z67MO1q6e44707H7Gg-1; Wed,
 01 Oct 2025 02:51:26 -0400
X-MC-Unique: bPY7Z67MO1q6e44707H7Gg-1
X-Mimecast-MFC-AGG-ID: bPY7Z67MO1q6e44707H7Gg_1759301485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C265219774E6; Wed,  1 Oct 2025 06:51:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CAF930002D0; Wed,  1 Oct 2025 06:51:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97AAB21E6A27; Wed, 01 Oct 2025 08:51:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 00/13] Error reporting patches for 2025-09-30
Date: Wed,  1 Oct 2025 08:51:21 +0200
Message-ID: <20251001065122.575596-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 9b16edec6e9a483469c789475b2065d26b52db35:

  Merge tag 'pull-ppc-for-20250928-20250929' of https://gitlab.com/harshpb/qemu into staging (2025-09-29 07:25:28 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-09-30-v2

for you to fetch changes up to bcb536cabe108e71e2900cdd605f5b4e59ac3e1f:

  error: Kill @error_warn (2025-10-01 08:33:24 +0200)

----------------------------------------------------------------
Error reporting patches for 2025-09-30

----------------------------------------------------------------
Markus Armbruster (13):
      monitor: Clean up HMP gdbserver error reporting
      tcg: Fix error reporting on mprotect() failure in tcg_region_init()
      hw/cxl: Convert cxl_fmws_link() to Error
      migration/cpr: Clean up error reporting in cpr_resave_fd()
      hw/remote/vfio-user: Clean up error reporting
      net/slirp: Clean up error reporting
      ui/spice-core: Clean up error reporting
      util/oslib-win32: Do not treat null @errp as &error_warn
      ui/pixman: Consistent error handling in qemu_pixman_shareable_free()
      ui/dbus: Clean up dbus_update_gl_cb() error checking
      ui/dbus: Consistent handling of texture mutex failure
      ivshmem-flat: Mark an instance of missing error handling FIXME
      error: Kill @error_warn

 include/exec/gdbstub.h         |  3 ---
 include/qapi/error.h           |  6 ------
 include/system/os-win32.h      |  5 ++++-
 hw/cxl/cxl-host.c              |  7 ++++---
 hw/display/virtio-gpu.c        |  8 ++++++--
 hw/misc/ivshmem-flat.c         |  8 ++++++--
 hw/net/virtio-net.c            |  8 +++++++-
 hw/remote/vfio-user-obj.c      | 13 +++++++++----
 io/channel-socket.c            |  4 ++--
 io/channel-watch.c             |  6 +++---
 migration/cpr.c                |  9 +++++----
 monitor/hmp-cmds.c             |  7 ++++---
 net/slirp.c                    |  9 +++++++--
 tcg/region.c                   |  7 +++++--
 tests/unit/test-error-report.c | 17 -----------------
 ui/dbus-listener.c             | 22 +++++++++++++++-------
 ui/gtk.c                       |  6 +++++-
 ui/qemu-pixman.c               |  5 ++++-
 ui/spice-core.c                |  6 ++++--
 util/aio-win32.c               |  2 +-
 util/error.c                   |  5 +----
 util/oslib-win32.c             | 25 ++++++++++++++++++++-----
 22 files changed, 112 insertions(+), 76 deletions(-)

-- 
2.49.0


