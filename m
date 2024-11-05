Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39192D31765
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MtK-0007mD-4B; Tue, 05 Nov 2024 11:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8MtI-0007lu-Pk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8MtH-0005Rp-7V
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730825929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mRysqN2ZKZTsN0Ey1O3pgZe0Le1xAbMn8pyz5TE3RS0=;
 b=czhMwXTFWsF33hi+odwljULYpRSRAyvHs556riN0qqe3KgsUI9FO3JllmAIwGNW10pU1xj
 eQ3YNVug7aT/xfJn6WEVJvs8o19q4AmRQXHWFqbYqOqmWgIZx3xDH3bVf2q9BLTycYup7R
 /qON9oJl/N2xkRCxtVYzYIL508mdl/0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-AJamMkhgOGGe12sFylrCuw-1; Tue,
 05 Nov 2024 11:58:46 -0500
X-MC-Unique: AJamMkhgOGGe12sFylrCuw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B68B19560A2
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2024 16:58:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83884300018D; Tue,  5 Nov 2024 16:58:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] vfio queue
Date: Tue,  5 Nov 2024 17:58:39 +0100
Message-ID: <20241105165841.3086136-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 9a7b0a8618b1293d589a631183e80791ad7bf552:

  Merge tag 'pull-aspeed-20241104' of https://github.com/legoater/qemu into staging (2024-11-05 10:06:08 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20241105

for you to fetch changes up to 89b516152777a8b54b117d90690ed9be62ba1177:

  vfio/migration: Add vfio_save_block_precopy_empty_hit trace event (2024-11-05 15:51:14 +0100)

----------------------------------------------------------------
vfio queue:

* Added migration trace events

----------------------------------------------------------------
Maciej S. Szmigiero (2):
      vfio/migration: Add save_{iterate, complete_precopy}_start trace events
      vfio/migration: Add vfio_save_block_precopy_empty_hit trace event

 include/hw/vfio/vfio-common.h |  3 +++
 hw/vfio/migration.c           | 17 +++++++++++++++++
 hw/vfio/trace-events          |  3 +++
 3 files changed, 23 insertions(+)


