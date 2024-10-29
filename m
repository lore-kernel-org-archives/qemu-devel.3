Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99152D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ngR-0006Fh-Gi; Tue, 29 Oct 2024 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5ngN-0006Df-EI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:58:55 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5ngJ-0004ea-G2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:58:54 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5nfq-000000014CX-2UFc; Tue, 29 Oct 2024 15:58:22 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/4] Trivial patches from multifd device state transfer
 support patch set
Date: Tue, 29 Oct 2024 15:58:12 +0100
Message-ID: <cover.1730203967.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

A new version of the multifd device state transfer support with VFIO consumer
patch set is being prepared, the previous version and the associated
discussion is available here:
https://lore.kernel.org/qemu-devel/cover.1724701542.git.maciej.szmigiero@oracle.com/

This new version was originally targeting QEMU 9.2 but such schedule proved
to be too optimistic due to sheer number of invasive changes/rework required,
especially with respect to the VFIO internal threads management and their
synchronization with the migration core.

In addition to these changes, recently merged commit 3b5948f808e3
("vfio/migration: Report only stop-copy size in vfio_state_pending_exact()")
seems to have uncovered a race between multifd RAM and device state transfers:
RAM transfer sender finishes the multifd stream with a SYNC in
ram_save_complete() but the multifd receive channels are only released
from this SYNC after the migration is wholly complete in
process_incoming_migration_bh().

The above causes problems if the multifd channels need to still be
running after the RAM transfer is completed, for example because
there is still remaining device state to be transferred.

Since QEMU 9.2 code freeze is coming I've separated small uncontroversial
commits from that WiP main patch set here, some of which were already
reviewed during previous main patch set iterations.

This way at least future code conflicts can be reduced and the amount
of patches that need to be carried in the future versions of the main
patch set is reduced.


Maciej S. Szmigiero (4):
  vfio/migration: Add save_{iterate,complete_precopy}_started trace
    events
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet
  migration: Document the BQL behavior of load SaveVMHandlers

 hw/vfio/migration.c           | 13 +++++++++++++
 hw/vfio/trace-events          |  3 +++
 include/hw/vfio/vfio-common.h |  3 +++
 include/migration/register.h  |  4 ++++
 migration/multifd.c           |  2 +-
 migration/ram.c               |  1 +
 migration/trace-events        |  1 +
 7 files changed, 26 insertions(+), 1 deletion(-)


