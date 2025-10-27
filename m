Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D63CCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPM1-0001tX-Tn; Mon, 27 Oct 2025 11:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPM0-0001q2-ID
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPLr-0008Kq-SM
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DvH2Q4k8NP1+EIt04/NPFmkCazRoq6SJpxl4pWo4S5A=;
 b=JpD1g81scFQbW2pUHgf40h/Dug00HVtHMvd9G3R7czXZybvSR+36O6+d10i2zcrvZGzh67
 EbHiY6NfaQtI37T/K+UXmmrsSgRSyQm2T58JpkIuEtD2ir5GIYhXaNxs0hNA0t5c1JLVBC
 srkv6FY/doVwr9+NFgc6ozEshqKUnaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-Q6OSTuMiNDuV2fTmCj1OHQ-1; Mon,
 27 Oct 2025 11:41:27 -0400
X-MC-Unique: Q6OSTuMiNDuV2fTmCj1OHQ-1
X-Mimecast-MFC-AGG-ID: Q6OSTuMiNDuV2fTmCj1OHQ_1761579686
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3561419560B1; Mon, 27 Oct 2025 15:41:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.183])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E591D30001A2; Mon, 27 Oct 2025 15:41:23 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 0/4] migration: Introduce POSTCOPY_DEVICE state
Date: Mon, 27 Oct 2025 16:41:07 +0100
Message-ID: <20251027154115.4138677-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series introduces a new POSTCOPY_DEVICE state that is active (both,
on source and destination side), while the destination loads the device
state. Before this series, if the destination machine failed during the
device load, the source side would stay stuck POSTCOPY_ACTIVE with no
way of recovery. With this series, if the migration fails while in
POSTCOPY_DEVICE state, the source side can safely resume, as destination
has not started yet.

RFC: https://lore.kernel.org/all/20250807114922.1013286-1-jmarcin@redhat.com/

V1: https://lore.kernel.org/all/20250915115918.3520735-1-jmarcin@redhat.com/

V2 changes:

- removed old patch 2, that changed migration_has_failed()

Patch 2:
- moved postcopy_ram_listen_thread() to postcopy_ram.c as per TODO,
  suggested by Fabiano

Patch 3:
- introduced separate postcopy-exit-on-error setting instead of reusing
  existing exit-on-error setting, suggested by Fabiano and Jirka
- merged migration_incoming_finish() and
  migration_incoming_state_destroy() into migration_incoming_cleanup()
  and added migration_incoming_cleanup_bh(), suggested by Fabiano

Patch 4:
- introduced POSTCOPY_DEVICE state also to destination, suggested by
  Jirka
- moved POSTCOPY_DEVICE->POSTCOPY_ACTIVE transition from return path
  thread to main migration thread, suggested by Peter

Juraj Marcin (3):
  migration: Move postcopy_ram_listen_thread() to postcopy-ram.c
  migration: Refactor all incoming cleanup into
    migration_incoming_cleanup()
  migration: Introduce POSTCOPY_DEVICE state

Peter Xu (1):
  migration: Do not try to start VM if disk activation fails

 migration/migration-hmp-cmds.c        |   2 +-
 migration/migration.c                 | 148 +++++++++++++++++---------
 migration/migration.h                 |   7 +-
 migration/postcopy-ram.c              | 137 ++++++++++++++++++++++++
 migration/postcopy-ram.h              |   3 +
 migration/savevm.c                    | 137 ++----------------------
 migration/savevm.h                    |   2 +
 migration/trace-events                |   1 +
 qapi/migration.json                   |  17 ++-
 system/vl.c                           |   3 +-
 tests/qtest/migration/precopy-tests.c |   3 +-
 11 files changed, 274 insertions(+), 186 deletions(-)

-- 
2.51.0


