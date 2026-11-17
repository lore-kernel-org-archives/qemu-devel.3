Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277D606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fwWvI5nH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGuo-000622-G9; Tue, 17 Nov 2026 05:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGun-00061Q-2Z
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:59:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xTGul-0006gw-K8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794913191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7TttmKyDSwvpQ/Bs286jPbaD66duvTNL/kepOE9WoBs=;
 b=fwWvI5nHoqUeWo4j7a0/DrrSO1F4KlGbj8/BlllyS0kR1W8035jBZPuTmgc3VTcF89KZDv
 UMqN4Pia7W/t8uaZWD9zKYBnSA43iYUHekEdLDweUWDlzfkQzhtUWrzZ1oNwNyodDsJC35
 GQiRDCz1Mym2M4+zXfklB2dAI7lnd4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-DZ4Fuxs3OUiqayIrS0Vb5g-1; Tue,
 17 Nov 2026 05:59:49 -0500
X-MC-Unique: DZ4Fuxs3OUiqayIrS0Vb5g-1
X-Mimecast-MFC-AGG-ID: DZ4Fuxs3OUiqayIrS0Vb5g_1794913188
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A32981956095
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:59:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F6C41801974
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:59:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD28321E6A04; Tue, 17 Nov 2026 11:59:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 0/3] qdev: Typed array properties for better QOM
 introspection
Date: Tue, 17 Nov 2026 11:59:42 +0100
Message-ID: <20261117105945.2802923-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With this applied, @qapi-type is always present, and the QAPI schema
reflects that.

Based-on: <20261117103629.2612744-1-armbru@redhat.com>

v3:
* PATCH 3: Update tests/qtest/qmp-cmd-test.c

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
 tests/qtest/qmp-cmd-test.c               |  9 +---
 tests/unit/test-qdev.c                   |  2 +-
 hw/display/apple-gfx-mmio.m              |  2 +-
 hw/display/apple-gfx-pci.m               |  2 +-
 hw/display/apple-gfx.m                   |  6 +++
 25 files changed, 115 insertions(+), 81 deletions(-)

-- 
2.55.0


