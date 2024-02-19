Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4570AC54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1D9-0003rV-IN; Mon, 19 Feb 2024 05:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1D8-0003r1-0j
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1D6-00016Z-Kn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708339760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DzoKqRtjrS8IJx8VnjUldBb8dumHoRMmqa/9KkKFbFo=;
 b=TP2pe7GbODVfu0PGbiUn4TIfkxqn7oEg5uaEI77dRyIZaGZ4d3dIEECRgHkQe7jJRPyw65
 zvdjVhT1o5UpIRAUH2tMnmj0LRCi8Wi1R33xMXNYg78T85C9sAjp7iM45eGjPqGZb+s07U
 3dMYb19BfeE8HZjgZY4wjRlarD83yqs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-jjN0We-UNpehInhsIwXm_g-1; Mon,
 19 Feb 2024 05:49:16 -0500
X-MC-Unique: jjN0We-UNpehInhsIwXm_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07ABC3CBD544;
 Mon, 19 Feb 2024 10:49:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 343621C060AF;
 Mon, 19 Feb 2024 10:49:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH 0/7] hw/ide: Clean up hw/ide/qdev.c and
 include/hw/ide/internal.h
Date: Mon, 19 Feb 2024 11:49:05 +0100
Message-ID: <20240219104912.378211-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While trying to make it possible to compile-out the CompactFlash IDE device
in downstream distributions (first patch), we noticed that there are more
things in the IDE code that could use a proper clean up:

First, hw/ide/qdev.c is quite a mix between IDE BUS specific functions
and (disk) device specific functions. Thus the second patch splits qdev.c
into two new separate files to make it more obvious which part belongs
to which kind of devices.

The remaining patches unentangle include/hw/ide/internal.h, which is meant
as a header that should only be used internally to the IDE subsystem, but
which is currently exposed to the world since include/hw/ide/pci.h includes
this header, too. Thus we move the definitions that are also required for
non-IDE code to other new header files, so we can finally change pci.h to
stop including internal.h. After these changes, internal.h is only included
by files in hw/ide/ as it should be.

Thomas Huth (7):
  hw/ide: Add the possibility to disable the CompactFlash device in the
    build
  hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
  hw/ide: Move IDE device related definitions to ide-dev.h
  hw/ide: Move IDE bus related definitions to a new header ide-bus.h
  hw/ide: Move IDE DMA related definitions to a separate header
    ide-dma.h
  hw/ide: Remove the include/hw/ide.h legacy file
  hw/ide: Stop exposing internal.h to non-IDE files

 include/hw/ide.h             |   9 --
 include/hw/ide/ide-bus.h     |  41 +++++++
 include/hw/ide/ide-dev.h     | 186 +++++++++++++++++++++++++++++++
 include/hw/ide/ide-dma.h     |  30 +++++
 include/hw/ide/internal.h    | 209 +----------------------------------
 include/hw/ide/pci.h         |   3 +-
 hw/i386/pc.c                 |   2 +-
 hw/ide/cf.c                  |  58 ++++++++++
 hw/ide/cmd646.c              |   1 +
 hw/ide/ide-bus.c             | 111 +++++++++++++++++++
 hw/ide/{qdev.c => ide-dev.c} | 137 +----------------------
 hw/ide/pci.c                 |   1 +
 hw/ide/piix.c                |   1 +
 hw/ide/sii3112.c             |   1 +
 hw/ide/via.c                 |   1 +
 hw/arm/Kconfig               |   2 +
 hw/ide/Kconfig               |  32 ++++--
 hw/ide/meson.build           |   4 +-
 18 files changed, 465 insertions(+), 364 deletions(-)
 delete mode 100644 include/hw/ide.h
 create mode 100644 include/hw/ide/ide-bus.h
 create mode 100644 include/hw/ide/ide-dev.h
 create mode 100644 include/hw/ide/ide-dma.h
 create mode 100644 hw/ide/cf.c
 create mode 100644 hw/ide/ide-bus.c
 rename hw/ide/{qdev.c => ide-dev.c} (67%)

-- 
2.43.2


