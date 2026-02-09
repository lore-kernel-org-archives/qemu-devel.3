Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23845E81BCF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWO-00071n-WF; Mon, 09 Feb 2026 09:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVv-00071Q-Cw
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVt-0005i9-3P
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fjg2XA3k6lRaEX4G75LHD1D6E31xSrKXEWM7OyyyF4E=;
 b=LVe/+VR2Cado3ZwAZeV+2Aknb/bA73avi3h8sUL/T3BRpSmI9dOweYwINHBBd2UZQR4cjR
 isFqGCbZgoKrnRmiD6457O1r0P8l6aPzhfoiH5wqzIkT9cCMswXxgRNZ4emwtYZHOPwgrt
 Iarl5cb3od2/sx8TUnblrp4B/os5xXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-VAG3KnLINlSGMRZbZUJgyw-1; Mon,
 09 Feb 2026 09:45:13 -0500
X-MC-Unique: VAG3KnLINlSGMRZbZUJgyw-1
X-Mimecast-MFC-AGG-ID: VAG3KnLINlSGMRZbZUJgyw_1770648311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 412491955DCA; Mon,  9 Feb 2026 14:45:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30CC018004AD; Mon,  9 Feb 2026 14:45:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] Block patches
Date: Mon,  9 Feb 2026 09:44:58 -0500
Message-ID: <20260209144508.45268-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit c4a9d49c7b23a02c646ebac756519c15a24f7ecc:

  Merge tag 'pull-9p-20260207' of https://github.com/cschoenebeck/qemu into staging (2026-02-07 17:46:15 +0000)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to a67819adb2212977360e9290bd005badb07dd2e4:

  docs: add SCSI migrate-pr documentation (2026-02-09 09:27:30 -0500)

----------------------------------------------------------------
Pull request

Andrey Drobyshev's qemugdb script improvements and my --device
scsi-block,migrate-pr=on|off live migration support for SCSI Persistent
Reservations.

----------------------------------------------------------------

Andrey Drobyshev (4):
  scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
    addresses
  scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
  scripts/qemugdb: timers: Improve 'qemu timers' command readability
  scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
    coredump

Stefan Hajnoczi (5):
  scsi: generalize scsi_SG_IO_FROM_DEV() to scsi_SG_IO()
  scsi: add error reporting to scsi_SG_IO()
  scsi: track SCSI reservation state for live migration
  scsi: save/load SCSI reservation state
  docs: add SCSI migrate-pr documentation

 docs/system/device-emulation.rst        |   1 +
 docs/system/devices/scsi/index.rst      |  10 +
 docs/system/devices/scsi/migrate-pr.rst |  54 +++++
 include/hw/scsi/scsi.h                  |  15 +-
 include/scsi/constants.h                |  21 ++
 hw/core/machine.c                       |   4 +-
 hw/scsi/scsi-bus.c                      |   3 +
 hw/scsi/scsi-disk.c                     |  90 +++++++-
 hw/scsi/scsi-generic.c                  | 291 +++++++++++++++++++++++-
 hw/scsi/trace-events                    |   2 +
 scripts/qemugdb/coroutine.py            | 257 +++++++++++++++++++--
 scripts/qemugdb/mtree.py                |   2 +-
 scripts/qemugdb/timers.py               |  54 ++++-
 13 files changed, 765 insertions(+), 39 deletions(-)
 create mode 100644 docs/system/devices/scsi/index.rst
 create mode 100644 docs/system/devices/scsi/migrate-pr.rst

-- 
2.52.0


