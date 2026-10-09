Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB56BCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCZr-0001Xv-Cd; Fri, 09 Oct 2026 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYw-0001RF-LD
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYt-0007yk-9Y
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eDQsxBpJdc9jXs2BGUvd0TCOaDkSYgZW/Ba6zPyxHpI=;
 b=DRMeu65WRjOi0akBcBXsz2iRYwApe1iSX/HOgF9cw9vV3VtlyInK3lcD55DIU0pRt1Xn34
 XRKvEo7VxjrhYSFt8zm47PDCd61zerUYVaSP6z9Agr82MZsL40J/pMao1LEWE7vvd4rik0
 cYRp4mCQNFOtizzWZcja9/VfXL+kqWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-ASHEy3PWNki_570qRblhdw-1; Fri,
 9 Oct 2026 15:31:01 +0000
X-MC-Unique: ASHEy3PWNki_570qRblhdw-1
X-Mimecast-MFC-AGG-ID: ASHEy3PWNki_570qRblhdw_1791559861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ABC418011E2; Fri,  9 Oct 2026 15:31:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 741871956086; Fri,  9 Oct 2026 15:30:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/8] scsi: clean up persistent reservation state after
 migration
Date: Fri,  9 Oct 2026 11:30:50 -0400
Message-ID: <20261009153058.1089786-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

I considered adding a separate interface or more complex qemu-pr-helper
protocol extension that does not reuse SCSI commands because that would be
cleaner. Since the command does not have security implications (it's a variant
of REGISTER AND IGNORE EXISTING KEYS), I went with this approach for
simplicity. Let me know if you prefer a different interface and what that it
should look like.

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
 block/file-posix.c       |   3 +-
 hw/scsi/scsi-disk.c      |  45 +++++++++---
 hw/scsi/scsi-generic.c   |  64 +++++++++++++----
 scsi/pr-manager-helper.c |  23 ++++--
 scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
 scsi/utils.c             |   3 +
 10 files changed, 251 insertions(+), 40 deletions(-)

-- 
2.56.0


