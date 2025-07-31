Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B4C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 12:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhSob-0004qU-Ja; Thu, 31 Jul 2025 08:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhSGV-0000aU-Gj
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhSGQ-0007XN-Ox
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753964397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/evXNjzwOPUQ8tMh0r51w3zsKPbm8qM4rMiFZJowQTg=;
 b=DD4dTzX0rKj31d5wfGwtfI+qVO5hsa70UKRGVJ5wmzWFNc2IasOoK9Egor5QxRodcrJGKJ
 ScAydaucF9HKHlu9NyjdJBKtIF6nNw9Yos5KZqF5SKMU5ZRUQqHpe3HsyJvxrhMd0Yxy4z
 RQq7JrUaUeJ1KhP+NJsGjVQngJomhKk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-Z0U6YVBTOYSz8HDMICPSTg-1; Thu,
 31 Jul 2025 08:19:55 -0400
X-MC-Unique: Z0U6YVBTOYSz8HDMICPSTg-1
X-Mimecast-MFC-AGG-ID: Z0U6YVBTOYSz8HDMICPSTg_1753964395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B479E180045B; Thu, 31 Jul 2025 12:19:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C147419373D9; Thu, 31 Jul 2025 12:19:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.2 0/4] vfio: Remove 'vfio-platform'
Date: Thu, 31 Jul 2025 14:19:43 +0200
Message-ID: <20250731121947.1346927-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Cédric Le Goater (4):
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
 hw/arm/virt.c                         |   5 -
 hw/core/sysbus-fdt.c                  | 383 --------------
 hw/vfio/amd-xgbe.c                    |  61 ---
 hw/vfio/calxeda-xgmac.c               |  61 ---
 hw/vfio/platform.c                    | 716 --------------------------
 hw/arm/Kconfig                        |   3 -
 hw/vfio/Kconfig                       |  16 -
 hw/vfio/meson.build                   |   3 -
 hw/vfio/trace-events                  |  11 -
 17 files changed, 26 insertions(+), 1454 deletions(-)
 rename {include/hw => hw}/vfio/vfio-region.h (100%)
 delete mode 100644 include/hw/vfio/vfio-amd-xgbe.h
 delete mode 100644 include/hw/vfio/vfio-calxeda-xgmac.h
 delete mode 100644 include/hw/vfio/vfio-platform.h
 delete mode 100644 hw/vfio/amd-xgbe.c
 delete mode 100644 hw/vfio/calxeda-xgmac.c
 delete mode 100644 hw/vfio/platform.c

-- 
2.50.1


