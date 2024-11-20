Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9992AD63928
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 10:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDiIr-0003U3-JI; Wed, 20 Nov 2024 05:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDiIp-0003TZ-Nt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 05:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDiIn-0006ur-Vn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 05:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732099876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WkEWZPLSOD8a1k2c/tGdOV9+DiElxxk6uBD3cU7xB1I=;
 b=F4CR44JSTt13kmcC1fgGIEkN1kZ9XEL3u97EZ1c1kM+cD35fx3CupCI602L5bjnBpM5A+c
 mhBhoL9MMSwnPPjvZG/2bvh2U9xmBNjIXd/XSMaEh7qPqENLrxUolWvf/Ugv5F62O+tj2U
 3/epuxUGNxmu05+nX0s7x0uVD9sV7UU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-TLPw5jYLOiKs5fYfsIJw0g-1; Wed,
 20 Nov 2024 05:51:12 -0500
X-MC-Unique: TLPw5jYLOiKs5fYfsIJw0g-1
X-Mimecast-MFC-AGG-ID: TLPw5jYLOiKs5fYfsIJw0g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 841491956048; Wed, 20 Nov 2024 10:51:11 +0000 (UTC)
Received: from merkur.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C09219560A3; Wed, 20 Nov 2024 10:51:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v3 0/8] Block layer patches
Date: Wed, 20 Nov 2024 11:51:06 +0100
Message-ID: <20241120105106.50669-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:

  Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 83987bf722b6b692bc745b47901be76a1c97140b:

  vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-20 11:47:49 +0100)

----------------------------------------------------------------
Block layer patches

- Fix qmp_device_add() to not throw non-scalar options away (fixes
  iothread-vq-mapping being silently ignored in device_add)
- Fix qdev property crash with integer PCI addresses and JSON -device
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

Kevin Wolf (1):
      qdev: Fix set_pci_devfn() to visit option only once

Stefan Hajnoczi (2):
      qdev-monitor: avoid QemuOpts in QMP device_add
      vl: use qmp_device_add() in qemu_create_cli_devices()

 block/parallels.c                |  4 +--
 hw/core/qdev-properties-system.c | 54 ++++++++++++++++++++++++++--------------
 system/qdev-monitor.c            | 42 ++++++++++++++++++++-----------
 system/vl.c                      | 14 +++--------
 python/scripts/mkvenv.py         |  3 +++
 tests/qemu-iotests/iotests.py    | 11 +++++---
 python/setup.cfg                 |  1 +
 tests/qemu-iotests/pylintrc      |  1 +
 8 files changed, 82 insertions(+), 48 deletions(-)


