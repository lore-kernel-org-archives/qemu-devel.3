Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD028606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JOkF+PQ5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOWVo-0001mL-Hg; Wed, 04 Nov 2026 03:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOWVm-0001m6-JE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 03:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOWVk-0003kp-QE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 03:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793781503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vBa4avPdV++9NTfZiLis9Dehm4fvv6tIh3/Nbk4B8Cc=;
 b=JOkF+PQ5viW9EcSk/QbXWNLlSSAi5W2fwFv4ZTixdQNvHxgaoD0rf+AWUI8/PjNxQmIuxh
 dktX7IFTzCz4oRpczrbTb73MspiGsnEhHkDjvqdLm2jsDJJRATV+t9Rj7nJIxxT0kw+OsA
 6OfGVUnBTaSu/LlLWlKv7PcDwZGqlBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-LDWgqoWVMnO2R-g44pEfEA-1; Wed,
 04 Nov 2026 03:38:20 -0500
X-MC-Unique: LDWgqoWVMnO2R-g44pEfEA-1
X-Mimecast-MFC-AGG-ID: LDWgqoWVMnO2R-g44pEfEA_1793781499
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11BCB1800366
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 08:38:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C35D718004FD
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 08:38:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 419A421E6A04; Wed, 04 Nov 2026 09:38:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH 0/2] qdev: Typed array properties for better QOM introspection
Date: Wed,  4 Nov 2026 09:38:14 +0100
Message-ID: <20261104083816.1120306-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
and a small part of PATCH 61 from Marc-André's v7.

With this applied on top of "[PATCH 0/4] qom/qdev: associate
properties with QAPI types fixups", only child and link properties
lack @qapi-type in my testing.

We could perhaps still include this in 11.2 as a bug fix, but I lean
towards queuing it up in my tree, with me taking care of the eventual
rebase.

Based-on: <20261104064552.959862-1-armbru@redhat.com>

Marc-André Lureau (2):
  qdev: Convert array properties to QAPI-aware registration
  qdev: Remove unused DEFINE_PROP_ARRAY parameter _arraytype

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
 23 files changed, 110 insertions(+), 67 deletions(-)

-- 
2.55.0


