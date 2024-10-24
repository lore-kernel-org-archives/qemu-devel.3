Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1ED0BB61
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 05:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qSH-0003ZX-Nh; Thu, 24 Oct 2024 01:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSF-0003Yy-4C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3qSC-0004Hj-L4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 01:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729747930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a1+5g8PXs7oNJBIi6HcX2TvFEydrtmrK3omcyDi+Y6c=;
 b=PIEOexfwk50ye5ztyL3/qBesxyEDsXg+YgqmBQCCVIKFAWDJp+k2mq+1Zf+He3AuJosLfO
 xrygihVHDAqPGIneg0cnP+bPAAFcGdy9f+a5uBY9QE902C0HXAZ1OpZLWuKQTW/qI61bpd
 46jeGBjfguQ8DW7wd5ee/MWHpMw0U6Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-Iqo3RH2jPL6fYArxMvButg-1; Thu,
 24 Oct 2024 01:32:08 -0400
X-MC-Unique: Iqo3RH2jPL6fYArxMvButg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3DFF19560BC
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:32:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DD0F1956056; Thu, 24 Oct 2024 05:32:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/4] vfio queue
Date: Thu, 24 Oct 2024 07:31:59 +0200
Message-ID: <20241024053203.1559456-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20241024

for you to fetch changes up to 00b519c0bca0e933ed22e2e6f8bca6b23f41f950:

  vfio/helpers: Align mmaps (2024-10-23 14:46:24 +0200)

----------------------------------------------------------------
vfio queue:

* Fixed size reported in vfio_state_pending_exact()
* Added support for PMD or PUD aligned mappings

----------------------------------------------------------------
Alex Williamson (2):
      vfio/helpers: Refactor vfio_region_mmap() error handling
      vfio/helpers: Align mmaps

Avihai Horon (2):
      vfio/migration: Report only stop-copy size in vfio_state_pending_exact()
      vfio/migration: Change trace formats from hex to decimal

 hw/vfio/helpers.c    | 66 +++++++++++++++++++++++++++++++++++++---------------
 hw/vfio/migration.c  |  3 ---
 hw/vfio/trace-events | 10 ++++----
 3 files changed, 52 insertions(+), 27 deletions(-)


