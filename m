Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA1CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqit-0004b8-Cw; Wed, 17 Sep 2025 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqi2-00035g-PA
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqht-0003jj-G1
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CKlffNnKcnVtITFogyToj1SNgcC8+HgQy+s6SZ654FU=;
 b=QY6ufKDy+iXhCZCehXic7JWJWuiXjLKuLpvQWJzMxOvmbpBe769aq2huKyh0nuj105diHf
 HUfogQkxaRg8iFVcaCxn10g89CNAsQ4v8f/xGIai3zYKWTd22AbxZ+R/3v2aAAU0B+t7op
 lDsf9YBGYDcsWHbKB6Idwqo+ccNrKBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-BvaQoch_M_Swhk1v0JdOoQ-1; Wed,
 17 Sep 2025 07:52:11 -0400
X-MC-Unique: BvaQoch_M_Swhk1v0JdOoQ-1
X-Mimecast-MFC-AGG-ID: BvaQoch_M_Swhk1v0JdOoQ_1758109931
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACC311800291; Wed, 17 Sep 2025 11:52:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28CCE195608E; Wed, 17 Sep 2025 11:52:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 356CB21E6A27; Wed, 17 Sep 2025 13:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 00/12] Error reporting cleanup, a fix,
 and &error_warn removal
Date: Wed, 17 Sep 2025 13:51:55 +0200
Message-ID: <20250917115207.1730186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From qapi/error.h:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().

Not mentioned, but just as undesirable: error_setg(&error_warn, ...).

This series eliminates such uses, and gets rid of &error_warn.
&error_warn has multiple issues and little use.  PATCH 12 has full
rationale.

A note on warnings: we don't use warnings much, and when we use them,
they're often pretty bad.  See my memo "Abuse of warnings for
unhandled errors and programming errors"
Message-ID: <87h5yijh3b.fsf@pond.sub.org>
https://lore.kernel.org/qemu-devel/87h5yijh3b.fsf@pond.sub.org/

v2:
* PATCH 03: Mention change of cxl_fmws_link() return value in commit
  message [Jonathan]
* PATCH 04: Change exit(1) to g_assert_not_reached(), because it's a
  programming error.
* PATCH 06+07: Replace questions in commit message by answers from
  review.
* PATCH 06: Fix a format string
* PATCH 08: Keep warnings instead of reverting to silence [Daniel]
* PATCH 12: Adjusted for replaced PATCH 08

Issues raised in review I decided not to address in this series:
* PATCH 03: messages could be improved further, in particular the
  "gdbstub: " prefix could be dropped
* ebpf_rss_load() can return false without setting an error
* Capture the discussion on how to deal with undhandled errors in
  cover letter and/or commit messages.

The first two could be done on top.

Markus Armbruster (12):
  monitor: Clean up HMP gdbserver error reporting
  tcg: Fix error reporting on mprotect() failure in  tcg_region_init()
  hw/cxl: Convert cxl_fmws_link() to Error
  migration/cpr: Clean up error reporting in cpr_resave_fd()
  hw/remote/vfio-user: Clean up error reporting
  net/slirp: Clean up error reporting
  ui/spice-core: Clean up error reporting
  util/oslib-win32: Do not treat null @errp as &error_warn
  ui/pixman: Consistent error handling in qemu_pixman_shareable_free()
  ui/dbus: Clean up dbus_update_gl_cb() error checking
  ui/dbus: Consistent handling of texture mutex failure
  error: Kill @error_warn

 include/exec/gdbstub.h         |  3 ---
 include/qapi/error.h           |  6 ------
 include/system/os-win32.h      |  5 ++++-
 hw/cxl/cxl-host.c              |  7 ++++---
 hw/display/virtio-gpu.c        |  8 ++++++--
 hw/net/virtio-net.c            |  8 +++++++-
 hw/remote/vfio-user-obj.c      |  9 +++------
 io/channel-socket.c            |  4 ++--
 io/channel-watch.c             |  6 +++---
 migration/cpr.c                |  9 +++++----
 monitor/hmp-cmds.c             |  7 ++++---
 net/slirp.c                    |  6 ++++--
 tcg/region.c                   |  8 ++++++--
 tests/unit/test-error-report.c | 17 -----------------
 ui/dbus-listener.c             | 22 +++++++++++++++-------
 ui/gtk.c                       |  6 +++++-
 ui/qemu-pixman.c               |  5 ++++-
 ui/spice-core.c                |  3 ++-
 util/aio-win32.c               |  2 +-
 util/error.c                   |  5 +----
 util/oslib-win32.c             | 26 +++++++++++++++++++++-----
 21 files changed, 97 insertions(+), 75 deletions(-)

-- 
2.49.0


