Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8155DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh4f-0006up-SZ; Tue, 13 Oct 2026 14:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4c-0006uE-Ch
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4a-00013M-OJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3t5ZFbDi16nXXc2C1ZxmpQrK4jtmAz+AVhY14m+LV7c=;
 b=O5W1Z9i/7VP3+Xlv4oHw0PHu5UOhj9fBrmOke2SZQqDk1tH3KDk/itjL4PD2cPYntuKOoo
 U+9akV/ouAbZk7iWE/04RuxiQBQF3o5kxP9KJrqr37k7KKjFJHf/S5cXtKy0Knu0KshB8d
 gZ1sZ9TqMFxKjgTsJ6IHuxQmVj6JoPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-bKz4X0fkM4ivUv03xmF7_w-1; Tue,
 13 Oct 2026 18:17:56 +0000
X-MC-Unique: bKz4X0fkM4ivUv03xmF7_w-1
X-Mimecast-MFC-AGG-ID: bKz4X0fkM4ivUv03xmF7_w_1791915475
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BDA5180A21D; Tue, 13 Oct 2026 18:17:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90DD73001D21; Tue, 13 Oct 2026 18:17:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/8] scsi: clean up persistent reservation state after
 migration
Date: Tue, 13 Oct 2026 14:17:44 -0400
Message-ID: <20261013181752.1299456-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2:
- Explicitly reject PR_HELPER_CLEAN commands in scsi_req_new() because
  this is an internal command that guests must not be able to invoke
- Move cdb[0] check after copy from io_hdr in pr-manager-helper.c
- Add missing endianness conversion for protocol flags in pr-manager-helper.c
- Ignore PR_HELPER_CLEANUP commands when there is no pr-manager to avoid
  passing through this QEMU-internal vendor-specific command to the
  underlying SCSI device.
- Add missing "forget" in comment (typo)

When a guest using SCSI persistent reservations is migrated on a Linux host
using multipathd, some state is left behind and this can cause multipathd to
register the old key again in the future. One way this can be observed is when
migrating a guest back-and-forth between two hosts: the REGISTER command will
fail when migrating back to the first host if the LUN is detached and
re-attached between migrations (i.e. multipathd sees that a path has come up).

This patch series modifies qemu-pr-helper to send multipathd commands that
clear the state once migration has completed successfully. This is implemented
as a vendor-specific SCSI command called PR_HELPER_CLEANUP that QEMU sends to
qemu-pr-helper just like PERSISTENT RESERVE IN and PERSISTENT RESERVE OUT
commands.

Buglink: https://redhat.atlassian.net/browse/RHEL-274966

Stefan Hajnoczi (8):
  pr-manager-helper: fix sense buffer overflow
  scsi: increase sense buffer size in scsi_SG_IO()
  hw/scsi-disk: move MIG_EVENT_FAILED into a new function
  qemu-pr-helper: add PR_HELPER_CLEANUP for live migration
  pr-manager-helper: add PR_HELPER_CLEANUP command support
  file-posix: forward PR_HELPER_CLEANUP commands to pr-manager
  scsi: clean up persistent reservation state after migration
  scsi: use REGISTER AND IGNORE EXISTING KEY for robustness

 meson.build              |   2 +
 include/hw/scsi/scsi.h   |   1 +
 include/scsi/constants.h |   1 +
 scsi/pr-helper.h         |   3 +
 block/file-posix.c       |  18 +++--
 hw/scsi/scsi-bus.c       |  10 +++
 hw/scsi/scsi-disk.c      |  45 +++++++++---
 hw/scsi/scsi-generic.c   |  64 +++++++++++++----
 scsi/pr-manager-helper.c |  23 ++++--
 scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
 scsi/utils.c             |   3 +
 11 files changed, 273 insertions(+), 43 deletions(-)

-- 
2.56.0


