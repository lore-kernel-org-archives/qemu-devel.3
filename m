Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085DEC3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVW5-0006AW-Nv; Tue, 17 Sep 2024 06:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVj-00066p-UN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVg-0006jl-FD
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nIihFgJL8IfmFJdASwunxoSTbZCeIRjbUCON743/G9Y=;
 b=JSLtJhBR644ryP0Fj8KctVUNcCkdSBi9mvfL5KgoaElm1I60fCOSEbHpYplqooOJU06l0g
 HAzXqdSqITm9kQstie5nTMUnmTzvo6AmwaxWg3657ospFuOfns6c2tVotXFu9fk3WwOOpR
 Ogn3C2NX8ZFya8CbXPexpC51zcJXhBU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-gkcnzyslPHqgFHI241R7uQ-1; Tue,
 17 Sep 2024 06:32:35 -0400
X-MC-Unique: gkcnzyslPHqgFHI241R7uQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760B61953953
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 10:32:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC14A19560AA; Tue, 17 Sep 2024 10:32:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/8] vfio queue
Date: Tue, 17 Sep 2024 12:32:21 +0200
Message-ID: <20240917103229.876515-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:

  Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240917

for you to fetch changes up to 8719224166832ff8230d7dd8599f42bd60e2eb96:

  vfio/igd: correctly calculate stolen memory size for gen 9 and later (2024-09-17 10:37:55 +0200)

----------------------------------------------------------------
vfio queue:

* Support for IGDs of gen 11 and later
* Coverity fixes

----------------------------------------------------------------
Corvin Köhne (7):
      vfio/igd: return an invalid generation for unknown devices
      vfio/igd: support legacy mode for all known generations
      vfio/igd: use new BDSM register location and size for gen 11 and later
      vfio/igd: add new bar0 quirk to emulate BDSM mirror
      vfio/igd: add ID's for ElkhartLake and TigerLake
      vfio/igd: don't set stolen memory size to zero
      vfio/igd: correctly calculate stolen memory size for gen 9 and later

Peter Maydell (1):
      hw/vfio/pci.c: Use correct type in trace_vfio_msix_early_setup()

 hw/vfio/pci.h        |   1 +
 hw/vfio/igd.c        | 185 +++++++++++++++++++++++++++++++++++++++++++--------
 hw/vfio/pci-quirks.c |   1 +
 hw/vfio/trace-events |   2 +-
 4 files changed, 162 insertions(+), 27 deletions(-)


