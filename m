Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295DCCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX82-0001gQ-5u; Mon, 11 May 2026 16:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX80-0001gC-MF
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX7y-0001na-9Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4rKGSv3yStu/gGKb59bZDPXaRSWRVnIGA+ku/+RGJxI=;
 b=KCJ73aLlTrmT+uKHEnMFo2hiSGhI4sOHFQbfXTfmIvEwWvD/cIXh8nd1OQC+n2oxe5FrRq
 Gid9xah2xseCUmrxmXBe8UGQHd3k+b4s/UU+dWbOhTPVXWby6uyvckoZ+5f9P9iaWUfVoq
 ZkviqVv/KRRuNgFi86dgne09lPwFo3o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-CiBmpKs9PHKhxP3wY9AQCg-1; Mon,
 11 May 2026 16:21:17 -0400
X-MC-Unique: CiBmpKs9PHKhxP3wY9AQCg-1
X-Mimecast-MFC-AGG-ID: CiBmpKs9PHKhxP3wY9AQCg_1778530876
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87E7619560AA
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:21:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51AB319560A2; Mon, 11 May 2026 20:21:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/24] Qom patches
Date: Tue, 12 May 2026 00:20:46 +0400
Message-ID: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/qom-pull-request

for you to fetch changes up to bc61a3209bf064826481a5f8f2b4feb47c70b02f:

  target/s390x: add gen-features.h dependency to s390x_system_ss (2026-05-11 23:59:33 +0400)

----------------------------------------------------------------
QOM object lifecycle fixes

----------------------------------------------------------------

Marc-André Lureau (23):
  hw/remote: check visit return in vfu_object_set_socket
  qom/object: update doc about NULL values in link properties
  hw/remote: guard listener unregister in finalize
  io/net-listener: move mutex init to instance_init
  net/colo-compare: guard finalize against uninitialized state
  ui/console: remove console from global list on finalization
  hw/i386/x86: free oem_id and oem_table_id on finalization
  hw/core/resetcontainer: free children array on finalization
  net/can: free ifname on socketcan finalization
  backends/igvm-cfg: free filename on finalization
  scsi/pr-manager-helper: free path on finalization
  accel/kvm: free device path on finalization
  system/qtest: add missing qtest_finalize()
  hw/fsi: move OPBus address space init to realize
  hw/fsi: move OPBus qbus_init() to instance_init
  hw/gpio/pca9552: fix state_str leak in pca955x_set_led
  hw/arm/aspeed: free fmc_model and spi_model on finalization
  hw/arm/sbsa-ref: free unrealized flash devices on finalization
  hw/arm/virt: free flash devices and OEM strings on finalization
  hw/ppc/pnv: drop extra ref on PHB after adding as child
  hw/riscv/virt: free flash devices and OEM strings on finalization
  meson: drop sphinx-build < 1.7 compatiblity check
  target/s390x: add gen-features.h dependency to s390x_system_ss

Peter Xu (1):
  system/ioport: Fix qom-list-properties crash on portio list obj

 docs/meson.build          | 14 +-------------
 include/qom/object.h      |  8 ++++----
 accel/kvm/kvm-all.c       |  8 ++++++++
 backends/igvm-cfg.c       |  1 +
 hw/arm/aspeed.c           |  9 +++++++++
 hw/arm/sbsa-ref.c         | 12 ++++++++++++
 hw/arm/virt.c             | 14 ++++++++++++++
 hw/core/resetcontainer.c  |  3 +++
 hw/fsi/aspeed_apb2opb.c   | 37 ++++++++++++++++++++++++-------------
 hw/gpio/pca9552.c         |  2 +-
 hw/i386/x86.c             |  9 +++++++++
 hw/ppc/pnv.c              |  1 +
 hw/remote/remote-obj.c    |  4 +++-
 hw/remote/vfio-user-obj.c |  4 +++-
 hw/riscv/virt.c           | 14 ++++++++++++++
 io/net-listener.c         |  9 ++++++++-
 net/can/can_socketcan.c   |  8 ++++++++
 net/colo-compare.c        | 31 +++++++++++++++----------------
 scsi/pr-manager-helper.c  |  1 +
 system/ioport.c           | 11 +++++++++--
 system/qtest.c            | 10 ++++++++++
 ui/console.c              |  5 ++++-
 target/s390x/meson.build  |  1 +
 23 files changed, 163 insertions(+), 53 deletions(-)

-- 
2.54.0


