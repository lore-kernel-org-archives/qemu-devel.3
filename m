Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AD5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hEt-0000QE-KK; Tue, 30 Sep 2025 16:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEp-0000PH-FF
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEg-00049p-87
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759265161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qlKEBw9lE6bo/EwdF3KTAeTlEPfJql2lMtvmPkMIXA4=;
 b=BKFvPf1wbqH7Ix62VWW5CD2uFoo5D8sRtjlXZqoFwIPqIqsxfWPbmJU77lUNY1N84WK8mC
 rkU2/OLua69Lui0h2L3HXDdWos/daZM7Kofgxt8CdUb3dA9SJgGOTO5/xbRyW5pNpOzOpL
 EUhYpvCptFC5Ov1ftdKvnHpJtfaAvSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-Ab1STqtDPMiMNoAGlc2pMw-1; Tue,
 30 Sep 2025 16:45:59 -0400
X-MC-Unique: Ab1STqtDPMiMNoAGlc2pMw-1
X-Mimecast-MFC-AGG-ID: Ab1STqtDPMiMNoAGlc2pMw_1759265158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0A61800562; Tue, 30 Sep 2025 20:45:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45F17180035E; Tue, 30 Sep 2025 20:45:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/4] block: update inserted/removed nodes from
 BlockRAMRegistrar
Date: Tue, 30 Sep 2025 16:45:51 -0400
Message-ID: <20250930204555.162133-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This patch series fixes a bug in BlockRAMRegistrar: it currently doesn't react
to block graph changes and newly inserted nodes lack RAMBlock information
needed to map I/O buffers. This is important for vdpa-blk devices because they
rely on the ability to map I/O buffers.

Stefan Hajnoczi (4):
  block: add BdrvChildClass->propagate_attach/detach() callbacks
  block: add blk_add_attach/detach_notifier() APIs
  block: rename RAMBlockRegistrar->notifier field
  block: update inserted/removed nodes from BlockRAMRegistrar

 include/block/block_int-common.h            |  11 ++
 include/system/block-backend-global-state.h |   9 ++
 include/system/block-ram-registrar.h        |   4 +-
 block.c                                     |  56 +++++--
 block/block-backend.c                       |  44 ++++++
 block/block-ram-registrar.c                 |  75 ++++++++-
 tests/unit/test-block-backend.c             | 164 ++++++++++++++++++++
 7 files changed, 344 insertions(+), 19 deletions(-)

-- 
2.51.0


