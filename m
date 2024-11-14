Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168DFD68B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBd9g-0008P1-Jb; Thu, 14 Nov 2024 11:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9c-0008O9-TN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tBd9Y-0002Zi-T3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VeXIjY+TB7UV+SBpsRTOOabzG4WJbh6vMkBJTKJZj+0=;
 b=Lnh/1VB/4KmJPKiFqWzLB1qjE/IEDmT6lnIqQMTBRKqdtRU9DrCcnqtVr5Ie1eVd0Cp/fA
 Y3E3Agff5yEvewRq02b8Hqm3BR85gSc/b0PF2oyKCfwj68RCKqdjJ6QE4WVVAjWJS0Yrh6
 Y+eqigmDtQTPinUCZ7/7h0P00A3gcZM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-_C-f5FAaMcSdi7_gnE0Kxw-1; Thu,
 14 Nov 2024 11:57:03 -0500
X-MC-Unique: _C-f5FAaMcSdi7_gnE0Kxw-1
X-Mimecast-MFC-AGG-ID: _C-f5FAaMcSdi7_gnE0Kxw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FCCB1954B03; Thu, 14 Nov 2024 16:57:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 650611955F21; Thu, 14 Nov 2024 16:57:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/8] Block layer patches
Date: Thu, 14 Nov 2024 17:56:49 +0100
Message-ID: <20241114165657.254256-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:

  Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 378a645b2f6125b1bdbd1fae3e8f30452d5b5934:

  vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-14 17:55:51 +0100)

----------------------------------------------------------------
Block layer patches

- Fix qmp_device_add() to not throw non-scalar options away (fixes
  iothread-vq-mapping being silently ignored in device_add)
- iotests: Fix mypy failure
- parallels: Avoid potential integer overflow
- Fix crash in migration_is_running()

----------------------------------------------------------------
Dmitry Frolov (1):
      parallels: fix possible int overflow

John Snow (4):
      iotests: reflow ReproducibleTestRunner arguments
      iotests: correct resultclass type in ReproducibleTestRunner
      python: disable too-many-positional-arguments warning
      python: silence pylint raising-non-exception error

Peter Xu (1):
      migration: Check current_migration in migration_is_running()

Stefan Hajnoczi (2):
      qdev-monitor: avoid QemuOpts in QMP device_add
      vl: use qmp_device_add() in qemu_create_cli_devices()

 block/parallels.c             |  4 ++--
 migration/migration.c         |  4 ++++
 system/qdev-monitor.c         | 42 ++++++++++++++++++++++++++++--------------
 system/vl.c                   | 14 ++++----------
 python/scripts/mkvenv.py      |  3 +++
 tests/qemu-iotests/iotests.py | 11 +++++++----
 python/setup.cfg              |  1 +
 tests/qemu-iotests/pylintrc   |  1 +
 8 files changed, 50 insertions(+), 30 deletions(-)


