Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABA6CCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlQ-00083l-Kq; Tue, 30 Sep 2025 08:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlN-00082A-S5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Zl8-0002Mp-JX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r83sJwP5JdkgYKPwNrLWoVIkeXjQIjoPbwW0se2NbMg=;
 b=WzWwIb9r0JBfKrcAvOyBgX5nH9kEodbg9Ptlc2i/SUGzNwOQq7GJrRkWTLcbjCQMDHaZ5B
 y2d4ZZ1sI4tHCt+OjmIJbCJAVrHMKXfc07A9RXlpWtoJIYAZDMUifvFRui2WjUNuNiyoee
 V2TqEzwZjteg2/sp+Caedp+vsJfHfeE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-FMCPEmYlPieeqmccYlnLeQ-1; Tue,
 30 Sep 2025 08:47:04 -0400
X-MC-Unique: FMCPEmYlPieeqmccYlnLeQ-1
X-Mimecast-MFC-AGG-ID: FMCPEmYlPieeqmccYlnLeQ_1759236423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABB5518015E1; Tue, 30 Sep 2025 12:46:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7A3C3000EB9; Tue, 30 Sep 2025 12:46:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EE0B21E6A27; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/13] Error reporting patches for 2025-09-30
Date: Tue, 30 Sep 2025 14:46:40 +0200
Message-ID: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-09-30

for you to fetch changes up to 2b69f2a88fce84792bf46e65d38d8aaad1f3161f:

  error: Kill @error_warn (2025-09-30 14:43:54 +0200)

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


