Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F40CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyJX-0000Ps-PR; Mon, 01 Sep 2025 02:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJV-0000IC-JH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJN-0002t4-5u
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q5w8bBlKlrAq2eKhlTHswlurzALBGfyxWtoE8c847Is=;
 b=jCxE3jEUhm85IazuMvNLt+XAxuM6EVuBAbt61Clv1Q5MKKSF/KCUO8BXpDQxD23cr5Uuo+
 AYD+z9KJzFvR83hUzjT2lTv5P0VicKeZjNFwP89i2L11wsSqoRPX/2z18bhpmZ/2pdDwI3
 SRjzvcpGYrjqxXCG1uH0TLUWNI8zPfo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-OQXt7Y2DNPaqxgg3R2qtgw-1; Mon,
 01 Sep 2025 02:46:38 -0400
X-MC-Unique: OQXt7Y2DNPaqxgg3R2qtgw-1
X-Mimecast-MFC-AGG-ID: OQXt7Y2DNPaqxgg3R2qtgw_1756709197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBEE619560BB; Mon,  1 Sep 2025 06:46:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C8CC19560B4; Mon,  1 Sep 2025 06:46:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/8] vfio: Remove 'vfio-platform'
Date: Mon,  1 Sep 2025 08:46:23 +0200
Message-ID: <20250901064631.530723-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello, 

The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
timeframe. QEMU 10.2 is the time for removal.

The last patch moves vfio-region.h under hw/vfio since it no longer
needs to be a public VFIO interface.

Thanks,

C.

Changes in v2:

 - Fixed 'system/system.h' include for the arm virt machine and a
   couple more models

Cédric Le Goater (8):
  hw/arm/virt: Include 'system/system.h'
  hw/isa/superio: Include 'system/system.h'
  hw/mips/loongson3_virt: Include 'system/system.h'
  hw/mips/malta: Include 'system/system.h'
  vfio: Remove 'vfio-amd-xgbe' device
  vfio: Remove 'vfio-calxeda-xgmac' device
  vfio: Remove 'vfio-platform'
  vfio: Move vfio-region.h under hw/vfio/

 docs/about/deprecated.rst             |  25 -
 docs/about/removed-features.rst       |  25 +
 docs/devel/kconfig.rst                |   2 -
 {include/hw => hw}/vfio/vfio-region.h |   0
 include/hw/vfio/vfio-amd-xgbe.h       |  46 --
 include/hw/vfio/vfio-calxeda-xgmac.h  |  43 --
 include/hw/vfio/vfio-device.h         |   2 +-
 include/hw/vfio/vfio-platform.h       |  78 ---
 hw/arm/virt.c                         |   6 +-
 hw/core/sysbus-fdt.c                  | 383 --------------
 hw/isa/isa-superio.c                  |   1 +
 hw/mips/loongson3_virt.c              |   1 +
 hw/mips/malta.c                       |   1 +
 hw/vfio/amd-xgbe.c                    |  61 ---
 hw/vfio/calxeda-xgmac.c               |  61 ---
 hw/vfio/platform.c                    | 716 --------------------------
 hw/arm/Kconfig                        |   3 -
 hw/vfio/Kconfig                       |  16 -
 hw/vfio/meson.build                   |   3 -
 hw/vfio/trace-events                  |  11 -
 20 files changed, 30 insertions(+), 1454 deletions(-)
 rename {include/hw => hw}/vfio/vfio-region.h (100%)
 delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
 delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
 delete mode 100644 include/hw/vfio/vfio-platform.h
 delete mode 100644 hw/vfio/amd-xgbe.c
 delete mode 100644 hw/vfio/calxeda-xgmac.c
 delete mode 100644 hw/vfio/platform.c

-- 
2.51.0


