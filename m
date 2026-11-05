Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C4606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/lqzRuX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOufQ-00034M-EJ; Thu, 05 Nov 2026 05:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf7-0002tU-Bd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf3-0004AI-FG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lqRNS7fMEzm2jdN8rQTGdCWAPUWuWRdNGPbkO5iRZ9c=;
 b=N/lqzRuX+dKikSOz9Ztdm3IHSL6QBbDR21vOrpjGpUmV4uGNDffK/0JbaqmcNVt5V4qbTZ
 Ksm6S+4bKBbNgnNkqjWHdcQBUFCMMGTLVmNSBlrslr4xvTFMwBFHkupHWHa2jvw/D79TPr
 25LN+lsWkNKFkuafHm8KhadPdWoKzmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-gpAM_GrWOwSRw4WnqGEaIQ-1; Thu,
 05 Nov 2026 05:25:34 -0500
X-MC-Unique: gpAM_GrWOwSRw4WnqGEaIQ-1
X-Mimecast-MFC-AGG-ID: gpAM_GrWOwSRw4WnqGEaIQ_1793874333
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9D531800553
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B19A1848D4B
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F33D421E6A04; Thu, 05 Nov 2026 11:25:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 0/3] qdev: Typed array properties for better QOM
 introspection
Date: Thu,  5 Nov 2026 11:25:27 +0100
Message-ID: <20261105102530.1848823-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In my "[PATCH v8 RESEND 00/56] qom/qdev: associate properties with
QAPI schema types", I noted under "Changes in v8":

    * Drop typed array PropertyInfos

      Why?  They complicate matters, and I ran out of time.

This series brings them back.  It's an updated version of PATCH 59+60
and a small part of PATCH 61 from Marc-André's v7.  I managed to do
without the QAPI generator changes from v7's PATCH 07+09.

With this applied on top of "[PATCH v2 0/5] qom/qdev: associate
properties with QAPI types fixups", @qapi-type is always present, and
the QAPI schema reflects that.

We could perhaps still include this in 11.2 as a bug fix, but I lean
towards queuing it up in my tree, with me taking care of the eventual
rebase.

Based-on: <20261105080310.1656968-1-armbru@redhat.com>

v2:
* PATCH 1: Fix qdev_prop_link_array.qapi_type, expand tabs
  (Marc-André)
* PATCH 3: New

Marc-André Lureau (2):
  qdev: Convert array properties to QAPI-aware registration
  qdev: Remove unused DEFINE_PROP_ARRAY parameter _arraytype

Markus Armbruster (1):
  qapi/qom: Make @qapi-type mandatory in output of qom-list etc.

 qapi/qom.json                            | 10 ++--
 hw/core/qdev-prop-internal.h             | 19 +++++++
 hw/display/apple-gfx.h                   |  1 +
 include/hw/block/block.h                 |  2 +-
 include/hw/core/qdev-properties-system.h |  2 +
 include/hw/core/qdev-properties.h        | 37 +++++++-------
 hw/core/qdev-properties-system.c         |  6 +++
 hw/core/qdev-properties.c                | 64 ++++++++++++++----------
 hw/input/stellaris_gamepad.c             |  2 +-
 hw/intc/arm_gicv3_common.c               |  2 +-
 hw/intc/arm_gicv5_common.c               |  4 +-
 hw/intc/rx_icu.c                         |  4 +-
 hw/misc/arm_sysctl.c                     |  4 +-
 hw/misc/mps2-scc.c                       |  2 +-
 hw/net/rocker/rocker.c                   |  2 +-
 hw/net/virtio-net.c                      |  2 +-
 hw/nvram/xlnx-efuse.c                    |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c        |  2 +-
 hw/riscv/riscv_hart.c                    |  6 +--
 hw/virtio/virtio-iommu-pci.c             |  2 +-
 tests/unit/test-qdev.c                   |  2 +-
 hw/display/apple-gfx-mmio.m              |  2 +-
 hw/display/apple-gfx-pci.m               |  2 +-
 hw/display/apple-gfx.m                   |  6 +++
 24 files changed, 114 insertions(+), 73 deletions(-)

-- 
2.55.0


