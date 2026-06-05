Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60173CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWit-0004Qw-VW; Fri, 05 Jun 2026 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWin-0004QL-Of
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWim-0005pG-4I
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XzKgajQ2STGB+mBRo2iO0iPU87pr90ifn4YhnB7X2ro=;
 b=MK56vtWR/ZJgW/StHmxkJbBa/OozMMAkY9rEQYIJPGUZcV2H2JbOs8TxpY4Xhs5448LThb
 Fmgwie+upxkwQITYR4cKS2dr92vag3ZzUhpvh37Al3USVJCq1mqB6psmYFoIP1clVmR84n
 i5liG1blj4abbkslaS9AV5NEsQQw/6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-NajJxZRuOUiWNhQVYKoWNQ-1; Fri,
 05 Jun 2026 11:44:28 -0400
X-MC-Unique: NajJxZRuOUiWNhQVYKoWNQ-1
X-Mimecast-MFC-AGG-ID: NajJxZRuOUiWNhQVYKoWNQ_1780674267
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E976F180034E
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B026F3000210; Fri,  5 Jun 2026 15:44:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 0/23] Fix various QOM object life-cycle issues
Message-Id: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
Date: Fri, 05 Jun 2026 19:44:20 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=3854;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Cl8EoaZeZ7gGYCbbIvvAlJVQCANVINoI37A+PKuqML0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7UqkWeq6soX6bFefNvHjY/m/XTusxXPhbh3
 rAuReioJ0qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5esfD/4oFHG0rDNEBxqCF3azKeDljbAS0OUcFCeDQbG8FRQxRsxoYOozNx3x0+NKUjMgiW8ECpV
 fU33l0gB8ry1JYSJqq1+aNqxa8u6z9DLD5q8VCMTghpXKfo5rhB2ey8kFffZ+EMMxxxvkdHT7s/
 lHa9USCCn8eT0ITFlA7KEkghaHrXOgcXpbxgS3XW+hLGoUCUZIM6KQ2bhwYSrCW7S04QKbUOw77
 /9z6EYlp8h8ZCoW5CFMSIxqbra6kEcEh2DwP12Km9bfQ6uJvzkmF2f7/LYGjhqQXzeCm0Vw+jTJ
 nbw8KwRrNpT1gYBcwTXo1mzC3ltFIeHtbwTCGqEALF+MAx1odnIgjThzP25AaUmO8fwdFdDXG5W
 8cJtxBH0p//et+nsgrzC6vDdKWnyId7SP0ZxrXFtIgNxPK3+MlnVhcIvuITXnw/cZ3xZn8xnlOR
 tbRLXTgSR893QUl4gpNtWKOGkaKuaC9xHtHU0ipLar0n0s/mHDAaapwxzjW2A+lgnE7BqrFATTZ
 vUcUrBFDmJnQunZ3RN6d3A9wrvl3U72/muTkq0p/sUWtap0JlsOEs9jHuI43PJ/I8+Y8KP9pWaJ
 w2YMfq5fSPvIs26dlbKjAtVoCnxu6Hh48k3QSe823wjzTfXEE9LvZQEn9DzS7ZZxpYI63UGCl1x
 lq0sighAfbXhIew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc:

  lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/qom-tests-pr-v1

for you to fetch changes up to a78ee35b70b0ef18dfd6e2a3e8ab818471a9e503:

  qtest: add "qom-tests" command (2026-06-05 12:23:33 +0400)

----------------------------------------------------------------
Fix various QOM object life-cycle issues

This series adds a new "qom-tests" qtest command that exercises basic QOM
object life-cycle: it instantiates all non-abstract object types, gets/sets
their properties, and unrefs them. This quickly surfaces leaks and crashes
that could otherwise be triggered at runtime via QMP qom commands.

----------------------------------------------------------------
Marc-André Lureau (24):
      Fix various QOM object life-cycle issues
      hw/pci: handle missing bus in prop_pci_busnr_get
      chardev/char-socket: handle NULL addr in char_socket_get_addr
      hw/pci-bridge: handle missing parent in prop_pxb_uid_get
      hw/pci-host/i440fx: handle NULL bus in pci-hole64 getters
      hw/pci-host/q35: handle NULL bus in pci-hole64 getters
      hw/ipmi: reject NULL 'bmc' property rather than crash
      hw/xlnx_dp: reject NULL 'dpdma' property rather than crash
      hw/intc/apic: move checks to realize()
      backends/cryptodev-lkcf: skip cleanup when not initialized
      system/ioport: minor code simplification
      hw/core/machine: free shim_filename on finalization
      net/filter: free old values in property setters
      target/i386/sev: add finalize functions and fix leaking setters
      target/i386/kvm/tdx: free strings in tdx_guest_finalize
      hw/i386/nitro_enclave: add instance finalize
      hw/i386/pc: free pcspk on finalization
      hw/tpm: free PPI buffer on finalization
      hw/loongarch/virt: free flash devices and OEM strings on finalization
      hw/ppc/spapr: free host_model and host_serial on finalization
      target/riscv: fix general_user_opts hash table leak
      target/riscv: use hash table as set for user_options
      hw/i2c/pmbus: fix undefined behavior in pmbus_direct_mode2data
      qtest: add "qom-tests" command

 target/riscv/cpu.h                  |  3 ++-
 tests/qtest/libqtest.h              |  8 ++++++
 backends/cryptodev-lkcf.c           |  4 +++
 chardev/char-socket.c               |  4 +++
 hw/core/machine.c                   |  1 +
 hw/display/xlnx_dp.c                |  6 +++++
 hw/i2c/pmbus_device.c               |  6 +++--
 hw/i386/nitro_enclave.c             | 11 ++++++++
 hw/i386/pc.c                        | 10 +++++++
 hw/intc/apic_common.c               | 23 +++++++++-------
 hw/ipmi/ipmi.c                      |  8 +++++-
 hw/loongarch/virt.c                 | 14 ++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  8 +++++-
 hw/pci-host/i440fx.c                | 15 +++++++++--
 hw/pci-host/q35.c                   | 15 +++++++++--
 hw/pci/pci.c                        | 11 ++++++--
 hw/ppc/spapr.c                      |  2 ++
 hw/tpm/tpm_tis_sysbus.c             |  9 +++++++
 net/filter.c                        |  2 ++
 system/ioport.c                     |  3 +--
 system/qtest.c                      | 46 ++++++++++++++++++++++++++++++++
 target/i386/cpu-apic.c              |  6 +----
 target/i386/kvm/tdx.c               |  5 ++++
 target/i386/sev.c                   | 37 ++++++++++++++++++++++++++
 target/riscv/cpu.c                  | 53 ++++++++++++++++++++++---------------
 target/riscv/kvm/kvm-cpu.c          |  8 +++---
 tests/qtest/libqtest.c              |  6 +++++
 tests/qtest/qom-test.c              | 12 +++++++++
 28 files changed, 282 insertions(+), 54 deletions(-)


