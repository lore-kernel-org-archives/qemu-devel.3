Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2097E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFq3-0002r9-Vj; Fri, 10 Jan 2025 09:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq1-0002qO-V4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq0-00058h-75
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HsDnbXYUMPbm8i+3DdECeG5igi0KfDiFMVlYpSA++bM=;
 b=cR3R3gLJVEqNRxFU2XKLFUJQRP4cSPwrudiWOy63uh1Lrh9osU37uYfBg5PsuncRMBfoUU
 rhs7bK7JweOmpI8svKkjus4Mq1cShhTqvKh28Nge8055JfjNt2gs//wfPqnJpM2uj8muLt
 kcsQpD35KRFZoZhNA2awo9f3v0uYt94=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-Hxtim3cNOy6uYmGbTxv64A-1; Fri,
 10 Jan 2025 09:18:07 -0500
X-MC-Unique: Hxtim3cNOy6uYmGbTxv64A-1
X-Mimecast-MFC-AGG-ID: Hxtim3cNOy6uYmGbTxv64A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 837F51955DBA; Fri, 10 Jan 2025 14:18:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3085195E3D9; Fri, 10 Jan 2025 14:18:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/9] ppc: Remove 405 CPU family
Date: Fri, 10 Jan 2025 15:17:51 +0100
Message-ID: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello,

This PPC 405 CPU and ref405ep machine was deprecated in QEMU 9.1
because there are no known users, firmware images are not available,
OpenWRT dropped support in 2019, U-Boot in 2017, and Linux in 2024.
Complete the phase-out process and remove tests, boards, CPU,
instructions and related models.

Thanks,

C. 

Cédric Le Goater (9):
  ppc/ppc405: Remove tests
  ppc/ppc405: Remove boards
  ppc/ppc405: Remove CPU
  ppc/ppc405: Remove storage control (SLER) SPR
  ppc/ppc405: Remove 40x exception model
  ppc/ppc405: Remove timer support
  ppc/ppc405: Remove cache handling instructions
  ppc/ppc405: Remove TLB instructions
  ppc/ppc405: Remove POWERPC_MMU_SOFT_4xx MMU model

 MAINTAINERS                      |    6 -
 docs/about/deprecated.rst        |    8 -
 docs/about/removed-features.rst  |    7 +
 docs/system/ppc/embedded.rst     |    1 -
 hw/ppc/ppc405.h                  |  186 -----
 include/hw/ppc/ppc.h             |   15 -
 target/ppc/cpu-models.h          |   30 -
 target/ppc/cpu.h                 |   42 +-
 target/ppc/helper.h              |    7 -
 target/ppc/mmu-booke.h           |    3 -
 target/ppc/spr_common.h          |    6 -
 hw/ppc/ppc.c                     |  251 ------
 hw/ppc/ppc405_boards.c           |  520 -------------
 hw/ppc/ppc405_uc.c               | 1216 ------------------------------
 target/ppc/cpu-models.c          |   57 --
 target/ppc/cpu_init.c            |  257 -------
 target/ppc/excp_helper.c         |  119 ---
 target/ppc/helper_regs.c         |   10 -
 target/ppc/misc_helper.c         |    5 -
 target/ppc/mmu-booke.c           |   63 --
 target/ppc/mmu_common.c          |   71 --
 target/ppc/mmu_helper.c          |   18 +-
 target/ppc/timebase_helper.c     |   20 -
 target/ppc/translate.c           |  136 ----
 tests/qtest/m48t59-test.c        |    5 -
 hw/ppc/Kconfig                   |    9 -
 hw/ppc/meson.build               |    3 -
 hw/ppc/trace-events              |    5 -
 tests/functional/meson.build     |    1 -
 tests/functional/test_ppc_405.py |   37 -
 tests/qtest/meson.build          |    1 -
 31 files changed, 11 insertions(+), 3104 deletions(-)
 delete mode 100644 hw/ppc/ppc405.h
 delete mode 100644 hw/ppc/ppc405_boards.c
 delete mode 100644 hw/ppc/ppc405_uc.c
 delete mode 100755 tests/functional/test_ppc_405.py

-- 
2.47.1


