Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1651AD2F036
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjgv-0007vl-Pj; Tue, 27 Jan 2026 09:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgr-0007u0-Iq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgp-0007H5-Qu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769522707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pX3KO8tgOEt7yDJfHAUSNlqvEetHdmZt2xPZ60Abnfc=;
 b=HrsLDBr+k/icjBxAsi/mLsKFiN4auKqJbxwXkFQFmae4yHk2ytxsASi9HeGAuB7XsgX8bL
 uDi1UGqKmWYS0ztMxQTom7eWyIfaG1QDHThbWtsKjHX/OWHjn/TWIM+eejGsLdc1dNg5t4
 cqp+g3iqkPmVLb+N+e3LkiKWNwJYQkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-dYNOUJf7Pyqft4c9C9KhiQ-1; Tue,
 27 Jan 2026 09:03:39 -0500
X-MC-Unique: dYNOUJf7Pyqft4c9C9KhiQ-1
X-Mimecast-MFC-AGG-ID: dYNOUJf7Pyqft4c9C9KhiQ_1769522618
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0BE1955D9A; Tue, 27 Jan 2026 14:03:38 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97F3A1800285; Tue, 27 Jan 2026 14:03:35 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Date: Tue, 27 Jan 2026 15:03:06 +0100
Message-ID: <20260127140316.4187221-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During switchover there is a period during which both source and
destination side VMs are paused. During this period, all network packets
are still routed to the source side, but it will never process them.
Once the destination resumes, it is not aware of these packets and they
are lost. This can cause packet loss in unreliable protocols and
extended delays due to retransmission in reliable protocols.

This series resolves this problem by caching packets received once the
source VM pauses and then passing and injecting them on the destination
side. This feature is implemented in the last patch. The caching and
injecting is implemented using network filter interface and should work
with any backend with vhost=off, but only TAP network backend was
explicitly tested.

This series also introduces an RP_VM_STARTED message on the return-path
channel, which is used to correctly calculate downtime for both precopy
and postcopy, and also as a trigger for netpass to forward packets to
the destination. With more data sent through the migration channel after
the destination VM starts, using RP_SHUT wouldn't be accurate anymore,
and in postcopy the downtime calculation was always incorrect.

As netpass requires return-path capability, its capability is also off
by default, but I am open for discussion about making it on by default,
as long as return-path is enabled (i.e. enabling return-path would also
enable netpass unless it is explicitly disabled).

Juraj Marcin (4):
  migration/qemu-file: Add ability to clear error
  migration: Introduce VM_STARTED return-path message
  migration: Convert VMSD early_setup into VMStateSavePhase enum
  migration: Pass network packets received during switchover to dest VM

 hw/core/machine.c           |   4 +-
 hw/virtio/virtio-mem.c      |   2 +-
 include/migration/vmstate.h |  33 +++--
 include/net/net.h           |   5 +
 migration/meson.build       |   1 +
 migration/migration.c       |  83 +++++++++++-
 migration/migration.h       |  11 ++
 migration/netpass.c         | 246 ++++++++++++++++++++++++++++++++++++
 migration/netpass.h         |  14 ++
 migration/options.c         |  29 +++++
 migration/options.h         |   2 +
 migration/qemu-file.c       |   6 +
 migration/qemu-file.h       |   1 +
 migration/savevm.c          |  44 ++++++-
 migration/savevm.h          |   2 +
 migration/trace-events      |   9 ++
 net/net.c                   |  11 ++
 net/tap.c                   |  11 +-
 qapi/migration.json         |   7 +-
 19 files changed, 501 insertions(+), 20 deletions(-)
 create mode 100644 migration/netpass.c
 create mode 100644 migration/netpass.h

-- 
2.52.0


