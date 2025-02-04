Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD6C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfDxX-0006D4-NV; Tue, 04 Feb 2025 03:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfDxV-0006Aw-2U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfDxT-0004uH-HA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738656417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H8ha8A6XGXVokYwHjRN9EGj7XMouy48zSk13M8X1hrQ=;
 b=HjnccNjzDGnClE4dbcbsb2fWJOcxC7mDx3Tq0tQkoZteix155HeSQxmYSMIiiK89evQlLn
 LgUPww2P49NoPEoQCxYTHs1Clf9wXRWyq+uDh1f+8LVMupuo3DRI1nx63e7nVo5AvV+ABM
 TxT0Zs2d1Hm3f9FqZd0gG8+1eRmrtcg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-cVlNq_Z2N7-_9XPioafVaQ-1; Tue,
 04 Feb 2025 03:06:56 -0500
X-MC-Unique: cVlNq_Z2N7-_9XPioafVaQ-1
X-Mimecast-MFC-AGG-ID: cVlNq_Z2N7-_9XPioafVaQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D9319560AB; Tue,  4 Feb 2025 08:06:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EC3D195608E; Tue,  4 Feb 2025 08:06:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/3] ppc: Remove ref405ep
Date: Tue,  4 Feb 2025 09:06:46 +0100
Message-ID: <20250204080649.836155-1-clg@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The PPC 405 CPU and ref405ep machine was deprecated in QEMU 9.1
because there are no known users, firmware images are not available,
OpenWRT dropped support in 2019, U-Boot in 2017, and Linux in 2024.

Continue the phase-out process and remove tests, plus boards. The 405
CPU implementation is kept for a while because it is possible to model
the power management (OCC) co-processor found on the IBM POWER [8-11]
processors.

Thanks,

C.

Changes in v2:

 - keep CPU implementation (for OCC possible models)

Cédric Le Goater (3):
  ppc/ppc405: Remove tests
  ppc/ppc405: Remove boards
  hw/ppc: Deprecate 405 CPUs

 MAINTAINERS                      |    6 -
 docs/about/deprecated.rst        |   17 +-
 docs/about/removed-features.rst  |    7 +
 docs/system/ppc/embedded.rst     |    1 -
 hw/ppc/ppc405.h                  |  186 -----
 hw/ppc/ppc405_boards.c           |  520 -------------
 hw/ppc/ppc405_uc.c               | 1216 ------------------------------
 tests/qtest/m48t59-test.c        |    5 -
 hw/ppc/Kconfig                   |    9 -
 hw/ppc/meson.build               |    3 -
 tests/functional/meson.build     |    1 -
 tests/functional/test_ppc_405.py |   37 -
 tests/qtest/meson.build          |    1 -
 13 files changed, 16 insertions(+), 1993 deletions(-)
 delete mode 100644 hw/ppc/ppc405.h
 delete mode 100644 hw/ppc/ppc405_boards.c
 delete mode 100644 hw/ppc/ppc405_uc.c
 delete mode 100755 tests/functional/test_ppc_405.py

-- 
2.48.1


