Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D391C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 04:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ3Zw-0008SS-Sy; Mon, 17 Jun 2024 00:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ3Zp-0008S0-Ng
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 00:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ3Zn-00047C-Ng
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 00:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718596957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z1EiM+JBmOU4rGn1SbVa7pe6q9WAw+D3Es9HXvdG6B4=;
 b=BySnhDlwYrHTV8OrsBdtVigbdhpMgtfilENNqJVWnF+zf9j+XzzJPCgZ2UTcLroWJkDW7a
 6XCEywHbfMlKBo5OS/E/Rrr4htCggENc1a16woIVgaOTdVBpRmmDUEmEaBXgnDN1O62q5M
 fphdaaQ7nCKJ9cW5lx+AD4Z+XSMlu+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-V5jNBU_yN1yp3A6bQ8ATUg-1; Mon,
 17 Jun 2024 00:02:34 -0400
X-MC-Unique: V5jNBU_yN1yp3A6bQ8ATUg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 819951956094; Mon, 17 Jun 2024 04:02:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 376FA1956087; Mon, 17 Jun 2024 04:02:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v2 00/19] aspeed queue
Date: Mon, 17 Jun 2024 06:02:28 +0200
Message-ID: <20240617040228.1878487-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 05ad1440b8428b0ade9b8e5c01469adb8fbf83e3:

  Merge tag 'virtio-grants-v8-tag' of https://gitlab.com/sstabellini/qemu into staging (2024-06-15 20:13:06 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20240617

for you to fetch changes up to 5f44521242d2fdfa190206a6be40577a58a71ef9:

  MAINTAINERS: Add reviewers for ASPEED BMCs (2024-06-16 21:08:54 +0200)

----------------------------------------------------------------
aspeed queue:

* Add AST2700 support

Changes in v2:

  - Fixed class_size in TYPE_ASPEED_INTC definition 
  - Fixed spelling : Unhandeled -> Unhandled 

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed/smc: Reintroduce "dram-base" property for AST2700

Jamin Lin (18):
      aspeed/wdt: Add AST2700 support
      aspeed/sli: Add AST2700 support
      aspeed/sdmc: remove redundant macros
      aspeed/sdmc: fix coding style
      aspeed/sdmc: Add AST2700 support
      aspeed/smc: correct device description
      aspeed/smc: support dma start length and 1 byte length unit
      aspeed/smc: support 64 bits dma dram address
      aspeed/smc: support different memory region ops for SMC flash region
      aspeed/smc: Add AST2700 support
      aspeed/scu: Add AST2700 support
      aspeed/intc: Add AST2700 support
      aspeed/soc: Add AST2700 support
      aspeed: Add an AST2700 eval board
      aspeed/soc: fix incorrect dram size for AST2700
      test/avocado/machine_aspeed.py: Add AST2700 test case
      docs:aspeed: Add AST2700 Evaluation board
      MAINTAINERS: Add reviewers for ASPEED BMCs

 MAINTAINERS                      |   3 +
 docs/system/arm/aspeed.rst       |  39 ++-
 include/hw/arm/aspeed_soc.h      |  30 +-
 include/hw/intc/aspeed_intc.h    |  44 +++
 include/hw/misc/aspeed_scu.h     |  47 ++-
 include/hw/misc/aspeed_sdmc.h    |   5 +-
 include/hw/misc/aspeed_sli.h     |  27 ++
 include/hw/ssi/aspeed_smc.h      |   3 +
 include/hw/watchdog/wdt_aspeed.h |   3 +-
 hw/arm/aspeed.c                  |  32 ++
 hw/arm/aspeed_ast27x0.c          | 648 +++++++++++++++++++++++++++++++++++++++
 hw/intc/aspeed_intc.c            | 361 ++++++++++++++++++++++
 hw/misc/aspeed_scu.c             | 306 +++++++++++++++++-
 hw/misc/aspeed_sdmc.c            | 220 +++++++++++--
 hw/misc/aspeed_sli.c             | 177 +++++++++++
 hw/ssi/aspeed_smc.c              | 347 +++++++++++++++++++--
 hw/watchdog/wdt_aspeed.c         |  24 ++
 hw/arm/meson.build               |   1 +
 hw/intc/meson.build              |   1 +
 hw/intc/trace-events             |  13 +
 hw/misc/meson.build              |   3 +-
 hw/misc/trace-events             |  11 +
 hw/ssi/trace-events              |   2 +-
 tests/avocado/machine_aspeed.py  |  62 ++++
 24 files changed, 2351 insertions(+), 58 deletions(-)
 create mode 100644 include/hw/intc/aspeed_intc.h
 create mode 100644 include/hw/misc/aspeed_sli.h
 create mode 100644 hw/arm/aspeed_ast27x0.c
 create mode 100644 hw/intc/aspeed_intc.c
 create mode 100644 hw/misc/aspeed_sli.c


