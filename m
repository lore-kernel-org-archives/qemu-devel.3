Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8BC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9T-00073M-J3; Fri, 08 Aug 2025 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9R-00071v-A0
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9P-0006TA-2F
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a9xUrGCZZOreQG3hW+5jqO/to+ASQTU92ZiDWvDGP6M=;
 b=f3Y7/QS9dhmHtW6MuPw5pV1cZERsqy7GOrGKvHmvBBdCADoZQUclYDfuo/FxgSAqp05UuH
 LPfE7IBVEvkcoqQdVmYoum9kRVMWAsGoG0GjtNdqGkHxkpLViFdAC+MjrqJhYoeddhLZiW
 qphLhErjfTpTuAUZpAaamBz6u0A2fEQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-44A8fjkbO0SGgKm-xfj6CQ-1; Fri,
 08 Aug 2025 04:08:27 -0400
X-MC-Unique: 44A8fjkbO0SGgKm-xfj6CQ-1
X-Mimecast-MFC-AGG-ID: 44A8fjkbO0SGgKm-xfj6CQ_1754640506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A83E51800561; Fri,  8 Aug 2025 08:08:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2642719560B4; Fri,  8 Aug 2025 08:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4563121E6A27; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp,
	marcandre.lureau@redhat.com
Subject: [PATCH 00/12] Error reporting cleanup, a fix, and &error_warn removal
Date: Fri,  8 Aug 2025 10:08:11 +0200
Message-ID: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus Armbruster (12):
  monitor: Clean up HMP gdbserver error reporting
  tcg: Fix error reporting on mprotect() failure in  tcg_region_init()
  hw/cxl: Convert cxl_fmws_link() to Error
  migration/cpr: Clean up error reporting in cpr_resave_fd()
  hw/remote/vfio-user: Clean up error reporting
  net/slirp: Clean up error reporting
  ui/spice-core: Clean up error reporting
  util/oslib-win32: Revert warning on WSAEventSelect() failure
  ui/pixman: Consistent error handling in qemu_pixman_shareable_free()
  ui/dbus: Clean up dbus_update_gl_cb() error checking
  ui/dbus: Consistent handling of texture mutex failure
  error: Kill @error_warn

 include/exec/gdbstub.h         |  3 ---
 include/qapi/error.h           |  6 ------
 hw/cxl/cxl-host.c              |  7 ++++---
 hw/display/virtio-gpu.c        |  8 ++++++--
 hw/net/virtio-net.c            |  8 +++++++-
 hw/remote/vfio-user-obj.c      |  9 +++------
 migration/cpr.c                |  9 +++++----
 monitor/hmp-cmds.c             |  7 ++++---
 net/slirp.c                    |  6 ++++--
 tcg/region.c                   |  8 ++++++--
 tests/unit/test-error-report.c | 17 -----------------
 ui/dbus-listener.c             | 22 +++++++++++++++-------
 ui/gtk.c                       |  6 +++++-
 ui/qemu-pixman.c               |  5 ++++-
 ui/spice-core.c                |  3 ++-
 util/error.c                   |  5 +----
 util/oslib-win32.c             |  4 ----
 17 files changed, 66 insertions(+), 67 deletions(-)

-- 
2.49.0


